private func checkInputIsNumber (_ oldInput: String, replaementString: String ) -> Bool {
    if oldInput.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil &&
        replaementString.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
        return true
    } else {
        return false
    }
}

private func processOptionalMaskedInput (shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var notCheangeableMaskSymbol = 0
    var maskSymbols = 0
    for char in inputMask ?? "" {
        if char == "#" || char == "A" {
            maskSymbols += 1
        }
    }
    notCheangeableMaskSymbol = inputMask!.count - maskSymbols
    if string == "" {
        rawInput = String(rawInput?.dropLast() ?? "")
        input.text = rawInput
        if checkInputIsNumber (input.text ?? "", replaementString: string)
            && inputMask!.count >= ((rawInput?.count ?? 0) + notCheangeableMaskSymbol + string.count) {
            input.text = SBOLMaskedFormatter.formatInput(withMask: inputMask, input: rawInput)
            updateTitileVisibility()
            return false
        }
        if (rawInput?.rangeOfCharacter(from: .decimalDigits) == nil) &&
            inputMask!.count >= ((rawInput?.count ?? 0) + notCheangeableMaskSymbol + string.count) {
            input.text = SBOLMaskedFormatter.formatInput(withMask: inputMask, input: rawInput)
            updateTitileVisibility()
            return false
        } else {
            return false
        }
    } else {
        if rawInput?.count == 0 {
            rawInput?.append(string)
            input.text = rawInput
            updateTitileVisibility()
            return false
        }
        if checkInputIsNumber(rawInput ?? "", replaementString: string)
            && inputMask!.count >= ((rawInput?.count ?? 0) + notCheangeableMaskSymbol + string.count) {
            rawInput?.append(string)
            input.text = SBOLMaskedFormatter.formatInput(withMask: inputMask, input: rawInput)
            updateTitileVisibility()
            return false
        }
        if (rawInput?.rangeOfCharacter(from: .decimalDigits) == nil) && (rawInput?.count ?? 0 > 0) &&
            inputMask!.count >= ((rawInput?.count ?? 0) + notCheangeableMaskSymbol + string.count) {
            if string.first!.isLetter {
                return processMaskedInput(range, replacementString: string)
            } else {
                rawInput?.append(string)
                input.text = rawInput
                updateTitileVisibility()
                return false
            }
        }
        rawInput?.append(string)
        input.text = rawInput
        updateTitileVisibility()
        return false
    }
}
