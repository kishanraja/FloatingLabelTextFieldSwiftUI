//
//  TextAlignment+Extension.swift
//  FloatingLabelTextFieldSwiftUI
//
//  Created by KISHAN_RAJA on 01/05/20.
//  Copyright © 2020 KISHAN_RAJA. All rights reserved.
//

import SwiftUI
@available(iOS 13.0, *)
extension TextAlignment {
    func getAlignment() -> Alignment {
        self == .leading ? Alignment.leading : self == .trailing ? Alignment.trailing : Alignment.center
    }
}
