//
//  Player.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *peerID;
@property (nonatomic, strong) UIImage *thumbnail;

@end
