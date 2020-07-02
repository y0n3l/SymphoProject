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
    }
    return self;
}

-(void) getAuthorsPage:(NSInteger)page withCompletionHandler:(AuthorsDownloadCompletionHandler)handler {
    NSThread* currentThread = [NSThread currentThread];
    NSURLSession* urlSession = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[self  urlForAuthorsPage:page]];
    NSLog(@"Connecting to %@", request);
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray* deserializedObjs = [self createAuthorsFromJSONStructure:json];
        [currentThread performBlock:^{
            handler(deserializedObjs, nil);
        }];
    }];
    [dataTask resume];
}

-(void) getPostsPage:(NSInteger)page forAuthor:(Author*)author withCompletionHandler:(PostsDownloadCompletionHandler)handler {
    NSThread* currentThread = [NSThread currentThread];
    NSURLSession* urlSession = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[self urlForPostFromAuthor:author page:page]];
    NSLog(@"Connecting to %@", request);
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray* deserializedObjs = [self createPostsFromJSONStructure:json];
        [currentThread performBlock:^{
            handler(deserializedObjs, nil);
        }];
    }];
    [dataTask resume];
}

-(void) getCommentsPage:(NSInteger)page forPost:(Post*)post withCompletionHandler:(CommentsDownloadCompletionHandler)handler {
    NSThread* currentThread = [NSThread currentThread];
    NSURLSession* urlSession = [NSURLSession sharedSession];
    NSURLRequest* request = [NSURLRequest requestWithURL:[self urlForCommentsFromPost:post page:page]];
    NSLog(@"Connecting to %@", request);
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray* deserializedObjs = [self createCommentsFromJSONStructure:json];
        [currentThread performBlock:^{
            handler(deserializedObjs, nil);
        }];
    }];
    [dataTask resume];
}

-(NSURL*) urlForAuthorsPage:(NSInteger)page {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://sym-json-server.herokuapp.com/authors?_page=%ld", (long)page]];
}

-(NSURL*) urlForPostFromAuthor:(Author*)author page:(NSInteger)page {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://sym-json-server.herokuapp.com/posts?authorId=%ld&_page=%ld&_sort=date&_order=desc",
                                 (long)author.userId, (long)page ]];
}

-(NSURL*) urlForCommentsFromPost:(Post*)post page:(NSInteger)page {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://sym-json-server.herokuapp.com/comments?postId=%ld&_page=%ld&_sort=date&_order=asc",
                                 (long)post.postId, page]];
}

-(NSArray*) createAuthorsFromJSONStructure:(NSArray*)json {
    NSMutableArray* authorsArray = [NSMutableArray array];
    for (NSDictionary* dict in json) {
        Author* author = [[Author alloc] init];
        author.name = dict[@"name"];
        author.userName = dict[@"userName"];
        author.userId = [dict[@"id"] integerValue];
        author.email = dict[@"email"];
        author.avatarUrl = [NSURL URLWithString:dict[@"avatarUrl"]];
        double lat = [dict[@"address"][@"latitude"] doubleValue];
        double lon = [dict[@"address"][@"longitude"] doubleValue];
        CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        author.location = location;
        [authorsArray addObject:author];
    }
    return authorsArray;
}

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

-(NSArray*) createCommentsFromJSONStructure:(NSArray*)json {
    NSMutableArray* commentsArray = [NSMutableArray array];
    for (NSDictionary* dict in json) {
        Comment* comment = [[Comment alloc] init];
        comment.commentId = [dict[@"id"] integerValue];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        comment.date = [dateFormat dateFromString:dict[@"date"]]; ;
        comment.body = dict[@"body"];
        comment.userName = dict[@"userName"];
        comment.email = dict[@"email"];
        comment.avatarURL = [NSURL URLWithString:dict[@"avatarUrl"]];
        [commentsArray addObject:comment];
    }
    return commentsArray;
}

@end
