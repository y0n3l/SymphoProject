//
//  UIPostDetailsTableViewController.m
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIPostDetailsTableViewController.h"

@implementation UIFullPostTableViewCell

@synthesize post = _post;

-(void) setPost:(Post *) post {
    _post = post;
    _bodyTextView.text = _post.body;
    _titleLabel.text = _post.title;
    _dateLabel.text = [NSDateFormatter localizedStringFromDate:_post.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

-(Post*) post {
    return _post;
}

@end

@implementation UICommentTableViewCell

@synthesize comment = _comment;

-(void) setComment:(Comment *)comment {
    _comment = comment;
    _usernameLabel.text = _comment.userName;
    _bodyTextView.text = _comment.body;
    _dateLabel.text = [NSDateFormatter localizedStringFromDate:_comment.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    _avatarView.avatarURL =_comment.avatarURL;
}

-(Comment*) comment {
    return _comment;
}

@end

@implementation UIPostDetailsTableViewController

-(void) commonInit {
    [super commonInit];
    _blogService = [[BlogService alloc] init];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // first section will show the post
    // and second section will show the paginated browsing for all comments for this post.
    if (section==0)
        return 1;
    else
        return [super tableView:tableView numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section==0?@"":@"Comments";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // if this is the first section, we show the full post
    // otherwise we invoke the parent paginated controller to have pages handling
    // for second section).
    if (indexPath.section==0) {
        UIFullPostTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FullPost"];
        cell.post = self.post;
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

/**
 
 */
-(void) downloadPage:(NSInteger)pageIdx withCompletionHandler:(PageDownloadCompletionHandler)hdlr{
    [_blogService getCommentsPage:pageIdx forPost:self.post withCompletionHandler:^(NSArray * _Nonnull comments, NSError * _Nullable error) {
       hdlr(comments, error);
    }];
}

-(UITableViewCell*) paginatedTableView:(UITableView*)tableView cellForContent:(NSObject*) contentObject {
    UICommentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    cell.comment = (Comment*)contentObject;
    return cell;
}

@end
