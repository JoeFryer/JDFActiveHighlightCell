//
//  JDFActiveHighlightTableViewCell.M
//
//  Created by Joe Fryer on 15/06/2014.
//  Copyright (c) 2014 Joe Fryer. All rights reserved.
//

#import "JDFActiveHighlightTableViewCell.h"


// Geometry
static CGFloat const JDFActiveHighlightTableViewCellActiveHighlightWidth = 7.0f;
static CGFloat const JDFActiveHighlightTableViewCellActiveHighlightExtendedWidthRatio = 2.2f;



@interface JDFActiveHighlightTableViewCell()

// Views
@property (nonatomic, strong) UIView *activeHighlight;

// State
@property (nonatomic) BOOL activationHighlightInProgress;
@property (nonatomic) BOOL previousExplicitRequestWasToShowActiveHighlight;

@end


@implementation JDFActiveHighlightTableViewCell

#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customInitialisation];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self customInitialisation];
}

- (void)customInitialisation
{
    self.previousExplicitRequestWasToShowActiveHighlight = NO;
    self.activeHighlightingEnabled = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.activeHighlight && !self.activationHighlightInProgress) {
        self.activeHighlight.frame = [self activeHighlightRestingFrame];
    }
}


#pragma mark - Selection

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.activeHighlightingEnabled) {
        if (selected) {
            if (!self.activationHighlightInProgress) {
                [self showActiveHighlightForcingAnimation];
            }
        } else {
            if (!self.previousExplicitRequestWasToShowActiveHighlight) {
                [self hideActiveHighlight];
            }
        }
    } else {
        [self hideActiveHighlight];
    }
}

- (void)showActiveHighlight
{
    if (!CGRectEqualToRect(self.activeHighlight.frame, [self activeHighlightRestingFrame])) {
        [self showActiveHighlightForcingAnimation];
    }
}

- (void)showActiveHighlightForcingAnimation
{
    self.previousExplicitRequestWasToShowActiveHighlight = YES;
    self.activationHighlightInProgress = YES;
    
    CGRect startingFrame = [self activeHighlightAnimationStartingFrame];
    if (!CGRectEqualToRect(self.activeHighlight.frame, [self activeHighlightRestingFrame])) {
        startingFrame = [self activeHighlightRestingFrame];
    }
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView = backgroundView;
    self.activeHighlight = [[UIView alloc] initWithFrame:startingFrame];
    self.activeHighlight.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [self.backgroundView addSubview:self.activeHighlight];
    [self.backgroundView sendSubviewToBack:self.activeHighlight];
        
    CGFloat damping = 0.6f;
    CGFloat initialVelocity = 0.0f;
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:damping initialSpringVelocity:initialVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.activeHighlight.frame = [self activeHighlightAnimationMidPointFrame];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:damping initialSpringVelocity:initialVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.activeHighlight.frame = [self activeHighlightRestingFrame];
        } completion:^(BOOL finished2) {
            self.activationHighlightInProgress = NO;
        }];
    }];
}

- (void)hideActiveHighlight
{
    self.previousExplicitRequestWasToShowActiveHighlight = NO;
    [self.activeHighlight removeFromSuperview];
    self.activeHighlight = nil;
}


#pragma mark - View frames

- (CGRect)activeHighlightAnimationStartingFrame
{
    return CGRectMake(self.frame.size.width, 0.0f, 0.0f, self.frame.size.height);
}

- (CGRect)activeHighlightAnimationMidPointFrame
{
    return CGRectMake(self.frame.size.width - (JDFActiveHighlightTableViewCellActiveHighlightWidth * JDFActiveHighlightTableViewCellActiveHighlightExtendedWidthRatio), 0.0f, (JDFActiveHighlightTableViewCellActiveHighlightWidth * JDFActiveHighlightTableViewCellActiveHighlightExtendedWidthRatio), self.frame.size.height);
}

- (CGRect)activeHighlightRestingFrame
{
    return CGRectMake(self.frame.size.width - JDFActiveHighlightTableViewCellActiveHighlightWidth, 0.0f, JDFActiveHighlightTableViewCellActiveHighlightWidth, self.frame.size.height);
}

@end
