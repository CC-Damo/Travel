//
//  SSS1.m
//  Travel
//
//  Created by Damien Delay on 05/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import "SSS1.h"
#import "StopData.h"

@interface SSS1 ()

@end

@implementation SSS1
@synthesize searchBtn, searchField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{    [[self view]setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchField.delegate = self;
    [self setNavigationTransparent];
    
}

-(void)setNavigationTransparent{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new] ;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [searchField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField  {
    [searchField resignFirstResponder];
    return NO;
}

- (IBAction)submitBtnp:(id)sender {
    StopData *st = [StopData sharedManager];
/*    if(searchField.text.length != 8){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Invalid Stop Number!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    }else{*/
    st.stopNo = searchField.text;
    NSLog(@"%@", st.stopNo);
 //   }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"stopPush1"]){
        if(searchField.text.length !=8){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Invalid Stop Number!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        return YES;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
