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
        UINib *constructedWordNib = [UINib nibWithNibName:@"CurrentConstructedWordCell" bundle:nil];
        UINib *playerCellNib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
        UINib *progressBarCell = [UINib nibWithNibName:@"ProgressBarCell" bundle:nil];
        
        [_gameTableView registerNib:constructedWordNib forCellReuseIdentifier:@"currentConstructedWord"];
        [_gameTableView registerNib:playerCellNib forCellReuseIdentifier:@"player"];
        [_gameTableView registerNib:progressBarCell forCellReuseIdentifier:@"progressBar"];
        //Skapa viewn programmatiskt, en rad per spelare

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Do any additional setup after loading the view.
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


- (void)setUpConstructedWordCell:(CurrentConstructedWordCell *)cell
{
    // Todo: set up cell
}

- (void)setUpProgressBarCell:(ProgressBarCell *)cell
{
    // Todo: set up cell
}

- (void)setUpPlayerCell:(PlayerCell *)cell
{
    // Todo: set up cell
}


#pragma mark - Table View Delegate/Datasource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *currentConstructedWordIdentifier = @"currentConstructedWord";
    static NSString *PlayerCellIdentifier = @"PlayerCell";
    static NSString *progressBarIdentifier = @"progressBar";
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:currentConstructedWordIdentifier];
        [self setUpConstructedWordCell:(CurrentConstructedWordCell *)cell];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:progressBarIdentifier];
        [self setUpProgressBarCell:(ProgressBarCell *)cell];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:PlayerCellIdentifier];
        [self setUpPlayerCell:(PlayerCell *)cell];
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
