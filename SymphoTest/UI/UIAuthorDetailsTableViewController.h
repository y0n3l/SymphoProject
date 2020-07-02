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
#import "UIAvatarView.h"
#import "BlogService.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A table view cell displaying an author details.
 */
@interface UIFullAuthorTableViewCell : UITableViewCell {
    IBOutlet UIAvatarView* _avatarView;
    IBOutlet UILabel* _nameLabel;
    IBOutlet UILabel* _usernameLabel;
    IBOutlet UILabel* _emailLabel;
}
@property (readwrite) Author* author;
@end

/** A table view cell displaying a blog post entry. */
@interface UIPostTableViewCell : UITableViewCell {
    IBOutlet UIAvatarView* _imageView;
    IBOutlet UILabel* _titleLabel;
    IBOutlet UILabel* _dateLabel;
    IBOutlet UILabel* _bodyLabel;
}

@property (readwrite, strong) Post* post;

@end

/**
 This class implements the display of an author posts with paginated content handling.
 It specialises the super class by enabling the add of a special header cell showing the author details at the begining
 of the table.
 */
@interface UIAuthorDetailsTableViewController : UIPaginatedTableViewController {
    BlogService* _blogService;
}

@property (readwrite) Author* author;

@end

NS_ASSUME_NONNULL_END
