//
//  TAPSearchResultChatTableViewCell.h
//  TapTalk
//
//  Created by Welly Kencana on 22/10/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import "TAPBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAPSearchResultChatTableViewCell : TAPBaseTableViewCell

- (void)setSearchResultChatTableViewCellWithData:(TAPRoomModel *)room
                                  searchedString:(NSString *)searchedString
                          numberOfUnreadMessages:(NSString *)unreadMessageCount;

@end

NS_ASSUME_NONNULL_END