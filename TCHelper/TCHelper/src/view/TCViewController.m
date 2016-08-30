//
//  TCViewController.m
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "TCViewController.h"
#import "TCCalc.h"
#import "TCSelectElementViewController.h"
#import "TCResultViewController.h"

@interface TCViewController ()<TCSelectElementViewControllerDelegate>
@property (nonatomic,strong) TCCalc *calc;

@property (assign) BOOL isTappingFirst;

@property (strong,nonatomic) TCElement *startElement;
@property (strong,nonatomic) TCElement *endElement;
@property (assign,nonatomic) int steps;

@end

@implementation TCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"计算器";
    
    self.steps = 3;
    self.startElement = [TCCalc elementNamed:@"aqua"];
    self.endElement = [TCCalc elementNamed:@"ignis"];
    
}


-(void)setStartElement:(TCElement *)startElement
{
    _startElement = startElement;
    
    [self.startElementButton setBackgroundImage:[UIImage imageNamed:startElement.name] forState:UIControlStateNormal];

}

-(void)setEndElement:(TCElement *)endElement
{
    _endElement = endElement;
    
    [self.endElementButton setBackgroundImage:[UIImage imageNamed:endElement.name] forState:UIControlStateNormal];

}

-(void)setSteps:(int)steps
{
    _steps = steps;
    
    self.labelSteps.text = [NSString stringWithFormat:@"%d 步",steps];
}

- (IBAction)decreaseStep:(id)sender {
    if (self.steps<=1) {
        return;
    }
    self.steps--;
}

- (IBAction)increaseStep:(id)sender {
    self.steps++;
}

- (IBAction)startElementTapped:(id)sender {
    TCSelectElementViewController *vc = [TCSelectElementViewController new];
    vc.delegate = self;
    self.isTappingFirst = YES;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

- (IBAction)endElementTapped:(id)sender {
    TCSelectElementViewController *vc = [TCSelectElementViewController new];
    vc.delegate = self;
    self.isTappingFirst = NO;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

- (IBAction)calcTapped:(id)sender {
    self.calc = [TCCalc new];
    self.calc.startElement = self.startElement;
    self.calc.endElement = self.endElement;
    self.calc.steps = self.steps;
    [self.calc startCalc];
    NSLog(@"result:%@",self.calc.allResultSet);
    
    
    TCResultViewController *vc = [TCResultViewController new];
    vc.paramResultSet = self.calc.allResultSet;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

-(void)didSelectElement:(TCElement *)element
{
    if (self.isTappingFirst) {
        self.startElement = element;
    }else{
        self.endElement = element;
    }
}

@end
