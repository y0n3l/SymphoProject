//
//  NSThread+Block.h
//
//  Created by Lionel on 06/11/14.
//
//

#import <Foundation/Foundation.h>

@interface NSThread (Block)

- (void)performBlock:(void (^)(void))block;

- (void)performBlock:(void (^)(void))block waitUntilDone:(BOOL)wait;

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
