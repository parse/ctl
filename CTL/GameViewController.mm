//
//  GameViewController.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 Flöde:
	* Brädet har en påse med bokstäver som innehåller 1 alfabet per spelare
	* Fyra spelare får 4 a:n och 4 b:n osv.
	* Påsen slås ihop och slumpas ut till alla spelare
	* Bokstäver som läggs ut tas bort ur påsen
	* Kör ett antal rundor (exempelvis 4)
	* ?????
	* Profit
 */
#import "GameViewController.h"
#import "LetterBag.h"
#import "Letter.h"
#import "Game.h"
#import "CurrentConstructedWordCell.h"
#import "PlayerCell.h"
#import "ProgressBarCell.h"
#import "Player.h"
#import "PlayerGameData.h"
#import "PlayerInfoViewController.h"
#import "Tile.h"
#import "Board.h"
#import "GCHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "Network.h"

#include <stdlib.h>

board::State random_board() {
	board::State board = {0};
	board.num_players = 5;
	
	char buffer[2] = {0};
	for (unsigned p = 0; p != board.num_players; ++p) {
		for (unsigned l = 0; l != board::NUM_LETTERS; ++l) {
			buffer[0] = 'A' + (rand() % 26);
			board::set_letter(board, p, l, buffer);
		}
	}
	
	return board;
}

@interface GameViewController ()

@end

@implementation GameViewController {
    board::State currentBoard;
	NSUInteger nextLetterIndex;
    Network *networkHelper;
}

@synthesize playerArray = _playerArray;
@synthesize letterBag = _letterBag;
@synthesize game = _game;
@synthesize gameTableView = _gameTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        nextLetterIndex = 0;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    networkHelper = [[Network alloc] init];

    UINib *constructedWordNib = [UINib nibWithNibName:@"CurrentConstructedWordCell" bundle:nil];
    UINib *playerCellNib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
    UINib *progressBarCell = [UINib nibWithNibName:@"ProgressBarCell" bundle:nil];
    
    [_gameTableView registerNib:constructedWordNib forCellReuseIdentifier:@"currentConstructedWord"];
    [_gameTableView registerNib:playerCellNib forCellReuseIdentifier:@"player"];
    [_gameTableView registerNib:progressBarCell forCellReuseIdentifier:@"progressBar"];

	currentBoard = random_board();
	
    //Skapa viewn programmatiskt, en rad per spelare
    _playerArray = [[NSMutableArray alloc] init];

    for (unsigned p = 0; p != currentBoard.num_players; ++p) {
		board::TempAllocator128 ta;
		NSMutableArray* tiles = [[NSMutableArray alloc] init];
		
		// char* word = board::word(ta, board, p);
		
		for (unsigned l = 0; l != board::NUM_LETTERS; ++l) {
			Letter *letter = [[Letter alloc] init];
			letter.character = [NSString stringWithUTF8String:board::letter(ta, currentBoard, p, l)];
			letter.points = [NSNumber numberWithInt:1];
			
			Tile *tile = [[Tile alloc] init];
			tile.letter = letter;
			[tiles addObject:tile];
		}		
        // Player 1
        Player *p1 = [[Player alloc] init];
        p1.peerID = [NSString stringWithFormat:@"Player %d", p];
        p1.name = [NSString stringWithFormat:@"Player %d", p];
        
        PlayerGameData *p1_gamedata = [[PlayerGameData alloc] init];
        p1_gamedata.player = p1;
        p1_gamedata.score = 0;
        p1_gamedata.tileArray = tiles;
        [_playerArray addObject:p1_gamedata];
    }
        
    [_gameTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// TODO: kolla upp smidigaste sättet att sätta upp spelplanens data.
- (void)setGame:(Game *)game
{
	_game = game;
	_letterBag = [[LetterBag alloc] initWithLanguage:_game.language
									 numberOfPlayers:_playerArray.count];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Game events

- (void)updateBoard
{

}

/**
 * Handle pressed character button events
 * Adds letter to the active game
 */
- (void)playerCharacterButtonPressed:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_gameTableView];
    NSIndexPath *indexPath = [_gameTableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath != nil) {
        UIButton *characterButton = (UIButton *)sender;
        
        if ([characterButton isSelected]) return;
        
        // Get index of button
        NSInteger buttonIndex = [characterButton tag]-1;
                        
        // Find associated Player and Tile
        NSInteger chosenPlayerIndex = indexPath.row-2; //-2 is because we have a progress bar and chosen letters cell
        
        PlayerGameData *pressedPlayer = [_playerArray objectAtIndex:chosenPlayerIndex];
        Tile *t = (Tile *)[pressedPlayer.tileArray objectAtIndex:buttonIndex];

        // Change background colour of button
        if (![characterButton isSelected]) {
            characterButton.backgroundColor = [UIColor redColor];
        }
        characterButton.selected = !characterButton.selected;
		
        NSString *chosenLetter = t.letter.character;
        NSLog(@"Letter %s chosen from %@ (PlayerIndex %d)", [chosenLetter UTF8String], pressedPlayer.player.name, chosenPlayerIndex);

		board::set_selected(currentBoard, chosenPlayerIndex, buttonIndex, true);
        board::set_word_letter(currentBoard, nextLetterIndex++, [t.letter.character UTF8String]);
        
        [self updateBoard];
    }
}

/**
 * Handle pressed button in constructed word area
 * Remove relevant letter from game array
 */
- (void)constructedWordCharacterButtonPressed:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_gameTableView];
    NSIndexPath *indexPath = [_gameTableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath != nil) {
        UIButton *characterButton = (UIButton *)sender;
        
        // Get index of button
        NSInteger buttonIndex = [characterButton tag]-1;
        
        NSLog(@"Letter at index %d to be removed from constructed word array", buttonIndex);
        
        // TODO: Put letter back in table view on the correct position
        
        // TODO: Fix and implement call to remove letter from struct
        //board::remove_letter(currentBoard, buttonIndex);
        
        [self updateBoard];
    }
}


#pragma mark - Table View Configure Cells

/**
 * Configure the top cell with the user-chosen letters
 *
 */
- (void)setUpConstructedWordCell:(CurrentConstructedWordCell *)cell
{
    UIButton *constructedWordButton;
        
    for (NSInteger i = 1; i < 7; i++) {
        // TODO: Get letters from struct 
        constructedWordButton = (UIButton *)[cell viewWithTag:i];
        [constructedWordButton setTitle:@"" forState:UIControlStateNormal];
        // Respond to touch events to remove letter
        [constructedWordButton addTarget:self action:@selector(constructedWordCharacterButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/**
 * Configure the progress bar cell
 *
 */
- (void)setUpProgressBarCell:(ProgressBarCell *)cell
{
    // TODO: Countdown 15 seconds and disable board for this player
}

/**
 * Configure each player cell consisting of user info and generated characters
 *
 */
- (void)setUpPlayerCell:(PlayerCell *)cell indexPath:(NSIndexPath *)indexPath
{
    UIButton *characterButton;
    PlayerGameData *player = [_playerArray objectAtIndex:indexPath.row-2];

    Tile *t;
    
    for (NSInteger i = 1; i < 6; i++) {
        characterButton = (UIButton *)[cell viewWithTag:i];
        
        t = [player.tileArray objectAtIndex:i-1];
        
        [characterButton setTitle:t.letter.character forState:UIControlStateNormal];
        [characterButton.titleLabel setTextAlignment: UITextAlignmentCenter];
        
        // Respond to touch evenets to add letter to our constructed word
        [characterButton addTarget:self action:@selector(playerCharacterButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // TODO: Add player info meta data
    //PlayerInfoViewController *playerInfoView = (PlayerInfoViewController *)[cell viewWithTag:6];
    
    //[playerInfoView setThumbnailImage: [UIImage imageNamed:@"ctl-logotype.png"]];
    //[playerInfoView setCurrentScore:[NSNumber numberWithInt:1]];
    //[playerInfoView setFutureScore:[NSNumber numberWithInt:1]];
     
}

#pragma mark - Table View Delegate/Datasource Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 53;
            break;
        case 1:
            return 25;
            break;
        default:
            return 60;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *currentConstructedWordIdentifier = @"currentConstructedWord";
    static NSString *playerCellIdentifier = @"player";
    static NSString *progressBarIdentifier = @"progressBar";
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:currentConstructedWordIdentifier];
        [self setUpConstructedWordCell:(CurrentConstructedWordCell *)cell];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:progressBarIdentifier];
        [self setUpProgressBarCell:(ProgressBarCell *)cell];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:playerCellIdentifier];
        [self setUpPlayerCell:(PlayerCell *)cell indexPath:indexPath];
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // the number of players, + 1 for the current constructed word cell, + 1 for the progress bar.
    return _playerArray.count + 2;
}
@end
