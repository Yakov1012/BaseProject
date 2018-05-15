//
//  KSHeritageDictionaryListTableViewCell.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSHeritageDictionaryListTableViewCell.h"
#import "KSHeritageDictionaryMacro.h"
#import "UIImageView+WebCache.h"

@interface KSHeritageDictionaryListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desclabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desclabelTopConstraint;
@property (nonatomic,strong) KSWordBookAuthorityDictionaryThirdCategoryModel *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downloadButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downloadButtonHeightConstraint;
@end

@implementation KSHeritageDictionaryListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configViews];
    [self initGesture];
}

- (void)initGesture {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesCallback:)];
    [self addGestureRecognizer:tap];
}

- (void)tapGesCallback:(UIGestureRecognizer *)gestureRecognizer {
    [self enterDetailVC];
}

- (void)enterDetailVC {
 
}

#pragma mark - 初始化赋值
- (void)setModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    self.desclabel.hidden = NO;
    self.downLoadButton.hidden = NO;
    self.titleLabel.textColor = kDarkTextColor;
    //首页有数据 或者 不是首页的情况
    self.titleLabel.text = model.name;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"wordBookHomeNoRRecommendDictionary"]];
    self.desclabel.text = [NSString stringWithFormat:@"单词数%@  参加人数%@",model.wordCount,model.joinCount];
    //如果数据库没有数据,显示添加
    self.model.dictionaryExecuteType = HeritageDictionaryExecuteUnKnown;
    self.model.downLoadProgress = 0;
    self.model.writeDBProgress = 0;
    [self configDownLoadButtonWithText:@"添加" titleColor:kGreenColor backgroundColor:[kGreenColor colorWithAlphaComponent:0.08]];
}

#pragma mark - 下载事件
- (void)downLoad  {

}

#pragma mark - 根据状态 配置添加按钮颜色
- (void)configDownLoadButtonWithText:(NSString *)text titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.downLoadButton setTitle:text forState:UIControlStateNormal];
        [self.downLoadButton setTitle:text forState:UIControlStateDisabled];
        [self.downLoadButton setTitleColor:titleColor forState:UIControlStateNormal];
        [self.downLoadButton setBackgroundColor:backgroundColor];
        if (self.model.dictionaryExecuteType == HeritageDictionaryExecuteDownLoading || self.model.dictionaryExecuteType == HeritageDictionaryExecuteWriteing) {
            self.downLoadButton.layer.borderColor = [kGreenColor colorWithAlphaComponent:0.08].CGColor;
        }else {
            self.downLoadButton.layer.borderColor = nil;
        }
    });
}

- (void)configViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.coverImageView.layer.cornerRadius = 3;
    [self.coverImageView.layer setMasksToBounds:YES];
    self.titleLabel.textColor = kDarkTextColor;
    self.desclabel.textColor = kDarkTextColor;
    self.downLoadButton.adjustsImageWhenHighlighted = NO;
    [self.downLoadButton.layer setCornerRadius:35/2.0];
    [self.downLoadButton.layer setMasksToBounds:YES];
    [self.lineView setBackgroundColor:kLightGrayColor];
    self.lineViewHeightConstraint.constant = kOnePixel;
    self.coverImageView.contentMode =UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;
    self.desclabel.adjustsFontSizeToFitWidth = YES;
}

#pragma mark - KSHeritageDownloadViewControllerDelegate
- (void)downloadFinishedWithSuccess:(BOOL)isSuccess {
    if(isSuccess) {
        [self configDownLoadButtonWithText:@"立即学习" titleColor:kDarkTextColor backgroundColor:kDarkTextColor];
    } else {
        [self configDownLoadButtonWithText:@"添加" titleColor:kGreenColor backgroundColor:[kGreenColor colorWithAlphaComponent:0.08]];
    }
}

//写入数据库结果
- (void)didReceiveWriteDBResultWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configHomePageViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.coverImageView.layer.cornerRadius = 3;
    self.lineView.hidden = YES;
    self.coverImageViewWidthConstraint.constant = 84;
    self.coverImageViewHeightConstraint.constant = 112;
    self.coverImageViewLeftConstraint.constant = 0;
    self.titleLabelTopConstraint.constant = 6;
    self.desclabelTopConstraint.constant = 7;
    self.downloadButtonWidthConstraint.constant = 90;
    self.downloadButtonHeightConstraint.constant = 30;
    self.downLoadButton.layer.cornerRadius = 30.0/2.0;
    self.downLoadButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.desclabel.adjustsFontSizeToFitWidth = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
