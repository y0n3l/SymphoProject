//
//  UIAuthorsViewControllerDelegate.m
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIAuthorsViewControllerDelegate.h"
#import "ServerStub.h"

@implementation UIAuthorTableViewCell

@synthesize author = _author;

-(void) setAuthor:(Author *)author {
    _author = author;
    _authorName.text = _author.userName;
    
}

-(Author*) author {
    return _author;
}

@end

@implementation UIAuthorsViewControllerDelegate


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
    _blogService = [[BlogService alloc] init];
    _authorsList = [[NSMutableArray alloc] init];
    _stillNeedToDownload = YES;
    _isCurrentlyDownloading = NO;
    _lastDownloadedPage = 0;
}

-(void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark -
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIPostsPerAuthorTableViewController *vcToPushTo = (UIPostsPerAuthorTableViewController*)segue.destinationViewController;
    NSIndexPath* selection = self.tableView.indexPathForSelectedRow;
    vcToPushTo.author = [self.authorsList objectAtIndex:selection.row];
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_authorsList count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isAboutToShowLastCell = ([_authorsList count] == indexPath.row);
    
    //Check if new content needs to be downloaded.
    if (isAboutToShowLastCell && _stillNeedToDownload && !_isCurrentlyDownloading) {
        _lastDownloadedPage +=1;
        _isCurrentlyDownloading = YES;
        __block UIAuthorsViewControllerDelegate* this = self;
        [_blogService getAuthorsPage:_lastDownloadedPage withCompletionHandler:^(NSArray * _Nonnull authors, NSError * _Nullable error) {
            [this.authorsList addObjectsFromArray:authors];
            this.isCurrentlyDownloading = NO;
            // check if new content may be available
            // the asumption is that the last page is reached when a page with less than
            // the expected number of elements is downloaded.
            //TODO improve this a bit....
            this.stillNeedToDownload = ([authors count]==10);
            [self.tableView reloadData];
        }];
    }/* else {
        NSLog(@"End of the list reached");
    }*/
    
    if (indexPath.row < [_authorsList count]) {
        UIAuthorTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"AuthorCell"];
        Author* author = _authorsList[indexPath.row];
        cell.author = author;
        return cell;
    } else {
        // this is the download status cell
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"DownloadStatus"];
        cell.textLabel.text = _stillNeedToDownload?@"Downloading...":@"that's all !";
        return cell;
    }
    
}



@end
