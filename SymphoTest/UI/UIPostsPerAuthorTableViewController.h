//
//  UIAuthorsViewControllerDelegate.h
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIPaginatedTableViewController.h"
#import "UIAuthorHeaderView.h"
#import "BlogService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIFullAuthorTableViewCell : UITableViewCell {
    IBOutlet UIAvatarView* _avatarView;
    IBOutlet UILabel* _nameLabel;
    IBOutlet UILabel* _usernameLabel;
    IBOutlet UILabel* _emailLabel;
}
@property (readwrite) Author* author;
@end

@interface UIPostTableViewCell : UITableViewCell {
    IBOutlet UIAvatarView* _imageView;
    IBOutlet UILabel* _titleLabel;
    IBOutlet UILabel* _dateLabel;
    IBOutlet UILabel* _bodyLabel;
}

@property (readwrite, strong) Post* post;

@end

@interface UIPostsPerAuthorTableViewController : UIPaginatedTableViewController {
    BlogService* _blogService;
}

@property (readwrite) Author* author;

@end

NS_ASSUME_NONNULL_END
