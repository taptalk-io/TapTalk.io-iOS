//
//  TAPMessageModel.h
//  Moselo
//
//  Created by Ritchie Nathaniel on 3/8/17.
//  Copyright © 2017 Moselo. All rights reserved.
//

#import "TAPBaseModel.h"
#import "TAPUserModel.h"
#import "TAPRoomModel.h"
#import "TAPQuoteModel.h"
#import "TAPReplyToModel.h"
#import "TAPForwardFromModel.h"
#import "Configs.h"
#import "TAPChatMessageType.h"

@interface TAPMessageModel : TAPBaseModel

@property (nonatomic, strong) NSString *messageID;
@property (nonatomic, strong) NSString *localID;
@property (nonatomic, strong) NSString *filterID;
@property (nonatomic) TAPChatMessageType type;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) TAPRoomModel *room;
@property (nonatomic, strong) NSString *recipientID;
@property (nonatomic, strong) NSNumber *created;
@property (nonatomic, strong) NSNumber *updated;
@property (nonatomic, strong) NSNumber *deleted;
@property (nonatomic, strong) TAPUserModel *user;
@property (nonatomic, strong) TAPQuoteModel *quote;
@property (nonatomic, strong) TAPReplyToModel *replyTo;
@property (nonatomic, strong) TAPForwardFromModel *forwardFrom;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic) BOOL isDeleted;
@property (nonatomic) BOOL isSending;
@property (nonatomic) BOOL isFailedSend;
@property (nonatomic) BOOL isRead;
@property (nonatomic) BOOL isDelivered;
@property (nonatomic) BOOL isHidden;

//If add new property, don't forget to update copyMessageModel method

+ (instancetype)createMessageWithUser:(TAPUserModel *)user room:(TAPRoomModel *)room body:(NSString *)body type:(TAPChatMessageType)type;
+ (instancetype)createMessageWithUser:(TAPUserModel *)user created:(NSNumber *)created room:(TAPRoomModel *)room body:(NSString *)body type:(TAPChatMessageType)type;

- (TAPMessageModel *)copyMessageModel;

@end
