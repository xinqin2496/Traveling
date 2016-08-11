//
//  MainViewController.m
//  Traveling
//
//  Created by 郑文青 on 16/6/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "MainViewController.h"
#import "TraveListViewModel.h"
#import "CityViewController.h"
#import "WebViewController.h"
#import "ParentChildView.h"
#import "RecommdCell.h"
#import "RecommdView.h"
#import "TravelCell.h"

#define ISWIDTH kScreenW >= 375

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource,UISearchBarDelegate>
{
    iCarousel *_ic;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerScrollView;
@property (weak, nonatomic) IBOutlet UIView *headerParentChildView;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *itemTitleArray;
@property (nonatomic,strong)NSArray *itemImageArray;
@property (nonatomic,strong)NSArray *itemURLArray;
@property (nonatomic,assign)CGFloat lineSpace;
@property (nonatomic,strong)NSArray *colorArray;
@property (nonatomic,strong)TraveListViewModel *TraveListVM;
@property (nonatomic,strong)ParentChildView *childView;
@property (nonatomic,strong)ImageViewScale *imageViewScale;
@property (nonatomic,strong)TravelCell *traveCell;
@property (nonatomic,assign)BOOL isClick;
- (IBAction)clickCityBtn:(id)sender;
@end

@implementation MainViewController
#pragma mark 懒加载
-(CGFloat)lineSpace
{
    return ISWIDTH ? (kScreenW - 4* 75)/4 :(kScreenW - 4 *70) / 4;
}
-(NSArray *)colorArray
{
    if (!_colorArray) {
        _colorArray = @[kRGBColor(198, 0, 98, 1.0),kRGBColor(229, 52, 50, 1.0),kRGBColor(244, 99, 24, 1.0),kRGBColor(184,86,218, 1.0),kRGBColor(118, 87, 217, 1.0),kRGBColor(69, 131, 212, 1.0),kRGBColor(34, 181, 129, 1.0),kRGBColor(107, 191, 37, 1.0)];
    }
    return _colorArray;
}
-(NSArray *)itemImageArray
{
    if (!_itemImageArray) {
        _itemImageArray = @[];
    }
    return _itemImageArray;
}
-(NSArray *)itemTitleArray
{
    if (!_itemTitleArray) {
        _itemTitleArray = @[@"景点",@"酒店",@"美食",@"旅游度假",@"旅游团购",@"周末游",@"用车自驾",@"攻略"];
    }
    return _itemTitleArray;
}
-(NSArray *)itemURLArray
{
    if (!_itemURLArray) {
        _itemURLArray = @[@"http://touch.piao.qunar.com/touch/index.htm?bd_source=qunar",@"http://touch.qunar.com/hotel/index",@"http://food.qunar.com/app?bd_source=qunar",@"http://touch.dujia.qunar.com/?bd_source=qunar",@"http://touch.dujia.qunar.com/tuan.qunar",@"http://touch.piao.qunar.com/touch/weekend/index.htm?in_track=t_sy_weekendtravel_touch&bd_source=qunar",@"http://cheche.qunar.com/?from=28&bd_source=qunar",@"http://touch.go.qunar.com/?bd_source=qunar"];
        
    }
    return _itemURLArray;
}
-(TraveListViewModel *)TraveListVM
{
    if (!_TraveListVM) {
        _TraveListVM = [TraveListViewModel new];
    }
    return _TraveListVM;
}
-(ImageViewScale *)imageViewScale
{
    if (!_imageViewScale) {
        _imageViewScale = [ImageViewScale new];
    }
    return _imageViewScale;
}
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isClick = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    [self topView];
    [self loadHeaderParentChildView];
    
    [self.cityBtn setTitle:kCurrentCity forState:UIControlStateNormal];
    //监听城市改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityChanged:) name:kCurrentCitychangedNotification object:nil];
    //添加搜索
    [self setSearchBarToNavigationItemTitleView];
    [Factory addMenuItemToVC:self];
    WK(weakSelf);
    [self.tableView addHeaderRefresh:^{
        [weakSelf.TraveListVM getScenicRequestModel:RequestModeRefresh completionHandler:^(NSError *error) {
            
            if (error) {
               [weakSelf.view showError:error.localizedDescription bgColor:kBgColor];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
               
            }
        }];
//        for (int  i = 101; i < 109; i++) {
//            CGFloat red = arc4random() % 256 / 255.0;
//            CGFloat green = arc4random() % 256 / 255.0;
//            CGFloat blue = arc4random() % 256 / 255.0;
//            
//            UIButton *button = (UIButton *)[self.tableView viewWithTag:i];
//            
//            button.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//        }
        
        [weakSelf.collectionView reloadData];
        [weakSelf.tableView endHeaderRefresh];
    }];
    [self.tableView beginHeaderRefresh];
    
    [self.tableView addAutoFooterRefresh:^{
       
        [weakSelf.TraveListVM getScenicRequestModel:RequestModeMore completionHandler:^(NSError *error) {
            
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
#pragma  mark  监听到通知后执行的方法
-(void)cityChanged:(NSNotification *)notification
{
    [self.cityBtn setTitle:kCurrentCity forState:UIControlStateNormal];
    
    //接到通知,改变当前城市的时候 开始刷新
    [self.tableView beginHeaderRefresh];
}
//添加搜索
-(void)setSearchBarToNavigationItemTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW *0.5, 30)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    
    searchBar.delegate = self;
    searchBar.frame = titleView.bounds;
    searchBar.backgroundColor = color;
    searchBar.layer.cornerRadius = 15;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:5];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  
    
    searchBar.placeholder = @"景点/酒店/去哪儿";
    [titleView addSubview:searchBar];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}


-(void)loadHeaderParentChildView
{
    ParentChildView *childView = [[NSBundle mainBundle]loadNibNamed:@"ParentChildView" owner:nil options:nil].lastObject;
    
    [self.headerParentChildView addSubview:childView];
    //国内游
    [childView.YunanBtn bk_addEventHandler:^(id sender) {
       NSString *urlStr = @"http://dujia.qunar.com/p/domestic?tm=ign_origin";
        [self gotoWebVCWithURLStr:urlStr];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //亲子游
    [childView.parentChildBtn bk_addEventHandler:^(id sender) {
        
        NSString *urlStr = @"http://zt.dujia.qunar.com/bp/zt.php?id=552&tf=xbtj_bylx&in_track=xbtj04";
        [self gotoWebVCWithURLStr:urlStr];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //三亚游
    [childView.sanyaBtn bk_addEventHandler:^(id sender) {
    
        NSString *urlStr = @"http://sanya.dujia.qunar.com/?tf=pklist_origin";
        [self gotoWebVCWithURLStr:urlStr];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //周边游
    [childView.SwimAroundBtn bk_addEventHandler:^(id sender) {
       NSString *urlStr = @"http://dujia.qunar.com/p/around?tf=dj_aroundnav";
        [self gotoWebVCWithURLStr:urlStr];
    } forControlEvents:UIControlEventTouchUpInside];
    //8月优惠
    [childView.preferentialBtn bk_addEventHandler:^(id sender) {
        NSString *urlStr = @"http://dujia.qunar.com/tejia?tf=dj_nav";
        [self gotoWebVCWithURLStr:urlStr];
    } forControlEvents:UIControlEventTouchUpInside];
    //日韩游
    [childView.HongKongBtn bk_addEventHandler:^(id sender) {
        NSString *urlStr = @"http://piao.qunar.com/topic/gat1409.htm";
        [self gotoWebVCWithURLStr:urlStr];
    } forControlEvents:UIControlEventTouchUpInside];
    
}
//跳转到webVC
-(void)gotoWebVCWithURLStr:(NSString *)URLStr
{
    WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.backURLStr = URLStr;
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark 按钮点击事件
- (IBAction)clickTravelingBtn:(UIButton *)sender
{
   
    WebViewController *wvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    wvc.hidesBottomBarWhenPushed = YES;
    wvc.title = sender.titleLabel.text;
   
    if (sender.tag == 108) {//飞机票
       wvc.backURLStr = @"http://touch.qunar.com/h5/flight/";
        
    }else if(sender.tag == 101){//火车票
       
        wvc.backURLStr = @"http://touch.train.qunar.com/?from=touchindex";
    }else if(sender.tag == 102){//汽车票
       
        wvc.backURLStr = @"http://touch.qunar.com/h5/bus?bd_source=qunar";
    }else if(sender.tag == 103){//地铁线路
        wvc.backURLStr = @"http://dt.8684.cn";
    }else if(sender.tag == 104){//出租车
        
        wvc.backURLStr = @"http://cheche.qunar.com/taxi_urban.jsp?from=238";
    }else if(sender.tag == 105){//自驾游
        wvc.backURLStr = @"http://cheche.qunar.com/selfDrive/?from=238";
    }else if(sender.tag == 106){//接送火车
        
        wvc.backURLStr = @"http://cheche.qunar.com/train.jsp?from=238";
    }else if(sender.tag == 107){//接送机
       
        wvc.backURLStr = @"http://car.qunar.com/?from=238";
    }
    [self.navigationController pushViewController:wvc animated:YES];
}

- (IBAction)clickCityBtn:(id)sender
{
    CityViewController *controller = [[CityViewController alloc] init];
    controller.currentCityString = kCurrentCity;
    
    controller.selectString = ^(NSString *string){
        [self.tableView beginHeaderRefresh];
        [self.cityBtn setTitle:string forState:UIControlStateNormal];
       
    };
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark 滚动视图
-(UIView *)topView
{
    [_timer invalidate];
    
    //    添加滚动栏
    _ic = [iCarousel new];
    [self.headerScrollView addSubview:_ic];
    
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        
    }];
    _ic.delegate = self;
    _ic.dataSource = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupScrollViewIndex:) userInfo:nil repeats:YES];
    
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = 7;
    [self.headerScrollView addSubview:_pageControl];
    _pageControl.currentPageIndicatorTintColor = kBgColor;
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(_ic).mas_equalTo(5);
        
    }];
    
    _pageControl.userInteractionEnabled = NO;
    
    return self.headerScrollView;
}
-(void)setupScrollViewIndex:(NSTimer *)timer
{
    [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    return 7;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    if (!view) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, self.headerScrollView.bounds.size.height)];
        
        UIImageView *imageView = [UIImageView new];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        imageView.tag = 100;
        imageView.contentMode = 2;
        view.clipsToBounds = YES;
    }
    UIImageView *imageView = (UIImageView  *)[view viewWithTag:100];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Scroll0%ld",index+1]];
    
    
    return view;
}
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}
/** 监控当前滚到到第几个 */
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    _pageControl.currentPage = carousel.currentItemIndex;
    
    
}
//点中做什么
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSArray *urlArray = @[@"http://disney.qunar.com/?in_track=p_dsy_xbtjdisney&in_track=xbtj02",@"http://touch.piao.qunar.com/touch/detail_2920170810.html?cat=from_area%3Dts_banner%26from_index%3D1",@"http://sale.piao.qunar.com/touch/topic/mk/t_1471.htm?cat=from_area%3Dts_banner%26from_index%3D3",@"http://dujia.qunar.com/summer2016?tf=xbtj_bylx&in_track=xbtj01",@"http://touch.piao.qunar.com/touch/detail_1306166277.html?cat=from_area%3Dts_banner%26from_index%3D4",@"http://touch.piao.qunar.com/touch/detail_3759437369.html?st=a3clM0QlRTQlQjglOEElRTYlQjUlQjclRTYlOUQlOUMlRTglOEUlOEUlRTUlQTQlQUIlRTQlQkElQkElMjZpZCUzRDEzODkzJTI2dHlwZSUzRDAlMjZpZHglM0QxJTI2cXQlM0R1bmtub3duJTI2YXBrJTNEMyUyNnNjJTNEVE9VQ0glMjZhYnRyYWNlJTNEYndkJTQwJUU2JTlDJUFDJUU1JTlDJUIwJTI2dXIlM0QlRTUlOEMlOTclRTQlQkElQUMlMjZsciUzRCVFNSU4QyU5NyVFNCVCQSVBQyUyNmZ0JTNEJTdCJTdE&cat=from_area%3Dts_banner%26from_index%3D7",@"http://sale.piao.qunar.com/touch/topic/mk/t_1365.htm?in_track=appsylbyiriyou&cat=from_area%3Dts_banner%26from_index%3D6#1"];
   
    NSString *urlStr = urlArray[index];
    
    [self gotoWebVCWithURLStr:urlStr];
}

#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.TraveListVM.rowNumber;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    RecommdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommdCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
       
        if (self.isClick) {

    [cell.btn1 bk_addEventHandler:^(id sender) {
       //上海必游TOP10
        NSString *urlStr = @"http://touch.piao.qunar.com/touch/toSku.htm?skuId=69&skuName=上海必游TOP10&cat=from_area%3Dts_sku%26from_index%3D0%26from_value%3D%25E4%25B8%258A%25E6%25B5%25B7%25E5%25BF%2585%25E6%25B8%25B8TOP10%26dist_city%3D%25E4%25B8%258A%25E6%25B5%25B7";
        [self gotoWebVCWithURLStr:urlStr];
        
    } forControlEvents:UIControlEventTouchUpInside];
        
    [cell.btn2 bk_addEventHandler:^(id sender) {
       //上海城市观光
        NSString *urlStr = @"http://touch.piao.qunar.com/touch/toSku.htm?skuId=544&skuName=上海城市观光&cat=from_area%3Dts_sku%26from_index%3D2%26from_value%3D%25E4%25B8%258A%25E6%25B5%25B7%25E5%259F%258E%25E5%25B8%2582%25E8%25A7%2582%25E5%2585%2589%26dist_city%3D%25E4%25B8%258A%25E6%25B5%25B7";
        [self gotoWebVCWithURLStr:urlStr];
    } forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 bk_addEventHandler:^(id sender) {
        //情迷博物馆
         NSString *urlStr = @"http://touch.piao.qunar.com/touch/toSku.htm?skuId=74&skuName=情迷博物馆&cat=from_area%3Dts_sku%26from_index%3D4%26from_value%3D%25E6%2583%2585%25E8%25BF%25B7%25E5%258D%259A%25E7%2589%25A9%25E9%25A6%2586%26dist_city%3D%25E4%25B8%258A%25E6%25B5%25B7";
        [self gotoWebVCWithURLStr:urlStr];
    } forControlEvents:UIControlEventTouchUpInside];
    [cell.btn4 bk_addEventHandler:^(id sender) {
        //亲子时光TOP10
        NSString *urlStr = @"http://touch.piao.qunar.com/touch/toSku.htm?skuId=75&skuName=亲子时光TOP10&cat=from_area%3Dts_sku%26from_index%3D3%26from_value%3D%25E4%25BA%25B2%25E5%25AD%2590%25E6%2597%25B6%25E5%2585%2589TOP10%26dist_city%3D%25E4%25B8%258A%25E6%25B5%25B7";
        [self gotoWebVCWithURLStr:urlStr];
    } forControlEvents:UIControlEventTouchUpInside];
            self.isClick = NO;
        }
    return cell;
    }else{
    TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravelCell" forIndexPath:indexPath];
        self.traveCell = cell;
        cell.titlLb.text = [self.TraveListVM titleForIndex:indexPath.row];
        cell.routeLb.text = [self.TraveListVM linePlanningForIndex:indexPath.row];
        [cell.DescIV sd_setImageWithURL:[self.TraveListVM scenicImageUrlForIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"login_big_dim_bg"]];
        
        
        [cell.iconIV sd_setImageWithURL:[self.TraveListVM userHeadeImageForIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"login_user"]];
        cell.thumbUpLb.text =[NSString stringWithFormat:@"%ld",(long)[self.TraveListVM likeCountForIndex:indexPath.row]];
        NSString *dateStr  = [NSString stringWithFormat:@"%@  %@",[self.TraveListVM starTimeForIndex:indexPath.row],[self.TraveListVM routeDaysForIndex:indexPath.row]];
        cell.dateLb.text = dateStr;
        [cell.thumbUpBtn bk_addEventHandler:^(id sender) {
            cell.thumbUpBtn.selected = !cell.thumbUpBtn.selected;
        } forControlEvents:UIControlEventTouchUpInside];
        
    return cell;
    }
  
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RecommdView *recommdView = [[NSBundle mainBundle]loadNibNamed:@"RecommdView" owner:nil options:nil].lastObject;
    if (section == 0) {
        recommdView.titleLb.text = @"上海旅游推荐";
        [recommdView.forwardbtn bk_addEventHandler:^(id sender) {
            NSLog(@"点击前往更多推荐");
        } forControlEvents:UIControlEventTouchUpInside];
    }else{
        recommdView.titleLb.text = @"游记";
        [recommdView.forwardbtn bk_addEventHandler:^(id sender) {
            NSLog(@"点击前往更多游记");
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return recommdView;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;    

    }else{
        WebViewController *wvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        wvc.hidesBottomBarWhenPushed = YES;
       
        //把 URL 转成 NSString
        wvc.backURLStr = [[self.TraveListVM bookUrlForIndex:indexPath.row] absoluteString];
        [self.navigationController pushViewController:wvc animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 190;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//可以让section 不悬停
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 30;
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}
#pragma mark UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemTitleArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //把故事板中的 标识cell 复用
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellItem" forIndexPath:indexPath];
    
    if (ISWIDTH) {
        CGRect frame = cell.frame;
        frame.size.width = 75;
        cell.frame = frame;
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5;

    cell.backgroundColor = self.colorArray[indexPath.row];
    //通过tag值 取到故事板中设置好的imageView和Label
    UIImageView *iconIV = (UIImageView *)[cell.contentView viewWithTag:88];
    UILabel *titleLB = (UILabel *)[cell.contentView viewWithTag:99];
    NSString *imageStr = self.itemTitleArray[indexPath.row];
    iconIV.image = [UIImage imageNamed:imageStr];
    
    titleLB.text = self.itemTitleArray[indexPath.row];
    
    return cell;
}
//行之间的间隔
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
   
    return 10;
    
}
//项之间的间隔
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.lineSpace ;
}
//上左下右边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

   
    return UIEdgeInsetsMake(10, self.lineSpace / 2, 10,  self.lineSpace / 2);
}

//选中某一行做什么
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *urlStr = self.itemURLArray[indexPath.row];
    
    [self gotoWebVCWithURLStr:urlStr];
   
   
}
#pragma mark 把通知移除
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
