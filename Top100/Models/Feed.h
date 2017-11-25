//
//  SongsList.h
//  Top100
//
//  Created by Jitesh Middha on 23/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface Feed : NSObject

@property (nonatomic, strong) NSMutableArray *songsList;

- (instancetype)initWithJSON: (NSDictionary *)jsonDict;

@end
