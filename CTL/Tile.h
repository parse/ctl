//
//  Tile.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TileView;
@class Letter;

@interface Tile : NSObject

@property (nonatomic, strong) TileView *tileView;
@property (nonatomic, strong) Letter *letter;

@end
