//
//  ViewController.m
//  FlexboxKitDemo
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#include <stdlib.h>
#import "GridDemoViewController.h"
@import FlexboxKit;

@interface GridDemoViewController ()

@property (nonatomic, strong) UIView *firstRow, *secondRow;
@property (nonatomic, strong) NSArray *firstRowViews, *secondRowViews;

@end

@implementation GridDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *purpleColor = [UIColor colorWithRed:0.533 green:0.247 blue:0.671 alpha:1.000];
    
    // the flexbox container
    FLEXBOXContainerView *container = [[FLEXBOXContainerView alloc] initWithFrame:self.view.bounds];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    container.backgroundColor = [UIColor darkGrayColor];
    container.flexAlignItems = FLEXBOXAlignmentStretch;
    container.flexDirection = FLEXBOXFlexDirectionColumn;
    
    self.firstRow = [[UIView alloc] initWithFrame:CGRectZero];
    self.firstRow.layer.borderColor = purpleColor.CGColor;
    self.firstRow.layer.borderWidth = 1;
    self.firstRow.flex = 1;
    self.firstRow.flexContainer = YES;
    
    self.secondRow = [[UIView alloc] initWithFrame:CGRectZero];
    self.secondRow.layer.borderColor = purpleColor.CGColor;
    self.secondRow.layer.borderWidth = 1;
    self.secondRow.flex = 1;
    self.secondRow.flexContainer = YES;

    self.firstRowViews = [self createFirstRowViews];
    self.secondRowViews = [self createSecondRowViews];
    
    [self.view addSubview:container];
    [container addSubview:self.firstRow];
    [container addSubview:self.secondRow];

    for (UIView *v in self.firstRowViews)
        [self.firstRow addSubview:v];
    
    for (UIView *v in self.secondRowViews)
        [self.secondRow addSubview:v];
    
    [self layout:0];
}

- (void)didPressButton:(UIButton*)sender
{
    [self layout:sender.tag];
}

#pragma mark - Different layouts

- (void)layout:(NSInteger)index
{
    for (FLEXBOXContainerView *c in @[self.firstRow, self.secondRow]) {
        c.flexAlignItems = FLEXBOXAlignmentCenter;
        c.flexDirection = FLEXBOXFlexDirectionRow;
        CGFloat containerGut = 32;
        c.flexMargin = (UIEdgeInsets){containerGut, containerGut, containerGut, containerGut};;
    }
    
    NSMutableArray *subviews = [NSMutableArray arrayWithArray:self.firstRowViews];
    [subviews addObjectsFromArray:self.secondRowViews];
    
    for (UIView *v in subviews) {
        CGFloat gut = 4;
        v.flexMargin = (UIEdgeInsets){gut, gut, gut, gut};
        v.flexPadding = (UIEdgeInsets){gut, gut, gut, gut};
    }
    
    //case 0
    [self.firstRowViews[0] setFlex:1.0/2.0];
    [self.firstRowViews[1] setFlex:1.0/6.0];
    [self.firstRowViews[2] setFlex:1.0/6.0];
    [self.firstRowViews[3] setFlex:1.0/6.0];

    switch (index) {

        case 0: {
            [self.secondRowViews[0] setFlexOffset:1.0/4.0];
            [self.secondRowViews[0] setFlex:1.0];
            break;
        }
            
        case 1: {
            [self.firstRowViews[0] setFlex:1.0/2.0];
            [self.firstRowViews[1] setFlex:1.0/2.0];
            [self.firstRowViews[2] setFlex:1.0/8.0];
            [self.firstRowViews[3] setFlex:1.0/8.0];
            break;
        }
            
        case 2: {
            [self.firstRowViews[0] setFlex:0.75/4.0];
            [self.firstRowViews[1] setFlex:0.75/4.0];
            [self.firstRowViews[2] setFlex:0.75/4.0];
            [self.firstRowViews[3] setFlex:0];
            break;
        }
            
        case 3: {
            [self.firstRowViews[0] setFlex:1];
            [self.firstRowViews[1] setFlex:1];
            [self.firstRowViews[2] setFlex:1];
            [self.firstRowViews[3] setFlex:1];
            break;
        }
            
        case 4: {
            
            int dice = arc4random_uniform(4);
            switch (dice) {
                case 0:
                    [self.secondRowViews[0] setFlexOffset:1.0/4.0];
                    [self.secondRowViews[0] setFlex:1.0];
                    break;
                    
                case 1:
                    [self.secondRowViews[0] setFlexOffset:1.0/3.0];
                    [self.secondRowViews[0] setFlex:1.0];
                    break;
                    
                case 2:
                    [self.secondRowViews[0] setFlexOffset:1.0/8.0];
                    [self.secondRowViews[0] setFlex:1.0];
                    break;
                    
                case 3:
                    [self.secondRowViews[0] setFlexOffset:1.0/2.0];
                    [self.secondRowViews[0] setFlex:1.0];
                    break;
                    
                default:
                    break;
            }

        }

        default:
            break;
    }
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        [[self.firstRow superview] flexLayoutSubviews];
    } completion:^(BOOL finished) { }];
}

#pragma mark - Test view (No layout logic)


// creates some test views
- (NSArray*)createFirstRowViews
{
    UIColor *tomatoColor = [UIColor colorWithRed:255.f/255.f green:99.f/255.f blue:71.f/255.f alpha:1.f];
    UIColor *steelBlueColor = [UIColor colorWithRed:0.f/255.f green:154.f/255.f blue:184.f/255.f alpha:1.f];
    
    NSArray *labels = @[@"1", @"2", @"3", @"4"];
    
    //Dum
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSUInteger i = 0; i < labels.count; i++) {
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTitle:labels[i] forState:UIControlStateNormal];
        [b setBackgroundColor:@[tomatoColor, steelBlueColor][i%2]];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius = 8;
        b.tag = i;
        [buttons addObject:b];
    }
    
    return buttons.copy;
}

- (NSArray*)createSecondRowViews
{
    UIColor *tomatoColor = [UIColor colorWithRed:255.f/255.f green:99.f/255.f blue:71.f/255.f alpha:1.f];
    UIColor *steelBlueColor = [UIColor colorWithRed:0.f/255.f green:154.f/255.f blue:184.f/255.f alpha:1.f];
    
    NSArray *labels = @[@"offset"];

    //Dum
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSUInteger i = 0; i < labels.count; i++) {
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTitle:labels[i] forState:UIControlStateNormal];
        [b setBackgroundColor:@[tomatoColor, steelBlueColor][i%2]];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius = 8;
        b.tag = 4;
        [buttons addObject:b];
    }
    
    return buttons.copy;
}

@end
