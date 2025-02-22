//
//  UIPostDetailsTableViewController.h
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPaginatedTableViewController.h"
#import "UIAvatarView.h"
#import "BlogService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIFullPostTableViewCell : UITableViewCell {
    IBOutlet UIAvatarView* _avatarView;
    IBOutlet UILabel* _usernameLabel;
    IBOutlet UILabel* _dateLabel;
    IBOutlet UILabel* _titleLabel;
    IBOutlet UITextView* _bodyTextView;
}
@property (readwrite) Post* post;
@end

@interface UICommentTableViewCell : UITableViewCell {
    IBOutlet UIAvatarView* _avatarView;
    IBOutlet UILabel* _usernameLabel;
    IBOutlet UILabel* _dateLabel;
    IBOutlet UITextView* _bodyTextView;
}

@property (readwrite) Comment* comment;

@end

/**
This class implements the display of a post and its related comments with paginated content handling.
It specialises the super class by enabling the add of a special header cell showing the post at the begining
of the table.
*/
@interface UIPostDetailsTableViewController : UIPaginatedTableViewController {
    BlogService* _blogService;
}

@property (readwrite) Post* post;

@end

NS_ASSUME_NONNULL_END
