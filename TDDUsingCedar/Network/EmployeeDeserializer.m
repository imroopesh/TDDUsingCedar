#import "EmployeeDeserializer.h"
#import "Employee.h"

@implementation EmployeeDeserializer


- (NSArray *)deserialize:(NSDictionary *)jsonDictionary
{

    NSMutableArray *employees = [NSMutableArray array];

    if (jsonDictionary != (id)[NSNull null]) {

        NSArray *employeesDictionary = jsonDictionary[@"d"];

        for (NSDictionary *employeeDict in employeesDictionary) {
            NSString *uri = employeeDict[@"uri"];
            NSString *name = employeeDict[@"name"];
            Employee *employee = [[Employee alloc] initWithUserUri:uri name:name];
            [employees addObject:employee];
        }
        return [employees copy];
    }
    return nil;
}
@end
