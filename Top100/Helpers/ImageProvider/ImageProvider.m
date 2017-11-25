//
//  ImageProvider.m
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "ImageProvider.h"


@interface ImageProvider ()
@property(strong, nonatomic) NSMutableDictionary *imageCache;
@end
@implementation ImageProvider

+ (id)sharedInstance {
    static ImageProvider *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCache = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)setImage:(UIImage *)image forUrl:(NSString *)url {
    self.imageCache[url] = image;
}

-(UIImage *)getImageforUrl:(NSString *)url {
    return self.imageCache[url];
}

-(BOOL)imageExistsForUrl:(NSString *)url {
    return self.imageCache[url];
}

@end
