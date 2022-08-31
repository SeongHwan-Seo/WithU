//
//  CreateStoryView.swift
//  WithU
//
//  Created by SHSEO on 2022/08/30.
//

import SwiftUI

struct CreateStoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
                        
                        
                    }, label: {
                        Text("저장")
                            .font(.headline)
                            .foregroundColor(.buttonBackground)
                    })
                }
                .padding()
                
                Divider()
                
                StoryBodyView()
                    .padding()
            }
            
        }
    }
}

struct selectedImage: Identifiable {
    var id = UUID().uuidString
    var image: Image
}

struct StoryBodyView: View {
    @State var text = ""
    @State var selectedImages = [selectedImage]()
    var body: some View {
        VStack {
            TextField("내용을 입력하세요.", text: $text)
                .font(.system(size: 14))
                .textFieldStyle(.plain)
                .foregroundColor(.ForegroundColor)
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("사진 추가")
                            .foregroundColor(.buttonBackground)
                    })
                    
                    Spacer()
                }
            }
            .padding(.top, 30)
            
            if selectedImages.count != 0 {
                HStack {
                    ForEach(selectedImages) { selectedImage in
                        
                        
                    }
                }
            }
            
        }
    }
}

struct CreateStoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateStoryView()
    }
}
