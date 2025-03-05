import Foundation
@testable import NewsReader

struct ISODateStringConverterProtocolMock: ISODateStringConverterProtocol {
    func convertToDate(_ dateString: String) -> Date? {
        return Date.now
    }

    func convert(isoDateString: String, toTimeFrom date: Date) -> String? {
        "4 hrs ago"
    }
}
