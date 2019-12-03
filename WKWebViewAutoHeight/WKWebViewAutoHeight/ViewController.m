//
//  ViewController.m
//  WKWebViewAutoHeight
//
//  Created by Jake on 2019/12/3.
//  Copyright © 2019 Ygomi. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) CGFloat height_webCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray new];
    self.height_webCell = 54;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadData];
}

- (void) loadData {
    [self.dataSource removeAllObjects];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"HTML" ofType:nil];
    NSString *htmlStr = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    WKWebViewTableViewCellModel *cellModel = [WKWebViewTableViewCellModel new];
    cellModel.htmlString = htmlStr;
    [self.dataSource addObject:cellModel];
    
    WKWebViewTableViewCellModel *cellModel1 = [WKWebViewTableViewCellModel new];
    [self.dataSource addObject:cellModel1];
    cellModel1.htmlString = htmlStr;
    
    WKWebViewTableViewCellModel *cellModel2 = [WKWebViewTableViewCellModel new];
    [self.dataSource addObject:cellModel2];
    cellModel2.htmlString =  htmlStr;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cellModel = self.dataSource[indexPath.row];
    if ([cellModel isKindOfClass:[WKWebViewTableViewCellModel class]]) {
        WKWebViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WKWebViewTableViewCell" forIndexPath:indexPath];
        cell.cellModel = cellModel;
        __weak typeof(self) ws = self;
        [cell setGetWebViewContentHeightBlock:^(CGFloat contentHeight) {
            __strong typeof(ws) ss = ws;
            ss.height_webCell = 54+contentHeight;
            [ss.tableView reloadData];
        }];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cellModel = self.dataSource[indexPath.row];
    if ([cellModel isKindOfClass:[WKWebViewTableViewCellModel class]]) {
        return _height_webCell;
    }
    return 0;
}

#pragma mark - IBActions

@end
