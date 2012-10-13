//
//  Network.h
//  CTL
//
//  Created by Anders Hassis on 2012-10-13.
//
//

#import <Foundation/Foundation.h>
#import "NetworkDelegate.h"
#import "GCHelper.h"

namespace board {
	struct State;
}

#pragma pack(push, 4)
struct MessageHeader {
	enum Type {
		BOARD_UPDATE
	};
	unsigned type;
	unsigned sequence;
};
#pragma pack(pop)

@class GameViewController;

@interface Network : NSObject <GCHelperDelegate>
@property (nonatomic, weak) UIViewController<NetworkDelegate> *delegate;

- (void)startGameWithNumbersOfPlayers:(NSInteger)numPlayers;
- (void)sendBoard:(const board::State&)board;

@end
