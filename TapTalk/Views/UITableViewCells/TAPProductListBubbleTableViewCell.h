//
//  TAPProductListBubbleTableViewCell.h
//  TapTalk
//
//  Created by Dominic Vedericho on 05/11/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import "TAPBaseXIBRotatedTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TAPProductListBubbleTableViewCellType) {
    TAPProductListBubbleTableViewCellTypeSingleOption = 0,
    TAPProductListBubbleTableViewCellTypeTwoOption = 1
};

@protocol TAPProductListBubbleTableViewCellDelegate <NSObject>

- (void)productListBubbleDidTappedLeftOrSingleOptionWithData:(TAPMessageModel *)message isSingleOptionView:(BOOL)isSingleOption;
- (void)productListBubbleDidTappedRightOptionWithData:(TAPMessageModel *)message isSingleOptionView:(BOOL)isSingleOption;
@end

@interface TAPProductListBubbleTableViewCell : TAPBaseXIBRotatedTableViewCell

@property (nonatomic) TAPProductListBubbleTableViewCellType productListBubbleTableViewCellType;
@property (weak, nonatomic) id<TAPProductListBubbleTableViewCellDelegate> delegate;

- (void)setProductListBubbleCellWithData:(NSArray *)productDataArray;
- (void)setProductListBubbleTableViewCellType:(TAPProductListBubbleTableViewCellType)productListBubbleTableViewCellType;

@end

NS_ASSUME_NONNULL_END
