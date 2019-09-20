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

func newsDate (inputDateString: String) {
    let currentDay = Date()   //сегодня
    var inputDate = SBOLServerDateFormatter.date(from: inputDateString)
    
    let dateFormat = DateFormatter()
    dateFormat.locale = Locale(identifier: "ru_RU")
    
    let currentCalendar = Calendar.current
    let currentComponents = currentCalendar.dateComponents([.day, .month, .year], from: currentDay)
    let currentDate = currentCalendar.date(from: currentComponents)
    let inputCalendar = Calendar.current
    let inputComponents = inputCalendar.dateComponents([.day, .month, .year], from: inputDate ?? Date())
    let inputComplexDate = inputCalendar.date(from: inputComponents)
    if currentDate == inputComplexDate {
        print("сегодня")
        return
    }
    let thisYear = currentComponents.year == inputComponents.year
    let thisMonth = currentComponents.month == inputComponents.month
    if thisYear {
        if thisMonth {
            if (currentComponents.day ?? 1) - 1 == inputComponents.day {
                print("вчера")
            } else if (currentComponents.day ?? 2) - 2 == inputComponents.day {
                print("позавчера")
            } else {
                print("\(inputComponents.day!) \(dateFormat.monthSymbols[(inputComponents.month!)-1])")
            }
        } else {
            print("\(inputComponents.day!) \(dateFormat.monthSymbols[(inputComponents.month!)-1])")
        }
    } else {
        print("\(inputComponents.day!) \(dateFormat.monthSymbols[(inputComponents.month!)-1]) \(inputComponents.year!)")
    }
}


let inputDateString = "2019-06-13T12:48:24+0300"
newsDate(inputDateString: inputDateString)
