//
//  ACViewController.m
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import "ACViewController.h"
#import "KSAutoCompleteTextfield.h"
#import "KSAutoCompleteTextfieldDelegate.h"
@interface ACViewController ()
{
    KSAutoCompleteTextfield *_textfield;
    KSAutoCompleteTextfieldDelegate *_delegate;
}
@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     _textfield = [[KSAutoCompleteTextfield alloc]initWithFrame:CGRectMake(0, 40, 200, 30) withFont:[UIFont systemFontOfSize:20] withCompleteColor:[UIColor redColor]];
    _delegate = [[KSAutoCompleteTextfieldDelegate alloc]init];
    _delegate.autoCompleteTextfield = _textfield;
    _textfield.delegate  =  _delegate;
    [[NSNotificationCenter defaultCenter] addObserver:_delegate
                                             selector:@selector(textChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:_textfield];
    [self.view addSubview:_textfield];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
