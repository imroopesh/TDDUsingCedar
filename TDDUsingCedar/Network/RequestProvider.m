#import "RequestProvider.h"


@implementation RequestProvider

- (NSURLRequest *)requestToGetEmployees {
    NSURL *URL = [NSURL URLWithString:@"https://cdn.jsdelivr.net/gh/imroopesh/TDDUsingCedar/TDDUsingCedarTests/Fixtures/employees.json"];
    return [NSURLRequest requestWithURL:URL];
}

@end
