//
//  PeekPageViewController.m
//  Downpour
//
//  Created by Kevin Jantzer on 9/8/15.
//  Copyright (c) 2015 Blackstone Audio, Inc. All rights reserved.
//

#import "PeekPageViewController.h"

@implementation PeekPageViewController
{
    float pad;
    
    NSMutableArray* pageViews;
    UIScrollView* pageScrollView;
}

-(id) delegate { return delegate; }
-(void) setDelegate:(id) newDelegate { delegate = newDelegate; }


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    pad = 20;
    items = @[];
    pageViews = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    [self createPageViewController];
}

-(NSArray*) items { return delegate; }
-(void) setItems:(id) newItems {
    items = newItems;
    [self setViews];
}


-(void) createPageViewController
{
    pageScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    pageScrollView.opaque = NO;
    pageScrollView.showsHorizontalScrollIndicator = NO;
    pageScrollView.clipsToBounds = NO;
    pageScrollView.pagingEnabled = YES;
    pageScrollView.delegate = self;
    
    adjustFrame(pageScrollView, pad, nil, -pad*3, nil);
    
    [self.view addSubview: pageScrollView];
}

// override this
-(UIView*) scrollView:(UIScrollView*) scrollView viewForIndex:(int) index
{
    return [[UIView alloc] initWithFrame:scrollView.bounds];
}

-(void) removeViews
{
    for(int i = 0; i < [pageViews count]; i++){
        UIView* view = [pageViews objectAtIndex:i];
        [pageViews removeObject:view];
        [view removeFromSuperview];
    }
}

-(void) setViews
{
    [self removeViews];
    
    for(int i = 0; i < [items count]; i++){
        
        UIView* view = [self scrollView:pageScrollView viewForIndex:i];
        
        view.x = (i*pageScrollView.width)+pad;
        view.y = (pageScrollView.height - (view.height))/2;
        view.width = pageScrollView.width-pad;
        
        [pageScrollView addSubview:view];
        
        [pageViews setObject:view atIndexedSubscript:i];
    }
    
    pageScrollView.contentSize = CGSizeMake(pageScrollView.width*[items count], pageScrollView.height);
}


#pragma mark - pager util methods

-(long) numberOfPages {
    return [items count];
}

-(int) onPageIndex {
    return roundf( pageScrollView.contentOffset.x / pageScrollView.width );
}

-(UIView*) currentView {
    return [self viewForIndex:[self onPageIndex]];
}

-(UIView*) viewForIndex:(int)index {
    
    return [pageViews objectAtIndex:index];
}

@end
