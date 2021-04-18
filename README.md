# FloatingLabelTextFieldSwiftUI

[![CI Status](https://img.shields.io/travis/kishanraja/FloatingLabelTextFieldSwiftUI.svg?style=flat)](https://travis-ci.org/kishanraja/FloatingLabelTextFieldSwiftUI)
[![Version](https://img.shields.io/cocoapods/v/FloatingLabelTextFieldSwiftUI.svg?style=flat)](https://cocoapods.org/pods/FloatingLabelTextFieldSwiftUI)
[![License](https://img.shields.io/cocoapods/l/FloatingLabelTextFieldSwiftUI.svg?style=flat)](https://cocoapods.org/pods/FloatingLabelTextFieldSwiftUI)
[![Platform](https://img.shields.io/cocoapods/p/FloatingLabelTextFieldSwiftUI.svg?style=flat)](https://cocoapods.org/pods/FloatingLabelTextFieldSwiftUI)


FloatingLabelTextFieldSwiftUI is a small and lightweight SwiftUI framework written in completely swiftUI (not using UIViewRepresentable) that allows to create beautiful and customisable floating label textfield! This library support RTL text (eg. Arabic) and easy to add left view and right view to your text field and customizable.

<p float="left">
    <img src="https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/blob/master/Graphics/FloatingLabelTextFieldSwiftUI.gif" width="350" height="623" >

</p>

If you like the project, please do not forget to `star ★` this repository and follow me on GitHub.


## 📦 Requirements

- iOS 13.0+
- Xcode 11.2+
- Swift 5.0

## 💻 Usage 

To start using the component add it to your project using CocoaPods or Swift Package. First of all import FloatingLabelTextFieldSwiftUI

```swift
import FloatingLabelTextFieldSwiftUI
```

<p float="left">
    <img src="https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/blob/master/Graphics/normal_text_field.gif">

</p>

```swift
struct ContentView: View {
    
    @State private var firstName: String = ""
    
    var body: some View {
        
        FloatingLabelTextField($firstName, placeholder: "First Name", editingChanged: { (isChanged) in
            
        }) {
            
        }.frame(height: 70)
    }
}
```

### FloatingLabelTextFieldStyle and Colors:

You can customize the colors of the textfield by using FloatingLabelTextFieldStyle property or create your own style and set a few properties. 

#### Property

```swift
struct ContentView: View {
    
    @State private var firstName: String = ""
    
    var body: some View {
        
        FloatingLabelTextField($firstName, placeholder: "First Name", editingChanged: { (isChanged) in
            
        }) {
            
        }
        .titleColor(.green)
        .selectedLineColor(.blue)
        .selectedTextColor(.blue)
        .selectedTitleColor(.blue)
        .frame(height: 70)
    }
}
```
#### FloatingLabelTextFieldStyle

Just two step for create and add style to FloatingLabelTextField. 

1. Create your own theme style. Set property as per your theme.

```swift
struct ThemeTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content
            .spaceBetweenTitleText(15) // Sets the space between title and text.
            .textAlignment(.leading) // Sets the alignment for text.
            .lineHeight(1) // Sets the line height.
            .selectedLineHeight(1.5) // Sets the selected line height.
            .lineColor(.gray) // Sets the line color.
            .selectedLineColor(.blue) // Sets the selected line color.
            .titleColor(.gray) // Sets the title color.
            .selectedTitleColor(.blue) // Sets the selected title color.
            .titleFont(.system(size: 12)) // Sets the title font.
            .textColor(.black) // Sets the text color.
            .selectedTextColor(.blue) // Sets the selected text color.
            .textFont(.system(size: 15)) // Sets the text font.
            .placeholderColor(.gray) // Sets the placeholder color.
            .placeholderFont(.system(size: 15)) // Sets the placeholder font.
            .errorColor(.red) // Sets the error color.
            .addDisableEditingAction([.paste]) // Disable text field editing action. Like cut, copy, past, all etc.
            .enablePlaceholderOnFocus(true) // Enable the placeholder label when the textfield is focused.
            .allowsHitTesting(true) // Whether this view participates in hit test operations.
            .disabled(false) // Whether users can interact with this.
    }
}
```

2. Add style to FloatingLabelTextField.

```swift
struct ContentView: View {
    
    @State private var firstName: String = ""
    
    var body: some View {
        FloatingLabelTextField($firstName, placeholder: "First Name", editingChanged: { (isChanged) in
            
        }) {
            
        }
        .floatingStyle(ThemeTextFieldStyle())
        .frame(height: 70)
    }
}
```

### Secure Text Entry
To enable Secure Text Entry use .isSecureTextEntry(true) property. 

<p float="left">
    <img src="https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/blob/master/Graphics/secure_text_field.gif">

</p>

```swift
struct ContentView: View {
    
    @State private var password: String = ""
    
    var body: some View {
        HStack(spacing: 20) {
            FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in
                
            }) {
                
            }
            .isSecureTextEntry(true)
            .frame(height: 70)
        }
    }
}
```

### Left - Right View
Yes, you can easily add your own views, buttons or image to left view or right view of the FloatingLabelTextField.

<p float="left">
    <img src="https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/blob/master/Graphics/left-right-view.gif">

</p>

```swift
struct ContentView: View {
    
    @State private var password: String = ""
    @State private var isPasswordShow: Bool = false
    
    var body: some View {
        FloatingLabelTextField($password, placeholder: "Password", editingChanged: { (isChanged) in
            
        }) {
            
        }
        .isSecureTextEntry(!self.isPasswordShow)
            .leftView({ // Add left view.
                Image("password")
            })
            .rightView({ // Add right view.
                Button(action: {
                    withAnimation {
                        self.isPasswordShow.toggle()
                    }
                    
                }) {
                    Image(self.isPasswordShow ? "eye_close" : "eye_show")
                }
            })
            .frame(height: 70)
            .padding()
    }
}
```

### Error Message & Validation

FloatingLableTextFieldSwiftUI supports displaying an error and add text field validations. This can be helpfull for adding validation on your form text field. To enable isShowError property to true and pass text field validations array to text field with message according condition. You can also add validation checker variable to check is text field is valid or not on submit button action.

FloatingLabelTextFieldSwiftUI also have some inbuilt validation regex checker fields like email, password, name, number.. etc. 

Here is some example

1. Email Validation
<p float="left">
    <img src="https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/blob/master/Graphics/email_validation.gif">

</p>

```swift
struct ContentView: View {
    
    @State private var email: String = ""
    @State private var isValidEmail: Bool = false
    
    var body: some View {
        VStack {
            FloatingLabelTextField($email, validtionChecker: $isValidEmail, placeholder: "Email", editingChanged: { (isChanged) in
                
            }) {
                
            }
            .addValidation(.init(condition: email.isValid(.email), errorMessage: "Invalid Email")) /// Sets the validation condition.
                .isShowError(true) /// Sets the is show error message.
                .errorColor(.red) /// Sets the error color.
                .keyboardType(.emailAddress)
                .frame(height: 70)
                .padding()
            
            Button(action: {
                self.endEditing(true)
                
                if self.isValidEmail {
                    print("Valid Email")
                    
                } else {
                    print("Invalid Email")
                }
                
            }) {
                Text("Create")
            }
        }
    }
}
```


2. Name Validation
<p float="left">
    <img src="https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/blob/master/Graphics/name_validation.gif">

</p>

```swift
struct ContentView: View {
    
    @State private var lastName: String = ""
    
    var body: some View {
        FloatingLabelTextField($lastName, placeholder: "Last Name", editingChanged: { (isChanged) in
            
        }) {
            
        }
        .isShowError(true) /// Sets the is show error message.
        .addValidations([.init(condition: lastName.isValid(.alphabet), errorMessage: "Invalid Name"),
                         .init(condition: lastName.count >= 2, errorMessage: "Minimum two character long")
        ]) /// Sets the validation conditions.
            .floatingStyle(ThemeTextFieldStyle2())
            .frame(height: 70)
    }
}
```


## 🐾 Examples

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 💾 Installation

### CocoaPods:

FloatingLabelTextFieldSwiftUI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FloatingLabelTextFieldSwiftUI'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `FloatingLabelTextFieldSwiftUI` into your Xcode project using Xcode 11+, specify it in `File > Swift Packages > Add`:

```ogdl
https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI.git
```

### Manual

You can download the latest files from our [Releases page](https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/releases). After doing so, copy the files in the `Sources` folder to your project.


## 🙋🏻‍♂️ Author

kishanraja, rajakishanrk1996@gmail.com

## 💰 Contribution

Feel free to fork the project and send me a pull-request! 

## 📝 Feedback
Please file an [Issue](https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI/issues).

## 📜 License

FloatingLabelTextFieldSwiftUI is available under the MIT license. See the LICENSE file for more info.
