//
//  TAPYourImageBubbleTableViewCell.h
//  TapTalk
//
//  Created by Welly Kencana on 29/10/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import "TAPBaseXIBRotatedTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TAPYourImageBubbleTableViewCellDelegate <NSObject>

- (void)yourImageReplyDidTappedWithMessage:(TAPMessageModel *)message;
- (void)yourImageQuoteDidTappedWithMessage:(TAPMessageModel *)message;

@end

@interface TAPYourImageBubbleTableViewCell : TAPBaseXIBRotatedTableViewCell

@property (weak, nonatomic) id<TAPYourImageBubbleTableViewCellDelegate> delegate;

@property (weak, nonatomic) TAPMessageModel *message;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewWidthConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewHeightConstraint;

- (void)setMessage:(TAPMessageModel *)message;
- (void)showStatusLabel:(BOOL)isShowed animated:(BOOL)animated;

- (void)showProgressDownloadView:(BOOL)show;
- (void)animateFailedDownloadingImage;
- (void)animateProgressDownloadingImageWithProgress:(CGFloat)progress total:(CGFloat)total;
- (void)animateFinishedDownloadingImage;
- (void)setInitialAnimateDownloadingImage;
- (void)setFullImage:(UIImage *)image;
- (void)setThumbnailImage:(UIImage *)thumbnailImage;

@end

NS_ASSUME_NONNULL_END
