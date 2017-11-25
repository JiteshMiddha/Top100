//
//  DownloadImageOperation.m
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "DownloadImageOperation.h"
#import "ImageProvider.h"
#import "InternetStatus.h"

@interface DownloadImageOperation()
@property (nonatomic, strong) SongsListCell *cell;
@property (nonatomic, strong) NSString *url;
@end

@implementation DownloadImageOperation
- (id)initWithUrl:(NSString *)urlString forCell:(SongsListCell *)cell {
    self = [super init];
    if (self) {
        self.cell = cell;
        self.url = urlString;
    }
    return self;
}

-(void)main
{
    ImageProvider *sharedInstance = [ImageProvider sharedInstance];
    if ([sharedInstance imageExistsForUrl:self.url]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        self.cell.artworkImageView.image = [sharedInstance getImageforUrl:self.url];
        });
    }
    else {
        
        if ([InternetStatus internetAvailable]) {
       
            NSURL *urlObject = [NSURL URLWithString:self.url];
            
            [[[NSURLSession sharedSession] dataTaskWithURL:urlObject completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                if (error == nil) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.cell.artworkImageView.image = [UIImage imageWithData:data];
                        [sharedInstance setImage:[UIImage imageWithData:data] forUrl:self.url];
                    });
                }
                else {
                    // error handling
                }
                
            }] resume];
        }
        else {
            // internet not available
        }
    }
    
}

@end
