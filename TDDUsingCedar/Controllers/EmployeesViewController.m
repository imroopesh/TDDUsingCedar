#import "EmployeesViewController.h"
#import "Blindside.h"
#import "EmployeesService.h"
#import "KSPromise.h"
#import "EmployeeViewController.h"


@interface EmployeesViewController ()

@property (nonatomic) EmployeesPresenter *employeesPresenter;
@property (nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) EmployeesService *apiClient;
@property (nonatomic, weak) id<BSInjector> injector;

@end


@implementation EmployeesViewController

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithEmployeesPresenter:
                                                         apiClient:)
                                  argumentKeys:
            [EmployeesPresenter class],
            [EmployeesService class],
            nil];
}

- (instancetype)initWithEmployeesPresenter:(EmployeesPresenter *)employeesPresenter
                               apiClient:(EmployeesService *)apiClient {
    self = [super init];
    if (self) {
        self.employeesPresenter = employeesPresenter;
        self.employeesPresenter.delegate = self;
        self.apiClient = apiClient;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Employees";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.tableView.frame = self.view.bounds;

    KSPromise *promise = [self.apiClient fetchAllEmployees];

    __weak typeof(self) weakSelf = self;
    [promise then:^id(NSArray *employees)
    {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        [strongSelf.employeesPresenter presentEmployees:employees inTableView:strongSelf.tableView];

        return nil;
    } error:nil];
}

#pragma mark - <EmployeesPresenterDelegate>

- (void)EmployeesPresenterDidSelectEmployee:(Employee *)employee {
    EmployeeViewController *employeeViewController = [self.injector getInstance:[EmployeeViewController class]];
    [employeeViewController setupWithEmployee:employee];

    [self.navigationController pushViewController:employeeViewController animated:YES];
}

@end
