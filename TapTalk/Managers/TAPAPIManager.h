//
//  TAPAPIManager.h
//  TapTalk
//
//  Created by Dominic Vedericho on 28/08/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TAPAPIManagerType) {
    TAPAPIManagerTypeGetAuthTicket,
    TAPAPIManagerTypeGetAccessToken,
    TAPAPIManagerTypeRefreshAccessToken,
    TAPAPIManagerTypeValidateAccessToken,
    TAPAPIManagerTypeGetMessageRoomListAndUnread,
    TAPAPIManagerTypeGetMessageRoomListAfter,
    TAPAPIManagerTypeGetMessageRoomListBefore,
    TAPAPIManagerTypeGetPendingNewAndUpdatedMessages,
    TAPAPIManagerTypeGetContactList,
    TAPAPIManagerTypeAddContact,
    TAPAPIManagerTypeRemoveContact,
    TAPAPIManagerTypeGetUserByUserID,
    TAPAPIManagerTypeGetUserByXCUserID,
    TAPAPIManagerTypeGetUserByUsername,
    TAPAPIManagerTypeUpdatePushNotification,
    TAPAPIManagerTypeUpdateMessageDeliveryStatus,
    TAPAPIManagerTypeUpdateMessageReadStatus
};

@interface TAPAPIManager : NSObject

+ (TAPAPIManager *)sharedManager;
- (NSString *)urlForType:(TAPAPIManagerType)type;

@end