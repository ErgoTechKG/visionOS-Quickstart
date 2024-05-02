//
//  VisionVideoCall.swift
//  Agora-Vision
//
//  Created by Max Cobb on 11/13/23.
//

import SwiftUI
import AgoraRtcKit

struct VisionVideoCall: View {

    var channel: String

    @ObservedObject private var agoraManager = AgoraManager(
        appId: "6c1fbe1e399c4aea9eeb6ba94c000779", role: .broadcaster
    )

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(agoraManager.allUsers), id: \.self) { uid in
                    AgoraVideoCanvasView(manager: agoraManager, canvasId: .userId(uid))
                        .frame(maxWidth: 400, maxHeight: 400)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
            }.padding(20)
        }.onAppear { agoraManager.joinChannel(channel) }
        .onDisappear { agoraManager.leaveChannel() }
    }

    private var columns: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 400))]

    public init(channel: String) { self.channel = channel }
}

//#Preview {
//    VisionVideoCall(channel: "test")
//}
