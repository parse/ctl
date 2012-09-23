//
//  Game.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LetterBag;
@class PlayerGameData;

@interface Game : NSObject

@property (nonatomic) BOOL isServer;
@property (nonatomic, strong) LetterBag *letterBag;
@property (nonatomic, strong) NSMutableArray *playerGameDataArray;
@property (nonatomic, strong) NSString *language;

@end
