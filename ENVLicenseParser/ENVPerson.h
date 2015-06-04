#import <Foundation/Foundation.h>

@interface ENVPerson : NSObject

@property (nonatomic, readonly) BOOL expired;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *licenseID;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *middleName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *street;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zip;

- (instancetype)initWithName:(NSString *)name
                   licenseID:(NSString *)licenseID
                     address:(NSString *)address
                     expired:(BOOL)expired;

@end
