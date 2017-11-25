//
//  GetListFromAPI.h
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

@interface GetListFromAPI : NSOperation

- (id)initWithCompletion: (void(^)(Feed* feed, NSError* error))completionHandler;

@end
