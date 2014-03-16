//
//  OpponentAI.m
//  TicTacToe
//
//  Created by Aaron Dufall on 16/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "OpponentAI.h"
#import "GameBoard.h"

@implementation OpponentAI{
    GameBoard *_board;
    NSArray *_preferences;
}

- (id)initWithBoard:(GameBoard *)board
{
    if (self = [super init]) {
        _board = board;
    }
    return self;
}

-(UILabel *)takeTurn
{
    if (!_board.center.text) {
        return _board.center;
    }
    for (UILabel *tile in _board.corners) {
        if (!tile.text) {
            return tile;
        }
    }
    
    for (UILabel *tile in _board.sides) {
        if (!tile.text) {
            return tile;
        }
    }
    return nil;
}

@end
