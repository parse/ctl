//
//  JoinGameViewController.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *const kSeguePresentGameController = @"presentGameViewController";

@interface JoinGameViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *playerArray;

@end
