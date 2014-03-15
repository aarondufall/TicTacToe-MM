//
//  ViewController.m
//  TicTacToe
//
//  Created by Aaron Dufall on 14/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "ViewController.h"

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
@property (strong, nonatomic) NSString *currentPlayer;



@end

@implementation ViewController{

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _rowOne = @[_myLabelOne, _myLabelTwo, _myLabelThree];
    _rowTwo = @[_myLabelFour, _myLabelFive, _myLabelSix];
    _rowThree = @[_myLabelSeven, _myLabelEight, _myLabelNine];
    
    _colOne = @[_myLabelOne, _myLabelFour,_myLabelSeven];
    _colTwo = @[_myLabelTwo, _myLabelFive, _myLabelEight];
    _colThree = @[_myLabelThree, _myLabelSix, _myLabelNine];
    
    _diagOne = @[_myLabelOne, _myLabelFive, _myLabelNine];
    _diagTwo = @[_myLabelThree, _myLabelFive, _myLabelThree];
    
    _patterns = @[_rowOne, _rowTwo, _rowThree, _colOne, _colTwo, _colThree, _diagOne, _diagTwo];
    
    
    [self setupNewGame];
}

-(void)setupNewGame
{
    self.currentPlayer = @"X";
    self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@",self.currentPlayer];
    for (NSArray *pattern in _patterns) {
        for (UILabel *label in pattern) {
            label.text = nil;
            label.backgroundColor = [UIColor whiteColor];
        }
    }
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

-(NSString *)nextPlayerTurn
{
    self.currentPlayer = [self.currentPlayer isEqualToString:@"X"] ? @"O" : @"X";
    return self.currentPlayer;
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
                    NSLog(@"Winner: %@ Pattern: %@", label.text, pattern);
                    for (UILabel * label in pattern) {
                        label.backgroundColor = [UIColor orangeColor];
                    }
                    return label.text;
                }
                
            } else {
                break;
            }
        }
    }
    
    return nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self setupNewGame];
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    UILabel *label = [self findLabelUsingPoint:[tapGestureRecognizer locationInView:self.gameView]];
    label.text = self.currentPlayer;
    if ([self whoWon]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Game Over"
                                                    message:[NSString stringWithFormat:@"%@ is the winner", label.text]
                                                   delegate:self
                                          cancelButtonTitle:@"New Game"
                                          otherButtonTitles:nil];
        [av show];
    } else {
        self.whichPlayerLabel.text = [NSString stringWithFormat:@"Current Player: %@", [self nextPlayerTurn]];
    }
}

@end
