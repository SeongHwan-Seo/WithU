//
//  AnniversaryView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI
import ExytePopupView

struct AnniversaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showingPopup = false
    @State var title = ""
    
    func createPopup() -> some View {
        
        ZStack(alignment: .center) {
            Color(.white)
                .frame(width: 250, height: 290)
                .cornerRadius(25)
            VStack(alignment: .center) {
                TextField("제목", text: $title)
                    .frame(width: 210)
                    .padding(.top, 20)
                Divider()
                    .frame(width: 160,height: 1)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
                Text("날짜")
                    .frame(width: 210)
                    .padding(.top, 30)
                Divider()
                    .frame(width: 160,height: 1)
                    .padding(.horizontal, 30)
                    .background(Color.gray)
                
                Button(action: {
                    showingPopup.toggle()
                }, label: {
                    Text("저장")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(width: 130, height: 50)
                        .foregroundColor(Color.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 225/255, green: 218/255, blue: 244/255), Color(red: 196/255, green: 203/255, blue: 242/255)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(30)
                }).padding(.top, 35)
                
                
            }
        }
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                LinearGradient(gradient: Gradient(colors: [Color(red: 225/255, green: 218/255, blue: 244/255), Color(red: 196/255, green: 203/255, blue: 242/255)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .padding()
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                    Button(action: {
                        showingPopup.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .padding()
                            .foregroundColor(.white)
                    })
                }
            }
        }
        .popup(isPresented: $showingPopup, type: .default, closeOnTap: false, closeOnTapOutside: true) {
            self.createPopup()
        }
        
    }
}

struct AnniversaryView_Previews: PreviewProvider {
    static var previews: some View {
        AnniversaryView()
    }
}
