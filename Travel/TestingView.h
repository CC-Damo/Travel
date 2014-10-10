//
//  TestingView.h
//  Travel
//
//  Created by Damien Delay on 22/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestingView : UIViewController
- (IBAction)travelline:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UILabel *callLabel;
- (IBAction)Facebook:(id)sender;
- (IBAction)Twitter:(id)sender;

@end
