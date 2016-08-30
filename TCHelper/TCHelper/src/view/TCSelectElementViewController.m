//
//  TCSelectElementViewController.m
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "TCSelectElementViewController.h"
#import "TCCalc.h"
#import "TCElementCell.h"

@interface TCSelectElementViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong) NSArray *allElements;

@end

@implementation TCSelectElementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择元素";
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneTapped)];
    self.navigationItem.rightBarButtonItem = barItem;
    
    UIBarButtonItem *cbarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelTapped)];
    self.navigationItem.leftBarButtonItem = cbarItem;
    
    
    self.allElements = [TCCalc getAllElements];
    self.allElements = [self.allElements sortedArrayUsingComparator:^NSComparisonResult(TCElement* obj1, TCElement* obj2) {
        return ( obj1.weight-obj2.weight);
    }];
    
    NSLog(@"all:%@",self.allElements);
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TCElementCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    
}



-(void)doneTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)cancelTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allElements.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TCElementCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    TCElement *element = self.allElements[indexPath.row];
    cell.titleLabel.text = element.alias;
    cell.imageView.image = [UIImage imageNamed:element.name];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        [self.delegate didSelectElement:self.allElements[indexPath.row]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

@end
