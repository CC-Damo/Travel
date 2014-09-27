//
//  Step2VC.m
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import "Step4.h"
#import "Step3Data.h"
#import "ProgressHUD.h"
#import "CustomCellService.h"

@interface Step4 (){
    UIRefreshControl *refreshControl;
}

@end

@implementation Step4

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, 0, 0)];
    [self.tableView insertSubview:refreshView atIndex:0];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Refreshing.."];
    refreshControl.attributedTitle = refreshString;
    
    [refreshView addSubview:refreshControl];
    jsonDictionary = [[NSDictionary alloc] init];
    serviceTag = [[NSArray alloc]  init];
    serviceNumber = [[NSArray alloc] init];
    eta = [[NSArray alloc]init];
    
    Step3Data *sharedData = [Step3Data sharedManager];
    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ddelay.co.uk/bus/timetable.php?stop=%@", [sharedData stopNo]]];
    
    NSLog(@"=== Step 2 Loaded ===");
    self.title = [sharedData title];
    [super viewDidLoad];
    [self parseJSONWithURL:url];
    
    

}

-(void)refresh:(id)sender{

    [self parseJSONWithURL:url];
    NSLog(@"Refreshing..");
    [refreshControl endRefreshing];
    
}

//===================== Parse Data =======================
           // Parse the JSON data from the given URL
           - (void) parseJSONWithURL:(NSURL *) jsonURL
    {
        // Set the queue to the background queue. We will run this on the background thread to keep
        // the UI Responsive.
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        [ProgressHUD show:@"Please Wait..."];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        // Run request on background queue (thread).
        dispatch_async(queue, ^{
            NSError *error = nil;
            
            // Request the data and store in a string.
            NSString *json = [NSString stringWithContentsOfURL:jsonURL
                                                      encoding:NSASCIIStringEncoding
                                                         error:&error];
            if (error == nil){
                
                // Convert the String into an NSData object.
                NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
                
                
                // Parse that data object using NSJSONSerialization without options.
                jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
                NSLog(@"Data: %@", jsonDictionary);
                // Parsing success.
                if (error == nil)
                {
                    // Go back to the main thread and update the table with the json data.
                    // Keeps the user interface responsive.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        serviceTag = [jsonDictionary valueForKey:@"tag"];
                        serviceNumber = [jsonDictionary valueForKey:@"number"];
                        eta = [jsonDictionary valueForKey:@"eta"];
                        
                        if(serviceTag.count <= 0){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"No buses at this time." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                            [alertView show];
                            [self.refreshControl endRefreshing];
                        }

                         [jsonTable reloadData];
                        [ProgressHUD dismiss];
                        [refreshControl endRefreshing];
                        
                        
                    });
                }
                
                // Parsing failed, display error as alert.
                else
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Uh Oh, Parsing Failed." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                    [ProgressHUD dismiss];
                    [alertView show];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [refreshControl endRefreshing];
                }
            }
            
            // Request Failed, display error as alert.
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Request Error! Check that you are connected to wifi or 3G/4G with internet access." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [ProgressHUD dismiss];
                [alertView show];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [refreshControl endRefreshing];
            }
        });
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Row Count: %lu", (unsigned long)serviceNumber.count);
    NSLog(@"Row Count: %lu", (unsigned long)serviceTag.count);
    return [serviceNumber count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"servicesearch";
    
    CustomCellService *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setSeparatorInset:UIEdgeInsetsZero
     ];
    cell.serviceNumber.text = [serviceNumber objectAtIndex:indexPath.row];
    cell.serviceTag.text = [serviceTag objectAtIndex:indexPath.row];
    cell.serviceETA.text = [eta objectAtIndex:indexPath.row];
    
    
    return cell;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

@end
