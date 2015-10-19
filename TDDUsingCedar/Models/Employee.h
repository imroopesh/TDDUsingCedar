#import <Foundation/Foundation.h>


@interface Employee : NSObject

@property (nonatomic, copy, readonly) NSString *uri;
@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithUserUri:(NSString *)uri name:(NSString *)name;

@end
