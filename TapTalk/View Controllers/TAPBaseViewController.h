//
//  TAPBaseViewController.h
//  Moselo
//
//  Created by Ritchie Nathaniel on 2/23/16.
//  Copyright © 2016 Moselo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAPPopUpInfoViewController.h"

@interface TAPBaseViewController : UIViewController

- (void)keyboardWillShowWithHeight:(CGFloat)keyboardHeight;
- (void)keyboardWillHideWithHeight:(CGFloat)keyboardHeight;
- (void)showCustomBackButton;
- (void)showCustomBackButtonOrange;
- (void)showCustomCloseButton;
- (void)reachabilityChangeIsReachable:(BOOL)reachable;
- (void)showPopupViewWithPopupType:(TAPPopUpInfoViewControllerType)type title:(NSString *)title detailInformation:(NSString *)detailInfo leftOptionButtonTitle:(NSString * __nullable)leftOptionString singleOrRightOptionButtonTitle:(NSString * __nullable)singleOrRightOptionString ;
- (void)popUpInfoDidTappedLeftButton;
- (void)popUpInfoTappedSingleButtonOrRightButton;
- (void)showNavigationSeparator:(BOOL)show;

@end
