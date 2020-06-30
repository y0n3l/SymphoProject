//
//  SymphoTestTests.m
//  SymphoTestTests
//
//  Created by Lionel on 28/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ServerStub.h"

@interface SymphoTestTests : XCTestCase

@end

@implementation SymphoTestTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAuthorsPageProcessing {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    ServerStub* server = [[ServerStub alloc] init];
    XCTestExpectation* expect = [[XCTestExpectation alloc] init];
    NSThread* callerThread = [NSThread currentThread];
    [server getAuthorsPage:1 withCompletionHandler:^(NSArray * _Nonnull authors, NSError * _Nullable error) {
        [expect fulfill];
        XCTAssertEqual([NSThread currentThread], callerThread, @"Thread invoking callback should be the same as invoker thread");
        XCTAssertEqual([authors count], 10, @"10 authors should be retrieved from page 1");
        //Check that at least the values of the first author are the correct ones.
        Author* author = authors[0];
        XCTAssertEqual(author.userId, 1);
        XCTAssertEqualObjects(author.name, @"Leigh Kessler");
        XCTAssertEqualObjects(author.userName, @"Myrtie_Heller51");
        XCTAssertEqualObjects(author.email, @"vance_hansen7@yahoo.com");
        XCTAssertEqualObjects(author.avatarUrl, [NSURL URLWithString:@"https://s3.amazonaws.com/uifaces/faces/twitter/nutzumi/128.jpg"]);
        XCTAssertEqual(author.location.coordinate.latitude, 73.5451);
        XCTAssertEqual(author.location.coordinate.longitude, 155.4534);
    }];
    XCTAssertEqual([XCTWaiter waitForExpectations:@[expect] timeout:2], XCTWaiterResultCompleted);
}


/*
 {
   "id": 1,
   "date": "2017-12-05T02:18:18.571Z",
   "title": "Quis doloribus libero ipsam.",
   "body": "Quibusdam nemo dolor cum. Nihil et nisi atque ut earum magnam dolorem quia. Eveniet deleniti et voluptatem molestiae. Rerum nostrum nam illum et corrupti soluta fugit voluptate. Error assumenda qui rerum dolor.",
   "imageUrl": "https://picsum.photos/id/146/640/480",
   "authorId": 1
 },
 */
- (void)testPostPageProcessing {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    ServerStub* server = [[ServerStub alloc] init];
    Author* author = [[Author alloc] init];
    author.userId = 1;
    XCTestExpectation* expect = [[XCTestExpectation alloc] init];
    NSThread* callerThread = [NSThread currentThread];
    [server getPostsPage:1 forAuthor:author withCompletionHandler:^(NSArray * _Nonnull posts, NSError * _Nullable error) {
        NSLog(@"posts: %@", posts);
        [expect fulfill];
        XCTAssertEqual([NSThread currentThread], callerThread, @"Thread invoking callback should be the same as invoker thread");
        XCTAssertEqual([posts count], 10, @"10 posts should be retrieved from page 1");
        //Check that at least the values of the first author are the correct ones.
        Post* post = posts[0];
        XCTAssertEqual(post.postId, 1);
        XCTAssertEqualObjects(post.title, @"Quis doloribus libero ipsam.");
        XCTAssertEqualObjects(post.body, @"Quibusdam nemo dolor cum. Nihil et nisi atque ut earum magnam dolorem quia. Eveniet deleniti et voluptatem molestiae. Rerum nostrum nam illum et corrupti soluta fugit voluptate. Error assumenda qui rerum dolor.");
        XCTAssertEqualObjects(post.imageURL, [NSURL URLWithString:@"https://picsum.photos/id/146/640/480"]);
    }];
    XCTAssertEqual([XCTWaiter waitForExpectations:@[expect] timeout:2], XCTWaiterResultCompleted);
}

/*
"id": 1,
"date": "2017-02-20T02:37:31.883Z",
"body": "Ratione et modi ipsam qui doloremque harum et. Quia recusandae voluptas ex fugiat. Aut eligendi quia natus voluptatem error delectus incidunt adipisci. Est illum rem cumque.",
"userName": "Shaun_Orn",
"email": "halle79@gmail.com",
"avatarUrl": "https://s3.amazonaws.com/uifaces/faces/twitter/a_harris88/128.jpg",
"postId": 1 */
- (void)testCommentsPageProcessing {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    ServerStub* server = [[ServerStub alloc] init];
    Post* post = [[Post alloc] init];
    post.postId = 1;
    XCTestExpectation* expect = [[XCTestExpectation alloc] init];
    NSThread* callerThread = [NSThread currentThread];
    [server getCommentsPage:1 forPost:post withCompletionHandler:^(NSArray * _Nonnull comments, NSError * _Nullable error) {
        NSLog(@"comments: %@", comments);
        [expect fulfill];
        XCTAssertEqual([NSThread currentThread], callerThread, @"Thread invoking callback should be the same as invoker thread");
        XCTAssertEqual([comments count], 10, @"10 posts should be retrieved from page 1");
        //Check that at least the values of the first author are the correct ones.
        Comment* comment = comments[0];
        XCTAssertEqual(comment.commentId, 1);
        XCTAssertEqualObjects(comment.body, @"Ratione et modi ipsam qui doloremque harum et. Quia recusandae voluptas ex fugiat. Aut eligendi quia natus voluptatem error delectus incidunt adipisci. Est illum rem cumque.");
        XCTAssertEqualObjects(comment.userName, @"Shaun_Orn");
        XCTAssertEqualObjects(comment.email, @"halle79@gmail.com");
        XCTAssertEqualObjects(comment.avatarURL, [NSURL URLWithString:@"https://s3.amazonaws.com/uifaces/faces/twitter/a_harris88/128.jpg"]);
        
    }];
    XCTAssertEqual([XCTWaiter waitForExpectations:@[expect] timeout:2], XCTWaiterResultCompleted);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
