#import "NSString+ENVAdditions.h"

@interface ENVNSStringAdditionsTests : XCTestCase

@end

@implementation ENVNSStringAdditionsTests

- (void)testTrimmingSpace {
  NSString *string = @" foo ";
  NSString *trimmedString = [string env_stringByTrimmingSpaces];
  XCTAssertEqualObjects(trimmedString, @"foo");
}

- (void)testTrimmingSpaceOnlyTrimsSpaces {
  NSString *string = @" foo\n";
  NSString *trimmedString = [string env_stringByTrimmingSpaces];
  XCTAssertEqualObjects(trimmedString, @"foo\n");
}

- (void)testJoiningString {
  NSString *string = @"First";
  NSString *joinedString = [string env_stringByJoiningString:@"Last"];
  XCTAssertEqualObjects(joinedString, @"First Last");
}

- (void)testJoiningBlankString {
  NSString *string = @"First";
  NSString *joinedString = [string env_stringByJoiningString:@""];
  XCTAssertEqualObjects(joinedString, @"First");
}

- (void)testJoiningWhitespaceString {
  NSString *string = @"First";
  NSString *joinedString = [string env_stringByJoiningString:@" "];
  XCTAssertEqualObjects(joinedString, @"First");
}

- (void)testJoiningNilString {
  NSString *string = @"First";
  NSString *joinedString = [string env_stringByJoiningString:nil];
  XCTAssertEqualObjects(joinedString, @"First");
}

- (void)testJoiningLongString {
  NSString *string = @"First";
  NSString *joinedString = [string env_stringByJoiningString:@"Middle Last"];
  XCTAssertEqualObjects(joinedString, @"First Middle Last");
}

- (void)testJoiningIntoEmptyString {
  NSString *joinedString = [@"" env_stringByJoiningString:@"Last"];
  XCTAssertEqualObjects(joinedString, @"Last");
}

- (void)testNameByFilteringNoneFromEmpty {
  NSString *name = [NSString env_nameByFilteringNone:@""];
  XCTAssertEqualObjects(name, @"");
}

- (void)testNameByFilteringNoneFromValidName {
  NSString *name = [NSString env_nameByFilteringNone:@"Middle"];
  XCTAssertEqualObjects(name, @"Middle");
}

- (void)testNameByFilteringNoneFromValidNone {
  NSString *name = [NSString env_nameByFilteringNone:@"none"];
  XCTAssertEqualObjects(name, @"");
}

- (void)testFormatAddressWithNil {
  NSString *address = [NSString env_formatAddressFromStreet:nil
                                                       city:nil
                                                      state:nil
                                                        zip:nil];
  XCTAssertEqualObjects(address, @"");
}

@end
