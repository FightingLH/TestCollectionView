//
//  ViewController.m
//  TestCollectionView
//
//  Created by lh on 16/9/12.
//  Copyright © 2016年 lh. All rights reserved.
//

#import "ViewController.h"
#import "LHFooterView.h"
#import "LHHeaderView.h"
#import "LHCollectionViewCell.h"
#import "Masonry.h"
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
static  NSString *const kHeaderMember = @"headerMember";
static  NSString *const kfFooterMember = @"footerMember";
static  NSString *const kCollectionMember = @"collectionMember";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)  UICollectionView *memberCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self memberCollectionView];
}

#pragma mark -collectView
-(UICollectionView *)memberCollectionView{
    if (!_memberCollectionView) {
        CGFloat rightDis = 12.5*SCREEN_WIDTH/320;
        CGFloat topDis = 18*SCREEN_HEIGHT/568;//+3
        CGFloat w = ((320 - 4*12.5)/3.0)*(SCREEN_WIDTH/320);
        CGFloat h = ((320 - 4*12.5)/3.0)*(SCREEN_HEIGHT/568);
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(topDis , rightDis, topDis, rightDis);
        layout.itemSize = CGSizeMake(w, h);
        layout.minimumInteritemSpacing = rightDis;
        layout.minimumLineSpacing = topDis;
        _memberCollectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        
        _memberCollectionView.delegate = self;
        _memberCollectionView.dataSource = self;
        _memberCollectionView.backgroundColor = [UIColor whiteColor];
        [_memberCollectionView registerClass:[LHCollectionViewCell class] forCellWithReuseIdentifier:kCollectionMember];
        [_memberCollectionView registerClass:[LHHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderMember];
        [_memberCollectionView registerClass:[LHFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfFooterMember];
        [self.view addSubview:_memberCollectionView];
        
        [_memberCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
    }
    return _memberCollectionView;
}

#pragma mark - UICollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionMember forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        LHHeaderView *hView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderMember forIndexPath:indexPath];
        hView.backgroundColor = [UIColor redColor];
        return hView;
    }else if(kind == UICollectionElementKindSectionFooter){
        LHFooterView *fView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kfFooterMember forIndexPath:indexPath];
        fView.backgroundColor = [UIColor grayColor];
        return fView;
    }
    return nil;
}

#pragma mark -header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 200);
}

#pragma mark -footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 200);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
