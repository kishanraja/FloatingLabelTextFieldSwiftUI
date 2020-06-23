//
//  TextFieldValidator.swift
//  FloatingLabelTextFieldSwiftUI
//
//  Created by KISHAN_RAJA on 18/06/20.
//

import Foundation

public struct TextFieldValidator {
    public var condition: Bool = true
    public var errorMessage: String = ""
    
    public init(condition: Bool, errorMessage: String) {
        self.condition = condition
        self.errorMessage = errorMessage
    }
}
