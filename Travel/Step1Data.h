//
//  Step1Data.h
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Step1Data : NSObject{
    NSString *serviceNumber;
}

@property (nonatomic, retain) NSString *serviceNumber;

+ (id)sharedManager;

@end
