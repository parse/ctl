//
//  HostGameViewController.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCHelper.h"

@interface HostGameViewController : UIViewController <GCHelperDelegate>

@property (nonatomic, strong) NSMutableArray *playerArray;

@end
