#import "Cedar.h"
#import "EmployeesViewController.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "EmployeesService.h"
#import "KSDeferred.h"
#import "Employee.h"
#import "EmployeeViewController.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(EmployeesViewControllerSpec)

describe(@"EmployeesViewController", ^{
    __block EmployeesViewController *subject;
    __block id<BSBinder, BSInjector> injector;
    __block EmployeesPresenter *employeesPresenter;
    __block EmployeesService *apiClient;

    void (^makeViewAppear)() = ^{
        [subject viewWillAppear:NO];
        [subject viewDidAppear:NO];
    };

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        employeesPresenter = nice_fake_for([EmployeesPresenter class]);
        [injector bind:[EmployeesPresenter class] toInstance:employeesPresenter];

        apiClient = nice_fake_for([EmployeesService class]);
        [injector bind:[EmployeesService class] toInstance:apiClient];

        subject = [injector getInstance:[EmployeesViewController class]];
        subject.view should_not be_nil;
    });

    describe(@"displaying employees", ^{
        __block KSDeferred *deferred;

        beforeEach(^{
            deferred = [KSDeferred defer];

            apiClient stub_method(@selector(fetchAllEmployees)).and_return(deferred.promise);

            makeViewAppear();
        });

        it(@"should display the employees in the table view when they are fetched successfully", ^{
            NSArray *employees = fake_for([NSArray class]);

            [deferred resolveWithValue:employees];

            employeesPresenter should have_received(@selector(presentEmployees:inTableView:)).with(employees, subject.tableView);
        });
    });

    describe(@"as an employees presenter delegate", ^{
        __block UINavigationController *navigationController;
        __block EmployeeViewController *employeeViewController;

        beforeEach(^{
            employeeViewController = [injector getInstance:[EmployeeViewController class]];
            spy_on(employeeViewController);
            [injector bind:[EmployeeViewController class] toInstance:employeeViewController];

            navigationController = [[UINavigationController alloc] initWithRootViewController:subject];
        });
        
        it(@"should set itself as the employees presenter's delegate", ^{
            employeesPresenter should have_received(@selector(setDelegate:)).with(subject);
        });

        it(@"should display an employee's details when the user selects an employee", ^{
            Employee *employee = nice_fake_for([Employee class]);

            [subject EmployeesPresenterDidSelectEmployee:employee];

            navigationController.topViewController should be_same_instance_as(employeeViewController);
            employeeViewController should have_received(@selector(setupWithEmployee:)).with(employee);
        });
    });
});

SPEC_END
