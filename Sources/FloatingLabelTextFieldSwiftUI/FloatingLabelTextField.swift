//
//  FloatingLabelTextField.swift
//  FloatingLabelTextFieldSwiftUI
//
//  Created by KISHAN_RAJA on 01/05/20.
//  Copyright © 2020 KISHAN_RAJA. All rights reserved.
//

import SwiftUI

//MARK: FloatingLabelTextField Style Protocol
@available(iOS 13.0, *)
public protocol FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField
}

//MARK: FloatingLabelTextField View
@available(iOS 13.0, *)
public struct FloatingLabelTextField: View {
    
    //MARK: Binding Property
    @Binding private var textFieldValue: String
    @State fileprivate var isSelected: Bool = false
    @Binding private var validtionChecker: Bool
    
    private var currentError: TextFieldValidator {
        if notifier.isRequiredField && isShowError && textFieldValue.isEmpty {
            return TextFieldValidator(condition: false, errorMessage: notifier.requiredFieldMessage)
        }
        
        if let firstError = notifier.arrValidator.filter({!$0.condition}).first {
            return firstError
        }
        return TextFieldValidator(condition: true, errorMessage: "")
    }
    
    @State fileprivate var isShowError: Bool = false
    
    @State fileprivate var isFocused: Bool = false
    
    //MARK: Observed Object
    @ObservedObject private var notifier = FloatingLabelTextFieldNotifier()
    
    //MARK: Properties
    private var placeholderText: String = ""
    private var editingChanged: (Bool) -> () = { _ in }
    private var commit: () -> () = { }
    
    //MARK: Init
    public init(_ text: Binding<String>, validtionChecker: Binding<Bool>? = nil, placeholder: String = "", editingChanged: @escaping (Bool)->() = { _ in }, commit: @escaping ()->() = { }) {
        self._textFieldValue = text
        self.placeholderText = placeholder
        self.editingChanged = editingChanged
        self.commit = commit
        self._validtionChecker = validtionChecker ?? Binding.constant(false)
    }
    
    // MARK: Center View
    var centerTextFieldView: some View {
        ZStack(alignment: notifier.textAlignment.getAlignment()) {
            
            if (notifier.isAnimateOnFocus ? (!isSelected && textFieldValue.isEmpty) : textFieldValue.isEmpty) {
                Text(placeholderText)
                    .font(notifier.placeholderFont)
                    .multilineTextAlignment(notifier.textAlignment)
                    .foregroundColor(notifier.placeholderColor)
            }
            
            if notifier.isSecureTextEntry {
                SecureField("", text: $textFieldValue.animation()) {
                }
                .onTapGesture {
                    self.isShowError = self.notifier.isRequiredField
                    self.validtionChecker = self.currentError.condition
                    self.editingChanged(self.isSelected)
                    if !self.isSelected {
                        UIResponder.currentFirstResponder?.resignFirstResponder()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if let currentResponder = UIResponder.currentFirstResponder, let currentTextField = currentResponder.globalView as? UITextField{
                            arrTextFieldEditActions = self.notifier.arrTextFieldEditActions
                            withAnimation {
                                self.isSelected = self.notifier.isSecureTextEntry
                            }
                            currentTextField.addAction(for: .editingDidEnd) {
                                self.isSelected = false
                                self.isShowError = self.notifier.isRequiredField
                                self.validtionChecker = self.currentError.condition
                                self.commit()
                                arrTextFieldEditActions = []
                            }
                        }
                    }
                }
                .disabled(self.notifier.disabled)
                .allowsHitTesting(self.notifier.allowsHitTesting)
                .font(notifier.font)
                .multilineTextAlignment(notifier.textAlignment)
                .foregroundColor((self.currentError.condition || !notifier.isShowError) ? (isSelected ? notifier.selectedTextColor : notifier.textColor) : notifier.errorColor)
                
            } else {
                TextField("", text: $textFieldValue.animation(), onEditingChanged: { (isChanged) in
                    withAnimation {
                        self.isSelected = isChanged
                    }
                    
                    self.validtionChecker = self.currentError.condition
                    self.editingChanged(isChanged)
                    self.isShowError = self.notifier.isRequiredField
                    arrTextFieldEditActions = self.notifier.arrTextFieldEditActions
                }, onCommit: {
                    self.isShowError = self.notifier.isRequiredField
                    self.validtionChecker = self.currentError.condition
                    self.commit()
                    arrTextFieldEditActions = []
                })
                .disabled(self.notifier.disabled)
                .allowsHitTesting(self.notifier.allowsHitTesting)
                .multilineTextAlignment(notifier.textAlignment)
                .font(notifier.font)
                .foregroundColor((self.currentError.condition || !notifier.isShowError) ? (isSelected ? notifier.selectedTextColor : notifier.textColor) : notifier.errorColor)
            }
        }
    }
    
    // MARK: Top error and title lable view
    var topTitleLable: some View {
        Text((self.currentError.condition || !notifier.isShowError) ? placeholderText : self.currentError.errorMessage)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: notifier.textAlignment.getAlignment())
            .animation(.default)
            .foregroundColor((self.currentError.condition || !notifier.isShowError) ? (self.isSelected ? notifier.selectedTitleColor : notifier.titleColor) : notifier.errorColor)
            .font(notifier.titleFont)
    }
    
    // MARK: Bottom Line View
    var bottomLine: some View {
        Divider()
            .frame(height: self.isSelected ? notifier.selectedLineHeight : notifier.lineHeight, alignment: .leading)
    }
    
    //MARK: Body View
    public var body: some View {
        VStack () {
            ZStack(alignment: .bottomLeading) {
                
                //Top error and title lable view
                if notifier.isShowError && self.isShowError && textFieldValue.isEmpty || (notifier.isAnimateOnFocus && isSelected){
                    self.topTitleLable.padding(.bottom, CGFloat(notifier.spaceBetweenTitleText)).opacity(1)
                    
                } else {
                    self.topTitleLable.padding(.bottom, CGFloat(!textFieldValue.isEmpty ? notifier.spaceBetweenTitleText : 0)).opacity((textFieldValue.isEmpty) ? 0 : 1)
                }
                
                HStack {
                    // Left View
                    notifier.leftView
                    
                    // Center View
                    centerTextFieldView
                    
                    //Right View
                    notifier.rightView
                }
            }
            
            //MARK: Line View
            if textFieldValue.isEmpty || !notifier.isShowError {
                bottomLine
                    .background((self.isSelected ? notifier.selectedLineColor : notifier.lineColor))
                
            } else {
                bottomLine
                    .background((self.currentError.condition) ? (self.isSelected ? notifier.selectedLineColor : notifier.lineColor) : notifier.errorColor)
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
    }
}

//MARK: FloatingLabelTextField Style Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    public func floatingStyle<S>(_ style: S) -> some View where S: FloatingLabelTextFieldStyle {
        return style.body(content: self)
    }
}

//MARK: View Property Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Sets the left view.
    public func leftView<LRView: View>(@ViewBuilder _ view: @escaping () -> LRView) -> Self {
        notifier.leftView = AnyView(view())
        return self
    }
    
    /// Sets the right view.
    public func rightView<LRView: View>(@ViewBuilder _ view: @escaping () -> LRView) -> Self {
        notifier.rightView = AnyView(view())
        return self
    }
}

//MARK: Text Property Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Sets the alignment for text.
    public func textAlignment(_ alignment: TextAlignment) -> Self {
        notifier.textAlignment = alignment
        return self
    }
    
    /// Sets the secure text entry for TextField.
    public func isSecureTextEntry(_ isSecure: Bool) -> Self {
        notifier.isSecureTextEntry = isSecure
        return self
    }
    
    /// Whether users can interact with this.
    public func disabled(_ isDisabled: Bool) -> Self {
        notifier.disabled = isDisabled
        return self
    }
    
    /// Whether this view participates in hit test operations.
    public func allowsHitTesting(_ isAllowsHitTesting: Bool) -> Self {
        notifier.allowsHitTesting = isAllowsHitTesting
        return self
    }
}

//MARK: Line Property Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Sets the line height.
    public func lineHeight(_ height: CGFloat) -> Self {
        notifier.lineHeight = height
        return self
    }
    
    /// Sets the selected line height.
    public func selectedLineHeight(_ height: CGFloat) -> Self {
        notifier.selectedLineHeight = height
        return self
    }
    
    /// Sets the line color.
    public func lineColor(_ color: Color) -> Self {
        notifier.lineColor = color
        return self
    }
    
    /// Sets the selected line color.
    public func selectedLineColor(_ color: Color) -> Self {
        notifier.selectedLineColor = color
        return self
    }
}

//MARK: Title Property Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Sets the title color.
    public func titleColor(_ color: Color) -> Self {
        notifier.titleColor = color
        return self
    }
    
    /// Sets the selected title color.
    public func selectedTitleColor(_ color: Color) -> Self {
        notifier.selectedTitleColor = color
        return self
    }
    
    /// Sets the title font.
    public func titleFont(_ font: Font) -> Self {
        notifier.titleFont = font
        return self
    }
    
    /// Sets the space between title and text.
    public func spaceBetweenTitleText(_ space: Double) -> Self {
        notifier.spaceBetweenTitleText = space
        return self
    }
}

//MARK: Text Property Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Sets the text color.
    public func textColor(_ color: Color) -> Self {
        notifier.textColor = color
        return self
    }
    
    /// Sets the selected text color.
    public func selectedTextColor(_ color: Color) -> Self {
        notifier.selectedTextColor = color
        return self
    }
    
    /// Sets the text font.
    public func textFont(_ font: Font) -> Self {
        notifier.font = font
        return self
    }
}

//MARK: Placeholder Property Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Sets the placeholder color.
    public func placeholderColor(_ color: Color) -> Self {
        notifier.placeholderColor = color
        return self
    }
    
    /// Sets the placeholder font.
    public func placeholderFont(_ font: Font) -> Self {
        notifier.placeholderFont = font
        return self
    }
}

//MARK: Error Property Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Sets the is show error message.
    public func isShowError(_ show: Bool) -> Self {
        notifier.isShowError = show
        return self
    }
    
    /// Sets the validation conditions.
    public func addValidations(_ conditions: [TextFieldValidator]) -> Self {
        notifier.arrValidator.append(contentsOf: conditions)
        return self
    }
    
    /// Sets the validation condition.
    public func addValidation(_ condition: TextFieldValidator) -> Self {
        notifier.arrValidator.append(condition)
        return self
    }
    
    /// Sets the error color.
    public func errorColor(_ color: Color) -> Self {
        notifier.errorColor = color
        return self
    }
    
    /// Sets the field is required or not with message.
    public func isRequiredField(_ required: Bool, with message: String) -> Self {
        notifier.isRequiredField = required
        notifier.requiredFieldMessage = message
        return self
    }
}

//MARK: Text Field Editing Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Disable text field editing action. Like cut, copy, past, all etc.
    public func addDisableEditingAction(_ actions: [TextFieldEditActions]) -> Self {
        notifier.arrTextFieldEditActions = actions
        return self
    }
}

//MARK: Animation Style Funcation
@available(iOS 13.0, *)
extension FloatingLabelTextField {
    /// Enable the placeholder label when the textfield is focused.
    public func enablePlaceholderOnFocus(_ isEanble: Bool) -> Self {
        notifier.isAnimateOnFocus = isEanble
        return self
    }
}

