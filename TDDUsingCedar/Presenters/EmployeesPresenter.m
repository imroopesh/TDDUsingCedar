#import "EmployeesPresenter.h"
#import "Blindside.h"
#import "Employee.h"
#import "EmployeeCellPresenter.h"


@interface EmployeesPresenter ()

@property (nonatomic) CellPresenterDataSource *cellPresenterDataSource;
@property (nonatomic, weak) id<BSInjector> injector;

@end


@implementation EmployeesPresenter

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithCellPresenterDataSource:)
                                  argumentKeys:[CellPresenterDataSource class], nil];
}

- (instancetype)initWithCellPresenterDataSource:(CellPresenterDataSource *)cellPresenterDataSource {
    self = [super init];
    if (self) {
        self.cellPresenterDataSource = cellPresenterDataSource;
        self.cellPresenterDataSource.delegate = self;
    }
    return self;
}

- (void)presentEmployees:(NSArray *)employees inTableView:(UITableView *)tableView {
    [EmployeeCellPresenter registerInTableView:tableView];

    NSMutableArray *cellPresenters = [NSMutableArray arrayWithCapacity:employees.count];
    
    for (Employee *employee in employees) {
        EmployeeCellPresenter *cellPresenter = [self.injector getInstance:[EmployeeCellPresenter class]];
        cellPresenter.employee = employee;
        [cellPresenters addObject:cellPresenter];
    }
    
    [self.cellPresenterDataSource displayCellPresenters:cellPresenters inTableView:tableView];
}

#pragma mark - <CellPresenterDataSourceDelegate>

- (void)cellPresenterDataSourceDidSelectCellPresenter:(EmployeeCellPresenter *)employeeCellPresenter {
    [self.delegate EmployeesPresenterDidSelectEmployee:employeeCellPresenter.employee];
}

@end
