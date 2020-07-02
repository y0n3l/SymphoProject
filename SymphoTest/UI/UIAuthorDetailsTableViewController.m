//
//  UIPostsPerAuthorTableViewController.m
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIAuthorDetailsTableViewController.h"
#import "UIPostDetailsTableViewController.h"

@implementation UIFullAuthorTableViewCell

@synthesize author = _author;

-(void) setAuthor:(Author *)author {
    _author = author;
    _usernameLabel.text = _author.userName;
    _avatarView.avatarURL = _author.avatarUrl;
    _nameLabel.text = _author.name;
    _emailLabel.text = _author.email;
}

-(Author*) author {
    return _author;
}

@end

@implementation UIPostTableViewCell

@synthesize post = _post;

-(void) setPost:(Post *)post {
    _post = post;
    _titleLabel.text = _post.title;
    _dateLabel.text = [NSDateFormatter localizedStringFromDate:_post.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    _bodyLabel.text = _post.body;
    _imageView.avatarURL = post.imageURL;
    
}

-(Post*) post {
    return _post;
}

@end

@implementation UIAuthorDetailsTableViewController

-(void) commonInit {
    [super commonInit];
    _blogService = [[BlogService alloc] init];
}

#pragma mark -
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIPostDetailsTableViewController *vcToPushTo = (UIPostDetailsTableViewController*)segue.destinationViewController;
    NSIndexPath* selection = self.tableView.indexPathForSelectedRow;
    vcToPushTo.post = (Post*)[self.contentList objectAtIndex:selection.row];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section==0?@"":@"Posts";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0)
        return 140;
    else
        return 110;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // first section will show the author details
    // and second section will show the paginated browsing for all posts from this author.
    if (section==0)
        return 1;
    else
        return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // if this is the first section, we show the full post
    // otherwise we invoke the parent paginated controller to have pages handling
    // for second section).
    if (indexPath.section==0) {
        UIFullAuthorTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FullAuthor"];
        cell.author = self.author;
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

/**
 
 */
-(void) downloadPage:(NSInteger)pageIdx withCompletionHandler:(PageDownloadCompletionHandler)hdlr{
    [_blogService getPostsPage:pageIdx forAuthor:self.author withCompletionHandler:^(NSArray * _Nonnull posts, NSError * _Nullable error) {
       hdlr(posts, error);
    }];
}

-(UITableViewCell*) paginatedTableView:(UITableView*)tableView cellForContent:(NSObject*) contentObject {
    UIPostTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    cell.post = (Post*)contentObject;
    return cell;
}


@end
