#import "Cedar.h"
#import "EmployeeViewController.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "Employee.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(EmployeeViewControllerSpec)

describe(@"EmployeeViewController", ^{
    __block EmployeeViewController *subject;
    __block id<BSBinder, BSInjector> injector;
    __block Employee *employee;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        employee = fake_for([Employee class]);
        employee stub_method(@selector(name)).and_return(@"My Special Employee");

        subject = [injector getInstance:[EmployeeViewController class]];
        [subject setupWithEmployee:employee];
        subject.view should_not be_nil;
    });

    it(@"should display the employee's name", ^{
        subject.title should equal(@"My Special Employee");
    });
});

SPEC_END
