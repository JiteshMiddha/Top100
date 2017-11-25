//
//  ImageProvider.h
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageProvider : NSObject

+(id)sharedInstance;
-(BOOL)imageExistsForUrl:(NSString *)url;
-(void)setImage:(UIImage *)image forUrl:(NSString *)url;
-(UIImage *)getImageforUrl:(NSString *)url;

@end
