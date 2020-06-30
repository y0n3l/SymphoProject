//
//  UIPaginatedTableViewController.m
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIPaginatedTableViewController.h"
#import "UIDownloadStateTableViewCell.h"

@implementation UIPaginatedTableViewController

-(instancetype) initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype) init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self commonInit];
    }
    return self;
}

-(void) commonInit {
    _contentList = [[NSMutableArray alloc] init];
    _stillNeedToDownload = YES;
    _isCurrentlyDownloading = NO;
    _lastDownloadedPage = 0;
    _pageSize = 10;
}

-(void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Pagination handling
-(void) downloadPage:(NSInteger)pageIdx withCompletionHandler:(PageDownloadCompletionHandler)hdlr{
    
}

-(UITableViewCell*) paginatedTableView:(UITableView*)tableView cellForContent:(NSObject*) contentObject {
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // as we need a status row at the end of the list => +1
    return [self.contentList count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isAboutToShowLastCell = ([_contentList count] == indexPath.row);
    
    //Check if new content needs to be downloaded.
    if (isAboutToShowLastCell && _stillNeedToDownload && !_isCurrentlyDownloading) {
        _lastDownloadedPage +=1;
        _isCurrentlyDownloading = YES;
        __block UIPaginatedTableViewController* this = self;
        [self downloadPage:_lastDownloadedPage withCompletionHandler:^(NSArray * _Nonnull pageContent, NSError * _Nullable error) {
            [this.contentList addObjectsFromArray:pageContent];
            this.isCurrentlyDownloading = NO;
            // check if new content may be available
            // the asumption is that the last page is reached when a page with less than
            // the expected number of elements is downloaded.
            //TODO improve this a bit....
            this.stillNeedToDownload = ([pageContent count]==this.pageSize);
            //TODO Could be improved by animating the inseertion of new lines.
            [self.tableView reloadData];
        }];
    }/* else {
        NSLog(@"End of the list reached");
    }*/
    
    if (isAboutToShowLastCell) {
        // The last last cell is the status cell.
        UIDownloadStateTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"DownloadStatus"];
        cell.isDownloading = _stillNeedToDownload;
        return cell;
    } else {
        // otherwise this is content cell.
        UITableViewCell* cell = [self paginatedTableView:self.tableView cellForContent:self.contentList[indexPath.row]];
        return cell;
    }
}

@end
