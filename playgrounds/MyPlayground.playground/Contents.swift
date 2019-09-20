import UIKit

var str = "4276385030"
let insertChar = "XX XXXX "
var result = ""
var indexes = [6]

for idx in 0...str.count-1 {
    if idx == 4 {
        result += " "
    }
    if indexes.contains(idx as Int){
        result += insertChar
    }
    result += "\(str[String.Index(encodedOffset: idx)])"
}

print(result)
