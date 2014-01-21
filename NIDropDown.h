//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnimatedDuration     0.3f

@class NIDropDown;

@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod:(NIDropDown *)sender;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
  NSString *animationDirection;
  UIImageView *imgView;
}

@property (nonatomic, assign) id <NIDropDownDelegate> delegate;
@property (nonatomic, strong) NSString *animationDirection;


- (void)hideDropDown:(UIButton *)b;

- (id)showDropDown:(UIButton *)btn
            height:(CGFloat *)height
        datasource:(NSArray *)arr
            images:(NSArray *)imgArr
         direction:(NSString *)direction;
@end
