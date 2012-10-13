//
//  Network.m
//  CTL
//
//  Created by Anders Hassis on 2012-10-13.
//
//

#import "Network.h"
#import "GCHelper.h"

@implementation Network

- (void)startGameWithNumbersOfPlayers:(NSInteger)numPlayers viewController:(id)presentingViewController
{
    [[GCHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:numPlayers viewController:presentingViewController delegate:self];
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

-(void)sendBoard {
    // TODO: Send game
//    [sendData ]
}

- (void)sendData:(NSData *)data {
    NSError *error;
    BOOL success = [[GCHelper sharedInstance].match sendDataToAllPlayers:data withDataMode:GKMatchSendDataReliable error:&error];
    if (!success) {
        CCLOG(@"Error sending init packet");
        [self matchEnded];
    }
}

- (void)sendRandomNumber {
    
    MessageRandomNumber message;
    message.message.messageType = kMessageTypeRandomNumber;
    message.randomNumber = ourRandom;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageRandomNumber)];
    [self sendData:data];
}

- (void)sendGameBegin {
    
    MessageGameBegin message;
    message.message.messageType = kMessageTypeGameBegin;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameBegin)];
    [self sendData:data];
    
}

- (void)sendMove {
    
    MessageMove message;
    message.message.messageType = kMessageTypeMove;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageMove)];
    [self sendData:data];
    
}

- (void)sendGameOver:(BOOL)player1Won {
    
    MessageGameOver message;
    message.message.messageType = kMessageTypeGameOver;
    message.player1Won = player1Won;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameOver)];
    [self sendData:data];
    
}

#pragma mark GCHelperDelegate

- (void)matchStarted {
    NSLog(@"Match started");
    /*
     if (receivedRandom) {
     [self setGameState:kGameStateWaitingForStart];
     } else {
     [self setGameState:kGameStateWaitingForRandomNumber];
     }
     [self sendRandomNumber];
     [self tryStartGame];
     */
}

- (void)inviteReceived {
    [self restartTapped:nil];
}

- (void)matchEnded {
    NSLog(@"Match ended");
    [[GCHelper sharedInstance].match disconnect];
    [GCHelper sharedInstance].match = nil;
    //[self endScene:kEndReasonDisconnect];
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    
    // Store away other player ID for later
    if (otherPlayerID == nil) {
        otherPlayerID = [playerID retain];
    }
    
    Message *message = (Message *) [data bytes];
    if (message->messageType == kMessageTypeRandomNumber) {
        
        MessageRandomNumber * messageInit = (MessageRandomNumber *) [data bytes];
        NSLog(@"Received random number: %ud, ours %ud", messageInit->randomNumber, ourRandom);
        bool tie = false;
        
        if (messageInit->randomNumber == ourRandom) {
            NSLog(@"TIE!");
            tie = true;
            ourRandom = arc4random();
            [self sendRandomNumber];
        } else if (ourRandom > messageInit->randomNumber) {
            NSLog(@"We are player 1");
            isPlayer1 = YES;
        } else {
            NSLog(@"We are player 2");
            isPlayer1 = NO;
        }
        
        if (!tie) {
            receivedRandom = YES;
            if (gameState == kGameStateWaitingForRandomNumber) {
                [self setGameState:kGameStateWaitingForStart];
            }
            [self tryStartGame];
        }
        
    } else if (message->messageType == kMessageTypeGameBegin) {
        
        [self setGameState:kGameStateActive];
        [self setupStringsWithOtherPlayerId:playerID];
        
    } else if (message->messageType == kMessageTypeMove) {
        
        NSLog(@"Received move");
        
        if (isPlayer1) {
            [player2 moveForward];
        } else {
            [player1 moveForward];
        }
    } else if (message->messageType == kMessageTypeGameOver) {
        
        MessageGameOver * messageGameOver = (MessageGameOver *) [data bytes];
        NSLog(@"Received game over with player 1 won: %d", messageGameOver->player1Won);
        
        if (messageGameOver->player1Won) {
            [self endScene:kEndReasonLose];
        } else {
            [self endScene:kEndReasonWin];
        }
        
    }
}




@end
