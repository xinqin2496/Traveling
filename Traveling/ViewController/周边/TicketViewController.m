//
//  TicketViewController.m
//  Traveling
//
//  Created by 郑文青 on 16/7/13.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "TicketViewController.h"
#import "SurroundViewModel.h"
#import "TicketCell.h"
#import "WebViewController.h"
@interface TicketViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)SurroundViewModel *surroundVM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TicketViewController
#pragma mark 懒加载
-(SurroundViewModel *)surroundVM
{
    if (!_surroundVM) {
        _surroundVM = [SurroundViewModel new];
    }
    return _surroundVM;
}

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    WK(weakSelf);
    [self.tableView addHeaderRefresh:^{
        [weakSelf.surroundVM getSurroundRequestModel:RequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                [weakSelf.view showError:error.localizedDescription bgColor:kBgColor];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
                
            }
        }];
        [weakSelf.tableView endHeaderRefresh];
    }];
    [self.tableView beginHeaderRefresh];
    
    [self.tableView addAutoFooterRefresh:^{
        
        [weakSelf.surroundVM getSurroundRequestModel:RequestModeMore completionHandler:^(NSError *error) {
            
            if (error) {
                [weakSelf.view showError:error.localizedDescription bgColor:kBgColor];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
                
            }
            [weakSelf.tableView endFooterRefresh];
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.surroundVM.rowNumber;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"TicketCell" forIndexPath:indexPath];
  
    cell.spotName.text = [self.surroundVM spotNameForIndex:indexPath.row];
    cell.ticketTitle.text = [self.surroundVM descriptionForIndex:indexPath.row];
    [cell.iconIV sd_setImageWithURL:[self.surroundVM imageURLForIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"gangao1"]];
    cell.cityName.text = [self.surroundVM provinceCityForIndex:indexPath.row];
    cell.priceLb.text = [NSString stringWithFormat:@"¥%@",[self.surroundVM priceForIndex:indexPath.row]?[self.surroundVM priceForIndex:indexPath.row]:@"30"];
    
    cell.starGradeLb.text = [self.surroundVM starGradeForIndex:indexPath.row];
    
    NSString *normalPrice = [NSString stringWithFormat:@"¥%@", [self.surroundVM normalPriceForIndex:indexPath.row] ?[self.surroundVM normalPriceForIndex:indexPath.row]:@"50"];
    NSUInteger length = [normalPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:normalPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [cell.normalPriceLb setAttributedText:attri];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.backURLStr = [[self.surroundVM detailUrlForIndex:indexPath.row]absoluteString];
    [self.navigationController pushViewController:webVC animated:YES];
  
}



@end
