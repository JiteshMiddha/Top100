//
//  FetchFromCoreDataOperation.h
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchFromCoreDataOperation : NSOperation

- (id)initWithCompletion: (void(^)(NSArray *list, NSError* error))completionHandler;

@end
