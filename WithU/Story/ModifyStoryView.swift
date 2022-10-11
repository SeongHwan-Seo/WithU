//
//  ModifyStoryView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/05.
//

import SwiftUI

struct ModifyStoryView: View {
    @Environment(\.presentationMode) var presentationMode
    let story: Story
    @State var text = ""
    @State var isShowingPicker = false
    @State var images: [UIImage]
    @State var isShowingCancelAlert = false // 화면에서 나갈 때
    @State var isTextEmpty = false
    @StateObject var viewModel: StoryViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack() {
                    Button(action: {
                        isShowingCancelAlert.toggle()
                    }, label: {
                        Text("닫기")
                            .font(.headline)
                            .foregroundColor(.ForegroundColor)
                            .alert(isPresented: $isShowingCancelAlert) {
                                Alert(title: Text("이 화면에서 나가시겠습니까?\n변경된 내용은 저장되지 않습니다."), message: nil, primaryButton: .destructive(Text("나가기"), action: {
                                    presentationMode.wrappedValue.dismiss()
                                }), secondaryButton: .cancel(Text("취소")))
                            }
                    })
                    
                    Spacer()
                    
                    Text("글 수정")
                        .font(.headline)
                        .foregroundColor(.ForegroundColor)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.modifyStory(story: Story(id: story.id, date: story.date, content: text, images: story.images, createDate: story.createDate), userId: UserDefaults.standard.string(forKey: "id")!)
                        
                        
                    }, label: {
                        Text("완료")
                            .font(.headline)
                            .foregroundColor(isTextEmpty ? Color.gray : .buttonBackground)
                    })
                    .disabled(isTextEmpty)
                }
                .padding([.top, .horizontal])
                
                Divider()
                
            }
            
            VStack {
                TextField("내용을 입력하세요.", text: $text)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .textFieldStyle(.plain)
                    .foregroundColor(.ForegroundColor)
                    .onChange(of: text) { text in
                        if text.isEmpty {
                            isTextEmpty = true
                        } else {
                            isTextEmpty = false
                        }
                        
                    }
                
                
                ScrollView(.horizontal){
                    HStack {
                        ForEach(0..<images.count, id: \.self) { index in
                            Image(uiImage: images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 170, height: 170)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
//                                .overlay(
//                                    Button(action: {
//                                        withAnimation(.default) {
//                                            removeImage(index: index)
//                                        }
//
//                                    }, label: {
//                                        if(images.count > 1) {
//                                            Image(systemName: "trash")
//                                                .resizable()
//                                                .frame(width: 20, height: 20)
//                                                .foregroundColor(.white)
//                                                .padding()
//                                                .background(Color.white.opacity(0.35))
//                                                .clipShape(Circle())
//                                        }
//                                    })
//                                    .padding(5)
//                                    ,alignment: .topLeading
//                                )
                            
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .onReceive(viewModel.didSendRequest) { _ in
            viewModel.loadStories(userId: UserDefaults.standard.string(forKey: "id")!)
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    
}

extension ModifyStoryView {
    fileprivate func removeImage(index: Int) {
        images.remove(at: index)
    }
}


