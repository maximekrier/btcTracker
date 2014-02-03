//
//  ViewController.m
//  BtcTracker
//
//  Created by noext on 02/01/14.
//  Copyright (c) 2014 noext. All rights reserved.
//

#import "ViewController.h"



@interface ViewController () <UIPickerViewDelegate>

@end

@implementation ViewController

    @synthesize BtcValueAvg,BtcValueLow,BtcValueHigh,aTimer,typeValue,settings,pickerValue,btnSettings,qrCode;
NSArray *arrStatus;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
	// Do any additional setup after loading the view, typically from a nib.
    pickerValue.delegate = self;
    typeValue = [NSNumber numberWithInt:0];
    settings = [NSNumber numberWithInt:0];
    aTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(runScheduledTask) userInfo:nil repeats:YES];
    arrStatus = [[NSArray alloc] initWithObjects:@"btc_usd", @"ltc_usd", @"nmc_usd", @"nvc_usd", @"ppc_usd", nil];
    [aTimer fire];
    [qrCode setAlpha:0.0];
    [pickerValue setAlpha:0.0];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    typeValue = [NSNumber numberWithInt:row];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return arrStatus.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [arrStatus objectAtIndex:row];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
/* runScheduledTask */
- (void)runScheduledTask {
    
    NSURL * url=[NSURL URLWithString:@"https://btc-e.com/api/3/ticker/btc_usd-ltc_usd-nmc_usd-nvc_usd-ppc_usd"];
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    
    NSMutableDictionary  *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    //NSLog(@"%@",typeValue);
    
    NSMutableDictionary *btc = [json valueForKey:@"btc_usd"];
    NSMutableDictionary *ltc = [json valueForKey:@"ltc_usd"];
    NSMutableDictionary *nmc = [json valueForKey:@"nmc_usd"];
    NSMutableDictionary *nvc = [json valueForKey:@"nvc_usd"];
    NSMutableDictionary *ppc = [json valueForKey:@"ppc_usd"];
    
    
    NSMutableDictionary *useValue;
    NSInteger value = [typeValue integerValue];
    switch (value ) {
        case 0:
            NSLog(@"%@",btc);
            useValue = btc;
            break;
        case 1:
            NSLog(@"%@",ltc);
            useValue = ltc;
            break;
        case 2:
            NSLog(@"%@",nmc);
            useValue = nmc;
            break;
        case 3:
            NSLog(@"%@",nvc);
            useValue = nvc;
            break;
        case 4:
            NSLog(@"%@",ppc);
            useValue = ppc;
            break;
            
        default:
            NSLog(@"default");
            break;
    }
    
    NSNumber *avgString = [useValue valueForKey:@"last"];
    NSNumber *highString = [useValue valueForKey:@"buy"];
    NSNumber *lowString = [useValue valueForKey:@"sell"];
   
    BtcValueAvg.text = [NSString stringWithFormat: @"$%d", avgString.intValue];
    BtcValueLow.text = [NSString stringWithFormat: @"$%d", lowString.intValue];
    BtcValueHigh.text = [NSString stringWithFormat: @"$%d", highString.intValue];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)displaySettings:(id)sender {
    NSLog(@"%@",settings);
    if(settings == [NSNumber numberWithInt: 0]){
        settings = [NSNumber numberWithInt: 1];
        [UIView animateWithDuration:1 animations:^(void) {
            pickerValue.alpha = 1;
            qrCode.alpha = 1;
        }];
        [btnSettings setTitle:@"Validate" forState:UIControlStateNormal];
        
        
    }else{
        settings = [NSNumber numberWithInt: 0];
        [UIView animateWithDuration:1 animations:^(void) {
            pickerValue.alpha = 0;
            qrCode.alpha = 0 ;
        }];
        [btnSettings setTitle:@"Settings" forState:UIControlStateNormal];
        [aTimer fire];

    }
    
}
@end





