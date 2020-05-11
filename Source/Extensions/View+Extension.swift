//
//  View+Extension.swift
//  FloatingLabelTextFieldSwiftUI
//
//  Created by KISHAN_RAJA on 02/05/20.
//  Copyright © 2020 KISHAN_RAJA. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    public func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
