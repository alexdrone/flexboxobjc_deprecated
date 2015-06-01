//
//  UIView+FLEXBOX.h
//  FlexboxKit
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

@import UIKit;
#import "FLEXBOXNode.h"

@interface UIView (FLEXBOX)

// Properties

/// YES if this view contains subviews that you wish to layout using the flexbox engine
/// @note You don't need to set this if your view is a FLEXBOXContainerView
@property (nonatomic, assign) BOOL flexContainer;

/// Set this if you wish to have a fixed size for this element
@property (nonatomic, assign) CGSize flexFixedSize;

/// The minumum size for this element
@property (nonatomic, assign) CGSize flexMinimumSize;

/// The maximum size for this element
@property (nonatomic, assign) CGSize flexMaximumSize;

/// It establishes the main-axis, thus defining the direction flex items are placed in the flex container.
/// - row: same as text direction (@see FLEXBOXFlexDirectionColumn)
/// - column (default): same as row but top to bottom (@see FLEXBOXFlexDirectionRow)
/// - row-reverse: (@see FLEXBOXFlexDirectionRowReverse)
/// - column-reverse: (@see FLEXBOXFlexDirectionColumnReverse)
@property (nonatomic, assign) FLEXBOXFlexDirection flexDirection;

/// The margins for this flex item (default is 0)
@property (nonatomic, assign) UIEdgeInsets flexMargin;

/// The padding for this flex item (default is 0)
@property (nonatomic, assign) UIEdgeInsets flexPadding;

/// Make the flexible items wrap if necesarry:
/// - wrap YES
/// - nowrap (default) NO
@property (nonatomic, assign) BOOL flexWrap;

/// It defines the alignment along the main axis. It helps distribute extra free
/// space leftover when either all the flex items on a line are inflexible, or are
/// flexible but have reached their maximum size. It also exerts some control over
/// the alignment of items when they overflow the line.
/// - flex-start (default): items are packed toward the start line (@see FLEXBOXJustificationFlexStart)
/// - flex-end: items are packed toward to end line (@see FLEXBOXJustificationFlexEnd)
/// - center: items are centered along the line (@see FLEXBOXJustificationCenter)
/// - space-between: items are evenly distributed in the line; first item is on the start line, last item on the end line (@see FLEXBOXJustificationSpaceBetween)
/// - space-around: items are evenly distributed in the line with equal space around them (@see FLEXBOXJustificationSpaceAround)
@property (nonatomic, assign) FLEXBOXJustification flexJustifyContent;

/// Center the alignments for one of the items inside a flexible element
/// - auto (default): The element inherits its parent container's align-items property, or "stretch" if it has no parent container (@see FLEXBOXAlignmentAuto)
/// - stretch: The element is positioned to fit the conatiner (@see FLEXBOXAlignmentStretch)
/// - center: The element is positioned at the center of the container (@see FLEXBOXAlignmentCenter)
/// - flex-start: The element is are positioned at the beginning of the container (@see FLEXBOXAlignmentFlexStart)
/// - flex-end: The element is positioned at the end of the container (@see FLEXBOXAlignmentFlexEnd)
@property (nonatomic, assign) FLEXBOXAlignment flexAlignSelf;

/// Center the alignments for all the items of the flexible element:
/// - stretch (default): The element is positioned to fit the conatiner (@see FLEXBOXAlignmentStretch)
/// - center: The element is positioned at the center of the container (@see FLEXBOXAlignmentCenter)
/// - flex-start: The element is are positioned at the beginning of the container (@see FLEXBOXAlignmentFlexStart)
/// - flex-end: The element is positioned at the end of the container (@see FLEXBOXAlignmentFlexEnd)
@property (nonatomic, assign) FLEXBOXAlignment flexAlignItems;

/// The flex property specifies the initial length of a flexible item.
/// A value between 0 and 1 (a ratio e.g. 1/2, 2/3)
@property (nonatomic, assign) CGFloat flex;


/// The node content directon (default is inherit)
@property (nonatomic, assign) FLEXBOXContentDirection flexContentDirection;

// Methods

/// Entry point for defining the size for this flex item
/// @note By default it calls -[UIView sizeThatFits:]
- (CGSize)flexComputeSize:(CGSize)bounds;

/// Call this method in -[UIView layoutSubviews] if you want the flexbox
/// engine to compute the layout
- (void)flexLayoutSubviews;

/// Define this block if you want to specify some custom logic instead of
/// calling -[UIView sizeThatFits:] in -[UIView flexComputeSize:]
@property (nonatomic, copy) CGSize (^flexSizeThatFitsBlock)(CGSize size);

@end
