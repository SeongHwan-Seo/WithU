//
//  AnniversaryView.swift
//  WithU
//
//  Created by seosh on 4/20/22.
//

import SwiftUI


struct AnniversaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AnniversaryViewModel()
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.backgroundColor
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .padding()
                            .foregroundColor(.ForegroundColor)
                    })
                    
                    Spacer()
                    
                    Text("기념일")
                        .font(.headline)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: {
                            CreateAnniversaryView(viewModel: viewModel)
                        },
                        label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .padding()
                                .foregroundColor(.ForegroundColor)
                        })
                    
                }
            }
            
            ScrollView {
                VStack {
                    ForEach(viewModel.anniversaries, id: \.id) { anniversary in
                        AnniversaryListView(anniversary: anniversary)
                    }
                    
                }
            }
            .offset(y: 50)
            
            //            List {
            //                ForEach(viewModel.anniversaries, id: \.id) { anniversary in
            //                    VStack {
            //                        AnniversaryListView(anniversary: anniversary)
            //                    }
            //
            //                }
            //            }
            
        }
        .onAppear {
            viewModel.loadAnniversaries(userId: UserDefaults.standard.string(forKey: "id") ?? "")
        }
        
        
    }
}

struct AnniversaryView_Previews: PreviewProvider {
    static var previews: some View {
        AnniversaryView()
    }
}
