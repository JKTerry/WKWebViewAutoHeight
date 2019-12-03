//
//  WKWebViewTableViewCell.h
//  WKWebViewAutoHeight
//
//  Created by Jake on 2019/12/3.
//  Copyright © 2019 Ygomi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewTableViewCellModel : NSObject
@property (nonatomic, copy  ) NSString *htmlString;
@end

@interface WKWebViewTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL  isLoadedWebView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet WKWebView *webView;
@property (nonatomic, copy  ) void(^getWebViewContentHeightBlock)(CGFloat contentHeight);

@property (nonatomic, strong) WKWebViewTableViewCellModel *cellModel;
@end

NS_ASSUME_NONNULL_END
