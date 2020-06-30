//
//  UIAvatarView.m
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIAvatarView.h"

@implementation UIAvatarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize avatarURL = _avatarURL;

-(void) setAvatarURL:(NSURL *)avatarURL {
    if (![_avatarURL isEqual:avatarURL]) {
        _avatarURL = avatarURL;
        NSURLSession* urlSession = [NSURLSession sharedSession];
        NSURLRequest* request = [NSURLRequest requestWithURL:_avatarURL];
        NSLog(@"Connecting to %@", request);
        __block UIAvatarView* this = self;
        self.image = nil;
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage* img = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                //apply the change in the context of the main thread.
                this.image = img;
            });
        }];
        [dataTask resume];
    }
}

-(NSURL*) avatarURL {
    return _avatarURL;
}

@end
