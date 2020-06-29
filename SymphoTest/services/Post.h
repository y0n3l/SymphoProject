//
//  Post.h
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 {
   "id": 1,
   "date": "2017-12-05T02:18:18.571Z",
   "title": "Quis doloribus libero ipsam.",
   "body": "Quibusdam nemo dolor cum. Nihil et nisi atque ut earum magnam dolorem quia. Eveniet deleniti et voluptatem molestiae. Rerum nostrum nam illum et corrupti soluta fugit voluptate. Error assumenda qui rerum dolor.",
   "imageUrl": "https://picsum.photos/id/146/640/480",
   "authorId": 1
 },
 */

@interface Post : NSObject

@property (readwrite) NSInteger postId;
@property (readwrite, copy) NSDate* date;
@property (readwrite, copy) NSString* title;
@property (readwrite, copy) NSString* body;
@property (readwrite, strong) NSURL* imageURL;

@end

NS_ASSUME_NONNULL_END
