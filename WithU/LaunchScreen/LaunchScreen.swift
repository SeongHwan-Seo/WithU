//
//  LaunchScreen.swift
//  WithU
//
//  Created by seosh on 4/14/22.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 225/255, green: 218/255, blue: 244/255), Color(red: 196/255, green: 203/255, blue: 242/255)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Text("With")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("U")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        
                }
                
            }
        }
        
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
