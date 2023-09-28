//
//  DetailView.swift
//  exc5
//
//  Created by Vitalii Zhukov on 9/28/23.
//

import SwiftUI


struct DetailView: View {
    var about: String
    var img_logo: URL
    
    var body: some View {
        VStack {
            Spacer()
            Text(about)
                .multilineTextAlignment(.center)
                .foregroundColor(CustomColor.LightBlue)
            Spacer()
            AsyncImage(url: img_logo) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 120, maxHeight: 120)
            } placeholder: {
                ProgressView()
            }
            Spacer()
        }
        .padding()
        .background(CustomColor.PinkBackground)
    }
}
