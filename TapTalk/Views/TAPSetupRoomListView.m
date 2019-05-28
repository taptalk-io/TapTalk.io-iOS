//
//  TAPSetupRoomListView.m
//  TapTalk
//
//  Created by Dominic Vedericho on 02/10/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import "TAPSetupRoomListView.h"

@interface TAPSetupRoomListView ()

@property (strong, nonatomic) UIView *firstLoadOverlayView;
@property (strong, nonatomic) UIView *firstLoadView;
@property (strong, nonatomic) UIImageView *firstLoadImageView;
@property (strong, nonatomic) UIImageView *firstLoadCenterIconImageView;
@property (strong, nonatomic) UILabel *titleFirstLoadLabel;
@property (strong, nonatomic) UILabel *descriptionFirstLoadLabel;

@end

@implementation TAPSetupRoomListView
#pragma mark - Lifecycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _firstLoadOverlayView = [[UIView alloc] initWithFrame:self.frame];
        self.firstLoadOverlayView.backgroundColor = [[TAPUtil getColor:@"04040F"] colorWithAlphaComponent:0.4f];
        [self addSubview:self.firstLoadOverlayView];
        
        _firstLoadView = [[UIView alloc] initWithFrame:CGRectMake(16.0f, (CGRectGetHeight(self.frame) - 220.0f) / 2.0f, CGRectGetWidth(self.frame) - 16.0f - 16.0f, 220.0f)];
        self.firstLoadView.backgroundColor = [UIColor whiteColor];
        self.firstLoadView.layer.cornerRadius = 8.0f;
        self.firstLoadView.clipsToBounds = YES;
        [self.firstLoadOverlayView addSubview:self.firstLoadView];
        
        _firstLoadImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.firstLoadView.frame) - 110.0f) / 2.0f, 32.0f, 110.0f, 110.0f)];
        self.firstLoadImageView.image = [UIImage imageNamed:@"TAPIconLoaderProgress" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
        [self.firstLoadView addSubview:self.firstLoadImageView];
        
        _firstLoadCenterIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.firstLoadImageView.frame) + 31.0f, CGRectGetMinY(self.firstLoadImageView.frame) + 31.0f, 48.0f, 48.0f)];
        self.firstLoadCenterIconImageView.image = [UIImage imageNamed:@"TAPIconNewSettingUp" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
        [self.firstLoadView addSubview:self.firstLoadCenterIconImageView];
        
        _titleFirstLoadLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, CGRectGetMaxY(self.firstLoadImageView.frame) + 8.0f, CGRectGetWidth(self.firstLoadView.frame) - 16.0f - 16.0f, 20.0f)];
        self.titleFirstLoadLabel.text = NSLocalizedString(@"Setting up Your Chat Room", @"");
        self.titleFirstLoadLabel.textColor = [TAPUtil getColor:TAP_COLOR_BLACK_44];
        self.titleFirstLoadLabel.font = [UIFont fontWithName:TAP_FONT_NAME_BOLD size:16.0f];
        NSMutableDictionary *titleFirstLoadAttributesDictionary = [NSMutableDictionary dictionary];
        CGFloat titleFirstLoadLetterSpacing = -0.4f;
        [titleFirstLoadAttributesDictionary setObject:@(titleFirstLoadLetterSpacing) forKey:NSKernAttributeName];
        NSMutableAttributedString *titleFirstLoadAttributedString = [[NSMutableAttributedString alloc] initWithString:self.titleFirstLoadLabel.text];
        [titleFirstLoadAttributedString addAttributes:titleFirstLoadAttributesDictionary
                                                range:NSMakeRange(0, [self.titleFirstLoadLabel.text length])];
        self.titleFirstLoadLabel.attributedText = titleFirstLoadAttributedString;
        self.titleFirstLoadLabel.textAlignment = NSTextAlignmentCenter;
        [self.firstLoadView addSubview:self.titleFirstLoadLabel];
    
        _descriptionFirstLoadLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleFirstLoadLabel.frame), CGRectGetMaxY(self.titleFirstLoadLabel.frame), CGRectGetWidth(self.titleFirstLoadLabel.frame), 18.0f)];
        self.descriptionFirstLoadLabel.textAlignment = NSTextAlignmentCenter;
        self.descriptionFirstLoadLabel.text = NSLocalizedString(@"Make sure you have a stable conection", @"");
        self.descriptionFirstLoadLabel.textColor = [TAPUtil getColor:TAP_COLOR_BLACK_44];
        self.descriptionFirstLoadLabel.font = [UIFont fontWithName:TAP_FONT_NAME_REGULAR size:13.0f];
        NSMutableDictionary *descriptionFirstLoadAttributesDictionary = [NSMutableDictionary dictionary];
        CGFloat descriptionFirstLoadLetterSpacing = -0.2f;
        [descriptionFirstLoadAttributesDictionary setObject:@(descriptionFirstLoadLetterSpacing) forKey:NSKernAttributeName];
        NSMutableAttributedString *descriptionFirstLoadAttributedString = [[NSMutableAttributedString alloc] initWithString:self.descriptionFirstLoadLabel.text];
        [descriptionFirstLoadAttributedString addAttributes:descriptionFirstLoadAttributesDictionary
                                                      range:NSMakeRange(0, [self.descriptionFirstLoadLabel.text length])];
        self.descriptionFirstLoadLabel.attributedText = descriptionFirstLoadAttributedString;
        [self.firstLoadView addSubview:self.descriptionFirstLoadLabel];
        
        self.firstLoadOverlayView.alpha = 0.0f;
        self.alpha = 0.0f;
    }
    return self;
}

#pragma mark - Custom Method
- (void)showSetupViewWithType:(TAPSetupRoomListViewType)type {
    if (type == TAPSetupRoomListViewTypeSettingUp) {
        self.titleFirstLoadLabel.text = NSLocalizedString(@"Setting up Your Chat Room", @"");
        self.descriptionFirstLoadLabel.text = NSLocalizedString(@"Make sure you have a stable conection", @"");
        self.firstLoadImageView.image = [UIImage imageNamed:@"TAPIconLoaderProgress" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
        self.firstLoadCenterIconImageView.image = [UIImage imageNamed:@"TAPIconNewSettingUp" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
    }
    else if (type == TAPSetupRoomListViewTypeSuccess) {
        self.titleFirstLoadLabel.text = NSLocalizedString(@"Setup successful", @"");
        self.descriptionFirstLoadLabel.text = NSLocalizedString(@"You are all set and ready to go!", @"");
        self.firstLoadImageView.image = [UIImage imageNamed:@"TAPIconLoaderSuccess" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
        self.firstLoadCenterIconImageView.image = [UIImage imageNamed:@"TAPIconNewSetupSuccess" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
    }
}

- (void)showFirstLoadingView:(BOOL)isVisible withType:(TAPSetupRoomListViewType)type {
    if (isVisible) {
        self.alpha = 1.0f;
        self.firstLoadOverlayView.alpha = 1.0f;
        
        if (type == TAPSetupRoomListViewTypeSettingUp) {
            //Remove Existing Animation
            if ([self.firstLoadImageView.layer animationForKey:@"SpinAnimation"] != nil) {
                [self.firstLoadImageView.layer removeAnimationForKey:@"SpinAnimation"];
            }
            
            //Add Animation
            if ([self.firstLoadImageView.layer animationForKey:@"SpinAnimation"] == nil) {
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                animation.fromValue = [NSNumber numberWithFloat:0.0f];
                animation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
                animation.duration = 1.5f;
                animation.repeatCount = INFINITY;
                animation.removedOnCompletion = NO;
                [self.firstLoadImageView.layer addAnimation:animation forKey:@"FirstLoadSpinAnimation"];
            }
        }
    }
    else {
        [UIView animateWithDuration:0.2f animations:^{
            self.firstLoadOverlayView.alpha = 0.0f;
            self.alpha = 0.0f;

            //Remove Animation
            if ([self.firstLoadImageView.layer animationForKey:@"SpinAnimation"] != nil) {
                [self.firstLoadImageView.layer removeAnimationForKey:@"SpinAnimation"];
            }
        }];
    }
}

@end
