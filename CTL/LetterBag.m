//
//  LetterBag.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LetterBag.h"
#import "Letter.h"
#import "AlphabetFactory.h"
#import "LanguageDefines.h"

@implementation LetterBag {
	NSMutableArray *letters;
}

- (LetterBag *)initWithLanguage:(NSString *)language numberOfPlayers:(NSInteger)numberOfPlayers
{
	if (self = [super init]) {
		letters = [[NSMutableArray alloc] init];
		NSArray *alphabet;
		for (int i = 0; i < numberOfPlayers; i++) {
			alphabet = [AlphabetFactory alphabetForLanguage:language];
			[letters addObjectsFromArray:alphabet];
		}
	}
	
	return self;
}

/**
 * Used to get a letter for the gameBoard. 
 * Removes the letter that has been returned.
 */
- (Letter *)getLetter
{
	NSInteger rand = arc4random()%letters.count;
	Letter *letter = [letters objectAtIndex:rand];
	[letters removeObject:letter];
	return letter;
}

@end
