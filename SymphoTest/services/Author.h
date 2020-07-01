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

/**
 This classes defines a blog post author.
 */
@interface Author : NSObject

/** This auhor's name. */
@property (readwrite, copy) NSString* name;
/** This auhor's username. */
@property (readwrite, copy) NSString* userName;
/** This auhor's userId. */
@property (readwrite) NSInteger userId;
/** This auhor's avatar. */
@property (readwrite, copy) NSURL* avatarUrl;
/** This auhor's email. */
@property (readwrite, copy) NSString* email;
/** This auhor's location. */
@property (readwrite, copy) CLLocation* location;

@end

NS_ASSUME_NONNULL_END
