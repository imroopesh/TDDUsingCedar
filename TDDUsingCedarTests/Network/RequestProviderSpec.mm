#import "Cedar.h"
#import "RequestProvider.h"
#import "InjectorProvider.h"
#import "Blindside.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;


SPEC_BEGIN(RequestProviderSpec)

describe(@"RequestProvider", ^{
    __block RequestProvider *subject;
    __block id<BSBinder, BSInjector> injector;

    beforeEach(^{
        injector = (id)[InjectorProvider injector];
        
        subject = [injector getInstance:[RequestProvider class]];
    });

    it(@"generates a request to get all employees", ^{
        NSURLRequest *request = [subject requestToGetEmployees];

        request.URL should equal([NSURL URLWithString:@"https://raw.githubusercontent.com/imroopesh/TDDUsingCedar/master/TDDUsingCedarSpecs/Fixtures/employees.json"]);
    });
});

SPEC_END
