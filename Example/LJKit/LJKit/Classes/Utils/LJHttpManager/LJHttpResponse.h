//
//  LJHttpResponse.h
//  LJKit
//
//  Created by developer on 2019/9/18.
//  Copyright © 2019 liujing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJHttpResponse : NSObject
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSNumber *code;
@end
