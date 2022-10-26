//
//  OpenSourceView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/26.
//

import SwiftUI

struct OpenSourceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(OpenSourceViewModel.allCases, id: \.self) { option in
                    Text("* \(option.lib)")
                    Link("\(option.url)", destination: URL(string: option.url)!)
                }
            }
        }
    }
}

struct OpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceView()
    }
}
