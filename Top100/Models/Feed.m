//
//  SongsList.m
//  Top100
//
//  Created by Jitesh Middha on 23/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "Feed.h"


@implementation Feed

#define Key_feed @"feed"
#define Key_results @"results"

- (instancetype)initWithJSON: (NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        
        NSDictionary *feeds = [jsonDict objectForKey:Key_feed];
        NSArray *resultsArray = [feeds objectForKey:Key_results];
        self.songsList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *result in resultsArray) {
            
            Song *song = [[Song alloc] initWithJSON:result];
            [self.songsList addObject:song];
        }
    }
    return self;
}

@end
