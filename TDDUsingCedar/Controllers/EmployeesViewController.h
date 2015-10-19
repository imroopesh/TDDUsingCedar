#import <UIKit/UIKit.h>
#import "EmployeesPresenter.h"


@interface EmployeesViewController : UIViewController <EmployeesPresenterDelegate>

@property (nonatomic, readonly) UITableView *tableView;

@end
