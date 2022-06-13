//
//  CustomActionSheetView.swift
//  WithU
//
//  Created by seosh on 6/12/22.
//

import SwiftUI

struct CustomActionSheetView: View {
    @Binding var isShowingPopupview: Bool
    @Binding var selectedImage: UIImage?
    @State var imagePickerPresented = false
    @State private var profileImage: Image?
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Button(action: {
                    imagePickerPresented.toggle()
                } ) {
                    Image(systemName: "person.crop.rectangle")
                    Text("앨범에서 선택하기")
                    
                }
                .sheet(isPresented: $imagePickerPresented,
                       onDismiss: loadImage,
                       content: { ImagePicker(image: $selectedImage) })
                .foregroundColor(Color.black)
                
                Spacer()
            }
            
            HStack {
                Button(action: {} ) {
                    Image(systemName: "camera")
                    Text("카메라로 찍기")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
            HStack {
                Button(action: {
                    isShowingPopupview.toggle()
                }) {
                    Image(systemName: "clear")
                    Text("취소")
                    
                }
                .foregroundColor(Color.black)
                Spacer()
            }
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 20)
            .background(Color.white)
            .cornerRadius(20)
        
    }
}


