//
//  MenuView.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isShowingMenuView: Bool
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.popBackgroundColor
                    .ignoresSafeArea()
            } else {
                LinearGradient(gradient: Gradient(colors: [Color(red: 225/255, green: 218/255, blue: 244/255), Color(red: 196/255, green: 203/255, blue: 242/255)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }
            
            
            VStack {
                MenuHeadView(isShowingMenuView: $isShowingMenuView)
                    .frame(height: 100)
                
                ForEach(MenuViewModel.allCases, id: \.self) { option in
                    NavigationLink(
                        destination: chooseDefinition(index: option.rawValue)
                            //.navigationBarBackButtonHidden(true)
                        ,
                        label: {MenuOptionView(viewModel: option)})
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
}

@ViewBuilder
func chooseDefinition(index: Int) -> some View {
    switch index {
    case 0: AnniversaryView()
    case 1: StoryView()
    case 2: SettingView()
    
    default:ProfileView()
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isShowingMenuView: .constant(true))
    }
}
