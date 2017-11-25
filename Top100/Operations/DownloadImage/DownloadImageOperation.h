//
//  DownloadImageOperation.h
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SongsListCell.h"

@interface DownloadImageOperation : NSOperation
- (id)initWithUrl:(NSString *)urlString forCell:(SongsListCell *)cell;
@end
