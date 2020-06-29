//
//  Comment.h
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/* This class describes a blog post comment. */
@interface Comment : NSObject

@property (readwrite) NSInteger commentId;
@property (readwrite, copy) NSDate* date;
@property (readwrite, copy) NSString* body;
@property (readwrite, copy) NSString* userName;
@property (readwrite, copy) NSString* email;
@property (readwrite, copy) NSURL* avatarURL;

@end

NS_ASSUME_NONNULL_END
