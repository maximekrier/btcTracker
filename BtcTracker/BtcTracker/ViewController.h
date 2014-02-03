//
//  ViewController.h
//  BtcTracker
//
//  Created by noext on 02/01/14.
//  Copyright (c) 2014 noext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSTimer *aTimer;
    NSInteger *type;
}

@property (weak, nonatomic) IBOutlet UILabel *BtcValueAvg;
@property (weak, nonatomic) IBOutlet UILabel *BtcValueLow;
@property (weak, nonatomic) IBOutlet UILabel *BtcValueHigh;
@property (nonatomic, retain) NSTimer *aTimer;
@property (nonatomic) NSNumber *typeValue;
@property (nonatomic) NSNumber *settings;

- (IBAction)displaySettings:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;

@property (weak, nonatomic) IBOutlet UIImageView *qrCode;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerValue;
@end
