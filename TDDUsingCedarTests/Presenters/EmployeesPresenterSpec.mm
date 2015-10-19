#import "Cedar.h"
#import "EmployeesPresenter.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "FakeCellPresenterDataSource.h"
#import "Employee.h"
#import "EmployeeCellPresenter.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(EmployeesPresenterSpec)

describe(@"EmployeesPresenter", ^{
    __block EmployeesPresenter *subject;
    __block id<BSBinder, BSInjector> injector;
    __block FakeCellPresenterDataSource *cellPresenterDataSource;
    __block UITableView *tableView;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        cellPresenterDataSource = [[FakeCellPresenterDataSource alloc] init];
        [injector bind:[CellPresenterDataSource class] toInstance:cellPresenterDataSource];
        
        tableView = [[UITableView alloc] init];

        subject = [injector getInstance:[EmployeesPresenter class]];
        subject.delegate = nice_fake_for(@protocol(EmployeesPresenterDelegate));
    });
    
    it(@"should generate employee cell presenters and hand them over to the cell presenter data source", ^{
        NSArray *employees = @[
            fake_for([Employee class]),
            fake_for([Employee class]),
            fake_for([Employee class])
        ];

        [subject presentEmployees:employees inTableView:tableView];
        
        cellPresenterDataSource.tableView should be_same_instance_as(tableView);

        cellPresenterDataSource.cellPresenters.count should equal(3);

        for (int i = 0; i < 3; i++) {
            EmployeeCellPresenter *cellPresenter = cellPresenterDataSource.cellPresenters[i];
            cellPresenter should be_instance_of([EmployeeCellPresenter class]);
            cellPresenter.employee should be_same_instance_as(employees[i]);
        }
    });

    it(@"should register the cell types on the table view", ^{
        NSArray *employees = @[fake_for([Employee class])];
        
        [subject presentEmployees:employees inTableView:tableView];
        
        EmployeeCellPresenter *cellPresenter = cellPresenterDataSource.cellPresenters.firstObject;
        
        [tableView dequeueReusableCellWithIdentifier:cellPresenter.cellIdentifier] should_not be_nil;
    });

    describe(@"as a cell presenter data source's delegate", ^{
        it(@"should set itself as the cell presenter data source's delegate", ^{
            cellPresenterDataSource.delegate should be_same_instance_as(subject);
        });

        it(@"should inform its delegate when the user taps on a cell", ^{
            NSArray *employees = @[
                fake_for([Employee class]),
                fake_for([Employee class]),
                fake_for([Employee class])
            ];

            [subject presentEmployees:employees inTableView:tableView];

            EmployeeCellPresenter *cellPresenter = cellPresenterDataSource.cellPresenters[1];
            [subject cellPresenterDataSourceDidSelectCellPresenter:cellPresenter];

            subject.delegate should have_received(@selector(EmployeesPresenterDidSelectEmployee:)).with(employees[1]);
        });
    });
});

SPEC_END
