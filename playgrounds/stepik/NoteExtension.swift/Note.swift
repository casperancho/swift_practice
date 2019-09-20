import UIKit

struct Note{
    var uid: String?
    let title: String
    var content: String
    let color: UIColor? = .white
    let importance: NoteImportance? = .normal
    var selfDestructionDate: Date? = nil
    
    init(uid: String, title: String, content: String) {
        self.content = content
        self.title = title
        if uid.isEmpty {
            self.uid = UUID().uuidString
        }else{
            self.uid = uid
        }
    }
    
    enum NoteImportance {
        case high
        case normal
        case low
    }
}


