//
//  TCViewController.h
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startElementButton;
@property (weak, nonatomic) IBOutlet UIButton *endElementButton;
@property (weak, nonatomic) IBOutlet UILabel *labelSteps;
- (IBAction)decreaseStep:(id)sender;
- (IBAction)increaseStep:(id)sender;
- (IBAction)startElementTapped:(id)sender;
- (IBAction)endElementTapped:(id)sender;
- (IBAction)calcTapped:(id)sender;


@end
