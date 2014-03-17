//
//  GameBoard.h
//  TicTacToe
//
//  Created by Aaron Dufall on 16/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameBoard : NSObject

@property (strong, nonatomic) NSArray *tiles;
@property (strong, nonatomic) NSArray *patterns;

- (id)initWithTiles:(NSArray *)tiles;
- (NSArray *)findPatternWithMatches:(int)numberOfMatches ofPlayer:(NSString *)player;


- (UILabel *)center;
- (NSArray *)corners;
- (NSArray *)sides;
- (void)resetBoard;
- (BOOL)isFull;


@end
