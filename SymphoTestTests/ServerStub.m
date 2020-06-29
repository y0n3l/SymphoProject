//
//  ServerStub.m
//  SymphoTestTests
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "ServerStub.h"
#import "BlogService+internal.h"
#import "NSThread+Block.h"

@implementation ServerStub

-(NSArray*) getJSONContentFromFile:(NSString*)fileName {
    NSBundle* testBundle = [NSBundle bundleForClass:[ServerStub class]];
    NSString *filePath = [testBundle pathForResource:fileName ofType:@"json"];

    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSArray* JSONContent = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    
    return JSONContent;
}

-(void) getAuthorsPage:(NSInteger)page withCompletionHandler:(AuthorsDownloadCompletionHandler)handler {
    // local test files that mimics server behavior instead of going to real production server.
    NSString* fileName = [NSString stringWithFormat:@"authors_%ld", (long)page];
    NSArray* json = [self getJSONContentFromFile:fileName];
    NSArray* deserializedObjs = [self createAuthorsFromJSONStructure:json];
    [[NSThread currentThread] performBlock:^{
        handler(deserializedObjs, nil);
    }];
}

-(void) getPostsPage:(NSInteger)page forAuthor:(Author*)author withCompletionHandler:(PostsDownloadCompletionHandler)handler {
    NSString* fileName = [NSString stringWithFormat:@"author%ld_page%ld", (long)author.userId, (long)page];
    NSArray* json = [self getJSONContentFromFile:fileName];
    NSArray* deserializedObjs = [self createPostsFromJSONStructure:json];
    [[NSThread currentThread] performBlock:^{
        handler(deserializedObjs, nil);
    }];
}

-(void) getCommentsPage:(NSInteger)page forPost:(Post*)post withCompletionHandler:(CommentsDownloadCompletionHandler)handler {
    NSString* fileName = [NSString stringWithFormat:@"comments%ld_page%ld", (long)post.postId, (long)page];
    NSArray* json = [self getJSONContentFromFile:fileName];
    NSArray* deserializedObjs = [self createCommentsFromJSONStructure:json];
    [[NSThread currentThread] performBlock:^{
        handler(deserializedObjs, nil);
    }];
}

/*
-(NSArray*) downloadPostsPage:(NSInteger)page forAuthor:(Author*)author {
    NSBundle* testBundle = [NSBundle bundleForClass:[ServerStub class]];
    NSString* fileName = [NSString stringWithFormat:@"author%ld_page%ld", (long)author.userId, (long)page];
    NSString *filePath = [testBundle pathForResource:fileName ofType:@"json"];

    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSArray* json = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    NSArray* deserializedObjs = [self createPostsFromJSONStructure:json];
    return deserializedObjs;
}

-(NSArray*) downloadCommentsPage:(NSInteger)page forPost:(Post*)post {
    NSString* fileName = [NSString stringWithFormat:@"comments%ld_page_%ld", (long)post.postId, (long)page];
    NSArray* json = [self getJSONContentFromFile:fileName];
    NSArray* deserializedObjs = [self createCommentsFromJSONStructure:json];
    return deserializedObjs;
}
 */


@end
