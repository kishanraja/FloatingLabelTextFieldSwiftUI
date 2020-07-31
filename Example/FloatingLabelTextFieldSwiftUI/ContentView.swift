//
//  ContentView.swift
//  Example
//
//  Created by KISHAN_RAJA on 10/05/20.
//  Copyright © 2020 KISHAN_RAJA. All rights reserved.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct ContentView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var mobileNumber: String = ""
    @State private var email: String = ""
    @State private var isValidEmail: Bool = false
    @State private var password: String = ""
    @State private var date: Date = Date()
    @State private var birthDate: String = ""
    @State private var showDatePicker: Bool = false
    
    @State private var isPasswordShow: Bool = false
    
    private var selectedDate: Binding<Date> {
        Binding<Date>(get: { self.date}, set : {
            self.date = $0
            self.setDateFormatterString()
        })
    }
    
    private func setDateFormatterString() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd - MMMM, yyyy"
        
        self.birthDate = formatter.string(from: self.date)
    }
    
    var body: some View {
        VStack {
            
            HStack(spacing: 20) {
                FloatingLabelTextField($firstName, placeholder: "First Name", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .isShowError(true)
                .addValidations([.init(condition: firstName.isValid(.alphabet), errorMessage: "Invalid Name"),
                                 .init(condition: firstName.count >= 2, errorMessage: "Minimum two character long")
                ])
                    .isRequiredField(true, with: "Name field is required")
                    .floatingStyle(ThemeTextFieldStyle())
                    .modifier(ThemeTextField())
                
                
                FloatingLabelTextField($lastName, placeholder: "Last Name", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .isShowError(true)
                .addValidations([.init(condition: lastName.isValid(.alphabet), errorMessage: "Invalid Name"),
                                 .init(condition: lastName.count >= 2, errorMessage: "Minimum two character long")
                ])
                    .floatingStyle(ThemeTextFieldStyle2())
                    .modifier(ThemeTextField())
            }
            
            FloatingLabelTextField($birthDate, placeholder: "Birth Date", editingChanged: { (isChanged) in
                self.showDatePicker = isChanged
            }) {
                
            }
            .modifier(ThemeTextField())
            
            if showDatePicker {
                DatePicker("", selection: selectedDate,
                           displayedComponents: .date)
            }
            
            FloatingLabelTextField($mobileNumber, placeholder: "Phone Number", editingChanged: { (isChanged) in
                
            }) {
                
            }
            .keyboardType(.phonePad)
            .modifier(ThemeTextField())
            FloatingLabelTextField($email, validtionChecker: $isValidEmail, placeholder: "Email", editingChanged: { (isChanged) in
                
            }) {
                
            }
            .addValidations([.init(condition: email.isValid(.email), errorMessage: "Invalid Email")
            ])
                .isShowError(true)
                .keyboardType(.emailAddress)
                .modifier(ThemeTextField())
            
            FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in
                
            }) {
                
            }
            .isShowError(true)
            .isRequiredField(true, with: "Password field is required")
            .rightView({
                Button(action: {
                    withAnimation {
                        self.isPasswordShow.toggle()
                    }
                    
                }) {
                    Image(self.isPasswordShow ? "eye_close" : "eye_show")
                }
            })
                .isSecureTextEntry(!self.isPasswordShow)
                .modifier(ThemeTextField())
            //            SecureField("", text:  $password)
            //            Text(password)
            Button(action: {
                self.endEditing(true)
                
                if self.isValidEmail {
                    print("Valid field")
                    
                } else {
                    print("Invalid field")
                }
                
            }) {
                Text("Create")
            }
            .buttonStyle(CreateButtonStyle())
            Spacer()
        }
            
        .padding()
        
    }
    
}

//MARK: Create floating style
struct ThemeTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content.titleColor(.black)
    }
}

struct ThemeTextFieldStyle2: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content.titleColor(.black).errorColor(.init(UIColor.green))
    }
}

//MARK: ViewModifier
struct ThemeTextField: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(height: 80)
    }
}

//MARK: Button style
struct CreateButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(Color.orange)
            .cornerRadius(10.0)
    }
}

//MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
