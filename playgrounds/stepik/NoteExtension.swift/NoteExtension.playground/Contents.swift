import UIKit

extension Note {
    var json: [String: Any]{
        set {
            self.json = newValue
        }
        get{
            return self.json
        }
    }
    
    
    static func parse(json: [String: Any]) -> Note?{
        let uid = json["uid"] as! String
        var color: UIColor
        if json["color"] as! UIColor != UIColor.white {
            color = json["color"] as! UIColor
        } else {
            color = UIColor.black
        }
        var importance: Importance
        if json["importance"] as! Importance != Importance.normal {
            importance = json["importance"] as! Importance
        } else {
            importance = Importance.low
        }
        let title = json["title"] as! String
        let content = json["content"] as! String
        let selfDestructionDate = json["selfDestructionDate"] as! Date
        return Note(
            uid: uid,
            title: title,
            content: content,
            color: color,
            importance: importance,
            selfDestructionDate: selfDestructionDate
    )
    }
}

