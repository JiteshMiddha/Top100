//
//  Song.h
//  Top100
//
//  Created by Jitesh Middha on 23/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSMutableArray *genres;
@property (nonatomic, strong) NSString *artworkUrl;


- (instancetype)initWithJSON: (NSDictionary *)jsonDict;

@end
