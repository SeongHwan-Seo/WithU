//
//  ModifyStoryView.swift
//  WithU
//
//  Created by SHSEO on 2022/10/05.
//

import SwiftUI
import Kingfisher

struct ModifyStoryView: View {
    @Environment(\.presentationMode) var presentationMode
    let story: StoryModifyParam
    @State var text: String
    @State var isShowingCancelAlert = false
    @State var isTextEmpty = false
    @StateObject var viewModel: StoryViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isShowingCancelAlert.toggle()
                }) {
                    Text("닫기")
                        .font(.headline)
                        .foregroundColor(.ForegroundColor)
                }
                Spacer()
                Text("글 수정")
                    .font(.headline)
                    .foregroundColor(.ForegroundColor)
                Spacer()
                Button(action: {
                    viewModel.modifyStory(storyId: story.id, storyContent: text, userId: UserDefaults.standard.string(forKey: "id")!)
                }) {
                    Text("완료")
                        .font(.headline)
                        .foregroundColor(isTextEmpty ? .gray : .buttonBackground)
                }
                .disabled(isTextEmpty)
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            VStack(spacing: 20) {
                TextField("내용을 입력하세요.", text: $text)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .textFieldStyle(.plain)
                    .foregroundColor(.ForegroundColor)
                    .onChange(of: text) { text in
                        isTextEmpty = text.isEmpty
                    }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(story.url, id: \.self) { url in
                            KFImage(url)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 170, height: 170)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .alert(isPresented: $isShowingCancelAlert) {
            Alert(
                title: Text("이 화면에서 나가시겠습니까?\n변경된 내용은 저장되지 않습니다."),
                primaryButton: .destructive(Text("나가기"), action: {
                    presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .onReceive(viewModel.didSendRequest) { _ in
            viewModel.loadStories(userId: UserDefaults.standard.string(forKey: "id")!)
            presentationMode.wrappedValue.dismiss()
        }
    }
}


