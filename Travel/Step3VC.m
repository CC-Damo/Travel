//
//  Step3VC.m
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import "Step3VC.h"
#import "Step2Data.h"


@interface Step3VC ()

@end

@implementation Step3VC

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
    Step2Data *step2data = [Step2Data sharedManager];
    stopNames = [[NSArray alloc] init];
    stopNumbers = [[NSArray alloc] init];
    
    NSString *passedURL = [step2data.url stringByReplacingOccurrencesOfString:@"&" withString:@"?"];
    NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ddelay.co.uk/bus/find_services2.php?service=%@", passedURL]];
    url=finalURL;
    NSLog(@"=== Step Three Loaded ===");
    NSLog(@"URL: %@", url);
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
                    stopNames = [jsonDictionary valueForKey:@"stop_name"];
                    stopNumbers = [jsonDictionary valueForKey:@"stop_number"];
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
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [stopNumbers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stop";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [stopNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [stopNumbers objectAtIndex:indexPath.row];
    
    return cell;
}

@end
