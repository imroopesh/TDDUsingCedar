#import <Foundation/Foundation.h>

@interface EmployeeDeserializer : NSObject

- (NSArray *)deserialize:(NSDictionary *)jsonDictionary;

@end
