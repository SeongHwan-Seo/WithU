//
//  DdayCountView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct DdayCountView: View {
    var body: some View {
        VStack {
            Text("With U")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Text("1800일")
                .font(.system(size: 26, weight: .bold, design: .rounded))
        }
        .padding(.top, 30)
    }
}

struct DdayCountView_Previews: PreviewProvider {
    static var previews: some View {
        DdayCountView()
    }
}
