//
//  BPTopCategoryCollectionViewController1.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryCollectionViewController1.h"
#import "KSHeritageDictionaryModel.h"
#import "KSHeritageDictionaryListContainerCollectionViewCell5.h"
#import "KSHeritageDictionaryMacro.h"

@interface BPTopCategoryCollectionViewController1 ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, strong) NSArray *cateogry;
@end

@implementation BPTopCategoryCollectionViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handlaData1];
    [self configSubViews];
}

- (void)configSubViews {
    self.title = @"权威词典";
    self.view.backgroundColor = kWhiteColor;
    //主collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainView = mainView;
    mainView.backgroundColor = kWhiteColor;
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerNib:[UINib nibWithNibName:NSStringFromClass([KSHeritageDictionaryListContainerCollectionViewCell5 class]) bundle:nil] forCellWithReuseIdentifier:@"KSHeritageDictionaryListContainerCollectionViewCell5"];
    [self.view addSubview:mainView];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    if (kiOS11) {
        self.mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)handlaData1 {
    NSArray *array1 = @[@"四级",@"六级",@"小学",@"初中",@"高中",@"大学"];
    NSArray *array2 = @[@"初中牛津版",@"新教初中牛津版",@"仁爱的版",@"初中河北版",@"初中牛津版",@"翼教版",@"初中牛津版",@"新教初中牛津版",@"仁爱的版",@"初中河北版",@"初中牛津版",@"翼教版"];
    NSArray *array3 = @[@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词"];
    
    NSMutableArray *muArray1 = @[].mutableCopy;
    [array1 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx1, BOOL * _Nonnull stop) {
        KSWordBookAuthorityDictionaryFirstCategoryModel *model = [[KSWordBookAuthorityDictionaryFirstCategoryModel alloc] init];
        model.name = title;
        NSMutableArray *tagArray = @[].mutableCopy;
        [array2 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx2, BOOL * _Nonnull stop) {
            KSWordBookAuthorityDictionarySecondCategoryModel *tagModel = [[KSWordBookAuthorityDictionarySecondCategoryModel alloc] init];
            KSWordBookAuthorityDictionaryThirdCategoryUpperModel *upperModel = [[KSWordBookAuthorityDictionaryThirdCategoryUpperModel alloc] init];
            tagModel.thirdCategoryModel = upperModel;
            tagModel.name = title;
            NSMutableArray *cellArray = @[].mutableCopy;
            [array3 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx3, BOOL * _Nonnull stop) {
                KSWordBookAuthorityDictionaryThirdCategoryModel *cellModel = [[KSWordBookAuthorityDictionaryThirdCategoryModel alloc] init];
                NSString *number = [NSString stringWithFormat:@"%ld%ld%ld",idx1,idx2,idx3];
                cellModel.name = [NSString stringWithFormat:@"%@:%@",number,title];
                cellModel.classId = @([number integerValue]);
                [cellArray addObject:cellModel];
            }];
            upperModel.data = cellArray;
            [tagArray addObject:tagModel];
        }];
        model.sub = tagArray;
        [muArray1 addObject:model];
    }];
    
    self.cateogry = muArray1.copy;
    
    [self.cateogry enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionaryFirstCategoryModel *firstCategoryModel, NSUInteger idx1, BOOL * _Nonnull stop) {
        [firstCategoryModel.sub enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel, NSUInteger idx2, BOOL * _Nonnull stop) {
            secondCategoryModel.defaultShowIndex = 0;
            if (idx2 == secondCategoryModel.defaultShowIndex) {
                secondCategoryModel.isSelected = YES;
            }else {
                secondCategoryModel.isSelected = NO;
            }
        }];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cateogry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSHeritageDictionaryListContainerCollectionViewCell5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSHeritageDictionaryListContainerCollectionViewCell5" forIndexPath:indexPath];
    KSWordBookAuthorityDictionaryFirstCategoryModel *model = self.cateogry[indexPath.row];
    [cell setModel:model indexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.mainView.bounds.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

