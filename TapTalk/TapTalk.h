//
//  TapTalk.h
//  TapTalk
//
//  Created by Ritchie Nathaniel on 11/09/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

#import "TAPRegisterViewController.h" //RN Temp
#import "TAPRoomListViewController.h"
#import "TAPCustomNotificationAlertViewController.h"
#import "TAPChatViewController.h"
#import "TAPChatManager.h"

#import "TAPUserModel.h"
#import "TAPMessageModel.h"
#import "TAPCustomKeyboardItemModel.h"

//! Project version number for TapTalk.
FOUNDATION_EXPORT double TapTalkVersionNumber;

//! Project version string for TapTalk.
FOUNDATION_EXPORT const unsigned char TapTalkVersionString[];

typedef NS_ENUM(NSInteger, TapTalkInstanceState) {
    TapTalkInstanceStateActive, //Active state triggered when application enter foreground
    TapTalkInstanceStateInactive //Inactive state triggered when application terminated by os, or crash, or when in background and have finished background sequence
};

typedef NS_ENUM(NSInteger, TapTalkEnvironment) {
    TapTalkEnvironmentProduction,
    TapTalkEnvironmentStaging,
    TapTalkEnvironmentDevelopment
};

@protocol TapTalkDelegate <NSObject>

- (void)tapTalkShouldResetAuthTicket;
- (void)tapTalkDidTappedNotificationWithMessage:(TAPMessageModel *)message;

@optional
//Custom Keyboard
- (void)tapTalkCustomKeyboardDidTappedWithSender:(TAPUserModel *)sender
                                       recipient:(TAPUserModel *)recipient
                                    keyboardItem:(TAPCustomKeyboardItemModel *)keyboardItem;

- (NSArray<TAPCustomKeyboardItemModel *> *)tapTalkCustomKeyboardForSender:(TAPUserModel *)sender
                                                                recipient:(TAPUserModel *)recipient;

@end

@interface TapTalk : NSObject

@property (weak, nonatomic) UIWindow *activeWindow;
@property (weak, nonatomic) id<TapTalkDelegate> delegate;
@property (nonatomic) TapTalkInstanceState instanceState;
@property (nonatomic) TapTalkEnvironment environment;

//Initalization
+ (TapTalk *)sharedInstance;

//Authentication
- (void)setAuthTicket:(NSString *)authTicket
              success:(void (^)(void))success
              failure:(void (^)(NSError *error))failure;
- (BOOL)isAuthenticated;

//Property
- (TAPRoomListViewController *)roomListViewController;
- (TAPRegisterViewController *)registerViewController; //RN Temp
- (TAPCustomNotificationAlertViewController *)customNotificationAlertViewController;

//AppDelegate Handling
- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions environment:(TapTalkEnvironment)environment;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

//Push Notification
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler;

//Exception Handling
- (void)handleException:(NSException *)exception;

//Custom Method
//General Set Up
- (void)activateInAppNotificationInWindow:(UIWindow *)activeWindow;
- (void)setEnvironment:(TapTalkEnvironment)environment;
- (UINavigationController *)getCurrentTapTalkActiveNavigationController;
- (UIViewController *)getCurrentTapTalkActiveViewController;

//Chat
- (void)openRoomWithOtherUser:(TAPUserModel *)otherUser fromNavigationController:(UINavigationController *)navigationController;
- (void)openRoomWithRoom:(TAPRoomModel *)room fromNavigationController:(UINavigationController *)navigationController;
- (void)shouldRefreshAuthTicket;

//Custom Keyboard
- (NSArray *)getCustomKeyboardWithSender:(TAPUserModel *)sender
                              recipient:(TAPUserModel *)recipient;
- (void)customKeyboardDidTappedWithSender:(TAPUserModel *)sender
                                recipient:(TAPUserModel *)recipient
                             keyboardItem:(TAPCustomKeyboardItemModel *)keyboardItem;

//Custom Bubble
- (void)addCustomBubbleDataWithClassName:(NSString *)className type:(NSInteger)type delegate:(id)delegate;

@end