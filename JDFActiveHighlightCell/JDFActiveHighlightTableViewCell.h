//
//  JDFActiveHighlightTableViewCell.M
//
//  Created by Joe Fryer on 15/06/2014.
//  Copyright (c) 2014 Joe Fryer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JDFActiveHighlightTableViewCell : UITableViewCell

@property (nonatomic) BOOL activeHighlightingEnabled;
@property (nonatomic, strong) UIColor *highlightColor;

- (void)showActiveHighlight;
- (void)hideActiveHighlight;

@end
