//
//  CustomCellService.h
//  Travel
//
//  Created by Damien Delay on 05/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellService : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *serviceNumber;
@property (strong, nonatomic) IBOutlet UILabel *serviceTag;
@property (strong, nonatomic) IBOutlet UILabel *serviceETA;


@end
