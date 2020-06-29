//
//  BlogService.m
//  SymphoTest
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "BlogService.h"
#import "BlogService+internal.h"
#import "NSThread+Block.h"

@implementation BlogService

-(instancetype) init {
    self = [super init];
    if (self) {
        _requestsQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(void) getAuthorsPage:(NSInteger)page withCompletionHandler:(AuthorsDownloadCompletionHandler)handler {
    NSThread* callerThread = [NSThread currentThread];
    [_requestsQueue addOperationWithBlock:^{
        NSArray* authors = [self downloadAuthorsPage:page];
        [callerThread performBlock:^{
            handler(authors, nil);
        }];
    }];
}

-(void) getPostsPage:(NSInteger)page forAuthor:(Author*)author withCompletionHandler:(PostsDownloadCompletionHandler)handler {
    NSThread* callerThread = [NSThread currentThread];
    [_requestsQueue addOperationWithBlock:^{
        NSArray* posts = [self downloadPostsPage:page forAuthor:author];
        [callerThread performBlock:^{
            handler(posts, nil);
        }];
    }];
}

/** Synchronously downloads the given authors page.
 */
-(NSArray*) downloadAuthorsPage:(NSInteger)page {
    return @[@"test"];
}

-(NSArray*) downloadPostsPage:(NSInteger)page forAuthor:(Author*)author {
    return @[@"test"];
}

-(NSArray*) createAuthorsFromJSONStructure:(NSArray*)json {
    NSMutableArray* authorsArray = [NSMutableArray array];
    for (NSDictionary* dict in json) {
        Author* author = [[Author alloc] init];
        author.name = dict[@"name"];
        author.userName = dict[@"userName"];
        author.userId = [dict[@"id"] integerValue];
        author.email = dict[@"email"];
        author.avatarUrl = dict[@"avatarUrl"];
        double lat = [dict[@"address"][@"latitude"] doubleValue];
        double lon = [dict[@"address"][@"longitude"] doubleValue];
        CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        author.location = location;
        [authorsArray addObject:author];
    }
    return authorsArray;
}

/*
{
  "id": 1,
  "date": "2017-12-05T02:18:18.571Z",
  "title": "Quis doloribus libero ipsam.",
  "body": "Quibusdam nemo dolor cum. Nihil et nisi atque ut earum magnam dolorem quia. Eveniet deleniti et voluptatem molestiae. Rerum nostrum nam illum et corrupti soluta fugit voluptate. Error assumenda qui rerum dolor.",
  "imageUrl": "https://picsum.photos/id/146/640/480",
  "authorId": 1
},*/

-(NSArray*) createPostsFromJSONStructure:(NSArray*)json {
    NSMutableArray* postsArray = [NSMutableArray array];
    for (NSDictionary* dict in json) {
        Post* post = [[Post alloc] init];
        post.postId = [dict[@"id"] integerValue];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        post.date = [dateFormat dateFromString:dict[@"date"]]; ;
        post.title = dict[@"title"];
        post.body = dict[@"body"];
        post.imageURL = [NSURL URLWithString:dict[@"imageUrl"]];
        [postsArray addObject:post];
    }
    return postsArray;
}


@end
