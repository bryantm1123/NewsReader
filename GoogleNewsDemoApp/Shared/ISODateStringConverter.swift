import Foundation

protocol ISODateStringConverterProtocol {
    func convert(isoDateString: String, toTimeFrom date: Date) -> String?
    func convertToDate(_ dateString: String) -> Date?
}

final class ISODateStringConverter: ISODateStringConverterProtocol {
    private let formatter: ISO8601DateFormatter

    init(formatter: ISO8601DateFormatter) {
        self.formatter = formatter
    }
    
    /// Converts an ISO8601 date string to a Calendar component to determine how many hours
    /// exist between the date string and the Date parameter.
    /// - Parameters:
    ///   - isoDateString: an ISO date string, e.g. "2025-01-22T15:46:00Z". Represents the starting date
    ///   - date: A Date object representing the end date for comparison, e.g. Date.now() to compare to the current time.
    /// - Returns: A string to display on the UI: e.g. "4 hours ago" where 4 is the result of calculating the diff between isoDateString and date.
    func convert(isoDateString: String, toTimeFrom date: Date) -> String? {
        guard let isoDate = convertToDate(isoDateString) else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: isoDate, to: date)
        let hours = components.hour
        return "\(hours ?? 0) hrs ago"
    }
    
    
    /// Converts and ISO8601 date string to a Date
    /// - Parameter dateString: ISO8601 date string
    /// - Returns: Optinoal Date object
    func convertToDate(_ dateString: String) -> Date? {
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone.current
        
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        formatter.formatOptions = [.withInternetDateTime]
        if let date = formatter.date(from: dateString) {
            return date
        }
        return nil
    }
}
