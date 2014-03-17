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
    
    NSArray *_corners;
    NSArray *_sides;
    UILabel *_center;
    
    
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
        
        _center  = tiles[4];
        _corners = @[tiles[0],tiles[2],tiles[6],tiles[8]];
        _sides   = @[tiles[3],tiles[1],tiles[5],tiles[7]];
    }
    return self;
}

-(void)resetBoard
{
    for (UILabel *tile in self.tiles) {
        tile.text = nil;
        tile.backgroundColor = [UIColor whiteColor];
    }

}

- (BOOL)isFull
{
    int usedTile = 0;
    for (UILabel *tile in self.tiles) {
        if (tile.text) {
            usedTile++;
        }
    }
    if (usedTile >= 9) {
        return YES;
    }
    return NO;
}



- (NSArray *)findPatternWithMatches:(int)numberOfMatches ofPlayer:(NSString *)player
{
    for (NSArray *pattern in _patterns) {
        NSString *lastBox;
        BOOL containsOpponent = NO;
        int matches = 0;
        
        for (UILabel *label in pattern) {
            if ([label.text isEqualToString:player]) {
                
                if (!lastBox) {
                    lastBox = label.text;
                }
                if ([lastBox isEqualToString:player]) {
                    lastBox = label.text;
                    matches++;
                } else {
                    lastBox = label.text;
                }
            } else if (!label.text){
                containsOpponent = YES;
            }
        }
        if (matches >= numberOfMatches) {
            return pattern;
        }
    }
    
    return nil;
}

- (NSArray *)corners
{
    return _corners;
}

- (NSArray *)sides
{
    return _sides;
}

- (UILabel *)center
{
    return _center;
}

@end
