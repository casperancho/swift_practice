import UIKit
import Foundation

var s = "    45 12 718075     "
var mask = "## ## ######"
// Trim all whitespace
s = s.trimmingCharacters(in: NSCharacterSet.whitespaces)

print(s.trimmingCharacters(in: NSCharacterSet.whitespaces))
print(s.replacingOccurrences(of: " ", with: ""))
print(mask.count - mask.replacingOccurrences(of: " ", with: "").count)

