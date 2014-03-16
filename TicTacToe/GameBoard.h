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

- (NSString *)whoWon;

@end
