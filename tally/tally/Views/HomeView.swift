import SwiftUI

struct HomeView: View {

    let child: Child

    var body: some View {
        VStack(spacing: 16) {

            Text("积点")
                .font(.headline)

            Text(child.name)
                .font(.largeTitle)
        }
        .padding(24)
    }
}
