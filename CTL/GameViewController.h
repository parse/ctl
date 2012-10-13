//
//  GameViewController.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCHelper.h"
#import "NetworkDelegate.h"

@class LetterBag;
@class Game;

enum CellTypeIndex {
	CONSTRUCTED_WORD_CELL_INDEX = 0,
	PROGRESS_BAR_CELL_INDEX,
	PLAYER_CELL_INDEX_START
};

@interface GameViewController : UIViewController <NetworkDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *gameTableView;
@property (nonatomic, strong) NSMutableArray *playerArray;
@property (nonatomic, strong) LetterBag *letterBag;
@property (nonatomic, strong) Game *game;

@end
