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
    _nameLabel.text = _author.name;
    _userNameLabel.text = author.userName;
    _avatarView.avatarURL = _author.avatarUrl;
}

-(Author*) author {
    return _author;
}

@end

@implementation UIAuthorsViewControllerDelegate

#pragma mark - Life cycle

-(void) commonInit {
    [super commonInit];
    _blogService = [[BlogService alloc] init];
}

#pragma mark - Transitions
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIPostsPerAuthorTableViewController *vcToPushTo = (UIPostsPerAuthorTableViewController*)segue.destinationViewController;
    NSIndexPath* selection = self.tableView.indexPathForSelectedRow;
    vcToPushTo.author = (Author*)[self.contentList objectAtIndex:selection.row];
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void) downloadPage:(NSInteger)pageIdx withCompletionHandler:(PageDownloadCompletionHandler)hdlr{
    [_blogService getAuthorsPage:_lastDownloadedPage withCompletionHandler:^(NSArray * _Nonnull authors, NSError * _Nullable error) {
       hdlr(authors, error);
    }];
}

-(UITableViewCell*) paginatedTableView:(UITableView*)tableView cellForContent:(NSObject*) contentObject {
    UIAuthorTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AuthorCell"];
    cell.author = (Author*)contentObject;
    return cell;
}

@end
