//
//  CellDemoTableViewController.m
//  FlexboxKitDemo
//
//  Created by Alex Usbergo on 10/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

@import FlexboxKit;
#import "CellDemoTableViewController.h"
#import <objc/runtime.h>

static const CGFloat CELL_HEIGHT = 62;

@interface FlexDemoTableViewCell : UITableViewCell

@end

@implementation FlexDemoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // Some colors
        UIColor *tomatoColor = [UIColor colorWithRed:255.f/255.f green:99.f/255.f blue:71.f/255.f alpha:1.f];
        UIColor *steelBlueColor = [UIColor colorWithRed:0.f/255.f green:154.f/255.f blue:184.f/255.f alpha:1.f];
        UIColor *purpleColor = [UIColor colorWithRed:0.533 green:0.247 blue:0.671 alpha:1.000];
        
        self.backgroundColor = self.contentView.backgroundColor = [UIColor blackColor];
    
        // Dummy views (No layout)
        
        UIView *left = [[UIView alloc] initWithFrame:CGRectZero];
        left.backgroundColor = tomatoColor;
        left.layer.cornerRadius = (CELL_HEIGHT-8)/2;
        
        UIView *right = [[FLEXBOXContainerView alloc] initWithFrame:CGRectZero];
        right.backgroundColor = steelBlueColor;
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectZero];
        time.textColor = [UIColor whiteColor];
        time.font = [UIFont boldSystemFontOfSize:11];
        time.text = @"88:88";
        time.backgroundColor = purpleColor;
        time.textAlignment = NSTextAlignmentCenter;

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.text = @"Lorem ipsum flexbox";
        
        UILabel *caption = [[UILabel alloc] initWithFrame:CGRectZero];
        caption.textColor = [UIColor whiteColor];
        caption.font = [UIFont systemFontOfSize:13];
        caption.text = @"Ex persius officiis appellantur vel, est viris admodum et est viris admodum.";
        
        
        // View hierarchy
        
        [self.contentView addSubview:left];
        [self.contentView addSubview:right];
        [self.contentView addSubview:time];
        
        [right addSubview:title];
        [right addSubview:caption];
        
        
        // Flexbox
        
        
        object_setClass(self.contentView, FLEXBOXContainerView.class);
        self.contentView.flexDirection = FLEXBOXFlexDirectionRow;
        
        left.flexFixedSize = (CGSize){CELL_HEIGHT-8,CELL_HEIGHT-8};
        left.flexMargin = (UIEdgeInsets){0,12,0,12};
        left.flexAlignSelf = FLEXBOXAlignmentCenter;
        
        right.flexContainer = YES;
        right.flex = 1;
        right.flexDirection = FLEXBOXFlexDirectionColumn;
        right.flexJustifyContent = FLEXBOXJustificationCenter;
        
        time.flexMargin = (UIEdgeInsets){0,12,0,12};
        time.flexPadding = (UIEdgeInsets){4,4,4,4};
        time.flexAlignSelf = FLEXBOXAlignmentCenter;
        
        title.flexMargin = (UIEdgeInsets){0,12,8,12};
        caption.flexMargin = (UIEdgeInsets){0,12,0,12};
    }
    
    return self;
}

@end


@interface CellDemoTableViewController ()

@end

@implementation CellDemoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [self.tableView registerClass:FlexDemoTableViewCell.class forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor blackColor];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}


@end
