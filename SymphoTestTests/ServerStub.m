//
//  ServerStub.m
//  SymphoTestTests
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "ServerStub.h"
#import "BlogService+internal.h"

@implementation ServerStub

-(NSArray*) downloadAuthorsPage:(NSInteger)page {
    NSBundle* testBundle = [NSBundle bundleForClass:[ServerStub class]];
    NSString* fileName = [NSString stringWithFormat:@"authors_%ld", (long)page];
    NSString *filePath = [testBundle pathForResource:fileName ofType:@"json"];

    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSArray* authorsJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    NSArray* deserializedObjs = [self createAuthorsFromJSONStructure:authorsJSON];
    return deserializedObjs;
}

-(NSArray*) downloadPostsPage:(NSInteger)page forAuthor:(Author*)author {
    NSBundle* testBundle = [NSBundle bundleForClass:[ServerStub class]];
    NSString* fileName = [NSString stringWithFormat:@"author%ld_page%ld", (long)author.userId, (long)page];
    NSString *filePath = [testBundle pathForResource:fileName ofType:@"json"];

    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSArray* json = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    NSArray* deserializedObjs = [self createPostsFromJSONStructure:json];
    return deserializedObjs;
}

@end
