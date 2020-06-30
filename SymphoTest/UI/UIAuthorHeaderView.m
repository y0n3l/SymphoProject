//
//  UIHeaderView.m
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIAuthorHeaderView.h"

@implementation UIAuthorHeaderView

@synthesize author = _author;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) setAuthor:(Author*)author {
    _author = author;
    _userNameLabel.text = _author.userName ;
    _nameLabel.text = _author.name;
    _avatarView.avatarURL = _author.avatarUrl;
}

-(Author*) author {
    return _author;
}

@end
