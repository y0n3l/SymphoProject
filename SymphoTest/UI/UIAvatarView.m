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

-(instancetype) initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void) commonInit {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
}


-(void) setAvatarURL:(NSURL *)avatarURL {
    if (![_avatarURL isEqual:avatarURL]) {
        _avatarURL = avatarURL;
        NSURLSession* urlSession = [NSURLSession sharedSession];
        // For avatar the cache is prefered to downloading it again.
        NSURLRequest* request = [NSURLRequest requestWithURL:_avatarURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5];
        /*NSCachedURLResponse* cache = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
        NSLog(@"Connecting to %@", request);
        NSLog(@"cache was %@", cache.data);*/
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
