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

NS_ASSUME_NONNULL_BEGIN

/* Block definition for authors download completion handler. */
typedef void (^AuthorsDownloadCompletionHandler)(NSArray* authors, NSError*  _Nullable error);

typedef void (^PostsDownloadCompletionHandler)(NSArray* posts, NSError*  _Nullable error);

@interface BlogService : NSObject {
    NSOperationQueue* _requestsQueue;
}

-(void) getAuthorsPage:(NSInteger)page withCompletionHandler:(AuthorsDownloadCompletionHandler)handler;

-(void) getPostsPage:(NSInteger)page forAuthor:(Author*)author withCompletionHandler:(PostsDownloadCompletionHandler)handler;


@end

NS_ASSUME_NONNULL_END