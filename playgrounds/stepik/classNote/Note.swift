#!/usr/bin/swift

import UIKit

enum Importance {
    case unimportant
    case usual
    case important
}

struct Note {
    let uid: UUID
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    var selfDestructionDate: Date
    
    init(uid: String, title: String, content: String, color: UIColor, importance: Importance, selfDestructionDate: Date) {
        guard !title.isEmpty || !content.isEmpty || importance.isEmpty else {
            return nil
        }
        
        if uid.isEmpty {
            self.uid = UUID().uuidString
        }else{
            self.uid = uid
        }
        
        if color.isEmpty {
            self.uid = UIColor(white: 1.0, alpha: 1.0)
        }else{
            self.uid = color
        }
        
        if selfDestructionDate.isEmpty {
            self.selfDestructionDate = 0
        }else{
            self.selfDestructionDate = selfDestructionDate
        }
    }
}



