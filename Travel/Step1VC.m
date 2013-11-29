//
//  Step1VC.m
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import "Step1VC.h"
#import "Step1Data.h"


@interface Step1VC ()

@end

@implementation Step1VC

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
    NSLog(@"=== Step One Loaded ===");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    Step1Data *sharedData = [Step1Data sharedManager];
    sharedData.serviceNumber = self.textField.text;
    NSLog(@"Shared Manager: %@", sharedData.serviceNumber);
}
@end
