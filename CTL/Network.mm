//
//  Network.m
//  CTL
//
//  Created by Anders Hassis on 2012-10-13.
//
//

#import "Network.h"
#import "GCHelper.h"

#include "Board.h"

inline void* pointer_add(const void* p, unsigned bytes) {
	return (char*)p + bytes;
}

@implementation Network {
	NSUInteger _sequence;
}

@synthesize delegate = _delegate;

- (NSString*)localPlayerID
{
	return [GKLocalPlayer localPlayer].playerID;
}

- (BOOL)isHost
{
	NSArray *ids = [[GCHelper sharedInstance] match].playerIDs;
	return [[ids objectAtIndex:0] isEqualToString:[self localPlayerID]];
}

- (void)startGameWithNumbersOfPlayers:(NSInteger)numPlayers
{
    [[GCHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:numPlayers viewController:self.delegate delegate:self];
}


- (void)sendData:(NSData *)data
{
    NSError *error;
    BOOL success = [[GCHelper sharedInstance].match sendDataToAllPlayers:data withDataMode:GKMatchSendDataReliable error:&error];
    if (!success) {
        NSLog(@"Error sending init packet");		
        [self matchEnded];
    }
}

-(void)sendBoard:(const board::State&)board
{
	NSMutableData *message = [NSMutableData dataWithCapacity:sizeof(MessageHeader) + sizeof(board::State)];
	unsigned char *data = (unsigned char*)message.mutableBytes;
	MessageHeader *header = (MessageHeader*)data;
	header->type = MessageHeader::BOARD_UPDATE;
	header->sequence = _sequence++;
	memcpy(&data[sizeof(MessageHeader)], &board, sizeof(board));
	
	[self sendData:message];
}

#pragma mark GCHelperDelegate

- (void)matchStarted {
    NSLog(@"Match started");
}

- (void)inviteReceived {

}

- (void)matchEnded {
    NSLog(@"Match ended");
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    MessageHeader* header = (MessageHeader*)data.bytes;
	if (header->type == MessageHeader::BOARD_UPDATE) {
		board::State *board = (board::State*)pointer_add(data.bytes, sizeof(MessageHeader));
		[_delegate boardReceived:*board];
	}
}

@end
