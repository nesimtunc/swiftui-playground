import SwiftUI

struct ContentView: View {
    private var col = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    private let visibleItemsCount = 4
    private let spacing: CGFloat = 16.0
    
    @ObservedObject private var model: ItemModel<Int>
    
    init() {
        var newItems = [Int]()
        for i in 0..<10 {
            newItems.append(i)
        }
        self.model = ItemModel(items: newItems,
                               showMoreText: "Show More",
                               showLessText: "Show Less",
                               visibleItemsCount: visibleItemsCount)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: col , alignment: .center, spacing: spacing) {
                ForEach(model.visibleItems, id: \.self) { i in
                    Text("\(i)")
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .font(.title)
                        .foregroundColor(Color.white)
                        .background(Rectangle().fill(Color.orange))
                }
            }
            Button {
                withAnimation {
                    model.toggle()
                }
            } label: {
                Text(model.toggleText)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Capsule().strokeBorder(Color.secondary, lineWidth: 1.5))
            }
            // This is on for demonstartion purpose, using same data but with whole
            LazyVGrid(columns: col , alignment: .center, spacing: spacing) {
                ForEach(model.items, id: \.self) { i in
                    Text("\(i)")
                        .frame(width: 100, height: 100, alignment: .center)
                        .font(.title)
                        .foregroundColor(Color.white)
                        .background(Rectangle().fill(Color.blue))
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.sizeCategory, .small)
                .previewDevice("iPhone 13 Pro Max")
                .previewLayout(.device)
        }
    }
}
