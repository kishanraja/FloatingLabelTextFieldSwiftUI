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
    @State private var password: String = ""
    
    @State private var isPasswordShow: Bool = false
    
    var body: some View {
        VStack {
            
            HStack(spacing: 20) {
                FloatingLabelTextField($firstName, placeholder: "First Name", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .floatingStyle(ThemeTextFieldStyle())
                .modifier(ThemeTextField())
                
                
                FloatingLabelTextField($lastName, placeholder: "Last Name", editingChanged: { (isChanged) in
                    
                }) {
                    
                }
                .floatingStyle(ThemeTextFieldStyle2())
                .modifier(ThemeTextField())
            }
            
            FloatingLabelTextField($mobileNumber, placeholder: "Phone Number", editingChanged: { (isChanged) in
                
            }) {
                
            }
            .keyboardType(.phonePad)
            .modifier(ThemeTextField())
            
            FloatingLabelTextField($email, placeholder: "Email", editingChanged: { (isChanged) in
                
            }) {
                
            }
            .keyboardType(.emailAddress)
            .modifier(ThemeTextField())
            
            FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in
                
            }) {
                
            }
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
        content.titleColor(.red)
    }
}

struct ThemeTextFieldStyle2: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content.titleColor(.green)
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
