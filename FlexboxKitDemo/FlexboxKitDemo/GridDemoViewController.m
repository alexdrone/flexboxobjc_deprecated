//
//  ViewController.m
//  FlexboxKitDemo
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#import "GridDemoViewController.h"
@import FlexboxKit;

@interface GridDemoViewController ()

@property (nonatomic, strong) FLEXBOXContainerView *container;
@property (nonatomic, strong) NSArray *views;

@end

@implementation GridDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the flexbox container
    FLEXBOXContainerView *c = [[FLEXBOXContainerView alloc] initWithFrame:self.view.bounds];
    c.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    c.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:c];
    
    self.container = c;

    self.views = [self createDummyViews];
    
    for (UIView *v in self.views)
        [c addSubview:v];
    
    //Flexbox
    [self layout:0];
}

- (void)didPressButton:(UIButton*)sender
{
    [self layout:sender.tag];
}

#pragma mark - Different layouts

- (void)layout:(NSInteger)index
{
    self.container.flexAlignItems = FLEXBOXAlignmentCenter;
    self.container.flexDirection = FLEXBOXFlexDirectionRow;
    self.container.flexWrap = YES;
    
    CGFloat containerGut = 32;
    self.container.flexPadding = (UIEdgeInsets){containerGut, containerGut, containerGut, containerGut};;
    
    for (UIView *v in self.views) {
        CGFloat gut = 4;
        v.flexMargin = (UIEdgeInsets){gut, gut, gut, gut};
        v.flexPadding = (UIEdgeInsets){gut, gut, gut, gut};
        v.flex = 0;
    }
    
    switch (index) {
            
        // all items in in a column
        case 0: {
            [self.views[0] setFlex:1.0/2.0];
            [self.views[1] setFlex:1.0/6.0];
            [self.views[2] setFlex:1.0/6.0];
            [self.views[3] setFlex:1.0/6.0];
            break;
        }
            
        case 1: {
            [self.views[0] setFlex:1.0/2.0];
            [self.views[1] setFlex:1.0/2.0];
            [self.views[2] setFlex:1.0/8.0];
            [self.views[3] setFlex:1.0/8.0];
            break;
        }
            
        case 2: {
            [self.views[0] setFlex:0.75/4.0];
            [self.views[1] setFlex:0.75/4.0];
            [self.views[2] setFlex:0.75/4.0];
            [self.views[3] setFlex:0];
            break;
        }
            
        case 3: {
            [self.views[0] setFlex:1];
            [self.views[1] setFlex:1];
            [self.views[2] setFlex:1];
            [self.views[3] setFlex:1];
            break;
        }
            
            
          
        default:
            break;
    }
    
    [UIView animateWithDuration:0.66 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        
        [self.container flexLayoutSubviews];
        //...or just [self.view setNeedsLayout]
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Test view (No layout logic)

- (NSArray*)labels
{
    return @[@"1", @"2", @"3", @"4"];
}

// creates some test views
- (NSArray*)createDummyViews
{
    UIColor *tomatoColor = [UIColor colorWithRed:255.f/255.f green:99.f/255.f blue:71.f/255.f alpha:1.f];
    UIColor *steelBlueColor = [UIColor colorWithRed:0.f/255.f green:154.f/255.f blue:184.f/255.f alpha:1.f];
    
    //Dum
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSUInteger i = 0; i < self.labels.count; i++) {
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTitle:self.labels[i] forState:UIControlStateNormal];
        [b setBackgroundColor:@[tomatoColor, steelBlueColor][i%2]];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius = 8;
        b.tag = i;
        [buttons addObject:b];
    }
    
    return buttons.copy;
}

@end
