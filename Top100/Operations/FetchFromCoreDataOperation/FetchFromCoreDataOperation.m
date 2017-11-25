//
//  FetchFromCoreDataOperation.m
//  Top100
//
//  Created by Jitesh Middha on 24/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "FetchFromCoreDataOperation.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Song.h"

@implementation FetchFromCoreDataOperation


#define ENTITY_NAME @"Songs"
#define CDKey_ArtistName @"artistName"
#define CDKey_ArtworkURL @"artworkUrl"
#define CDKey_Genre @"genres"

void (^fetchCompletion)(NSArray *, NSError *);


- (id)initWithCompletion: (void(^)(NSArray *list, NSError* error))completionHandler {
    self = [super init];
    if (self) {
        
        fetchCompletion = completionHandler;
    }
    return self;
}


-(void)main {
    
    NSManagedObjectContext *context = [self getContext];
    if (context) {
        
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:ENTITY_NAME];
    NSError *error = nil;
    NSMutableArray *fetchedResult = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    NSMutableArray *fetchedSongsArray = [[NSMutableArray alloc] init];
    if (error == nil) {
        
        for (NSManagedObject *result in fetchedResult) {
            Song *songObject = [[Song alloc] init];
            songObject.artistName = [result valueForKey:CDKey_ArtistName];
            songObject.artworkUrl = [result valueForKey:CDKey_ArtworkURL];
            
            NSMutableArray *genresArray = [NSKeyedUnarchiver unarchiveObjectWithData:[result valueForKey:CDKey_Genre]];
            songObject.genres = genresArray;
            [fetchedSongsArray addObject:songObject];
        }
    }
    fetchCompletion(fetchedSongsArray, error);
    }
}


-(NSManagedObjectContext *)getContext {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [delegate  privateQueueContext];
}

@end
