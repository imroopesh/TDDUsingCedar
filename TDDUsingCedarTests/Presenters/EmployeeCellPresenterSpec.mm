#import "Cedar.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "EmployeeCellPresenter.h"
#import "Employee.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(EmployeeCellPresenterSpec)

describe(@"EmployeeCellPresenter", ^{
    __block EmployeeCellPresenter *subject;
    __block id<BSBinder, BSInjector> injector;
    __block UITableViewCell *cell;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        subject = [injector getInstance:[EmployeeCellPresenter class]];
        
        subject.employee = [[Employee alloc] initWithUserUri:@"1" name:@"Pink Floyd"];
        
        cell = [[UITableViewCell alloc] init];
        [subject presentInCell:cell];
    });
    
    it(@"should display the employee name", ^{
        cell.textLabel.text should equal(@"Pink Floyd");
    });
});

SPEC_END
