//
//  HomeImageView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct HomeImageView: View {
    var body: some View {
        Image("background")
            .resizable()
            .aspectRatio(contentMode: .fit)
            
    }
}

struct HomeImageView_Previews: PreviewProvider {
    static var previews: some View {
        HomeImageView()
    }
}
