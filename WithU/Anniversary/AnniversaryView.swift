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
        
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color.backgroundColor
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                VStack {
                    
                    HStack {
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.ForegroundColor)
                        })

                        Spacer()

                        Text("기념일")
                            .font(.headline)
                            .foregroundColor(.ForegroundColor)

                        Spacer()

                        NavigationLink(
                            destination: {
                                CreateAnniversaryView(viewModel: viewModel)
                            },
                            label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.ForegroundColor)
                            })

                    }
                    .padding()

                    Divider()
                }
            


            }


            VStack {
                AnniversaryListView(viewModel: viewModel)
                    
            }
            

            .offset(y: 61)
            .padding(.bottom, 20)


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
