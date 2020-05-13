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
    
    //MARK: Observed Object
    @ObservedObject private var notifier = FloatingLabelTextFieldNotifier()
    
    //MARK: Properties
    private var placeholderText: String = ""
    private var editingChanged: (Bool) -> () = { _ in }
    private var commit: () -> () = { }
    
    //MARK: Init
    public init(_ text: Binding<String>, placeholder: String = "", editingChanged: @escaping (Bool)->() = { _ in }, commit: @escaping ()->() = { }) {
        self._textFieldValue = text
        self.placeholderText = placeholder
        self.editingChanged = editingChanged
        self.commit = commit
        
    }
    
    // MARK: Center View
    var centerTextFieldView: some View {
        ZStack(alignment: notifier.textAlignment.getAlignment()) {
            
            if textFieldValue.isEmpty {
                Text(placeholderText)
                    .font(notifier.placeholderFont)
                    .multilineTextAlignment(notifier.textAlignment)
                    .foregroundColor(notifier.placeholderColor)
            }
            
            if notifier.isSecureTextEntry {
                SecureField("", text: $textFieldValue.animation()) {
                }
                .onTapGesture {
                    self.editingChanged(self.isSelected)
                    if !self.isSelected {
                        UIResponder.currentFirstResponder?.resignFirstResponder()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if let currentResponder = UIResponder.currentFirstResponder, let currentTextField = currentResponder.globalView as? UITextField{
                            self.isSelected = self.notifier.isSecureTextEntry
                            currentTextField.addAction(for: .editingDidEnd) {
                                self.isSelected = false
                                self.commit()
                            }
                        }
                    }
                }
                .font(notifier.font)
                .multilineTextAlignment(notifier.textAlignment)
                .foregroundColor(isSelected ? notifier.selectedTextColor : notifier.textColor)
                
            } else {
                TextField("", text: $textFieldValue.animation(), onEditingChanged: { (isChanged) in
                    self.isSelected = isChanged
                    self.editingChanged(isChanged)
                    
                }, onCommit: {
                    print("onCommit")
                    self.commit()
                })
                    .multilineTextAlignment(notifier.textAlignment)
                    .font(notifier.font)
                    .foregroundColor(isSelected ? notifier.selectedTextColor : notifier.textColor)
            }
        }
    }
    
    //MARK: Body View
    public var body: some View {
        VStack () {
            ZStack(alignment: .bottomLeading) {
                
                Text(placeholderText)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: notifier.textAlignment.getAlignment())
                    .animation(.default)
                    .foregroundColor( self.isSelected ? notifier.selectedTitleColor : notifier.titleColor)
                    .padding(.bottom, CGFloat(!textFieldValue.isEmpty ? notifier.spaceBetweenTitleText : 0))
                    .opacity(textFieldValue.isEmpty ? 0 : 1)
                    .font(notifier.titleFont)
                
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
            Divider()
                .frame(height: self.isSelected ? notifier.selectedLineHeight : notifier.lineHeight, alignment: .leading).background( self.isSelected ? notifier.selectedLineColor : notifier.lineColor)
            
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



//MARK: Preview
//struct FloatingLabelTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatingLabelTextField()
//    }
//}
