//
//  Step1VC.m
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import "Step1VC.h"
#import "Step1Data.h"
#import "ProgressHUD.h"

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
     [[self view]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];   
    NSLog(@"=== Step One Loaded ===");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.textField.delegate = self;

    [self setNavigationTransparent];
    
}

-(void)setNavigationTransparent{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new] ;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [self setNavigationTransparent];

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

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"serviceSearchPush1"]){
        if(self.textField.text.length <1){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Invalid Service Number!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        return YES;
    }
    return YES;
}

@end
