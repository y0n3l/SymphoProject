//
//  UIHeaderView.h
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Author.h"
#import "UIAvatarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIAuthorHeaderView : UIView {
    IBOutlet UILabel* _userNameLabel;
    IBOutlet UILabel* _nameLabel;
    IBOutlet UIAvatarView* _avatarView;
}

@property (readwrite) Author* author;
@end

NS_ASSUME_NONNULL_END
