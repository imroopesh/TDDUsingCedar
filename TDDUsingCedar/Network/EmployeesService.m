#import "EmployeesService.h"
#import "Blindside.h"
#import "KSDeferred.h"
#import "Employee.h"
#import "RequestProvider.h"
#import "JSONClient.h"
#import "EmployeeDeserializer.h"


@interface EmployeesService ()

@property(nonatomic) RequestProvider *requestProvider;
@property(nonatomic) JSONClient *jsonClient;
@property(nonatomic) EmployeeDeserializer *deserializer;

@end


@implementation EmployeesService

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithRequestProvider:jsonClient:deserializer:)
                                  argumentKeys:
            [RequestProvider class],
            [JSONClient class],
            [EmployeeDeserializer class],
            nil];
}

- (instancetype)initWithRequestProvider:(RequestProvider *)requestProvider
                             jsonClient:(JSONClient *)jsonClient
                           deserializer:(EmployeeDeserializer *)deserializer {
    self = [super init];
    if (self) {
        self.requestProvider = requestProvider;
        self.jsonClient = jsonClient;
        self.deserializer = deserializer;
    }
    return self;
}

- (KSPromise *)fetchAllEmployees
{
    NSURLRequest *request = [self.requestProvider requestToGetEmployees];

    KSPromise *jsonPromise = [self.jsonClient sendRequest:request];

    KSPromise *promise = [jsonPromise then:^id(NSDictionary *employeesJSONDict)
    {
        NSArray *employees = [self.deserializer deserialize:employeesJSONDict];
        return employees;
    } error:nil];

    return promise;
}

@end
