#import "Cedar.h"
#import "Employee.h"
#import "EmployeeDeserializer.h"
#import "Blindside.h"
#import "InjectorProvider.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(EmployeeDeserializerSpec)

describe(@"EmployeeDeserializer", ^{
    __block EmployeeDeserializer *subject;
    __block id<BSBinder, BSInjector> injector;

    beforeEach(^{

        injector = (id) [InjectorProvider injector];
        subject = [injector getInstance:[EmployeeDeserializer class]];
    });

    describe(@"Deserialize", ^{
        __block NSArray *employees;
        beforeEach(^{
            NSString *fixturePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"employees" ofType:@"json"];
            NSData *fixtureData = [NSData dataWithContentsOfFile:fixturePath];
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:fixtureData options:0 error:nil];
            employees = [subject deserialize:jsonDictionary];
        });

        it(@"should deserialize", ^{
            employees.count should equal(4);

            Employee *employee1 = employees[0];
            employee1.uri should equal(@"com.roop.com::useruri:user:1");
            employee1.name should equal(@"Roopesh M");

            Employee *employee2 = employees[1];
            employee2.uri should equal(@"com.roop.com::useruri:user:2");
            employee2.name should equal(@"Nishant S");

            Employee *employee3 = employees[2];
            employee3.uri should equal(@"com.roop.com::useruri:user:3");
            employee3.name should equal(@"Harsha L");

            Employee *employee4 = employees[3];
            employee4.uri should equal(@"com.roop.com::useruri:user:4");
            employee4.name should equal(@"Kishore G");

        });
    });
});

SPEC_END
