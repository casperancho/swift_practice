import UIKit

struct NewsModuleScreenNews {
    let id: Int
    let sourceTag: String
    let title: String
    let formattedDate: String
    let isNewsOfTheDay: Bool
    let imageLink: String
    let viewCounter: Int
}

struct NewsModuleScreenPoll {
    let id: Int
    let sourceTag: String
    let title: String
    let formattedEndDate: String
    let viewCounter: Int
}

struct NewsModuleShortNews {
    let id: Int
    let sourceTag: String
    let title: String
    let date: Date
    let isNewsOfTheDay: Bool
    let imageLink: String
    let viewCounter: Int
}

struct NewsModuleShortPoll {
    let id: Int
    let sourceTag: String
    let title: String
    let endDate: Date
    let viewCounter: Int
}

enum NewsModuleScreenNewsItem {
    case news(desc: NewsModuleScreenNews)
    case poll(desc: NewsModuleScreenPoll)
}

enum NewsModuleShortItem {
    case news(desc: NewsModuleShortNews)
    case poll(desc: NewsModuleShortPoll)
}

private var cachedNewsArray: [NewsModuleShortItem] = []
let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())
let pollShortItem = NewsModuleShortPoll (
    id: 1,
    sourceTag: "Хммм",
    title: "ОПРОС+1",
    endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
    viewCounter: 3
)
let pollShortItem2 = NewsModuleShortPoll (
    id: 2,
    sourceTag: "Хммм",
    title: "ОПРОС+2",
    endDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
    viewCounter: 3
)
let singleShortMainNewsItem = NewsModuleShortNews (
    id: 3,
    sourceTag: "я",
    title: "ГЛАВНАЯ",
    date: Date(),
    isNewsOfTheDay: true,
    imageLink: "",
    viewCounter: 23
)
let singleShortMainNewsItemOld = NewsModuleShortNews (
    id: 5,
    sourceTag: "я",
    title: "ГЛАВНАЯ",
    date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
    isNewsOfTheDay: true,
    imageLink: "",
    viewCounter: 23
)
let singleShortNewsItem = NewsModuleShortNews (
    id: 4,
    sourceTag: "просто",
    title: "новость",
    date: Date(),
    isNewsOfTheDay: false,
    imageLink: "",
    viewCounter: 23
)
let singleShortNewsItemOld = NewsModuleShortNews (
    id: 4,
    sourceTag: "просто",
    title: "новость OLD-3",
    date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
    isNewsOfTheDay: false,
    imageLink: "",
    viewCounter: 23
)

let pollShortItemOld = NewsModuleShortPoll (
    id: 2,
    sourceTag: "Хммм",
    title: "ОПРОС оконченный-2",
    endDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
    viewCounter: 3
)
let pollShortItemOld2 = NewsModuleShortPoll (
    id: 2,
    sourceTag: "Хммм",
    title: "ОПРОС оконченный",
    endDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
    viewCounter: 3
)
cachedNewsArray.append(.news(desc: singleShortNewsItemOld)) // 4
////cachedNewsArray.append(.poll(desc: pollShortItem2)) // 2
////cachedNewsArray.append(.poll(desc: pollShortItem)) //1
cachedNewsArray.append(.poll(desc: pollShortItemOld2))  //1
//cachedNewsArray.append(.news(desc: singleShortNewsItem)) // 4
//cachedNewsArray.append(.news(desc: singleShortNewsItemOld)) // 4
cachedNewsArray.append(.poll(desc: pollShortItemOld))  //1
cachedNewsArray.append(.news(desc: singleShortMainNewsItemOld)) //3

cachedNewsArray.append(.news(desc: singleShortNewsItem)) // 4
cachedNewsArray.append(.news(desc: singleShortNewsItem)) // 4
cachedNewsArray.append(.poll(desc: pollShortItem)) //1
cachedNewsArray.append(.poll(desc: pollShortItem)) //1
cachedNewsArray.append(.news(desc: singleShortMainNewsItem)) //3
cachedNewsArray.append(.poll(desc: pollShortItem2)) // 2



//print(cachedNewsArray)


//let new = cachedNewsArray.sorted {
//    switch (lhs: $0,rhs: $1){
//    case (let .poll(descLeft) ,let  .poll(descRight)):
////        if descLeft.endDate < Date() {
////            return true
////        }
////        if descRight.endDate < Date(){
////            return true
////        }
//        if descLeft.endDate < descRight.endDate{
//            return true
//        }
//        return false
//
//    case ( .poll(let poll), .news(let news)):
//        if poll.endDate < Date() && news.date < poll.endDate{
//            return true
//        }
//
//        return true
//
//    case (.news, .poll):
//        return false
//
//    case (.news(let descLeft), .news(let descRight)):
//        if descLeft.date > descRight.date && ((descLeft.isNewsOfTheDay && descRight.isNewsOfTheDay) || (!descLeft.isNewsOfTheDay && !descRight.isNewsOfTheDay)){
//            return true
//        }
//        if descLeft.isNewsOfTheDay {
//            return true
//        }
//        return false
//    }
//
//}



//let new = cachedNewsArray.sorted {
//    switch (lhs: $0,rhs: $1) {
//    case (let lhs, let rhs):
//        var isLeftSidePoll = false
//        var isLeftSideNewsOfTheDay = false
//        var leftDate = Date()
//        var isLeftPollResult = false
//        switch lhs {
//        case .news(let desc):
//            isLeftSideNewsOfTheDay = desc.isNewsOfTheDay
//            leftDate = desc.date
//        case .poll(let desc):
//            if desc.endDate < Date() {
//                isLeftPollResult = true
//            } else {
//                isLeftSidePoll = true
//            }
//            leftDate = desc.endDate
//        }
//        switch rhs {
//        case .news(let desc):
//            if isLeftSidePoll ||  isLeftSideNewsOfTheDay { ++
//                return true
//            }
//
//            if isLeftPollResult && desc.date < leftDate{ ++
//                return true
//            }
//
//            if desc.isNewsOfTheDay && isLeftSideNewsOfTheDay && desc.date < leftDate {  ++
//                    return true
//            }
//
//            if !desc.isNewsOfTheDay && !isLeftSideNewsOfTheDay && desc.date < leftDate  { ++
//
//                return true
//            }
//
//            return false
//
//        case .poll(let desc):
//            if desc.endDate < Date(){
//                return true
//            }
//
//            if isLeftPollResult { ++
//                return true
//            }
//
//            if isLeftSidePoll && desc.endDate > leftDate  { ++
//                    return true
//            }
//            return false
//        }
//    }
//}


let currentDate = Date()
let new = cachedNewsArray.sorted {
    switch (lhs: $0,rhs: $1) {
    case (.poll(let descLeft), .poll(let descRight)):
        let isLHSPoolFinished = descLeft.endDate < currentDate
        let isRHSPoolFinished = descRight.endDate < currentDate
        switch (isLHSPoolFinished, isRHSPoolFinished) {
        case (true, true): return descLeft.endDate > descRight.endDate
        case (false, false): return descLeft.endDate < descRight.endDate
        default: return !isLHSPoolFinished
        }

    case (.news, .poll(let poll)):
        return poll.endDate < currentDate

    case ( .poll(let poll), .news(let news)):
        return !(poll.endDate < currentDate && poll.endDate < news.date)

    case (.news(let descLeft), .news(let descRight)):
        return descLeft.isNewsOfTheDay == descRight.isNewsOfTheDay ? descRight.date < descLeft.date : descLeft.isNewsOfTheDay
    }
}


for items in new{
    print(items)
}

//class SBOLNewsImageView: UIImageView {
//    func setImage(placeholderImage: UIImage, imageURLToChange: URL, completion: @escaping () -> Void) {
//        af_setImage(withURL: imageURL, placeholderImage: placeholderImage) { _ in
//            completion()
//            image = placeholderImage ?? nil
//        }
//    }
//}
