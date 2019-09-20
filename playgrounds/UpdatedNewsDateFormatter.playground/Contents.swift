import UIKit

class SBOLServerDateFormatter {
    private static let instance = SBOLServerDateFormatter()
    
    static func string(from date: Date) -> String {
        return instance.formatter.string(from: date)
    }
    
    static func date(from string: String) -> Date? {
        return instance.formatter.date(from: string)
    }
    
    private let formatter = ISO8601DateFormatter()
    
    private init() {
        formatter.timeZone = TimeZone.current
    }
}

let inputDateString = "2019-07-14T12:48:24+0300"

let currentDay = Date()   //сегодня
var inputDate = SBOLServerDateFormatter.date(from: inputDateString)

let dateFormat = DateFormatter()
dateFormat.locale = Locale(identifier: "ru_RU")
dateFormat.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")

let currentCalendar = Calendar.current

let yearDiff = currentCalendar.dateComponents([.year], from: inputDate!, to: currentDay)
if yearDiff.year != 0 {
    var output = dateFormat.string(from: inputDate!)

    print(output.replacingOccurrences(of: "г.", with: ""))
} else {
    let diff = currentCalendar.dateComponents([.day], from: inputDate!, to: currentDay)
    switch diff.day {
        
    case 0: print("сегодня")
    case 1: print("вчера")
    case 2: print("позавчера")
        
    default:
        let stringArray = dateFormat.string(from: inputDate!).split(separator: " ")
        dateFormat.setLocalizedDateFormatFromTemplate("dd MMMM")
        print(dateFormat.string(from: currentDay))

    }
}
