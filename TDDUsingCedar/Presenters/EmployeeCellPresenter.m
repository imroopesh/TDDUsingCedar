#import "EmployeeCellPresenter.h"
#import "Employee.h"


@implementation EmployeeCellPresenter

+ (void)registerInTableView:(UITableView *)tableView {
    return [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmployeeCell"];
}

- (void)presentInCell:(UITableViewCell *)cell {
    cell.textLabel.text = self.employee.name;
}

- (NSString *)cellIdentifier {
    return @"EmployeeCell";
}

@end
