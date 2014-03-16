//
//  GameBoard.m
//  TicTacToe
//
//  Created by Aaron Dufall on 16/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "GameBoard.h"

@implementation GameBoard{
    
    NSArray *_rowOne;
    NSArray *_rowTwo;
    NSArray *_rowThree;
    
    NSArray *_colOne;
    NSArray *_colTwo;
    NSArray *_colThree;
    
    NSArray *_diagOne;
    NSArray *_diagTwo;
    
    NSArray *_patterns;
    
    
}


- (id)initWithTiles:(NSArray *)tiles
{
    if (self = [super init]) {
        _rowOne     = @[tiles[0], tiles[1], tiles[2]];
        _rowTwo     = @[tiles[3], tiles[4], tiles[5]];
        _rowThree   = @[tiles[6], tiles[7], tiles[8]];
        
        _colOne     = @[tiles[0], tiles[3], tiles[6]];
        _colTwo     = @[tiles[1], tiles[4], tiles[7]];
        _colThree   = @[tiles[2], tiles[5], tiles[8]];
        
        _diagOne = @[tiles[0], tiles[4], tiles[8]];
        _diagTwo = @[tiles[2], tiles[4], tiles[6]];
        
        _patterns = @[_rowOne, _rowTwo, _rowThree, _colOne, _colTwo, _colThree, _diagOne, _diagTwo];
        self.tiles = tiles;
    }
    return self;
}



-(NSString *)whoWon
{
    for (NSArray *pattern in _patterns) {
        NSString *lastBox;
        int matches = 0;
        
        for (UILabel *label in pattern) {
            if (label.text) {
                if (!lastBox) {
                    lastBox = label.text;
                }
                if ([lastBox isEqualToString:label.text]) {
                    lastBox = label.text;
                    matches++;
                } else {
                    lastBox = label.text;
                }
                
                if (matches >= 3) {
                    for (UILabel * label in pattern) {
                        label.backgroundColor = [UIColor orangeColor];
                    }
// put in winner check
//                    _gameOver = YES;
//                    self.currentTurnLabel.center = orginalDraggablePlayerLocation;
                    return label.text;
                }
                
            } else {
                break;
            }
        }
    }
    
    return nil;
}

@end
