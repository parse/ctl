//
//  Alphabet.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlphabetFactory.h"
#import "LanguageDefines.h"

@implementation AlphabetFactory

+ (NSArray *)alphabetForLanguage:(NSString *)language
{
	if ([language isEqualToString:SWEDISH]) {
		// TODO: lägg till resten av bokstäverna...
		return [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"X", @"Y", @"Z", @"Å", @"Ä", @"Ö", nil];
	} else if ([language isEqualToString:ENGLISH]) {
		// TODO: lägg till resten av bokstäverna...
		return [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
	}
	return nil;
}

@end
