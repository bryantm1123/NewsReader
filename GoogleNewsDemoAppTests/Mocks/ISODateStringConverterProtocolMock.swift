import Foundation
@testable import GoogleNewsDemoApp

struct ISODateStringConverterProtocolMock: ISODateStringConverterProtocol {
    func convertToDate(_ dateString: String) -> Date? {
        return Date.now
    }

    func convert(isoDateString: String, toTimeFrom date: Date) -> String? {
        "4 hrs ago"
    }
}
