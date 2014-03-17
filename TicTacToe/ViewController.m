//
//  ViewController.m
//  TicTacToe
//
//  Created by Aaron Dufall on 14/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "ViewController.h"
#import "GameBoard.h"
#import "OpponentAI.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *myLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *myLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFour;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFive;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSix;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSeven;
@property (weak, nonatomic) IBOutlet UILabel *myLabelEight;
@property (weak, nonatomic) IBOutlet UILabel *myLabelNine;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (weak, nonatomic) IBOutlet UIView *gameView;

@property (strong, nonatomic) GameBoard *board;
@property (strong, nonatomic) OpponentAI *opponent;

@property (strong, nonatomic) NSString *currentPlayerToken;

@property (weak, nonatomic) IBOutlet UILabel *currentTurnLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentBox;

@end

@implementation ViewController{

//    NSArray *_rowOne;
//    NSArray *_rowTwo;
//    NSArray *_rowThree;
//
//    NSArray *_colOne;
//    NSArray *_colTwo;
//    NSArray *_colThree;
//
//    NSArray *_diagOne;
//    NSArray *_diagTwo;

//    NSArray *_patterns;
    
    CGPoint orginalDraggablePlayerLocation;
    
    
    NSDate *_startDate;
    NSTimer *_timer;
    NSTimeInterval _totalCountDownInterval;
    NSInteger _remainingTime;

    BOOL _gameOver;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *tiles = @[_myLabelOne,_myLabelTwo, _myLabelThree, _myLabelFour, _myLabelFive, _myLabelSix, _myLabelSeven, _myLabelEight, _myLabelNine];
    
    GameBoard *gameBoard = [[GameBoard alloc]initWithTiles:tiles];
    self.board = gameBoard;
    self.opponent = [[OpponentAI alloc]initWithBoard:self.board];
    
    
    orginalDraggablePlayerLocation = self.currentTurnLabel.center;
    [self setupNewGame];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UILabel *)findLabelUsingPoint:(CGPoint)point
{
    for(UIView *aView in [self.gameView subviews])
    {
        if(CGRectContainsPoint(aView.frame, point))
        {
            return (UILabel *)aView;
        }
    }
    return nil;
}


-(void)setupNewGame
{
    [self.board resetBoard];
    
    self.currentPlayerToken = @"X";
    self.currentTurnLabel.center = orginalDraggablePlayerLocation;
    self.currentTurnLabel.text = self.currentPlayerToken;
    
    _gameOver = NO;
    
//    [self startTimer];
    
}

#pragma mark User Interface

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self setupNewGame];
}



#pragma mark User Input
- (IBAction)onDrag:(UIPanGestureRecognizer *)panGestureReconizer
{
    CGPoint point = [panGestureReconizer locationInView:self.view];
    CGPoint convertedPoint = [self.view convertPoint:point toView:self.gameView];
    
    self.currentTurnLabel.center = point;
    
    point.x += self.currentTurnLabel.frame.origin.x;
    point.y += self.currentTurnLabel.frame.origin.y;
    
    for (UILabel *box in self.board.tiles) {
        if (CGRectContainsPoint(box.frame, convertedPoint)) {
            _currentBox = box;
        }
    }
    
    if(panGestureReconizer.state == UIGestureRecognizerStateEnded)
    {
        [self placePlayer:self.currentPlayerToken inBoxLabel:self.currentBox];
        [self nextPlayerTurn];

    }
    
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    UILabel *label = [self findLabelUsingPoint:[tapGestureRecognizer locationInView:self.gameView]];
    
    [self placePlayer:self.currentPlayerToken inBoxLabel:label];
    [self nextPlayerTurn];
    
    
}

#pragma mark Game actions

-(NSString *)nextPlayerTurn
{
    
    if ([self.currentPlayerToken isEqualToString:@"X"]) {
        self.currentPlayerToken = @"O";
        [self placePlayer:self.currentPlayerToken inBoxLabel:[self.opponent takeTurn]];
        self.currentPlayerToken = @"X";
        
    }
//    [self checkWinner];

      // Single Player
      // self.currentPlayerToken = [self.currentPlayerToken isEqualToString:@"X"] ? @"O" : @"X";
  
    self.currentTurnLabel.center = orginalDraggablePlayerLocation;
    self.currentTurnLabel.text = self.currentPlayerToken;
//    [self startTimer];
    return self.currentPlayerToken;
}

-(void)placePlayer:(NSString *)player inBoxLabel:(UILabel *)box
{
        box.text = player;
        float delay = [player isEqualToString:@"X"]? 0 : 0.5;
        [box setTransform:CGAffineTransformMakeScale(0.25, 0.25)];
        box.alpha = 0.0;
        [UIView animateWithDuration:0.3 delay:delay options:UIViewAnimationOptionTransitionNone animations:^{
            [box setTransform:CGAffineTransformMakeScale(1.35, 1.35)];
            box.alpha = 1;
            [box setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        } completion:^(BOOL finished){
            if (finished) {
                [self checkWinner];
            }
        }];
    
}

-(void)checkWinner
{
    if ([self whoWon]) {
        [self showWinnerWithMessage:[NSString stringWithFormat:@"%@ is the winner", [self whoWon]]];
    } else if ([self.board isFull]){
        [self showWinnerWithMessage:@"It's A Draw"];
    }
}

-(void)showWinnerWithMessage:(NSString *)message
{
    _gameOver = YES;
    self.currentTurnLabel.center = orginalDraggablePlayerLocation;
    [self stopTimer];
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Game Over"
                                                message:message
                                               delegate:self
                                      cancelButtonTitle:@"New Game"
                                      otherButtonTitles:nil];
    
    self.whichPlayerLabel.alpha = 0;
    self.whichPlayerLabel.text = message;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        self.whichPlayerLabel.alpha = 1;
    } completion:nil];
    
    [self.whichPlayerLabel.layer performSelector:@selector(removeAllAnimations) withObject:nil afterDelay:2.0];
    [av performSelector:@selector(show) withObject:nil afterDelay:2.0];
}

-(NSString *)whoWon
{
    NSArray *winner;
    if ((winner = [self.board findPatternWithMatches:3 ofPlayer:@"X"])) {
        for (UILabel * label in winner) {
            label.backgroundColor = [UIColor orangeColor];
        }
        return @"X";
    }
    if ((winner = [self.board findPatternWithMatches:3 ofPlayer:@"O"])) {
        for (UILabel * label in winner) {
            label.backgroundColor = [UIColor orangeColor];
        }
        return @"O";
    }
    
    for (UILabel * label in winner) {
        label.backgroundColor = [UIColor orangeColor];
    }
    return nil;
}

#pragma mark Timer
-(void)startTimer
{
    
    if (!_totalCountDownInterval) {
        _totalCountDownInterval = 10.0;
    }
    _startDate = [NSDate date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                              target:self
                                            selector:@selector(updateCounter:)
                                            userInfo:nil
                                             repeats:YES];
    
    
}

-(void)stopTimer
{
    _remainingTime = nil;
    _startDate = nil;
    [_timer invalidate];
    _timer = nil;
}



-(void)updateCounter:(NSTimer *)timer
{
    NSTimeInterval secondsSinceStart = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _remainingTime = _totalCountDownInterval - secondsSinceStart;
    
    NSInteger seconds = _remainingTime % 60;
    NSString *result = [NSString stringWithFormat:@"Time Left: %02d", seconds];
    
    if (!_gameOver) {
        self.whichPlayerLabel.text = result;
        if (_remainingTime <= 0) {
            [self nextPlayerTurn];
        }
    }
}


@end
