//
//  NSThread+Block.h
//
//  Created by Lionel on 06/11/14.
//
//

#import <Foundation/Foundation.h>

/**
 Various helpers methods to invoke blocks in the context of a NSThread instance.
 */
@interface NSThread (Block)

- (void)performBlock:(void (^)(void))block;

- (void)performBlock:(void (^)(void))block waitUntilDone:(BOOL)wait;

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
