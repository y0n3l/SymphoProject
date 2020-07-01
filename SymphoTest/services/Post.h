//
//  Post.h
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This class defines blog posts entries.
 */

@interface Post : NSObject

/** This post unique identifier. */
@property (readwrite) NSInteger postId;
/** The date when this post has been written. */
@property (readwrite, copy) NSDate* date;
/** This post title. */
@property (readwrite, copy) NSString* title;
/** This post body */
@property (readwrite, copy) NSString* body;
/** URL of the image illustrating this post. */
@property (readwrite, strong) NSURL* imageURL;

@end

NS_ASSUME_NONNULL_END
