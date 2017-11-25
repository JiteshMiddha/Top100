//
//  GetListFromAPI.m
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "GetListFromAPI.h"

@interface GetListFromAPI()

@end

@implementation GetListFromAPI

#define ListURL @"https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/100/non-explicit.json"

void (^getListCompletion)(Feed *feed, NSError *);

- (id)initWithCompletion: (void(^)(Feed* feed, NSError* error))completionHandler
{
    self = [super init];
    if (self) {
        
        getListCompletion = completionHandler;
    }
    return self;
}


-(void)main
{
    if ([self isCancelled]) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:ListURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error == nil) {
            
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            Feed *feedResponse = [[Feed alloc] initWithJSON:dict];
            getListCompletion(feedResponse, nil);
        }
        else {
            getListCompletion(nil, error);
        }
        
    }];

    [task resume];
}

@end
