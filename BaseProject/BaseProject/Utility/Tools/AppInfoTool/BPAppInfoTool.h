//
//  BPAppInfoTool.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/26.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPAppInfoTool : NSObject


//系统版本号
@property (strong, nonatomic,readonly) NSString *systemVersion;
//设备唯一标识码
@property (strong, nonatomic,readonly) NSString *uuid;
//idfa(identifierForIdentifier，广告标示符)
@property (strong, nonatomic, readonly) NSString *idfa;
//app版本号
@property (strong, nonatomic,readonly) NSString *clientVersion;
//设备类型,iPhone,iPad
@property (strong, nonatomic,readonly) NSString *mobileType;


@end
