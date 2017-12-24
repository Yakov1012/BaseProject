//
//  BPBaseTableView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseTableView.h"

@implementation BPBaseTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self awakeFromNib];
}

- (void)config {
    self.backgroundColor = kWhiteColor;
}

@end
