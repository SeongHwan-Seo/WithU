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
//    @State var isAnniversaryToggle = UserDefaults.standard.bool(forKey: "AnniversaryToggle")
    let url = URL(string: "https://glass-meteorite-16f.notion.site/669a3fa6661a4e3b9bd92173acb8ab37")!
    
    
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
                    Section(header: Text("앱").foregroundColor(.buttonBackground)){
                        
                        Toggle("지난 기념일 보기", isOn: $viewModel.isAnniversaryToggle)
                            .onChange(of: viewModel.isAnniversaryToggle) { value in
                                UserDefaults.standard.set(value, forKey: "AnniversaryToggle")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color.buttonBackground))
                            
                            
                        
                        Button(action: {
                            isShowingPopup.toggle()
                            
                        }, label: {
                            Text("데이터 삭제하기")
                                
                        })
                        
                        NavigationLink(destination: VersionInfoView(), label: {Text("버전 정보")})
                        
                    }
                    
                    Section(header: Text("일반").foregroundColor(.buttonBackground)){
                        Button(action: {
                            viewModel.goToStore()
                        }, label: {
                            Text("앱 평가")
                        })
                        NavigationLink(destination: OpenSourceView(), label: {
                            Text("오픈소스 라이선스")
                        })
                        Link("개인정보처리방침", destination: url)
                            
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .foregroundColor(Color.ForegroundColor)
                
            }
            .offset(y: 61)
            //.padding()
            
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
