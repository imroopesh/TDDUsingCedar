#import <Foundation/Foundation.h>


@class KSPromise;


@interface EmployeesService : NSObject

- (KSPromise *)fetchAllEmployees;

@end
