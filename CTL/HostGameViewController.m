//
//  HostGameViewController.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HostGameViewController.h"
#import "GCHelper.h"
#import "GameViewController.h"

@interface HostGameViewController ()

@end

@implementation HostGameViewController

@synthesize playerArray;

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
    
    // Set ourselves as player 1 and the game to active
    //[self setGameState:kGameStateActive];
    
    //GameViewController *gameViewController = [[GameViewController alloc] init];
    
//    [self setGameState:kGameStateWaitingForMatch];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
