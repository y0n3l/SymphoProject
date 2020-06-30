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
    // we want comments to be handled as paginated by the super class, but we also
    // want 1 row more at the beginning of the table to show the post.
    return [super tableView:tableView numberOfRowsInSection:section]+1;
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
