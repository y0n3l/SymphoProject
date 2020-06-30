//
//  UIPostsPerAuthorTableViewController.m
//  SymphoProject
//
//  Created by Lionel on 29/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIPostsPerAuthorTableViewController.h"

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
    UIPostTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    cell.post = (Post*)contentObject;
    return cell;
}


@end
