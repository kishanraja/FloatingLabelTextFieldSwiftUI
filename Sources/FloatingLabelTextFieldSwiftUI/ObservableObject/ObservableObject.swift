//
//  ObservableObject.swift
//  FloatingLabelTextFieldSwiftUI
//
//  Created by KISHAN_RAJA on 01/05/20.
//  Copyright © 2020 KISHAN_RAJA. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
class FloatingLabelTextFieldNotifier: ObservableObject {
    
    //MARK: Views Properties
    @Published var leftView: AnyView?
    @Published var rightView: AnyView?
    
    //MARK: Alignment Properties
    @Published var textAlignment: TextAlignment = .leading
    
    //MARK: Line Properties
    @Published var lineHeight: CGFloat = 1
    @Published var selectedLineHeight: CGFloat = 1.5
    @Published var lineColor: Color = .black
    @Published var selectedLineColor: Color = .blue
    
    //MARK: Title Properties
    @Published var titleColor: Color = .gray
    @Published var selectedTitleColor: Color = .blue
    @Published var titleFont: Font = .system(size: 12)
    
    //MARK: Text Properties
    @Published var textColor: Color = .black
    @Published var selectedTextColor: Color = .blue
    @Published var font: Font = .system(size: 15)
    
    //MARK: Placeholder Properties
    @Published var placeholderColor: Color = .gray
    @Published var placeholderFont: Font = .system(size: 15)
    
    //MARK: Other Properties
    @Published var spaceBetweenTitleText: Double = 15
    @Published var isSecureTextEntry: Bool = false
    @Published var disabled: Bool = false
    @Published var allowsHitTesting: Bool = true
    
    //MARK: Error Properties
    @Published var isShowError: Bool = false
    @Published var errorColor: Color = .red
    @Published var arrValidator: [TextFieldValidator] = []
    @Published var isRequiredField: Bool = false
    @Published var requiredFieldMessage: String = ""
    
    //MARK: Action Editing Properties
    @Published var arrTextFieldEditActions: [TextFieldEditActions] = []
    
    //MARK: Animation Style Properties
    @Published var isAnimateOnFocus: Bool = false
}
