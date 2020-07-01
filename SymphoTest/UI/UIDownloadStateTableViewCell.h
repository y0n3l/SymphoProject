//
//  UIDownloadStateTableViewCell.h
//  SymphoProject
//
//  Created by Lionel on 30/06/2020.
//  Copyright © 2020 sympho. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A special table view cell that can be used to indicate that content is currently
 being downloaded thanks to an activity indictor and shows a text when
 the activity indicator is inactive (no download active).
 */
@interface UIDownloadStateTableViewCell : UITableViewCell {
    IBOutlet UIActivityIndicatorView* _downloadIndicator;
    IBOutlet UILabel* _textInformation;
}
/** Set this to 'YES' to indicate that a download is ongoing and that the activity indicator should be shown. */
@property (readwrite) BOOL isDownloading;
/** The text to be shown when the activity indicator is not shown (stopped). */
@property (readwrite) NSString* textInfo;

@end

NS_ASSUME_NONNULL_END
