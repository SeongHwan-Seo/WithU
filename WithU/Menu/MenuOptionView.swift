//
//  MenuOptionView.swift
//  WithU
//
//  Created by seosh on 4/13/22.
//

import SwiftUI

struct MenuOptionView: View {
    let viewModel: MenuViewModel
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .resizable()
                .frame(width: 26, height: 26)
            
            Text(viewModel.title)
                .font(.system(size: 18, weight: .semibold))
            
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct MenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        MenuOptionView(viewModel: .setting)
    }
}
