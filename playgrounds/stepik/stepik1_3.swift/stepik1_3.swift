class Car {
    let model: String
    var color: String
    var position: Car.Position
    
    init(model: String, color: String, position: Position) {
        self.color = color
        self.model = model
        self.position = position
    }
    
    struct Position {
        var x: Int
        var y: Int
    }
    
    enum Direction{
        case back
        case forward
        case left
        case right
    }
    
    struct Go {
        var distance: Int
        var direction: Direction
    }
    
    func exec(comand: Go){
        switch comand.direction{
        case .back:
            self.position.y -= comand.distance
        case .forward:
            self.position.y += comand.distance
        case .left:
            self.position.x -= comand.distance
        case .right:
            self.position.x += comand.distance
        }
    }
}

let myFirst = Car(model: "VW", color: "white", position: .init(x: 1, y: 2))
myFirst.exec(comand: .init(distance: 2, direction: .back))
print(myFirst.position)
