//
//  TAPDataManager.h
//  TapTalk
//
//  Created by Ritchie Nathaniel on 20/08/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAPUserModel.h"
#import "TAPRecentSearchModel.h"
@import AFNetworking;

@interface TAPDataManager : NSObject

+ (TAPDataManager *)sharedManager;

+ (void)setActiveUser:(TAPUserModel *)user;
+ (TAPUserModel *)getActiveUser;
+ (void)setAccessToken:(NSString *)accessToken expiryDate:(NSTimeInterval)expiryDate;
+ (NSString *)getAccessToken;
+ (void)setRefreshToken:(NSString *)refreshToken expiryDate:(NSTimeInterval)expiryDate;
+ (NSString *)getRefreshToken;
+ (void)updateMessageToFailedWhenClosedInDatabase;
+ (void)updateMessageToFailedWithLocalID:(NSString *)localID;
+ (void)setMessageLastUpdatedWithRoomID:(NSString *)roomID lastUpdated:(NSNumber *)lastUpdated;
+ (NSNumber *)getMessageLastUpdatedWithRoomID:(NSString *)roomID;

+ (TAPMessageModel *)messageModelFromPayloadWithUserInfo:(NSDictionary *)dictionary;

//Database Call
+ (void)searchMessageWithString:(NSString *)searchString
                         sortBy:(NSString *)columnName
                        success:(void (^)(NSArray *resultArray))success
                        failure:(void (^)(NSError *error))failure;
+ (void)getMessageWithRoomID:(NSString *)roomID
        lastMessageTimeStamp:(NSNumber *)timeStamp
                   limitData:(NSInteger)limit
                     success:(void (^)(NSArray<TAPMessageModel *> *messageArray))success
                     failure:(void (^)(NSError *error))failure;
+ (void)getAllMessageWithRoomID:(NSString *)roomID
                      sortByKey:(NSString *)columnName
                      ascending:(BOOL)isAscending
                        success:(void (^)(NSArray<TAPMessageModel *> *messageArray))success
                        failure:(void (^)(NSError *error))failure;
+ (void)getRoomListSuccess:(void (^)(NSArray *resultArray))success
                   failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseRecentSearchResultSuccess:(void (^)(NSArray<TAPRecentSearchModel *> *recentSearchArray, NSArray *unreadCountArray))success
                                     failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseAllUnreadMessagesWithSuccess:(void (^)(NSArray *unreadMessages))success
                                        failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseUnreadMessagesInRoomWithRoomID:(NSString *)roomID
                                     activeUserID:(NSString *)activeUserID
                                          success:(void (^)(NSArray *unreadMessages))success
                                          failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseUnreadRoomCountWithActiveUserID:(NSString *)activeUserID
                                           success:(void (^)(NSInteger unreadRoomCount))success
                                           failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseContactSearchKeyword:(NSString *)keyword
                                 sortBy:(NSString *)columnName
                                success:(void (^)(NSArray *resultArray))success
                                failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseAllUserSortBy:(NSString *)columnName
                         success:(void (^)(NSArray *resultArray))success
                         failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseAllContactSortBy:(NSString *)columnName
                            success:(void (^)(NSArray *resultArray))success
                            failure:(void (^)(NSError *error))failure;
+ (void)searchChatAndContactWithString:(NSString *)searchString
                                SortBy:(NSString *)columnName
                               success:(void (^)(NSArray *roomArray, NSArray *unreadCountArray))success
                               failure:(void (^)(NSError *error))failure;
+ (void)insertDatabaseMessageWithData:(NSArray *)dataArray
                            tableName:(NSString *)tableName
                              success:(void (^)(void))success
                              failure:(void (^)(NSError *error))failure;
+ (void)updateOrInsertDatabaseMessageWithData:(NSArray *)dataArray
                                      success:(void (^)(void))success
                                      failure:(void (^)(NSError *error))failure;
+ (void)updateOrInsertDatabaseMessageInMainThreadWithData:(NSArray *)dataArray
                                                  success:(void (^)(void))success
                                                  failure:(void (^)(NSError *error))failure;
+ (void)updateOrInsertDatabaseRecentSearchWithData:(NSArray *)dataArray
                                           success:(void (^)(void))success
                                           failure:(void (^)(NSError *error))failure;
+ (void)updateOrInsertDatabaseContactWithData:(NSArray *)dataArray
                                      success:(void (^)(void))success
                                      failure:(void (^)(NSError *error))failure;
+ (void)updateMessageReadStatusToDatabaseWithData:(NSArray *)dataArray
                                          success:(void (^)(void))success
                                          failure:(void (^)(NSError *error))failure;
+ (void)updateMessageDeliveryStatusToDatabaseWithData:(NSArray *)dataArray
                                              success:(void (^)(void))success
                                              failure:(void (^)(NSError *error))failure;
+ (void)deleteDatabaseMessageWithData:(NSArray *)dataArray
                              success:(void (^)(void))success
                              failure:(void (^)(NSError *error))failure;
+ (void)deleteDatabaseMessageWithPredicateString:(NSString *)predicateString
                                         success:(void (^)(void))success
                                         failure:(void (^)(NSError *error))failure;
+ (void)getDatabaseContactByUserID:(NSString *)userID
                           success:(void (^)(BOOL isContact))success
                           failure:(void (^)(NSError *error))failure;
+ (void)deleteDatabaseAllRecentSearchSuccess:(void (^)(void))success
                                     failure:(void (^)(NSError *error))failure;

//API Call
+ (void)callAPIGetAuthTicketWithUser:(TAPUserModel *)user
                             success:(void (^)(NSString *authTicket))success
                             failure:(void (^)(NSError *error))failure; //DV Temp
+ (void)callAPIGetAccessTokenWithAuthTicket:(NSString *)authTicket
                                    success:(void (^)(void))success
                                    failure:(void (^)(NSError *error))failure;
- (void)callAPIRefreshAccessTokenSuccess:(void (^)(void))success
                                 failure:(void (^)(NSError *error))failure;
+ (void)callAPIValidateAccessTokenAndAutoRefreshSuccess:(void (^)(void))success
                                  failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetMessageRoomListAndUnreadWithUserID:(NSString *)userID
                                             success:(void (^)(NSArray *messageArray))success
                                             failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetNewAndUpdatedMessageSuccess:(void (^)(NSArray *messageArray))success
                                      failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetMessageBeforeWithRoomID:(NSString *)roomID
                               maxCreated:(NSNumber *)maxCreated
                                  success:(void (^)(NSArray *messageArray, BOOL hasMore))success
                                  failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetMessageAfterWithRoomID:(NSString *)roomID
                              minCreated:(NSNumber *)minCreated
                                 success:(void (^)(NSArray *messageArray))success
                                 failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetContactList:(void (^)(NSArray *userArray))success
                      failure:(void (^)(NSError *error))failure;
+ (void)callAPIAddContactWithUserID:(NSString *)userID
                            success:(void (^)(NSString *message))success
                            failure:(void (^)(NSError *error))failure;
+ (void)callAPIRemoveContactWithUserID:(NSString *)userID
                               success:(void (^)(NSString *message))success
                               failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetUserByUserID:(NSString *)userID
                       success:(void (^)(TAPUserModel *user))success
                       failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetUserByXCUserID:(NSString *)XCUserID
                         success:(void (^)(TAPUserModel *user))success
                         failure:(void (^)(NSError *error))failure;
+ (void)callAPIGetUserByUsername:(NSString *)username
                         success:(void (^)(TAPUserModel *user))success
                         failure:(void (^)(NSError *error))failure;
+ (void)callAPIUpdatePushNotificationWithToken:(NSString *)token
                                       isDebug:(BOOL)isDebug
                                       success:(void (^)(void))success
                                       failure:(void (^)(NSError *error))failure;
+ (void)callAPIUpdateMessageDeliverStatusWithArray:(NSArray *)messageArray
                                        success:(void (^)(NSArray *updatedMessageIDsArray))success
                                        failure:(void (^)(NSError *error, NSArray *messageArray))failure;
+ (void)callAPIUpdateMessageReadStatusWithArray:(NSArray *)messageArray
                                       success:(void (^)(NSArray *updatedMessageIDsArray))success
                                       failure:(void (^)(NSError *error, NSArray *messageArray))failure;
+ (NSURLSessionUploadTask *)callAPIUploadFileWithFileData:(NSData *)fileData
                                                   roomID:(NSString *)roomID
                                                 fileType:(NSString *)fileType
                                                 mimeType:(NSString *)mimeType
                                                  caption:(NSString *)caption
                                          completionBlock:(void (^)(NSDictionary *responseObject))successBlock
                                            progressBlock:(void (^)(CGFloat progress, CGFloat total))progressBlock
                                             failureBlock:(void(^)(NSError *error))failureBlock;
+ (void)callAPIDownloadFileWithFileID:(NSString *)fileID
                               roomID:(NSString *)roomID
                          isThumbnail:(BOOL)isThumbnail
                      completionBlock:(void (^)(UIImage *downloadedImage))successBlock
                        progressBlock:(void (^)(CGFloat progress, CGFloat total))progressBlock
                         failureBlock:(void(^)(NSError *error))failureBlock;
+ (void)callAPIGetBulkUserByUserID:(NSArray *)userIDArray
                       success:(void (^)(NSArray *userModelArray))success
                           failure:(void (^)(NSError *error))failure;

@end
