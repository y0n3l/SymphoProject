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

@interface UIPostTableViewCell : UITableViewCell {
    IBOutlet UIImageView* _imageView;
    IBOutlet UILabel* _titleLabel;
    IBOutlet UILabel* _bodyLabel;
}

@property (readwrite, strong) Post* post;

@end

@interface UIPostsPerAuthorTableViewController : UIPaginatedTableViewController {
    BlogService* _blogService;
    IBOutlet UIAuthorHeaderView* _headerView;
}

@property (readwrite) Author* author;

@end

NS_ASSUME_NONNULL_END
