//
//  HelpViewController.m
//  TicTacToe
//
//  Created by Aaron Dufall on 16/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *urlString = @"http://en.wikipedia.org/wiki/Tic-tac-toe";
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
