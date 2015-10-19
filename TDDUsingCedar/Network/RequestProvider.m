#import "RequestProvider.h"


@implementation RequestProvider

- (NSURLRequest *)requestToGetEmployees {
    NSURL *URL = [NSURL URLWithString:@"https://rawgit.com/imroopesh/TDDUsingCedar/master/TDDUsingCedarTests/Fixtures/employees.json"];
    return [NSURLRequest requestWithURL:URL];
}

@end
