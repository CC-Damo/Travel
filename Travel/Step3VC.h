//
//  Step3VC.h
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Step3VC : UITableViewController<UITableViewDataSource, UITableViewDelegate>{
    NSDictionary *jsonDictionary;
    
    IBOutlet UITableView *jsonTable;
    NSArray *stopNames;
    NSArray *stopNumbers;
    NSURL *url;
}

@end
