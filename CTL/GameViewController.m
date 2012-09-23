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

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize playerArray = _playerArray;
@synthesize letterBag = _letterBag;
@synthesize gameMetaData = _gameMetaData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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

// TODO: kolla upp smidigaste sättet att sätta upp spelplanens data. Jag kan tänkte göra det i
- (void)setGameMetaData:(Game *)gameMetaData
{
	_gameMetaData = gameMetaData;
	_letterBag = [[LetterBag alloc] initWithLanguage:_gameMetaData.language 
									 numberOfPlayers:_playerArray.count];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
