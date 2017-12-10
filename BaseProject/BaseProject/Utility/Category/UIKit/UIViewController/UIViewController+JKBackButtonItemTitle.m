//
//  UIViewController+BackButtonItemTitle.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UIViewController+JKBackButtonItemTitle.h"

@implementation UIViewController (JKBackButtonItemTitle)

@end

@implementation UINavigationController (JKNavigationItemBackBtnTile)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    
    UIViewController * viewController = self.viewControllers.count > 1 ? \
                    [self.viewControllers objectAtIndex:self.viewControllers.count - 2] : nil;
    
    if (!viewController) {
        return YES;
    }
    
    NSString *backButtonTitle = nil;
    if ([viewController respondsToSelector:@selector(bp_navigationItemBackBarButtonTitle)]) {
        backButtonTitle = [viewController bp_navigationItemBackBarButtonTitle];
    }
    
    if (!backButtonTitle) {
        backButtonTitle = viewController.title;
    }
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:backButtonTitle
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:nil action:nil];
    viewController.navigationItem.backBarButtonItem = backButtonItem;
    
    return YES;
}

@end
