//
//  SettingView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = SettingViewModel()
    @State var isShowingPopup = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color.backgroundColor
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.ForegroundColor)
                        })
                        
                        Spacer()
                        
                        Text("설정")
                            .font(.headline)
                            .foregroundColor(.ForegroundColor)
                            .padding(.trailing, 15)
                        
                        Spacer()
                        
                        
                        
                    }
                    .padding()
                    
                    Divider()
                }
                
                
            }
            
            
            VStack {
                List{
                    Section(header: Text("앱 설정").foregroundColor(.buttonBackground)){
                        
                        Button(action: {
                            isShowingPopup.toggle()
                            
                        }, label: {
                            Text("데이터 삭제하기")
                        })
                        
                    }
                    
                    Section(header: Text("일반").foregroundColor(.buttonBackground)){
                        NavigationLink(destination: Text("dd"), label: {
                            Text("공지사항")
                        })
                        NavigationLink(destination: Text("dd"), label: {
                            Text("앱 평가")
                        })
                        NavigationLink(destination: Text("dd"), label: {
                            Text("개인 정보 처리 방침")
                        })
                        NavigationLink(destination: Text("dd"), label: {
                            Text("오픈소스 라이선스")
                        })
                    }
                }
                .listStyle(.plain)
            }
            .offset(y: 61)
            .padding(.bottom, 20)
        }
        .overlay(
            ZStack{
                if isShowingPopup {
                    GeometryReader { geometry in
                        DeletePopupView(viewModel: viewModel, isShowingPopup: $isShowingPopup)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    .background(
                        Color.black.opacity(0.65)
                            .edgesIgnoringSafeArea(.all)
                    )
                    
                }
            }
        )
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
