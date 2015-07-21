//
//  AboutViewController.m
//  Travel
//
//  Created by Damien Delay on 11/10/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *fullURL = @"http://ddelay.co.uk/bus/";
    
    NSURL *url = [NSURL URLWithString:fullURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self setNavigationTransparent];
    [_webControler loadRequest:request];
    [[self view]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNavigationTransparent{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new] ;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
