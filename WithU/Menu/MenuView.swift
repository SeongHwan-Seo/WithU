//
//  MenuView.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import SwiftUI

struct MenuView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 225/255, green: 218/255, blue: 244/255), Color(red: 196/255, green: 203/255, blue: 242/255)]), startPoint: .top, endPoint: .bottom) 
                .ignoresSafeArea()
            
            VStack {
                MenuHeadView(isShowing: $isShowing)
                    .frame(height: 200)
                
                ForEach(MenuViewModel.allCases, id: \.self) { option in
                    NavigationLink(
                        destination: chooseDefinition(index: option.rawValue),
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
    case 0: ProfileView()
    case 1: AnniversaryView()
    case 2: StoryView()
    case 3: SettingView()
    
    default:ProfileView()
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isShowing: .constant(true))
    }
}
