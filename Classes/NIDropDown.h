//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnimatedDuration     0.3f
#define kDropDownCellHeight   30.0f

typedef enum _NIDirection {
  NID_UP,
  NID_DOWN,
} NIDirection;

@class NIDropDown;

@protocol NIDropDownDelegate <NSObject>
@optional
/**
 @brief DropDownCell被点击，通知出来
 */
- (void)niDropDownDidChanged:(NIDropDown *)niDropDown indexPath:(NSIndexPath *)index;
@end

// TODO: secion如果使用的话，添加UITableView相关的处理
@protocol NIDropDownDataSource <NSObject>
@optional
/**
 @brief DropDown列表添加到其它视图上，而且不是btn的super
 @warning 需与`customSuperViewCenterInNIDropDown:`配合使用
 */
- (UIView *)customSuperViewInNIDropDown:(NIDropDown *)niDropDown;
- (CGPoint)customSuperViewCenterInNIDropDown:(NIDropDown *)niDropDown;
/**
 @brief   返回Section数量，默认为1
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @return  Section数量
 */
- (NSInteger)numberOfSectionsInNIDropDown:(NIDropDown *)niDropDown;
/**
 @brief   每个条目的高度，默认为kDropDownCellHeight
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @param   indexPath:  定位Cell
 @return  高度
 */
- (CGFloat)niDropDown:(NIDropDown *)niDropDown heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 @brief   自定义显示Cell，需要传入Custom的视图
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @param   indexPath:  定位Cell
 @return  自定义的视图
 */
- (UIView *)niDropDown:(NIDropDown *)niDropDown customCellViewAtIndexPath:(NSIndexPath *)indexPath;
/**
 @brief   显示Cell标题
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @param   indexPath:  定位Cell
 @return  标题
 */
- (NSString *)niDropDown:(NIDropDown *)niDropDown titleForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 @brief   每个Section的高度，默认为 0
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @param   indexPath:  定位Section
 @return  高度
 */
- (CGFloat)niDropDown:(NIDropDown *)niDropDown heightForHeaderInSection:(NSInteger)section;
/**
 @brief   自定义显示Section Header，需要传入Custom的视图
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @param   indexPath:  定位Section
 @return  自定义的视图
 */
- (UIView *)niDropDown:(NIDropDown *)niDropDown customViewForHeaderInSection:(NSInteger)section;

@required
/**
 @brief   返回某个Section里的条目数量
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @param   section:  定位Section
 @return  条目数量
 */
- (NSInteger)niDropDown:(NIDropDown *)niDropDown numberOfRowsInSection:(NSInteger)section;
/**
 @brief   TableView的高度，默认为kDropDownCellHeight
 @param   niDropDown: NIDropDown，用于区分不同的NI
 @return  高度
 */
- (CGFloat)heightForTableViewInNIDropDown:(NIDropDown *)niDropDown;
@end

@interface NIDropDown : UIView
@property (nonatomic, assign) id<NIDropDownDelegate> delegate;
@property (nonatomic, assign) id<NIDropDownDataSource> dataSource;

@property (nonatomic, strong) NSIndexPath *indexPath;


- (void)hideDropDown:(UIButton *)btn;

- (void)showDropDown:(UIButton *)btn
          dataSource:(id<NIDropDownDataSource>)dataSource
           direction:(NIDirection)direction;
@end
