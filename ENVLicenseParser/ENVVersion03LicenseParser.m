#import "ENVPerson.h"
#import "ENVVersion03LicenseParser.h"
#import "NSArray+ENVAdditions.h"
#import "NSDate+ENVAdditions.h"
#import "NSString+ENVAdditions.h"

@implementation ENVVersion03LicenseParser

+ (ENVPerson *)personFromString:(NSString *)string {
  string = [string substringFromIndex:31+2];
  NSArray *components = [string componentsSeparatedByCharactersInSet:
                         [NSCharacterSet newlineCharacterSet]];
  NSDictionary *dictionary = [components env_licenseDictionary];
  NSString *licenseID = dictionary[@"DAQ"];

  NSString *street = dictionary[@"DAG"];
  NSString *city = dictionary[@"DAI"];
  NSString *state = dictionary[@"DAJ"];
  NSString *zip = dictionary[@"DAK"];
  NSString *address = [NSString env_formatAddressFromStreet:street
                                                       city:city
                                                      state:state
                                                        zip:zip];

  NSString *givenNames = [self givenNamesFromString:dictionary[@"DCT"]];
  if (!givenNames) {
    givenNames = @"";
  }
  NSString *lastName = dictionary[@"DCS"];
  NSString *fullName = [[[givenNames env_stringByJoiningString:lastName]
                         env_stringByTrimmingSpaces]
                        capitalizedString];
  NSString *expirationDateSting = dictionary[@"DBA"];
  NSDate *expirationDate = [NSDate env_dateFromString:expirationDateSting
                                           withFormat:@"MMddyyyy"];
  BOOL expired = [expirationDate env_isInPast];
  
  ENVPerson *person = [[ENVPerson alloc] initWithName:fullName
                                            licenseID:licenseID
                                              address:address
                                              expired:expired];
  
  [person setFirstName:givenNames];
  [person setMiddleName:@""];
  [person setLastName:lastName];
  [person setStreet:street];
  [person setCity:city];
  [person setState:state];
  [person setZip:zip];
  
  return person;
}

+ (NSString *)givenNamesFromString:(NSString *)string {
  return [string stringByReplacingOccurrencesOfString:@","
                                           withString:@" "];
}

@end
