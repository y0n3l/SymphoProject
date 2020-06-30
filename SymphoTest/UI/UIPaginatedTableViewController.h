//
//  UIPaginatedTableViewController.h
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BlogService.h"

NS_ASSUME_NONNULL_BEGIN

/**
 
 */
typedef void (^PageDownloadCompletionHandler)(NSArray* pageContent, NSError*  _Nullable error);

@interface UIPaginatedTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    NSInteger _lastDownloadedPage;
}
@property (readonly) NSMutableArray* contentList;
@property (readwrite) BOOL isCurrentlyDownloading;
@property (readwrite) BOOL stillNeedToDownload;
@property (readwrite) NSInteger pageSize;

-(void) commonInit;

-(void) downloadPage:(NSInteger)pageIdx withCompletionHandler:(PageDownloadCompletionHandler)hdlr;

-(UITableViewCell*) paginatedTableView:(UITableView*)tableView cellForContent:(NSObject*) contentObject;

@end

NS_ASSUME_NONNULL_END
