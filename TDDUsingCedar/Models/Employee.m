#import "Employee.h"


@interface Employee ()

@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *name;

@end


@implementation Employee

- (instancetype)initWithUserUri:(NSString *)uri name:(NSString *)name {
    self = [super init];
    if (self) {
        self.uri = uri;
        self.name = name;
    }
    return self;
}

@end
