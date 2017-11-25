//
//  Song.m
//  Top100
//
//  Created by Jitesh Middha on 23/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "Song.h"

@implementation Song

#define Key_artistName @"artistName"
#define Key_artworkUrl @"artworkUrl100"
#define Key_genres @"genres"
#define Key_name @"name"

- (instancetype)initWithJSON: (NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        
        self.artistName = [jsonDict objectForKey:Key_artistName];
        self.artworkUrl = [jsonDict objectForKey:Key_artworkUrl];
        
        NSArray *genreArray = [jsonDict objectForKey:Key_genres];
        
        self.genres = [[NSMutableArray alloc] init];
        for (NSDictionary *genreObject in genreArray) {
            
            NSString *genreString = [genreObject objectForKey:Key_name];
            [self.genres addObject:genreString];
        }
    }
    return self;
}

@end
