//
//  UIDownloadStateTableViewCell.h
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDownloadStateTableViewCell : UITableViewCell {
    IBOutlet UIActivityIndicatorView* _downloadIndicator;
    IBOutlet UILabel* _textInformation;
}

@property (readwrite) BOOL isDownloading;
@property (readwrite) NSString* textInfo;

@end

NS_ASSUME_NONNULL_END
