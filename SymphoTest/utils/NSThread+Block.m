//
//  NSThread+Block.m
//
//  Created by Lionel on 06/11/14.
//
//

#import "NSThread+Block.h"

@implementation NSThread (Block)

- (void)runBlock:(void (^)(void))block{
    block();
}

- (void)performBlock:(void (^)(void))block{
    [self performBlock:block waitUntilDone:NO];
}

- (void)performBlock:(void (^)(void))block waitUntilDone:(BOOL)wait{
    [self performSelector:@selector(runBlock:)
                 onThread:self
               withObject:[block copy]
            waitUntilDone:wait];
}
@end
