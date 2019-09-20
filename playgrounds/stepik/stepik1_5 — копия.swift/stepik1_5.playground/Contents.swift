import UIKit

extension Array{
    //меняем текущий массив
    mutating func myShuffle(){
        for _ in 0..<self.count-1 {
            let randomInd = Int.random(in: 0..<self.count)
            let secondRandomInd = Int.random(in: 0..<self.count)
            if randomInd == secondRandomInd && randomInd != 0 {
                self.swapAt(randomInd-1, secondRandomInd)
            } else {
                self.swapAt(randomInd, secondRandomInd)
            }
        }
    }
}

var myArr = [1,2,3,5,8,13]
myArr.myShuffle()
print(myArr)

func calcLetters(str: String) -> [String: Int] {
    var resultDict : [String: Int] = [:]
    for char in str {
        guard resultDict.index(forKey: String(char)) != nil else {
            resultDict[String(char)] = 1
            continue
        }
        let cur: Int = resultDict[String(char)]!
        resultDict[String(char)] = cur + 1
    }
    return resultDict
}

print(calcLetters(str: "hello"))

