#import "EmployeeViewController.h"
#import "Employee.h"


@interface EmployeeViewController ()

@property(nonatomic, strong) Employee *employee;

@end


@implementation EmployeeViewController

- (void)setupWithEmployee:(Employee *)employee {
    self.employee = employee;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.employee.name;

    self.view.backgroundColor = [UIColor whiteColor];
}

@end
