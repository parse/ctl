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
#import "PlayerInfoView.h"
#import "Tile.h"
#import "Board.h"
#import <QuartzCore/QuartzCore.h>

#include <stdlib.h>
board::State random_board() {
	board::State board = {0};
	board.num_players = 5;
	
	for (unsigned p = 0; p != board.num_players; ++p) {
		for (unsigned l = 0; l != board::NUM_LETTERS; ++l)
			board.letters[p][l] = 'A' + (rand() % 24);
	}
	
	return board;
}

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize playerArray = _playerArray;
@synthesize letterBag = _letterBag;
@synthesize game = _game;
@synthesize gameTableView = _gameTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UINib *constructedWordNib = [UINib nibWithNibName:@"CurrentConstructedWordCell" bundle:nil];
    UINib *playerCellNib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
    UINib *progressBarCell = [UINib nibWithNibName:@"ProgressBarCell" bundle:nil];
    
    [_gameTableView registerNib:constructedWordNib forCellReuseIdentifier:@"currentConstructedWord"];
    [_gameTableView registerNib:playerCellNib forCellReuseIdentifier:@"player"];
    [_gameTableView registerNib:progressBarCell forCellReuseIdentifier:@"progressBar"];

	board::State board = random_board();
	
    //Skapa viewn programmatiskt, en rad per spelare
    _playerArray = [[NSMutableArray alloc] init];

    for (unsigned p = 0; p != board.num_players; ++p) {
		board::TempAllocator128 ta;
		NSMutableArray* tiles = [[NSMutableArray alloc] init];
		
		// char* word = board::word(ta, board, p);
		
		for (unsigned l = 0; l != board::NUM_LETTERS; ++l) {
			Letter *letter = [[Letter alloc] init];
			letter.character = [NSString stringWithUTF8String:board::letter(ta, board, p, l)];
			letter.points = [NSNumber numberWithInt:1];
			
			Tile *tile = [[Tile alloc] init];
			tile.letter = letter;
			[tiles addObject:tile];
		}		
        
        // Player 1
        Player *p1 = [[Player alloc] init];
        p1.peerID = @"p1";
        p1.name = @"p1";
        
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

#pragma mark - Table View Configure Cells
- (void)setUpConstructedWordCell:(CurrentConstructedWordCell *)cell
{
    UIButton *butt;
        
    for (NSInteger i = 1; i < 7; i++) {
        butt = (UIButton *)[cell viewWithTag:i];
        
        [butt.titleLabel setText:@"A"];
    }

}

- (void)setUpProgressBarCell:(ProgressBarCell *)cell
{
    // TODO: Setup cell
}

- (void)setUpPlayerCell:(PlayerCell *)cell indexPath:(NSIndexPath *)indexPath
{
    UIButton *butt;
    PlayerGameData *player = [_playerArray objectAtIndex:indexPath.row-2];

    Tile *t;
    
    for (NSInteger i = 1; i < 6; i++) {
        butt = (UIButton *)[cell viewWithTag:i];
        
        t = [player.tileArray objectAtIndex:i-1];
        
        [butt.titleLabel setText:t.letter.character];
        [butt.titleLabel setTextAlignment: UITextAlignmentCenter];
    }
    
    PlayerInfoView *playerInfoView = (PlayerInfoView *)[cell viewWithTag:6];
    /*
    [playerInfoView setThumbnailImage: [UIImage imageNamed:@"ctl-logotype.png"]];
    [playerInfoView setCurrentScore:[NSNumber numberWithInt:1]];
    [playerInfoView setFutureScore:[NSNumber numberWithInt:1]];
     */
}

#pragma mark - Table View Delegate/Datasource Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 53;
    } else if (indexPath.row == 1) {
        return 25.0;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *currentConstructedWordIdentifier = @"currentConstructedWord";
    static NSString *playerCellIdentifier = @"player";
    static NSString *progressBarIdentifier = @"progressBar";
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = (CurrentConstructedWordCell *)[tableView dequeueReusableCellWithIdentifier:currentConstructedWordIdentifier];
        [self setUpConstructedWordCell:(CurrentConstructedWordCell *)cell];
    } else if (indexPath.row == 1) {
        cell = (ProgressBarCell *)[tableView dequeueReusableCellWithIdentifier:progressBarIdentifier];
        [self setUpProgressBarCell:(ProgressBarCell *)cell];
    } else {
        cell = (PlayerCell *)[tableView dequeueReusableCellWithIdentifier:playerCellIdentifier];
        [self setUpPlayerCell:(PlayerCell *)cell indexPath:indexPath];
    }
    NSLog(@"Cell: %@", cell);
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
