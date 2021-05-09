//
//  CircleImage.swift
//  Landmarks
//
//  Created by Le Tien Tai on 9/5/21.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("dark").frame(maxWidth: 400, maxHeight: 400)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
