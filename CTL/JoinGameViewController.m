//
//  JoinGameViewController.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JoinGameViewController.h"
#import "GameViewController.h"
#import "SegueDefines.h"
#import "GameMetaData.h"

@interface JoinGameViewController ()

@end

@implementation JoinGameViewController

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
    
  //  GameMetaData *game1 =
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if (segue.identifier == kSeguePresentGameController) {
		GameViewController *gVC = (GameViewController *)self.presentedViewController;
		// TODO: sätt rätt game data i gVC
	}
}

@end
