//
//  Step2VC.m
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import "Step2VC.h"
#import "Step1Data.h"
#import "CustomCell.h"
#import "Step2Data.h"


@interface Step2VC ()

@end

@implementation Step2VC

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
    jsonDictionary = [[NSDictionary alloc] init];
    serviceName = [[NSArray alloc]  init];
    serviceNumber = [[NSArray alloc] init];
    serviceProvider = [[NSArray alloc]init];
    serviceUrl = [[NSArray alloc] init];
    
    Step1Data *sharedData = [Step1Data sharedManager];
    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ddelay.co.uk/bus/find_services.php?service=%@", [sharedData serviceNumber]]];
           
    NSLog(@"=== Step 2 Loaded ===");
    self.title = [NSString stringWithFormat:@"Search: %@", sharedData.serviceNumber];
    [super viewDidLoad];
    [self parseJSONWithURL:url];
    

}
//===================== Parse Data =======================
           // Parse the JSON data from the given URL
           - (void) parseJSONWithURL:(NSURL *) jsonURL
    {
        // Set the queue to the background queue. We will run this on the background thread to keep
        // the UI Responsive.
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        
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
                        serviceName = [jsonDictionary valueForKey:@"desc"];
                        serviceNumber = [jsonDictionary valueForKey:@"service"];
                        serviceProvider = [jsonDictionary valueForKey:@"provider"];
                        serviceUrl = [jsonDictionary valueForKey:@"desc URL"];
                        [jsonTable reloadData];
                    });
                }
                
                // Parsing failed, display error as alert.
                else
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Uh Oh, Parsing Failed." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                    
                    [alertView show];
                }
            }
            
            // Request Failed, display error as alert.
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Request Error! Check that you are connected to wifi or 3G/4G with internet access." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                
                [alertView show];
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
    return serviceNumber.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"service";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.numberLabel.text = [serviceNumber objectAtIndex:indexPath.row];
    cell.nameLabel.text = [serviceName objectAtIndex:indexPath.row];
    cell.providerLabel.text  = [serviceProvider objectAtIndex:indexPath.row];
    
    Step2Data *step2data = [Step2Data sharedManager];
    step2data.url = [serviceUrl objectAtIndex:indexPath.row];
  //  NSLog(@"URL: %@", step2data.url);
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

@end
