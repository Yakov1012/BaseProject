//
//  BPTestCollectionViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHeritageDictionaryModel.h"

@interface BPTestCollectionViewCell : UICollectionViewCell

- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic,strong) NSArray *array;
@end
