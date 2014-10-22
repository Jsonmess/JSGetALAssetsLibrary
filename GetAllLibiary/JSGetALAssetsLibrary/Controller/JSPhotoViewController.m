//
//  JSPhotoViewController.m
//  GetAllLibiary
//
//  Created by json on 14/10/19.
//  Copyright (c) 2014年 Jsonmess. All rights reserved.
//

#import "JSPhotoViewController.h"
#import "JSPhotoTool.h"
#import "JSPhotoScrollView.h"
@interface JSPhotoViewController ()

@end

@implementation JSPhotoViewController

+ (JSPhotoViewController *)photoViewControllerForPageIndex:(NSUInteger)pageIndex
{
    if (pageIndex < [[JSPhotoTool sharedInstance] PhotoCount])
    {
        return [[self alloc] initWithPageIndex:pageIndex];
    }
    return nil;
}

- (id)initWithPageIndex:(NSInteger)pageIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil)
    {
        _pageIndex = pageIndex;
    }
    return self;
}

- (void)loadView
{
    // replace our view property with our custom image scroll view
    JSPhotoScrollView *scrollView = [[JSPhotoScrollView alloc] init];
    scrollView.index = _pageIndex;
    
    self.view = scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.parentViewController.navigationItem.title =
    [NSString stringWithFormat:@"%@/%@", [@(self.pageIndex+1) stringValue], [@([[JSPhotoTool sharedInstance] PhotoCount]) stringValue]];
}
@end
