//
//  Alphabet.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlphabetFactory : NSObject

+ (NSArray *)alphabetForLanguage:(NSString *)language;

@end
