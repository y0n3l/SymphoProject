//
//  UIPostsPerAuthorTableViewController.m
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIPostsPerAuthorTableViewController.h"

@implementation UIPostTableViewCell

@synthesize post = _post;

-(void) setPost:(Post *)post {
    _post = post;
    _titleLabel.text = _post.title;
    _dateLabel.text = [NSDateFormatter localizedStringFromDate:_post.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];;
    _bodyLabel.text = _post.body;
    _imageView.avatarURL = post.imageURL;
    
}

-(Post*) post {
    return _post;
}

@end

@implementation UIPostsPerAuthorTableViewController

@synthesize author = _author;

-(void) commonInit {
    [super commonInit];
    _blogService = [[BlogService alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _headerView;
}

-(void) setAuthor:(Author *)author {
    _author = author;
    _headerView.author = _author;
}

-(Author*) author {
    return _author;
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
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
