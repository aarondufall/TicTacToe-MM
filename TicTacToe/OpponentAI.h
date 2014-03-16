//
//  OpponentAI.h
//  TicTacToe
//
//  Created by Aaron Dufall on 16/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameBoard;

@interface OpponentAI : NSObject

- (id)initWithBoard:(GameBoard *)board;
- (UILabel *)takeTurn;

@end
