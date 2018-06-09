//
//  BPImprovingTipViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPImprovingTipViewController.h"
#import "BPSimpleModel.h"
#import "BPImprovingTipViewModel.h"
#import "BPSimpleTableViewCell.h"
#import "BPSimpleTableController.h"

@interface BPImprovingTipViewController ()
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) BPImprovingTipViewModel *viewModel;
@end

@implementation BPImprovingTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self handleData];
}

- (BPImprovingTipViewModel *)viewModel{
    if (!_viewModel) {
        BPImprovingTipViewModel *viewModel = [BPImprovingTipViewModel viewModel];
        weakify(viewModel);
        [viewModel configTableviewCell:^BPSimpleTableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            BPSimpleTableViewCell *cell = [BPSimpleTableViewCell cellWithTableView:tableView];
            [cell setModel:viewModel.data[indexPath.row] indexPath:indexPath];
            return cell;
        }];
        weakify(self);
        
        [viewModel setDataLoadSuccessedConfig:^(NSArray * _Nonnull dataSource) {
            strongify(self);
            self.dataArray = dataSource;
            [self refreshDataSuccessed];
        } failed:^{
            strongify(self);
            [self refreshDataFailed];
        }];
        _viewModel = viewModel;
    }
    return _viewModel;
}

- (void)handleData {
    self.tableView.dataSource = self.viewModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BPSimpleModel *model = self.dataArray[indexPath.row];
    NSString *className = model.fileName;
    Class classVc = NSClassFromString(className);
    if (classVc) {
        if (model.subVc_array.count) {
            BPSimpleTableController *vc = [[classVc alloc] init];
            [vc setLeftBarButtonTitle:model.title];
            //[vc setLeftBarButtonTitle:BPLocalizedString(bp_naviItem_backTitle)];
            vc.dataArray = model.subVc_array;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            BPBaseViewController * vc = [[classVc alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            //vc.navigationItem.title = model.title;
            [vc setLeftBarButtonTitle:model.title];
            vc.dynamicJumpString = model.dynamicJumpString;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
