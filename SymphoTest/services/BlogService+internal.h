//
//  BlogService.h
//  SymphoTest
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Internal only API that can be reused accross the 2 different BlogService implementations:
 the real one accessing prod server and the stub one used for UTests.
 */
@interface BlogService (internalAPI)
/** Returns an array of `Authors` instances from the given JSON structure. */
-(NSArray*) createAuthorsFromJSONStructure:(NSArray*)json;

/** Returns an array of `Post` instances from the given JSON structure. */
-(NSArray*) createPostsFromJSONStructure:(NSArray*)json;

/** Returns an array of `Comment` instances from the given JSON structure. */
-(NSArray*) createCommentsFromJSONStructure:(NSArray*)json;
@end

NS_ASSUME_NONNULL_END
