//
//  WKWebViewTableViewCell.m
//  WKWebViewAutoHeight
//
//  Created by Jake on 2019/12/3.
//  Copyright © 2019 Ygomi. All rights reserved.
//

#import "WKWebViewTableViewCell.h"

@implementation WKWebViewTableViewCellModel

@end

@interface WKWebViewTableViewCell()<WKNavigationDelegate>

@end

@implementation WKWebViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupWebView];
}

- (void) setupWebView {
    self.webView.navigationDelegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.contentScaleFactor = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellModel:(WKWebViewTableViewCellModel *)cellModel {
    _cellModel = cellModel;
    if (self.isLoadedWebView == NO) {
//        NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
        [self.webView loadHTMLString:_cellModel.htmlString baseURL:nil];
        self.isLoadedWebView = YES;
    }
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    __weak typeof(self) ws = self;
    [self.webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable complete, NSError * _Nullable error) {
        __strong typeof(ws) ss = ws;
        __weak typeof(ss) w_s = ss;
        [ss.webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            __strong typeof(w_s) s_s = w_s;
            CGFloat contentHeight = [result floatValue];
            NSLog(@"webviewheight:%.3f",contentHeight);
            if (s_s.getWebViewContentHeightBlock) {
                s_s.getWebViewContentHeightBlock(contentHeight);
            }
        }];
    }];
    
}
@end
