//
//  InternetStatus.h
//  Top100
//
//  Created by Jitesh Middha on 25/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface InternetStatus : NSObject

+(BOOL)internetAvailable;
@end
