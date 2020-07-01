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
Generic signature to define page completion download whatever the type of content is.
 */
typedef void (^PageDownloadCompletionHandler)(NSArray* pageContent, NSError*  _Nullable error);

/**
 This table view controller implements an "auto download next page" as soon as the last row has been reached.
 This enable a seamless content browsing from user perspective.
 */
@interface UIPaginatedTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    /** The last downloaded page idx. */
    NSInteger _lastDownloadedPage;
}
/** The already downloaded content to be displayed in the table. */
@property (readonly) NSMutableArray* contentList;
/** A boolean flag to keep track if a dowload is currently being performed. */
@property (readwrite) BOOL isCurrentlyDownloading;
/** A boolean track to keep track if there's still some content to be available (= the last page
 hasn't been reached yet) */
@property (readwrite) BOOL stillNeedToDownload;
/** The number of items to be downloaded in each page. */
@property (readwrite) NSInteger pageSize;

/** The init to be invoked whatever the type of constructor invoked is. */
-(void) commonInit;

/** Subclasses MUST override this method to implement the page of the given index and
 invoke the completion handler given as parameter once it is done.
 @param pageIdx The index of the content page to be downloaded.
 @param hdlr The completion to be invoked once the specified page has been downloaded. */
-(void) downloadPage:(NSInteger)pageIdx withCompletionHandler:(PageDownloadCompletionHandler)hdlr;

/** Subclasses MUST override this method to return the table view cell corresponding to
 given content.
@param tableView The tableView associated to this TableViewController.
@param contentObject The content object to be displayed in a cell. */
-(UITableViewCell*) paginatedTableView:(UITableView*)tableView cellForContent:(NSObject*) contentObject;

@end

NS_ASSUME_NONNULL_END
