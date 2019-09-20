//
//  NoteExtension.swift
//  YandexNote
//
//  Created by Arslan Nevlyaev on 27/06/2019.
//  Copyright © 2019 Arslan Nevlyaev. All rights reserved.
//

import UIKit

extension Note {
    
    static func parse (json: [String: Any]) -> Note? {
        
        guard let title = json["title"] as? String,
            let content = json["content"] as? String,
            let jsonImportance = json["importance"] as? String,
            let uid = json["uid"] as? String else { return nil }
        
        let importance = Importance(rawValue: jsonImportance) ?? .normal
        
        var color: UIColor = .white
        if let jsonColor = json["color"] as? String {
            color = UIColor(hex: jsonColor) ?? .white
        }
        
        var selfDestructionDate: Date?
        if let date = json["selfDestructionDate"] as? String,
            let interval = TimeInterval(date) {
            selfDestructionDate = Date(timeIntervalSince1970: interval)
        }
    
        return Note(uid: uid,
                    title: title,
                    content: content,
                    color: color,
                    selfDestructionDate: selfDestructionDate,
                    importance: importance)
    }
}
