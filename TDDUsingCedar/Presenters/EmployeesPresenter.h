#import <UIKit/UIKit.h>
#import "CellPresenterDataSource.h"


@class Employee;


@protocol EmployeesPresenterDelegate

- (void)EmployeesPresenterDidSelectEmployee:(Employee *)employee;

@end


@interface EmployeesPresenter : NSObject <CellPresenterDataSourceDelegate>

@property (nonatomic, weak) id<EmployeesPresenterDelegate> delegate;

- (void)presentEmployees:(NSArray *)employees inTableView:(UITableView *)tableView;

@end
