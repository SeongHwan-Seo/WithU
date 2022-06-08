//
//  DdayCountView.swift
//  WithU
//
//  Created by seosh on 5/30/22.
//

import SwiftUI

struct DdayCountView: View {
    @Binding var dDay: Dday
    var body: some View {
        VStack {
            Text(dDay.message)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.black)
            Text(dDay.count)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundColor(.black)
        }
        .padding(.top, 30)
    }
}


