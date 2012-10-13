//
//  NetworkDelegate.h
//  CTL
//
//  Created by Jim Sagevid on 10/13/12.
//
//

#ifndef CTL_NetworkDelegate_h
#define CTL_NetworkDelegate_h

namespace board {
	struct State;
}

@protocol NetworkDelegate
- (void)boardReceived:(const board::State&)board;
@end

#endif
