//
//  ContentView.swift
//  QRCodeScannerSwiftUI
//
//  Created by Shahriar Nasim Nafi on 9/12/21.
//  Copyright © 2021 Shahriar Nasim Nafi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var qrCodeText: String = ""
    
    var body: some View {
        ZStack {
            QRCodeScanner(qrCodeFrameColor: UIColor(Color.orange), qrCodeText: $qrCodeText)
            VStack {
                Spacer()
                Button {
                    
                    guard let url = URL(string: qrCodeText) else { return }
                    UIApplication.shared.open(url)
                    
                } label: {
                    Text(qrCodeText)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(nil)
                }

            }
            .padding(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
