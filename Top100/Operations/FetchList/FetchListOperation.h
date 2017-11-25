//
//  FetchListOperation.h
//  Top100
//
//  Created by Jitesh Middha on 22/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

@interface FetchListOperation : NSOperation

- (id)initWithCompletion: (void(^)(NSArray* list, NSError* error))completionHandler;

@end
