import Testing
import Foundation
@testable import GoogleNewsDemoApp

struct ISODateStringConverterTests {
    let isoDateConverter = ISODateStringConverter(formatter: ISO8601DateFormatter())
    
    @Test func isoDateWithFractionalSecondsIsCorrectlyConverted() throws {
        let dateWithFractionalSeconds = "2025-01-23T15:52:23.3636319Z"
        let endDate = try #require( endDatePlusFourHours(isoDateConverter.convertToDate(dateWithFractionalSeconds)))
        
        let converted = isoDateConverter.convert(isoDateString: dateWithFractionalSeconds,
                                                 toTimeFrom: endDate)
        
        #expect(converted == "4 hrs ago")
    }
    
    @Test func isoDateWithInternetDateTimeIsCorrectlyConverted() throws {
        let dateWithInternetDateTime = "2025-01-23T04:58:38Z"
        let endDate = try #require( endDatePlusFourHours(isoDateConverter.convertToDate(dateWithInternetDateTime)))
        
        let converted = isoDateConverter.convert(isoDateString: dateWithInternetDateTime,
                                                 toTimeFrom: endDate)
        
        #expect(converted == "4 hrs ago")
    }
    
    private func endDatePlusFourHours(_ date: Date?) -> Date? {
        guard let date else { return nil }
        return Calendar.current.date(byAdding: .hour, value: 4, to: date)
    }
}
