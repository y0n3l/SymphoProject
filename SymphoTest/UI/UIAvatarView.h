//
//  UIAvatarView.h
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This class handles the download and display of a user avatar.
 */
@interface UIAvatarView : UIImageView

/** The url of the avatar url to be shown. */
@property (readwrite, copy) NSURL* avatarURL;

@end

NS_ASSUME_NONNULL_END
