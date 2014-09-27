//
//  TestingView.m
//  Travel
//
//  Created by Damien Delay on 22/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import "TestingView.h"

@interface TestingView ()

@end

@implementation TestingView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UIImageView *backGroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background"]];
    //[self.view addSubview:backGroundView];
    [[self view]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)travelline:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:01709515151"]];
    
}
@end
