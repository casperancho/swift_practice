//
//  Note.swift
//  YandexNote
//
//  Created by Arslan Nevlyaev on 26/06/2019.
//  Copyright © 2019 Arslan Nevlyaev. All rights reserved.
//

import UIKit

protocol JSONSerializable {
    var json: [String: Any] { get }
}

// MARK: - JSONSerializable, Hashable

struct Note: JSONSerializable, Hashable {
    
    // Models
    enum Importance: String {
        case high = "high"
        case normal = "normal"
        case low = "low"
    }
    
    // Properties
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let selfDestructionDate: Date?
    let importance: Importance
    
    // MARK: - Initialization
    
    init(uid: String = UUID().uuidString,
         title: String,
         content: String,
         color: UIColor = .white,
         selfDestructionDate: Date? = nil,
         importance: Importance) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.selfDestructionDate = selfDestructionDate
        self.importance = importance
    }
    
    // MARK: - JSONSerializable
    
    var json: [String : Any] {
        var json: [String : Any] = [:]
        
        json["uid"] = self.uid
        json["title"] = self.title
        json["content"] = self.content
        
        if let color = self.color.toHex(),
            self.color != .white {
            json["color"] = color
        }
        
        if let date = self.selfDestructionDate {
            json["selfDestructionDate"] = String(Date().timeIntervalSince(date))
        }
        
        if self.importance != .normal {
            json["importance"] = self.importance.rawValue
        }
        
        return json
    }
}

extension UIColor {
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
