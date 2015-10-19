#import "RequestProvider.h"


@implementation RequestProvider

- (NSURLRequest *)requestToGetEmployees {
    NSURL *URL = [NSURL URLWithString:@"https://raw.githubusercontent.com/imroopesh/TDDUsingCedar/master/TDDUsingCedarSpecs/Fixtures/employees.json"];
    return [NSURLRequest requestWithURL:URL];
}

@end
