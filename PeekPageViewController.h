//
//  PeekPageViewController.h
//
//  Created by Kevin Jantzer on 9/8/15.
//  Copyright (c) 2015 Blackstone Audio, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeekPageViewController : UIViewController <UIScrollViewDelegate>
{
    id delegate;
    NSArray* items;
}

-(id) delegate;
-(void) setDelegate:(id) newDelegate;

-(NSArray*) items;
-(void) setItems:(id) newItems;

-(void) setViews;
-(long) numberOfPages;
-(int) onPageIndex;
-(UIView*) currentView;
-(UIView*) viewForIndex:(int)index;

@end
