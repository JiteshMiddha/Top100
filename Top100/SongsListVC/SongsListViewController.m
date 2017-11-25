//
//  SongsListViewController.m
//  Top100
//
//  Created by Jitesh Middha on 22/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import "SongsListViewController.h"
#import "SongsListCell.h"
#import "FetchListOperation.h"
#import "DownloadImageOperation.h"

#define Cell_FullWidth @"CellFullWidth"
#define Cell_TypeA @"CellTypeA"
#define Cell_TypeB @"CellTypeB"

@interface SongsListViewController() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSArray *songs;
@end

@implementation SongsListViewController

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.songs = [[NSArray alloc] init];
    self.queue = [NSOperationQueue new];
    
    [self fetchMusicList];
}


#pragma mark Private

-(void)fetchMusicList {
    __weak SongsListViewController *weakSelf = self;
    FetchListOperation *operation = [[FetchListOperation alloc] initWithCompletion:^(NSArray *list, NSError *error) {
        if (error) {
            // Peresent an error alert
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.songs = list;
            [weakSelf.collectionView reloadData];
        });
    }];
    
    [self.queue addOperation:operation];
}

#pragma mark - Collenction View Data Source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.songs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SongsListCell *cell;
    if (indexPath.item == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_FullWidth forIndexPath:indexPath];
    }
    else if(indexPath.item <= 6) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_TypeA forIndexPath:indexPath];
    }
    else {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_TypeB forIndexPath:indexPath];
    }
    
    
    Song *songObject = self.songs[indexPath.item];
    
    cell.artistNameLabel.text = songObject.artistName;
    cell.genreLabel.text = [songObject.genres componentsJoinedByString:@","];
    cell.artworkImageView.image = nil;
    
    DownloadImageOperation *operation = [[DownloadImageOperation alloc] initWithUrl:songObject.artworkUrl forCell:cell];
    
    [self.queue addOperation:operation];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        return CGSizeMake(collectionView.frame.size.width - 20, 150.0); // 20 = total margins from both sides (10 + 10)
    }
    else if(indexPath.item <= 6) {
        CGFloat size = (collectionView.frame.size.width - 20)/3 - 10;
        return CGSizeMake(size, size + 33); // 33 = fixed height for 2 single line label
    }
    CGFloat size = (collectionView.frame.size.width - 20)/3 - 10;
    return CGSizeMake(size, size);
}
@end
