//
//  TAPRoomListView.h
//  TapTalk
//
//  Created by Welly Kencana on 6/9/18.
//  Copyright © 2018 Moselo. All rights reserved.
//

#import "TAPBaseView.h"

@interface TAPRoomListView : TAPBaseView

@property (strong, nonatomic) UITableView *roomListTableView;

- (void)showNoChatsView:(BOOL)isVisible;

@end