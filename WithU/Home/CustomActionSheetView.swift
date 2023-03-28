//
//  CustomActionSheetView.swift
//  WithU
//
//  Created by seosh on 6/12/22.
//

import SwiftUI

struct CustomActionSheetView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var isShowingPopupview: Bool
    @Binding var selectedImage: UIImage?
    @Binding var choice: Int //1 -> 내 프로필, 2 -> 파트너 프로필, 3 -> bgImage
    @State var imagePickerPresented = false
    @State private var profileImage: Image?
    func setImageString() {
        switch choice {
        case 1:
            if viewModel.selectedImage != nil {
                let imageString = (viewModel.user.id ?? "") + "myImage"
                viewModel.user.imageString = imageString
                viewModel.uploadImage(img: viewModel.selectedImage!, name: imageString)
            }
        case 2:
            if viewModel.uselectedImage != nil {
                let uImageString = (viewModel.user.id ?? "") + "uImage"
                viewModel.user.uimageString = uImageString
                viewModel.uploadImage(img: viewModel.uselectedImage!, name: uImageString)
            }
        case 3:
            if viewModel.bgSelectedImage != nil {
                let bgImageString = (viewModel.user.id ?? "") + "bgImage"
                viewModel.user.bgImageString = bgImageString
                viewModel.uploadImage(img: viewModel.bgSelectedImage!, name: bgImageString)
                
                viewModel.updateUser()
            }
        default:
            return
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Button(action: {
                    imagePickerPresented.toggle()
                    isShowingPopupview.toggle()
                } ) {
                    Image(systemName: "person.crop.rectangle")
                    Text("앨범에서 선택하기")
                    
                }
                .sheet(isPresented: $imagePickerPresented,
                       onDismiss: setImageString,
                       content: { ImagePicker(image: $selectedImage) })
                .foregroundColor(Color.ForegroundColor)
                
                Spacer()
            }
            
            HStack {
                Button(action: {
                    isShowingPopupview.toggle()
                }) {
                    Image(systemName: "clear")
                    Text("취소")
                    
                }
                .foregroundColor(Color.ForegroundColor)
                Spacer()
            }
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 20)
            .background(Color.popBackgroundColor)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        
    }
}


