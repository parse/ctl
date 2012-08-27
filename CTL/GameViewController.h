//
//  GameViewController.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LetterBag;
@class Game;

NSString *const kSeguePresentGameViewController = @"presentGameViewController";

@interface GameViewController : UIViewController {
}

@property (nonatomic, strong) NSMutableArray *playerArray;
@property (nonatomic, strong) LetterBag *letterBag;
@property (nonatomic, strong) Game *gameMetaData;

@end
