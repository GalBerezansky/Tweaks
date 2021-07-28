/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.

 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import "_FBEditableTweakDateViewController.h"

@interface _FBEditableTweakDateViewController ()

///Date picker that reflects the value of the tweak.
@property(readonly, nonatomic) UIDatePicker *datePicker;

@end

@implementation _FBEditableTweakDateViewController {}

- (instancetype)initWithEditableTweak:(id<FBEditableTweak>)tweak {
  if ((self = [super initWithNibName:nil bundle:nil])) {
    _tweak = tweak;
    self.title = _tweak.name;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self setupDatePicker];
  [self.datePicker addTarget:self action:@selector (pressDateButton)
            forControlEvents:UIControlEventValueChanged];
}

- (void)setupDatePicker {
  auto datePickerRect = CGRectMake
      (self.view.bounds.origin.x,
      self.view.bounds.origin.y,
      self.view.bounds.size.width,
      self.view.bounds.size.height * 2.0/3.0 );
  _datePicker = [[UIDatePicker alloc] initWithFrame:datePickerRect];
  self.datePicker.date = self.tweak.currentValue ?: self.tweak.defaultValue;
  [self.view addSubview:self.datePicker];

  if (@available(iOS 14.0, *)) {
    // In iOS 14 and above, the default \c UIDatePickerStyle changed from \c UIDatePickerStyleWheels
    // to \c UIDatePickerStyleAutomatic.
    self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    [self.datePicker setValue:UIColor.blackColor forKey:@"textColor"];
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addDatePickerConstraints];
  }
}

- (void)addDatePickerConstraints {
  auto topConstraint =
      [NSLayoutConstraint constraintWithItem:self.datePicker
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1.0
                                    constant:40];

  auto centerXAxisConstraint =
      [NSLayoutConstraint constraintWithItem:self.datePicker
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1.0
                                    constant:0];

  [self.view addConstraint:topConstraint];
  [self.view addConstraint:centerXAxisConstraint];
}

- (void)pressDateButton {
  self.tweak.currentValue = self.datePicker.date;
}

@end
