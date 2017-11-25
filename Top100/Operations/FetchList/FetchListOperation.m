//
//  FetchListOperation.m
//  Top100
//
//  Created by Jitesh Middha on 22/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "FetchListOperation.h"
#import "GetListFromAPI.h"
#import "SaveOperation.h"
#import "FetchFromCoreDataOperation.h"
#import "InternetStatus.h"

@interface FetchListOperation()

@property (nonatomic, strong) Feed *feed;

@end


@implementation FetchListOperation

void (^completionBlock)(NSArray *list, NSError *);

- (id)initWithCompletion: (void(^)(NSArray* list, NSError* error))completionHandler
{
    self = [super init];
    if (self) {
        completionBlock = completionHandler;
    }
    return self;
}


-(void)main
{
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 1;
    if ([InternetStatus internetAvailable]) { // internet available
        
        // fetching from api
        GetListFromAPI *getOperation = [[GetListFromAPI alloc] initWithCompletion:^(Feed *feed, NSError *error) {
            
            self.feed = feed;

            // saving to core data
            SaveOperation *saveOperation = [[SaveOperation alloc] initWithSongList: self.feed.songsList];
            [queue addOperation:saveOperation];
    
            // fetching from core data
            FetchFromCoreDataOperation *cdFetchOperation = [[FetchFromCoreDataOperation alloc] initWithCompletion:^(NSArray *list, NSError *error) {
                
                completionBlock(list, error);
            }];
            [cdFetchOperation addDependency:saveOperation];
            [queue addOperation:cdFetchOperation];
        }];
        [queue addOperation:getOperation];
    }
    else {
        
        FetchFromCoreDataOperation *cdFetchOperation = [[FetchFromCoreDataOperation alloc] initWithCompletion:^(NSArray *list, NSError *error) {
            
            completionBlock(list, error);
        }];
        [queue addOperation:cdFetchOperation];
    }
}



@end
