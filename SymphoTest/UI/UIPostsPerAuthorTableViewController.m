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
    _bodyLabel.text = _post.body;
    
}

-(Post*) post {
    return _post;
}

@end

@implementation UIPostsPerAuthorTableViewController

-(void) commonInit {
    [super commonInit];
    _blogService = [[BlogService alloc] init];
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
