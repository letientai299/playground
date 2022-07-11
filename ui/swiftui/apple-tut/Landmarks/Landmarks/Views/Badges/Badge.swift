import SwiftUI

struct Badge: View {
    var symbols: some View {
        ForEach(0..<8) { i in
            RotatedBadgeSymbol(angle: Angle(degrees: Double(i*360/8)))
        }
        .opacity(0.5)
    }

    var body: some View {
        ZStack {
            BadgeBackground()
            GeometryReader { g in
                symbols
                    .scaleEffect(1.0/4.0, anchor: .top)
                    .position(x: g.size.width/2.0, y: 3.0/4.0 * g.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
