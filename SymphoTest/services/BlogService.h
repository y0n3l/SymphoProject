//
//  BlogService.h
//  SymphoTest
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Post.h"
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

/* Block definition for authors download completion handler. */
typedef void (^AuthorsDownloadCompletionHandler)(NSArray* authors, NSError*  _Nullable error);

typedef void (^PostsDownloadCompletionHandler)(NSArray* posts, NSError*  _Nullable error);

typedef void (^CommentsDownloadCompletionHandler)(NSArray* comments, NSError*  _Nullable error);

/**
 This interface exposes main entry points to access server content: authors, blog posts and comments.
 It uses content through pages.
 */
@interface BlogService : NSObject {
}

/**
 Returns authors for the given page index.
 @param page The index of the page to be retrieved . First page has index 1.
 @param handler The handler to be invoked once the dowload of the page has been done or when an error has been encountered.
 The handler is invoked in the caller's thread context.
 */
-(void) getAuthorsPage:(NSInteger)page withCompletionHandler:(AuthorsDownloadCompletionHandler)handler;

/**
Returns a posts page for a given author.
@param page The index of the page to be retrieved . First page has index 1.
@param author The author whose posts should be retrieved.
@param handler The handler to be invoked once the dowload of the page has been done or when an error has been encountered.
The handler is invoked in the caller's thread context.
*/
-(void) getPostsPage:(NSInteger)page forAuthor:(Author*)author withCompletionHandler:(PostsDownloadCompletionHandler)handler;

/**
Returns a comments page for a given post.
@param page The index of the page to be retrieved . First page has index 1.
@param post The post for which comment should be downloaded.
@param handler The handler to be invoked once the dowload of the page has been done or when an error has been encountered.
The handler is invoked in the caller's thread context.
*/
-(void) getCommentsPage:(NSInteger)page forPost:(Post*)post withCompletionHandler:(CommentsDownloadCompletionHandler)handler;


@end

NS_ASSUME_NONNULL_END
