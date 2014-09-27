//
//  StopData.h
//  Travel
//
//  Created by Damien Delay on 05/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopData : NSObject{
    NSString * stopNo;
}
@property (nonatomic, retain) NSString *stopNo;

+ (id)sharedManager;

@end
