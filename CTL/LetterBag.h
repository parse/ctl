//
//  LetterBag.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Letter;

@interface LetterBag : NSObject

- (Letter *)getLetter;
- (LetterBag *)initWithLanguage:(NSString *)language numberOfPlayers:(NSInteger)numberOfPlayers;

@end
