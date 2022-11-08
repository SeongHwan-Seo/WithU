//
//  VersionInfoView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/26.
//

import SwiftUI

struct VersionInfoView: View {
    @StateObject var viewModel = SettingViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.top)
                .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                    
                    if(value.startLocation.x < 20 && value.translation.width > 100) {
                        self.mode.wrappedValue.dismiss()
                    }
                    
                }))
            
            
            VStack{
                HStack {
                    Text("현재버전")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.ForegroundColor)
                    
                    Text("v \(viewModel.getCurrentVersion())")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.ForegroundColor)
                        .padding(.trailing, 20)
                    
                    
                    
                    Text("최신버전")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.ForegroundColor)
                                    Text("v \(viewModel.getUpdatedVersion())")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        .foregroundColor(.ForegroundColor)
                    
                }
                
                
                Button(action: {
                    viewModel.goToStore()
                }, label: {
                    Text("업데이트")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: 200, height: 70)
                        .background(Color.buttonBackground)
                        .foregroundColor(Color.buttonForeground)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                })
                .padding(.top, 50)
                
                
                
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    self.mode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                })
                
                
                
            }
        }
        
        
        
        
        
    }
    
}



struct VersionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VersionInfoView()
    }
}
