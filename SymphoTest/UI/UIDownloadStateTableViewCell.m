//
//  UIDownloadStateTableViewCell.m
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import "UIDownloadStateTableViewCell.h"

@implementation UIDownloadStateTableViewCell

@synthesize isDownloading = _isDownloading;
@synthesize textInfo = _textInfo;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setTextInfo:(NSString *)textInfo {
    _textInfo = textInfo;
    _textInformation.text = _textInfo;
}

-(NSString*) textInfo {
    return _textInfo;
}

-(void) setIsDownloading:(BOOL)isDownloading {
    _isDownloading = isDownloading;
    _downloadIndicator.hidden = !isDownloading;
    _textInformation.hidden = isDownloading;
    if (_isDownloading)
        [_downloadIndicator startAnimating];
    else
        [_downloadIndicator stopAnimating];
}

-(BOOL) isDownloading {
    return _isDownloading;
}

@end
