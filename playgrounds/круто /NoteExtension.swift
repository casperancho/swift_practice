//
//  NoteExtension.swift
//  
//
//  Created by Timur Rakhimov on 30/06/2019.
//

import UIKit

extension Note {
    
    var json: [String: Any] {
        var result = [String: Any]()
        
        result["title"] = self.title
        result["content"] = self.content
        result["uid"] = self.uid
        
        if self.color != .white {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
            result["color"] = [r, g, b, a]
        }
        
        switch self.importance {
        case .usual:
            break
        default:
            result["importance"] = self.importance.rawValue
        }
        
        if let date = self.selfDestructionDate {
            result["selfDestructionDate"] = date.timeIntervalSince1970
        }
        
        return result
    
    }
    
    static func parse(json: [String: Any]) -> Note? {
        
        guard let title = json["title"] as? String else {
            return nil
        }
        
        guard let content = json["content"] as? String else {
            return nil
        }
        
        guard let uid = json["uid"] as? String else {
            return nil
        }
        
        var color: UIColor
        if let colorRgb = json["color"] as? [CGFloat] {
            color = UIColor(red: colorRgb[0],
                            green: colorRgb[1],
                            blue: colorRgb[2],
                            alpha: colorRgb[3])
        } else {
            color = .white
        }
        
        var importance: Importance
        if let importanceRawValue = json["importance"] as? String {
            importance = Importance(rawValue: importanceRawValue) ?? .usual
        } else {
            importance = .usual
        }
        
        var selfDestructionDate: Date?
        if let date = json["selfDestructionDate"] as? TimeInterval {
            selfDestructionDate = Date(timeIntervalSince1970: date)
        } else {
            selfDestructionDate = nil
        }
        
        let note = Note(uid: uid, title: title, content: content, color: color, importance: importance, selfDestructionDate: selfDestructionDate)
        
        return note
    }
}
