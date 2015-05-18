# FlexboxKit
A simple UIKit extension to wrap the flexbox properties in regular UIView. This project is based on the robust Facebook's C implementation of Flexbox.

The goal is to have a small standalone UIKit library to layout elements. It doesn't rely on the DOM model at all.


<p align="center">
![Gif](demo.gif)



#Usage

The easiest way to use the flexbox layout facilities is to instantiate a `FLEXBOXContainerView`, set its flexbox properties (as exposed in the UIView category `UIVIew+FLEXBOX`), add all the 
subviews you want to it and additionaly set their flex properties.

You can have nested `FLEXBOXContainerView`s in the view hierarchy to accomplish more complex layouts.

e.g. Given a view (in this case a *UITableViewCell*) with these subviews:

```Objective-C

FLEXBOXContainerView *contentView, right;
UIView *left;
UILabel *title, *caption;

...

[contentView addSubview:left];
[contentView addSubview:right];
[contentView addSubview:time];

[right addSubview:title];
[right addSubview:caption];

``` 

The following flexbox layout code

```Objective-C

contentView.flexDirection = FLEXBOXFlexDirectionRow;

left.flexFixedSize = (CGSize){A_FIXED_SIZE, A_FIXED_SIZE};
left.flexMargin = (UIEdgeInsets){SOME_MARGIN, SOME_MARGIN, SOME_MARGIN, SOME_MARGIN};
left.flexAlignSelf = FLEXBOXAlignmentCenter;

right.flex = 1;
right.flexJustifyContent = FLEXBOXJustificationCenter;

time.flexMargin = (UIEdgeInsets){SOME_MARGIN, SOME_MARGIN, SOME_MARGIN, SOME_MARGIN};
time.flexPadding = (UIEdgeInsets){SOME_PADDING, SOME_PADDING, SOME_PADDING, SOME_PADDING};
time.flexAlignSelf = FLEXBOXAlignmentCenter;

``` 
Results in:

<p align="center">
![Gif](cell-example.png)

##Advanced usage

You can use **FlexboxKit** without using `FLEXBOXContainerView` by simply having a `-[UIView layoutSubviews]` that calls the `-[UIView flexLayoutSubviews]` method defined in the UIView category `UIVIew+FLEXBOX`.

e.g.

```Objective-C

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self flexLayoutSubviews];
}


``` 
By some minor changes in `-[UIView flexLayoutSubviews]` you can simply run the layout code in a background thread if you wish (by simply executing `[node layoutConstrainedToMaximumWidth:self.bounds.size.width]` in a background thread)

# Attribuitions 
It uses Facebook's [flexbox implementation][css-layout] and was inspired by Josh Abernathy's
[SwiftBox] and Robert Böhnke's [FLXView].

[css-layout]: https://github.com/facebook/css-layout
[swiftbox]: https://github.com/joshaber/SwiftBox
[flxview]: https://github.com/robb/FLXView
