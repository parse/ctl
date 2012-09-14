//
//  Packet.h
//  CTL
//
//  Created by Anders Hassis on 2012-09-14.
//
//

#import <Foundation/Foundation.h>

typedef enum
{
	PacketTypeSignInRequest = 0x64,    // server to client
	PacketTypeSignInResponse,          // client to server
    
	PacketTypeServerReady,             // server to client
	PacketTypeClientReady,             // client to server
    
	PacketTypeDealLetters,               // server to client
	PacketTypeClientDealtLetters,        // client to server
    
	PacketTypeActivatePlayer,          // server to client
	PacketTypeClientPlayed,             // client to server
	
	PacketTypeOtherClientQuit,         // server to client
	PacketTypeServerQuit,              // server to client
	PacketTypeClientQuit,              // client to server
}
PacketType;

@interface Packet : NSObject

@property (nonatomic, assign) int packetNumber;
@property (nonatomic, assign) PacketType packetType;
@property (nonatomic, assign) BOOL sendReliably;

+ (id)packetWithType:(PacketType)packetType;
- (id)initWithType:(PacketType)packetType;

@end
