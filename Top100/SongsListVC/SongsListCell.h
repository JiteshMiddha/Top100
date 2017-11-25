//
//  SongsListCell.h
//  Top100
//
//  Created by Jitesh Middha on 23/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongsListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;

@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *genreLabel;

@end
