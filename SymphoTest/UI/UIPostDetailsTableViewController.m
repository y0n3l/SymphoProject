//
//  UIPostDetailsTableViewController.m
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIPostDetailsTableViewController.h"

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
