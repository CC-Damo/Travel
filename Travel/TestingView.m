//
//  TestingView.m
//  Travel
//
//  Created by Damien Delay on 22/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import "TestingView.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


@interface TestingView ()

@end

@implementation TestingView
@synthesize callButton, callLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UIImageView *backGroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background"]];
    //[self.view addSubview:backGroundView];
    [[self view]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    if([self canDeviceMakeCall] == NO){
        callButton.hidden = true;
        callLabel.hidden = true;
        
    }
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    
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

-(IBAction)Facebook:(id)sender{
    NSURL *facebookURL = [NSURL URLWithString:@"fb://profile/262515318354"];
    if([[UIApplication sharedApplication] canOpenURL:facebookURL]){
        [[UIApplication sharedApplication] openURL:facebookURL];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com/262515318354"]];
    }
}
-(IBAction)Twitter:(id)sender{
    
    NSURL *twitterURL = [NSURL URLWithString:@"twitter:///user?screen_name=TravelSYorks"];
    if([[UIApplication sharedApplication] canOpenURL:twitterURL]){
        [[UIApplication sharedApplication] openURL:twitterURL];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/TravelSYorks"]];
    }
}

-(BOOL)canDeviceMakeCall{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        // Device supports phone calls, lets confirm it can place one right now
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [netInfo subscriberCellularProvider];
        NSString *mnc = [carrier mobileNetworkCode];
        if (([mnc length] == 0) || ([mnc isEqualToString:@"65535"])) {
            // Device cannot place a call at this time.  SIM might be removed.
            return NO;
        } else {
            // Device can place a phone call
            return YES;
        }
    } else {
        // Device does not support phone calls
        return  NO;
    }
}

@end
