//
//  Step2Data.h
//  Travel
//
//  Created by Damo-Dev on 28/11/2013.
//  Copyright (c) 2013 DDelay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Step2Data : NSObject{
    NSString *url;
}

@property (nonatomic, retain) NSString *url;

+ (id)sharedManager;


@end
