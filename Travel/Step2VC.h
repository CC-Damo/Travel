//
//  Step2VC.h
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Step2VC : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    NSDictionary *jsonDictionary;
    
    IBOutlet UITableView *jsonTable;
    NSArray *serviceName;
    NSArray *serviceProvider;
    NSArray *serviceNumber;
    NSArray *serviceUrl;
    NSURL *url;
    
}


@end
