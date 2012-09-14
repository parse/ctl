//
//  Packet.m
//  CTL
//
//  Created by Anders Hassis on 2012-09-14.
//
//

#import "Packet.h"

@implementation Packet
 
@synthesize packetNumber = _packetNumber;
@synthesize packetType = _packetType;
@synthesize sendReliably = _sendReliably;

+ (id)packetWithType:(PacketType)packetType
{
	return [[[self class] alloc] initWithType:packetType];
}

- (id)initWithType:(PacketType)packetType
{
	if ((self = [super init]))
	{
		self.packetNumber = -1;
		self.packetType = packetType;
		self.sendReliably = YES;
	}
	return self;
}


@end
