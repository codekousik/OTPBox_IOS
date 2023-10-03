//
//  OtpView.swift
//  OTPDemo
//
//  Created by Kousik Das on 03/10/23.
//

import SwiftUI

struct OtpView: View {
    @State var otpText: String = ""
    @FocusState private var isKeyBoardShowing : Bool
    
    var body: some View {
        VStack {
            Text("Verify OTP")
                .font(.largeTitle.bold())
                //.frame(minWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 0){
                ForEach(0..<4 ,id: \.self){index in
                    OtpTextBox(index)
                }
            }
            .background(content:{
                TextField("", text: $otpText)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    ///- Hiding it out
                    .frame(width: 1, height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyBoardShowing)
            })
            .contentShape(Rectangle())
            /// - Open keyboard when Tapped
            .onTapGesture {
                isKeyBoardShowing.toggle()
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
           
            Button {
                
            }label: {
                Text("Verify")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(.blue)
                    }
            }
            .disableWithOpacity(otpText.count < 4)
        }
        .padding(.all)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    //MARK: OTP Text Box
    @ViewBuilder
    func OtpTextBox(_ index: Int) -> some View {
        ZStack{
            if otpText.count > index{
                
                //Finding charater in index
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            }else{
                Text(" ")
            }
            
        }
        .frame(width: 45, height: 45)
        .background{
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(.gray, lineWidth: 0.5)
        }
        .frame(maxWidth:.infinity)
    }
}
//MARK: View Extension
extension View{
    func disableWithOpacity(_ condition: Bool) -> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1.0)
    }
}
//MARK: BInding <String> Extension
extension Binding where Value == String{
    func limit(_ lenth: Int) -> Self{
        if self.wrappedValue.count > lenth{
            DispatchQueue.main.async {
                self.wrappedValue = String(wrappedValue.prefix(lenth))
            }
        }
        return self
    }
}

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView()
    }
}

