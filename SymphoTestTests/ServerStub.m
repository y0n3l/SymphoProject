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

/**
 The server stub just overrides the remote server access to local files to test the business logic
 behavior.
 */
@implementation ServerStub

-(NSURL*) urlForAuthorsPage:(NSInteger)page {
    NSBundle* testBundle = [NSBundle bundleForClass:[ServerStub class]];
    NSString* fileName = [NSString stringWithFormat:@"authors_%ld", (long)page];
    NSURL* url = [testBundle URLForResource: fileName withExtension:@"json"];
    return url;
}

-(NSURL*) urlForPostFromAuthor:(Author*)author page:(NSInteger)page {
    NSBundle* testBundle = [NSBundle bundleForClass:[ServerStub class]];
    NSString* fileName = [NSString stringWithFormat:@"author%ld_page%ld", (long)author.userId, (long)page];
    NSURL* url = [testBundle URLForResource: fileName withExtension:@"json"];
    return url;
}

-(NSURL*) urlForCommentsFromPost:(Post*)post page:(NSInteger)page {
    NSBundle* testBundle = [NSBundle bundleForClass:[ServerStub class]];
    NSString* fileName = [NSString stringWithFormat:@"comments%ld_page%ld", (long)post.postId, (long)page];
    NSURL* url = [testBundle URLForResource: fileName withExtension:@"json"];
    return url;
}

@end
