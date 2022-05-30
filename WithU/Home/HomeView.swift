//
//  HomeView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                EmptyImageView()
                CoupleImageView()
                DdayCountView()
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            
            
            
            
        }
        //.edgesIgnoringSafeArea(.all)
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
