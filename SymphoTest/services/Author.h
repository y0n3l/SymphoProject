//
//  Author.h
//  SymphoTest
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Author : NSObject

@property (readwrite, copy) NSString* name;
@property (readwrite, copy) NSString* userName;
@property (readwrite) NSInteger userId;
@property (readwrite, copy) NSURL* avatarUrl;
@property (readwrite, copy) NSString* email;
@property (readwrite, copy) CLLocation* location;

@end

NS_ASSUME_NONNULL_END
