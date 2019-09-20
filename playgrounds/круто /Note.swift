//
//  Note.swift
//
//
//  Created by Timur Rakhimov on 26/06/2019.
//


import UIKit

struct Note {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
 
    init(uid: String = UUID().uuidString,
         title: String,
         content: String,
         color: UIColor = UIColor.white,
         importance: Importance,
         selfDestructionDate: Date?) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
}

enum Importance: String {
    case unimportant
    case usual
    case important
}

