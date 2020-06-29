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

NS_ASSUME_NONNULL_BEGIN

@interface UIAuthorTableViewCell : UITableViewCell {
    IBOutlet UIImageView* _avatarView;
    IBOutlet UILabel* _authorName;
}

@property (readwrite, strong) Author* author;

@end

@interface UIAuthorsViewControllerDelegate : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    BlogService* _blogService;
    NSInteger _lastDownloadedPage;
}
@property (readonly) NSMutableArray* authorsList;
@property (readwrite) BOOL isCurrentlyDownloading;
@property (readwrite) BOOL stillNeedToDownload;

@end

NS_ASSUME_NONNULL_END
