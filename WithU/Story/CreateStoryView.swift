//
//  CreateStoryView.swift
//  WithU
//
//  Created by SHSEO on 2022/08/30.
//

import SwiftUI
import PhotosUI

struct CreateStoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var selectedImages: [UIImage] = []
    @State var selectedImageStrings = [String]()
    @State var text = ""
    let storyID = UUID().uuidString
    @StateObject var viewModel = StoryViewModel()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.backgroundColor
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            VStack{
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("취소")
                            .font(.headline)
                            .foregroundColor(.ForegroundColor)
                    })
                    
                    Spacer()
                    
                    Text("스토리 등록")
                        .font(.headline)
                        .foregroundColor(.ForegroundColor)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.createStory(story: Story(id: storyID, date: Date().toString()!, content: text, images: selectedImageStrings), userId: UserDefaults.standard.string(forKey: "id")!)
                        viewModel.uploadStoryImage(img: selectedImages, imgName: selectedImageStrings, userId: UserDefaults.standard.string(forKey: "id")!, storyId: storyID)
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("저장")
                            .font(.headline)
                            .foregroundColor(.buttonBackground)
                    })
                }
                .padding()
                
                Divider()
                
                StoryBodyView(text: $text, selectedImages: $selectedImages,selectedImageStrings: $selectedImageStrings, viewModel: viewModel)
                    .padding()
            }
            
        }
    }
}



struct StoryBodyView: View {
    @Binding var text: String
    @Binding var selectedImages: [UIImage]
    @Binding var selectedImageStrings: [String]
    @StateObject var viewModel: StoryViewModel
    var config: PHPickerConfiguration  {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images //videos, livePhotos...
        config.selectionLimit = 0 //0 => any, set 1-2-3 for har limit
        return config
    }
    @State var isShowingPicker = false
    
    
    var body: some View {
        VStack {
            TextField("내용을 입력하세요.", text: $text)
                .font(.system(size: 14))
                .textFieldStyle(.plain)
                .foregroundColor(.ForegroundColor)
            
            VStack {
                HStack {
                    Button(action: {
                        isShowingPicker.toggle()
                    }, label: {
                        Text("사진 추가")
                            .foregroundColor(.buttonBackground)
                    })
                    
                    Spacer()
                }
            }
            .padding(.top, 30)
            
            if selectedImages.count != 0 {
                ScrollView(.horizontal){
                    HStack {
                        ForEach(selectedImages, id: \.self) { selectedImage in
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                        }
                    }
                }
                
            }
            
        }
        .sheet(isPresented: $isShowingPicker) {
            PhotoPicker(configuration: config, pickerResult: $selectedImages, selectedImageStrings: $selectedImageStrings, isShowingPicker: $isShowingPicker)
        }
    }
}

struct CreateStoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateStoryView()
    }
}
