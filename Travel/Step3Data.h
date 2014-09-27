//
//  Step3Data.h
//  Travel
//
//  Created by Damien Delay on 04/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Step3Data : NSObject{
    NSString *stopNo;
    NSString *title;
    
}

@property (nonatomic, retain) NSString *stopNo;
@property (nonatomic, retain) NSString *title;
+(id)sharedManager;

@end
