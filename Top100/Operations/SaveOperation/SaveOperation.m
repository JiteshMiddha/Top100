//
//  SaveOperation.m
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "SaveOperation.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Song.h"

@interface SaveOperation()

@property (nonatomic, strong) NSArray *songs;

@end


@implementation SaveOperation

#define ENTITY_NAME @"Songs"
#define CDKey_ArtistName @"artistName"
#define CDKey_ArtworkURL @"artworkUrl"
#define CDKey_Genre @"genres"


- (id)initWithSongList: (NSArray *)songs
{
    self = [super init];
    if (self) {
        
        self.songs = songs;
    }
    return self;
}


-(void)main
{
    [self truncateData];
    [self saveSongsList];
}


-(NSManagedObjectContext *)getContext {
    
//    __block AppDelegate *delegate;
//    dispatch_async(dispatch_get_main_queue(), ^{
//
       AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    });
    
        return [delegate privateQueueContext];
    
}

-(void)saveSongsList {
    
    NSManagedObjectContext *context = [self getContext];
    if (context) {
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    
    for (Song *song in self.songs) {
        
        NSManagedObject *newSongObject = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        [newSongObject setValue:song.artistName ? song.artistName : @"" forKey:CDKey_ArtistName];
        [newSongObject setValue:song.artworkUrl ? song.artworkUrl : @"" forKey:CDKey_ArtworkURL];
        
        NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:song.genres];
        if (arrayData) {
            
            [newSongObject setValue:arrayData forKey:CDKey_Genre];
        }
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
    }
    }
}

-(void) truncateData {
 
    NSManagedObjectContext *context = [self getContext];
    if (context) {
 
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:ENTITY_NAME];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    [context executeRequest:delete error:&deleteError];
    }
}
@end
