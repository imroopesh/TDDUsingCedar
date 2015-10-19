#import <Foundation/Foundation.h>
#import "CellPresenter.h"


@class Employee;


@interface EmployeeCellPresenter : NSObject <CellPresenter>

@property (nonatomic) Employee *employee;

@end
