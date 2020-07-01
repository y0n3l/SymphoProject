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

/** This comment unique identifer. */
@property (readwrite) NSInteger commentId;
/** The date when this comment has been made. */
@property (readwrite, copy) NSDate* date;
/** This post body content. */
@property (readwrite, copy) NSString* body;
/** The username of the user who wrote this comment. */
@property (readwrite, copy) NSString* userName;
/** The email of the user who wrote this comment. */
@property (readwrite, copy) NSString* email;
/** An avatar for the user who wrote this comment. */
@property (readwrite, copy) NSURL* avatarURL;

@end

NS_ASSUME_NONNULL_END
