//
//  ProfileView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI


struct ProfileView: View {
    init() { //화면전체의 백그라운드 배경 색 변경
        UITableView.appearance().backgroundColor = .systemBackground
    }
    
    @State var showingPopup = false
    @State private var myNickName = ""
    
    
    
    var body: some View {
        ZStack {
            List {
                ForEach(ProfileMenu.allCases) {
                    section in
                    Section(
                        header: Text(section.title)
                    ) {
                        ForEach(section.profileMenu, id: \.hashValue) {
                            raw in
                            NavigationLink(raw, destination: {
                                
                            })
                            
//                            Text("\(raw)")
//                                .onTapGesture {
//                                    showingPopup.toggle()
//                                }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
           
            }
        }
        
        
        
        
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
