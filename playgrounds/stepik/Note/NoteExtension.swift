#!/usr/bin/swift

import UIKit

extension Note {
    static func parse(json: [String: Any]) -> Note? {
        let note_json = Note
        
        do {
            let json_data = try
                JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print("Error JSONSeriaization \(json)")
            return self
        }
        
        for field in json_data {
            switch field {
                case "color":
                    switch json_data[field] {
                        case .white:
                            break
                        default:
                            note_json.color = UIColor(json_data[field])
                    }
                
                case "importance":
                    switch json_data[field] {
                        case .usual:
                            break;
                        default:
                            note_json.importance = importance
                    }
                
                case "selfDestructionDate":
                    note_json[field] = Date(timeIntervalSine1970: json_data[field])
                
                default:
                    note_json[field] = json_data[field]
                    break;
            }
            
        }
        
        return note_json
    }
}

let json_string: String? = "{'uid': '1', 'title': 'Title', 'content': 'Content', 'color': 'white', 'importance': 'important', 'selfDestructionDate': 10}"
var note = Note.parse(json: json_string);

print(note)
