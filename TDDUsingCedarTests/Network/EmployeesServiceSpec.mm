#import "Cedar.h"
#import "EmployeesService.h"
#import "InjectorProvider.h"
#import "Blindside.h"
#import "RequestProvider.h"
#import "JSONClient.h"
#import "KSDeferred.h"
#import "Employee.h"
#import "EmployeeDeserializer.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(EmployeesServiceSpec)

describe(@"EmployeesService", ^{
    __block EmployeesService *subject;
    __block id<BSBinder, BSInjector> injector;
    __block RequestProvider *requestProvider;
    __block JSONClient *jsonClient;
    __block EmployeeDeserializer *deserializer;
    
    beforeEach(^{
        injector = (id)[InjectorProvider injector];

        requestProvider = fake_for([RequestProvider class]);
        [injector bind:[RequestProvider class] toInstance:requestProvider];

        jsonClient = fake_for([JSONClient class]);
        [injector bind:[JSONClient class] toInstance:jsonClient];

        deserializer = [injector getInstance:[EmployeeDeserializer class]];
        subject = [injector getInstance:[EmployeesService class]];
    });

    describe(@"getting all employees", ^{
        __block KSDeferred *jsonDeferred;
        __block NSURLRequest *request;
        __block KSPromise *promise;

        beforeEach(^{
            request = fake_for([NSURLRequest class]);
            requestProvider stub_method(@selector(requestToGetEmployees)).and_return(request);

            jsonDeferred = [KSDeferred defer];
            jsonClient stub_method(@selector(sendRequest:)).and_return(jsonDeferred.promise);

            promise = [subject fetchAllEmployees];
        });

        it(@"makes a request", ^{
            jsonClient should have_received(@selector(sendRequest:)).with(request);
        });

        it(@"resolves the promise with an array of employees when the request succeeds", ^{
            NSString *fixturePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"employees" ofType:@"json"];
            NSData *fixtureData = [NSData dataWithContentsOfFile:fixturePath];
            NSDictionary *jsonEmployees = [NSJSONSerialization JSONObjectWithData:fixtureData options:0 error:nil];
            [jsonDeferred resolveWithValue:jsonEmployees];


            NSArray *employees = promise.value;
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

        it(@"rejects the promise with an error when the request fails", ^{
            NSError *error = fake_for([NSError class]);
            [jsonDeferred rejectWithError:error];

            promise.error should be_same_instance_as(error);
        });
    });
});

SPEC_END
