//
//  PlayerGameData.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@class PlayerCellView;

@interface PlayerGameData : NSObject

@property (nonatomic) NSInteger score;
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) NSMutableArray *tileArray;
@property (nonatomic, strong) PlayerCellView *playerCell;


@end
