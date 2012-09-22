//
//  Game.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameMetaData.h"
#import "LetterBag.h"
#import "Letter.h"

@implementation GameMetaData

@synthesize isServer = _isServer;
@synthesize letterBag = _letterBag;
@synthesize playerGameDataArray = _playerGameDataArray;
@synthesize language = _language;

- (id)initWithPlayers
{
	if (self = [super init]) {
        
        return self;
	}
    
    return nil;
}

@end
