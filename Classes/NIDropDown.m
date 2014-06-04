//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import <SQCommonHeader.h>

@interface NIDropDown () <
UITableViewDelegate,
UITableViewDataSource
>
{
}


@property (nonatomic, assign) NIDirection direction;

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;

@end

@implementation NIDropDown

-(void)dealloc
{
}

- (id)init
{
  if (self = [super init]) {
    
  }
  return self;
}

- (void)showDropDown:(UIButton *)btn
        dataSource:(id<NIDropDownDataSource>)dataSource
         direction:(NIDirection)direction
{
  _btnSender = btn;
  _direction = direction;
  _dataSource = dataSource;
  
  CGFloat height = kDropDownCellHeight; // table’s height, use cell height first.
  if ([_dataSource respondsToSelector:@selector(heightForTableViewInNIDropDown:)]) {
    height = [_dataSource heightForTableViewInNIDropDown:self];
  }
  
  CGRect btnFrame = btn.frame;
  if (direction == NID_UP) {
    self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y, btnFrame.size.width, 0);
    self.layer.shadowOffset = CGSizeMake(-5, -5);
  } else if (direction == NID_DOWN) {
    self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height, btnFrame.size.width, 0);
    self.layer.shadowOffset = CGSizeMake(-5, 5);
  }
  
  self.layer.masksToBounds = NO;
  self.layer.cornerRadius = 8;
  self.layer.shadowRadius = 5;
  self.layer.shadowOpacity = 0.5;
  
  _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btnFrame.size.width, 0)];
  _table.delegate = self;
  _table.dataSource = self;
  _table.layer.cornerRadius = 5;
  _table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
  _table.separatorStyle = UITableViewCellSeparatorStyleNone;
//  _table.separatorColor = [UIColor darkGrayColor];
  
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kAnimatedDuration];
  if (direction == NID_UP) {
    self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y-height, btnFrame.size.width, height);
  } else if (direction == NID_DOWN) {
    self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height, btnFrame.size.width, height);
    if (self.originY+self.height > kScreenSize.height)
      self.height = kScreenSize.height - self.originY;
  }
  _table.frame = CGRectMake(0, 0, btnFrame.size.width, height);
  [UIView commitAnimations];
  
  [self addSubview:_table];
  
  if ([_dataSource respondsToSelector:@selector(customSuperViewInNIDropDown:)]) {
    if (![_dataSource respondsToSelector:@selector(customSuperViewCenterInNIDropDown:)]) {
      [NSException raise:@"NIDropDown DataSource Error" format:@"customSuperViewInNIDropDown需与`customSuperViewCenterInNIDropDown:`配合使用"];
    }
    
    UIView *superView = [_dataSource customSuperViewInNIDropDown:self];
    CGPoint center = [_dataSource customSuperViewCenterInNIDropDown:self];
    [superView addSubview:self];
    self.center = center;
  } else {
    [btn.superview addSubview:self];
  }
}

- (void)hideDropDown:(UIButton *)btn
{
  CGRect btnFrame = btn.frame;
  
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:kAnimatedDuration];
  if (_direction == NID_UP) {
    self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y, btnFrame.size.width, 0);
  } else if (_direction == NID_DOWN) {
    self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height, btnFrame.size.width, 0);
  }
  _table.frame = CGRectMake(0, 0, btnFrame.size.width, 0);
  [UIView commitAnimations];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if ([_dataSource respondsToSelector:@selector(numberOfSectionsInNIDropDown:)])
    return [_dataSource numberOfSectionsInNIDropDown:self];
  else
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([_dataSource respondsToSelector:@selector(niDropDown:heightForRowAtIndexPath:)])
    return [_dataSource niDropDown:self heightForRowAtIndexPath:indexPath];
  else
    return kDropDownCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ([_dataSource respondsToSelector:@selector(niDropDown:numberOfRowsInSection:)])
    return [_dataSource niDropDown:self numberOfRowsInSection:section];
  else
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"NI_Cell_Identifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  if ([_dataSource respondsToSelector:@selector(niDropDown:customCellViewAtIndexPath:)]) {
    UIView *customView = [_dataSource niDropDown:self customCellViewAtIndexPath:indexPath];
    customView.frame = cell.contentView.bounds;
    [cell.contentView addSubview:customView];
  } else {
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = RGB(0x666666);
    cell.backgroundView = v;
    UIView *sv = [[UIView alloc] init];
    sv.backgroundColor = RGB(0xff9f00);
    cell.selectedBackgroundView = sv;
    
    if ([_dataSource respondsToSelector:@selector(niDropDown:titleForRowAtIndexPath:)])
      cell.textLabel.text = [_dataSource niDropDown:self titleForRowAtIndexPath:indexPath];
  }
  
//  if (indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-1) {
//    for (UIView *subview in cell.subviews) {
//      if ([subview isKindOfClass:[UIImageView class]]) {
//        [subview removeFromSuperview];
//      }
//    }
//  }
  
  if ([indexPath compare:_indexPath] == NSOrderedSame) {
    [tableView selectRowAtIndexPath:indexPath
                           animated:YES
                     scrollPosition:UITableViewScrollPositionNone];
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if ([_dataSource respondsToSelector:@selector(niDropDown:heightForHeaderInSection:)])
    return [_dataSource niDropDown:self heightForHeaderInSection:section];
  else
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if ([_dataSource respondsToSelector:@selector(niDropDown:customViewForHeaderInSection:)]) {
    return [_dataSource niDropDown:self customViewForHeaderInSection:section];
  }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([_delegate respondsToSelector:@selector(niDropDownDidChanged:indexPath:)])
    [_delegate niDropDownDidChanged:self indexPath:indexPath];
  
  [self hideDropDown:_btnSender];
  
  UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
  [_btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
  
//  for (UIView *subview in _btnSender.subviews) {
//    if ([subview isKindOfClass:[UIImageView class]]) {
//      [subview removeFromSuperview];
//    }
//  }
}

@end
