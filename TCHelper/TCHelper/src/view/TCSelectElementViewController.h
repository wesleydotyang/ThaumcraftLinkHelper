//
//  TCSelectElementViewController.h
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCElement.h"



@interface TCSelectElementViewController : UIViewController

@property (weak) id delegate;
@end


@protocol  TCSelectElementViewControllerDelegate<NSObject>

-(void)didSelectElement:(TCElement*)element;

@end