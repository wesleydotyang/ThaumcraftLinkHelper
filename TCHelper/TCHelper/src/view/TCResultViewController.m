//
//  TCResultViewController.m
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "TCResultViewController.h"
#import "TCElementCell.h"
#import "TCElement.h"

@interface TCResultViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TCResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"结果";
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(doneTapped)];
    self.navigationItem.rightBarButtonItem = barItem;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TCElementCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

-(void)doneTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.paramResultSet.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.paramResultSet[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCElementCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    TCElement *element = self.paramResultSet[indexPath.section][indexPath.row];
    cell.titleLabel.text = element.alias;
    cell.imageView.image = [UIImage imageNamed:element.name];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        reusableview = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        
        reusableview.backgroundColor = [UIColor lightGrayColor];
//        NSString *title = [[NSString alloc] initWithFormat:@"Recipe Group %d",indexPath.section +1];
      
        
    }
 
    
    return reusableview;
    
    
}


@end
