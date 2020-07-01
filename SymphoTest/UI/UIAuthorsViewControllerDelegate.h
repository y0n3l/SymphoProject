//
//  UIAuthorsViewControllerDelegate.h
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BlogService.h"
#import "UIPaginatedTableViewController.h"
#import "UIAuthorDetailsTableViewController.h"
#import "UIAvatarView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A table view cell that shows an author.
 */
@interface UIAuthorTableViewCell : UITableViewCell {
    IBOutlet UIAvatarView* _avatarView;
    IBOutlet UILabel* _nameLabel;
    IBOutlet UILabel* _userNameLabel;
}

@property (readwrite, strong) Author* author;

@end

/**
 This class manages the rendition of the list of authors with pages.
 */
@interface UIAuthorsViewControllerDelegate : UIPaginatedTableViewController {
    BlogService* _blogService;
}

@end

NS_ASSUME_NONNULL_END
