//
//  TAPMyAccountView.m
//  TapTalk
//
//  Created by Dominic Vedericho on 04/05/19.
//  Copyright © 2019 Moselo. All rights reserved.
//

#import "TAPMyAccountView.h"

@interface TAPMyAccountView ()

@property (strong, nonatomic) UILabel *changeLabel;
@property (strong, nonatomic) UILabel *loadingLabel;
@property (strong, nonatomic) UIImageView *changeIconImageView;
@property (strong, nonatomic) UIImageView *loadingImageView;

@property (strong, nonatomic) UIView *progressBarBackgroundView;
@property (strong, nonatomic) UIView *progressBarView;
@property (strong, nonatomic) CAShapeLayer *progressLayer;
@property (nonatomic) CGFloat lastProgress;
@property (nonatomic) CGFloat newProgress;
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;
@property (nonatomic) NSInteger updateInterval;

- (void)setChangeImageButtonAsEnabled:(BOOL)enabled;
- (void)animateFinishedUploadingImage;

@end

@implementation TAPMyAccountView
#pragma mark - Lifecycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        self.backgroundColor = [TAPUtil getColor:TAP_COLOR_WHITE_F3];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetMaxY(self.scrollView.frame));
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = [TAPUtil getColor:TAP_COLOR_WHITE_F3];
        [self addSubview:self.scrollView];
        
        CGFloat profilePictureTopGap = 26.0f;
        if (IS_IPHONE_X_FAMILY) {
            profilePictureTopGap = 6.0f; //-20.0f for navigation bar height different from iphone 8 and below
        }
        
        //Min Y profile image view + profile image view height + gap with change label + change label height + bottom gap
        CGFloat halfRoundWhiteBackgroundViewHeight = [TAPUtil currentDeviceNavigationBarHeightWithStatusBar:YES iPhoneXLargeLayout:NO] + profilePictureTopGap + 96.0f + 8.0f + 22.0f + 24.0f;
        _halfRoundWhiteBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -halfRoundWhiteBackgroundViewHeight, CGRectGetWidth(self.frame), halfRoundWhiteBackgroundViewHeight * 2)];
        self.halfRoundWhiteBackgroundView.layer.cornerRadius = CGRectGetWidth(self.halfRoundWhiteBackgroundView.frame) / 2.0f;
        self.halfRoundWhiteBackgroundView.layer.borderWidth = 1.0f;
        self.halfRoundWhiteBackgroundView.layer.borderColor = [TAPUtil getColor:TAP_COLOR_GREY_DC].CGColor;
        self.halfRoundWhiteBackgroundView.backgroundColor = [UIColor whiteColor];
    
        UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.halfRoundWhiteBackgroundView.frame) / 2.0f, CGRectGetWidth(self.halfRoundWhiteBackgroundView.frame), CGRectGetHeight(self.halfRoundWhiteBackgroundView.frame) / 2.0f)];
        mask.backgroundColor = [TAPUtil getColor:TAP_COLOR_GREY_DC];
        self.halfRoundWhiteBackgroundView.layer.mask = mask.layer;
        [self.scrollView addSubview:self.halfRoundWhiteBackgroundView];
        
        _additionalWhiteBounceView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 0.0f)];
        self.additionalWhiteBounceView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:self.additionalWhiteBounceView];
        
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), [TAPUtil currentDeviceNavigationBarHeightWithStatusBar:YES iPhoneXLargeLayout:NO])];
        self.shadowView.backgroundColor = [[TAPUtil getColor:TAP_COLOR_BLACK_19] colorWithAlphaComponent:0.3f];
        self.shadowView.layer.shadowRadius = 2.0f;
        self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.shadowView.layer.shadowOpacity = 1.0f;
        self.shadowView.layer.masksToBounds = NO;
        self.shadowView.alpha = 0.0f;
        [self addSubview:self.shadowView];
        
        _navigationHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), [TAPUtil currentDeviceNavigationBarHeightWithStatusBar:YES iPhoneXLargeLayout:NO])];
        self.navigationHeaderView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.navigationHeaderView];
        
        _navigationSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.navigationHeaderView.frame) - 1.0f, CGRectGetWidth(self.navigationHeaderView.frame), 1.0f)];
        self.navigationSeparatorView.backgroundColor = [TAPUtil getColor:TAP_COLOR_GREY_DC];
        self.navigationSeparatorView.alpha = 0.0f;
        [self.navigationHeaderView addSubview:self.navigationSeparatorView];
        
        //12.0f = nav bar height (44.0f) - height / 2
        _cancelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16.0f, [TAPUtil currentDeviceStatusBarHeight] + 10.0f, 24.0f, 24.0f)];
        self.cancelImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.cancelImageView.image = [UIImage imageNamed:@"TAPIconCancelOrange" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
        [self addSubview:self.cancelImageView];
        
        _loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16.0f, [TAPUtil currentDeviceStatusBarHeight] + 10.0f, 24.0f, 24.0f)];
        self.loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.loadingImageView.image = [UIImage imageNamed:@"TAPIconLoadingOrange" inBundle:[TAPUtil currentBundle] compatibleWithTraitCollection:nil];
        self.loadingImageView.alpha = 0.0f;
        [self addSubview:self.loadingImageView];

        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.cancelImageView.frame) - 8.0f, CGRectGetMinY(self.cancelImageView.frame) - 8.0f, 40.0f, 40.0f)];
        [self addSubview:self.cancelButton];
        
        CGFloat leftGap = CGRectGetMaxX(self.cancelButton.frame) + 32.0f;
        _navigationHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftGap, [TAPUtil currentDeviceStatusBarHeight] + 9.0f, CGRectGetWidth(self.navigationHeaderView.frame) - leftGap - leftGap, 25.0f)];
        self.navigationHeaderLabel.textColor = [TAPUtil getColor:TAP_COLOR_BLACK_19];
        self.navigationHeaderLabel.font = [UIFont fontWithName:TAP_FONT_NAME_BOLD size:20.0f];
        self.navigationHeaderLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationHeaderLabel.text = NSLocalizedString(@"My Account", @"");
        [self.navigationHeaderView addSubview:self.navigationHeaderLabel];
        
        _profileImageView = [[TAPImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 96.0f) / 2, CGRectGetMaxY(self.navigationHeaderView.frame) + profilePictureTopGap, 96.0f, 96.0f)];
        self.profileImageView.layer.cornerRadius = CGRectGetWidth(self.profileImageView.frame) / 2.0f;
        self.profileImageView.image = [UIImage imageNamed:@"TAPIconDefaultAvatar"];
        self.profileImageView.layer.masksToBounds = YES;
        self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:self.profileImageView];
        
        _progressBarBackgroundView = [[UIView alloc] initWithFrame:self.profileImageView.frame];
        self.progressBarBackgroundView.layer.cornerRadius = CGRectGetWidth(self.progressBarBackgroundView.frame) / 2.0f;
        self.progressBarBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        self.progressBarBackgroundView.alpha = 0.0f;
        [self.scrollView addSubview:self.progressBarBackgroundView];
        
        _progressBarView = [[UIView alloc] initWithFrame:CGRectMake(12.0f, 12.0f, CGRectGetWidth(self.progressBarBackgroundView.frame) - 12.0f - 12.0f, CGRectGetWidth(self.progressBarBackgroundView.frame) - 12.0f - 12.0f)];
        self.progressBarView.backgroundColor = [UIColor clearColor];
        [self.progressBarBackgroundView addSubview:self.progressBarView];
        
        //CS TEMP - hide remove profilebutton temporaryly
//        _removeProfilePictureButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.profileImageView.frame) - 24.0f, CGRectGetMinY(self.profileImageView.frame), 24.0f, 24.0f)];
//        [self.removeProfilePictureButton setImage:[UIImage imageNamed: @"TAPIconRemoveRedShine"] forState:UIControlStateNormal];
//        self.removeProfilePictureButton.alpha = 0.0f;
//        [self.scrollView addSubview:self.removeProfilePictureButton];
        
        _changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.profileImageView.frame) + 8.0f, 100.0f, 22.0f)];
        self.changeLabel.font = [UIFont fontWithName:TAP_FONT_NAME_BOLD size:16.0f];
        self.changeLabel.text = NSLocalizedString(@"Change", @"");
        self.changeLabel.textColor = [TAPUtil getColor:TAP_COLOR_ORANGE_00];
        CGSize changeLabelSize = [self.changeLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, 22.0f)];
        self.changeLabel.frame = CGRectMake((CGRectGetWidth(self.frame) - changeLabelSize.width - 4.0f - 14.0f) / 2, CGRectGetMinY(self.changeLabel.frame), changeLabelSize.width, 22.0f);
        [self.scrollView addSubview:self.changeLabel];
        
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.profileImageView.frame) + 8.0f, CGRectGetWidth(self.frame), 22.0f)];
        self.loadingLabel.font = [UIFont fontWithName:TAP_FONT_NAME_MEDIUM size:16.0f];
        self.loadingLabel.textColor = [TAPUtil getColor:TAP_COLOR_GREY_9B];
        self.loadingLabel.text = NSLocalizedString(@"Uploading", @"");
        self.loadingLabel.alpha = 0.0f;
        self.loadingLabel.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:self.loadingLabel];
        
        _changeIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.changeLabel.frame) + 4.0f, CGRectGetMinY(self.changeLabel.frame) + 4.0f, 14.0f, 14.0f)];
        self.changeIconImageView.image = [UIImage imageNamed:@"TAPIconEditOrange"];
        [self.scrollView addSubview:self.changeIconImageView];
        
        _changeProfilePictureButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.changeLabel.frame), CGRectGetMinY(self.changeLabel.frame) - 8.0f, CGRectGetWidth(self.changeLabel.frame) + 4.0f + CGRectGetWidth(self.changeIconImageView.frame), 40.0f)];
        [self.scrollView addSubview:self.changeProfilePictureButton];
        
        _fullNameTextField = [[TAPCustomTextFieldView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.changeLabel.frame) + 48.0f, CGRectGetWidth(self.frame), 0.0f)];
        [self.fullNameTextField setTapCustomTextFieldViewType:TAPCustomTextFieldViewTypeFullName];
        self.fullNameTextField.frame = CGRectMake(CGRectGetMinX(self.fullNameTextField.frame), CGRectGetMinY(self.fullNameTextField.frame), CGRectGetWidth(self.fullNameTextField.frame), [self.fullNameTextField getTextFieldHeight]);
        [self.scrollView addSubview:self.fullNameTextField];
        
        _usernameTextField = [[TAPCustomTextFieldView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.fullNameTextField.frame) + 24.0f, CGRectGetWidth(self.frame), 0.0f)];
        [self.usernameTextField setTapCustomTextFieldViewType:TAPCustomTextFieldViewTypeUsernameWithoutDescription];
        self.usernameTextField.frame = CGRectMake(CGRectGetMinX(self.usernameTextField.frame), CGRectGetMinY(self.usernameTextField.frame), CGRectGetWidth(self.usernameTextField.frame), [self.usernameTextField getTextFieldHeight]);
        [self.scrollView addSubview:self.usernameTextField];
        
        _mobileNumberTextField = [[TAPCustomTextFieldView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.usernameTextField.frame) + 24.0f, CGRectGetWidth(self.frame), 0.0f)];
        [self.mobileNumberTextField setTapCustomTextFieldViewType:TAPCustomTextFieldViewTypeMobileNumber];
        self.mobileNumberTextField.frame = CGRectMake(CGRectGetMinX(self.mobileNumberTextField.frame), CGRectGetMinY(self.mobileNumberTextField.frame), CGRectGetWidth(self.mobileNumberTextField.frame), [self.mobileNumberTextField getTextFieldHeight]);
        [self.scrollView addSubview:self.mobileNumberTextField];
        
        _emailTextField = [[TAPCustomTextFieldView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.mobileNumberTextField.frame) + 24.0f, CGRectGetWidth(self.frame), 0.0f)];
        [self.emailTextField setTapCustomTextFieldViewType:TAPCustomTextFieldViewTypeEmailOptional];
        self.emailTextField.frame = CGRectMake(CGRectGetMinX(self.emailTextField.frame), CGRectGetMinY(self.emailTextField.frame), CGRectGetWidth(self.emailTextField.frame), [self.emailTextField getTextFieldHeight]);
        [self.scrollView addSubview:self.emailTextField];
        
        _continueButtonView = [[TAPCustomButtonView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.emailTextField.frame) + 24.0f, CGRectGetWidth(self.frame), 50.0f)];
        [self.continueButtonView setCustomButtonViewType:TAPCustomButtonViewTypeInactive];
        [self.continueButtonView setButtonWithTitle:NSLocalizedString(@"Continue", @"")];
//        [self.scrollView addSubview:self.continueButtonView]; //CS TEMP - hide continue button
        
        CGFloat bottomGap = 16.0f;
        if (IS_IPHONE_X_FAMILY) {
            bottomGap = [TAPUtil safeAreaBottomPadding];
        }
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetMaxY(self.continueButtonView.frame) + bottomGap);
        
        _startAngle = M_PI * 1.5;
        _endAngle = self.startAngle + (M_PI * 2);
        _newProgress = 0.0f;
        _updateInterval = 1;
    }
    
    return self;
}

#pragma mark - Custom Method
- (void)refreshViewPosition {
    [UIView animateWithDuration:0.2f animations:^{
        self.fullNameTextField.frame = CGRectMake(CGRectGetMinX(self.fullNameTextField.frame), CGRectGetMinY(self.fullNameTextField.frame), CGRectGetWidth(self.fullNameTextField.frame), [self.fullNameTextField getTextFieldHeight]);
        self.usernameTextField.frame = CGRectMake(CGRectGetMinX(self.usernameTextField.frame), CGRectGetMaxY(self.fullNameTextField.frame) + 24.0f, CGRectGetWidth(self.usernameTextField.frame), [self.usernameTextField getTextFieldHeight]);
        self.mobileNumberTextField.frame = CGRectMake(CGRectGetMinX(self.mobileNumberTextField.frame), CGRectGetMaxY(self.usernameTextField.frame) + 24.0f, CGRectGetWidth(self.mobileNumberTextField.frame), [self.mobileNumberTextField getTextFieldHeight]);
        self.emailTextField.frame = CGRectMake(CGRectGetMinX(self.emailTextField.frame), CGRectGetMaxY(self.mobileNumberTextField.frame) + 24.0f, CGRectGetWidth(self.emailTextField.frame), [self.emailTextField getTextFieldHeight]);
        //CS TEMP - uncomment below code to show password
        //        self.passwordTextField.frame = CGRectMake(CGRectGetMinX(self.passwordTextField.frame), CGRectGetMaxY(self.emailTextField.frame) + 24.0f, CGRectGetWidth(self.passwordTextField.frame), [self.passwordTextField getTextFieldHeight]);
        //        self.retypePasswordTextField.frame = CGRectMake(CGRectGetMinX(self.retypePasswordTextField.frame), CGRectGetMaxY(self.passwordTextField.frame) + 24.0f, CGRectGetWidth(self.retypePasswordTextField.frame), [self.retypePasswordTextField getTextFieldHeight]);
        //        self.continueButtonView.frame = CGRectMake(0.0f, CGRectGetMaxY(self.retypePasswordTextField.frame) + 24.0f, CGRectGetWidth(self.frame), 50.0f);
        //END CS TEMP
        self.continueButtonView.frame = CGRectMake(0.0f, CGRectGetMaxY(self.emailTextField.frame) + 24.0f, CGRectGetWidth(self.frame), 50.0f); // CS TEMP - remove this line of code to show password
        
        CGFloat bottomGap = 16.0f;
        if (IS_IPHONE_X_FAMILY) {
            bottomGap = [TAPUtil safeAreaBottomPadding];
        }
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetMaxY(self.continueButtonView.frame) + bottomGap);
    }];
}

- (void)setContinueButtonEnabled:(BOOL)enable {
    [self.continueButtonView setAsActiveState:enable animated:NO];
}

- (void)setChangeImageButtonAsEnabled:(BOOL)enabled {
    if (enabled) {
        self.changeProfilePictureButton.enabled = YES;
        self.changeIconImageView.alpha = 1.0f;
        self.changeLabel.alpha = 1.0f;
    }
    else {
        self.changeProfilePictureButton.enabled = NO;
        self.changeIconImageView.alpha = 0.0f;
        self.changeLabel.alpha = 0.0f;
    }
}

- (void)setContentEditable:(BOOL)editable {
    if (editable) {
        [self.fullNameTextField setAsEnabled:YES];
        [self.usernameTextField setAsEnabled:YES];
        [self.emailTextField setAsEnabled:YES];
    }
    else {
        [self.fullNameTextField setAsEnabled:NO];
        [self.usernameTextField setAsEnabled:NO];
        [self.emailTextField setAsEnabled:NO];
    }
}

- (void)setProfilePictureWithImage:(UIImage *)image {
    if (image ==  nil) {
        self.profileImageView.image = [UIImage imageNamed:@"TAPIconDefaultAvatar"];
        self.removeProfilePictureButton.alpha = 0.0f;
    }
    else {
        self.profileImageView.image = image;
        self.removeProfilePictureButton.alpha = 1.0f;
    }
}

- (void)setProfilePictureWithImageURL:(NSString *)imageURL {
    
    if (imageURL ==  nil || [imageURL isEqualToString:@""]) {
        self.profileImageView.image = [UIImage imageNamed:@"TAPIconDefaultAvatar"];
        self.removeProfilePictureButton.alpha = 0.0f;
    }
    else {
        [self.profileImageView setImageWithURLString:imageURL];
        self.removeProfilePictureButton.alpha = 1.0f;
    }
}

- (void)setAsLoading:(BOOL)loading {
    //set navigation view & image upload loading
    if (loading) {
        [self setChangeImageButtonAsEnabled:NO];
        self.cancelButton.enabled = NO;
        self.loadingImageView.alpha = 1.0f;
        self.cancelImageView.alpha = 0.0f;
        self.loadingLabel.alpha = 1.0f;
        self.progressBarBackgroundView.alpha = 1.0f;
        
        //ADD ANIMATION
        if ([self.loadingImageView.layer animationForKey:@"SpinAnimation"] == nil) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.fromValue = [NSNumber numberWithFloat:0.0f];
            animation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
            animation.duration = 1.5f;
            animation.repeatCount = INFINITY;
            animation.cumulative = YES;
            animation.removedOnCompletion = NO;
            [self.loadingImageView.layer addAnimation:animation forKey:@"SpinAnimation"];
        }
    }
    else {
        [self setChangeImageButtonAsEnabled:YES];
        self.cancelButton.enabled = YES;
        self.loadingImageView.alpha = 0.0f;
        self.cancelImageView.alpha = 1.0f;
        self.loadingLabel.alpha = 0.0f;

        //REMOVE ANIMATION
        if ([self.loadingImageView.layer animationForKey:@"SpinAnimation"] != nil) {
            [self.loadingImageView.layer removeAnimationForKey:@"SpinAnimation"];
        }
        
        [self animateFinishedUploadingImage];
    }
}

- (void)animateProgressUploadingImageWithProgress:(CGFloat)progress total:(CGFloat)total {
    CGFloat lastProgress = self.lastProgress;
    _newProgress = progress/total;
    
    self.progressBarBackgroundView.alpha = 1.0f;
    
    NSInteger lastPercentage = (NSInteger)floorf((100.0f * lastProgress));
    NSLog(@"PERCENT %@",[NSString stringWithFormat:@"%ld%%", (long)lastPercentage]);
    
    //Circular Progress Bar using CAShapeLayer and UIBezierPath
    _progressLayer = [CAShapeLayer layer];
    [self.progressLayer setFrame:self.progressBarView.bounds];
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.progressBarView.bounds), CGRectGetMidY(self.progressBarView.bounds)) radius:(self.progressBarView.bounds.size.height) / 2 startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    
    self.progressLayer.lineCap = kCALineCapSquare;
    self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayer.lineWidth = 6.0f;
    self.progressLayer.path = progressPath.CGPath;
    self.progressLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.position = CGPointMake(self.progressBarView.layer.frame.size.width / 2 , self.progressBarView.layer.frame.size.height / 2 );
    [self.progressLayer setStrokeEnd:0.0f];
    [self.progressBarView.layer addSublayer:self.progressLayer];
    
    [self.progressLayer setStrokeEnd:self.newProgress];
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = self.updateInterval;
    [strokeEndAnimation setFillMode:kCAFillModeForwards];
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.fromValue = [NSNumber numberWithFloat:self.lastProgress];
    strokeEndAnimation.toValue = [NSNumber numberWithFloat:self.newProgress];
    _lastProgress = self.newProgress;
    [self.progressLayer addAnimation:strokeEndAnimation forKey:@"progressStatus"];
}

- (void)animateFinishedUploadingImage {
    self.lastProgress = 0.0f;
    self.progressLayer.strokeEnd = 0.0f;
    self.progressLayer.strokeStart = 0.0f;
    [self.progressLayer removeAllAnimations];
    _progressLayer = nil;
    
    self.progressBarBackgroundView.alpha = 0.0f;
}

@end
