//
//  NIViewController.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIViewController.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIViewController () <
NIDropDownDataSource,
NIDropDownDelegate
>

@property (nonatomic, strong) NIDropDown *dropDown;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation NIViewController

@synthesize btnSelect;

- (void)dealloc
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  btnSelect.layer.borderWidth = 1;
  btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
  btnSelect.layer.cornerRadius = 5;
  
  /*
   Tmp data source
   */
  self.dataSource = [NSMutableArray arrayWithObjects:@"ASDF", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9", nil];
}

- (void)viewDidUnload
{
  btnSelect = nil;
  [self setBtnSelect:nil];
  
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectClicked:(id)sender
{
  if(_dropDown == nil) {
    [self showNIDropDown:btnSelect];
  } else {
    [self hideNIDropDown:btnSelect];
  }
}

#pragma mark - NIDropDown

- (void)showNIDropDown:(UIButton *)btn
{
//  _dropDownContainnerView = [[UIView alloc] init];
//  _dropDownContainnerView.size = kScreenSize;
//  [[UIApplication sharedApplication].keyWindow addSubview:_dropDownContainnerView];
//  _dropDownContainnerView.backgroundColor = [UIColor clearColor];
//  
//  UIView *gestureView = [[UIView alloc] initWithFrame:_dropDownContainnerView.bounds];
//  gestureView.backgroundColor = [UIColor clearColor];
//  [_dropDownContainnerView addSubview:gestureView];
//  
//  UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapedDropDownContainnerView)];
//  [gestureView addGestureRecognizer:tgr];
  
  _dropDown = [[NIDropDown alloc] init];
  [_dropDown showDropDown:btn dataSource:self direction:NID_DOWN];
  
  _dropDown.indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
  _dropDown.delegate = self;
}

- (void)hideNIDropDown:(UIButton *)btn
{
//  [_dropDownContainnerView removeFromSuperview];
//  _dropDownContainnerView = nil;
  
  [_dropDown hideDropDown:btn];
  self.dropDown = nil;
}

- (void)didTapedDropDownContainnerView
{
  [self hideNIDropDown:btnSelect];
}

#pragma mark - NIDropDown delegate

- (void)niDropDownDidChanged:(NIDropDown *)sender indexPath:(NSIndexPath *)index;
{
//  DDLogInfo(@"niDropDownDelegateMethod:%@ indexPath:%@", sender, index);
  
//  [_dropDownContainnerView removeFromSuperview];
//  _dropDownContainnerView = nil;
  self.dropDown = nil;
  
//  NSArray *deviceIds = [[NADeviceList gDeviceList] getDeviceIdList];
//  if ([deviceIds count] > index.row) {
//    NSString *currentDeviceId = [deviceIds objectAtIndex:index.row];
//    [[NADeviceList gDeviceList] setCurrentDeviceId:currentDeviceId];
//    
//    [self updateDataSource];
//  }
}

#pragma mark - NIDropDown DataSource

- (CGFloat)heightForTableViewInNIDropDown:(NIDropDown *)niDropDown
{
  return kDropDownCellHeight * [_dataSource count];
}

- (NSInteger)niDropDown:(NIDropDown *)niDropDown numberOfRowsInSection:(NSInteger)section
{
  return [_dataSource count];
}

- (NSString *)niDropDown:(NIDropDown *)niDropDown titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [_dataSource objectAtIndex:indexPath.row];
}

//- (UIView *)customSuperViewInNIDropDown:(NIDropDown *)niDropDown
//{
//  return _dropDownContainnerView;
//}

//- (CGPoint)customSuperViewCenterInNIDropDown:(NIDropDown *)niDropDown
//{
//  return CGPointMake(160.0f, 90.0f);
//}

@end
