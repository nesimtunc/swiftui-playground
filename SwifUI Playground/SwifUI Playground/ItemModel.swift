import Foundation

class ItemModel<T>: NSObject, ObservableObject {
    var items: [T]
    let showMoreText: String
    let showLessText: String
    let visibleItemsCount: Int
    
    @Published var visibleItems: [T] = []
    @Published var showAll: Bool = false
    @Published var toggleText: String = ""
    
    init(
        items: [T],
        showMoreText: String,
        showLessText: String,
        visibleItemsCount: Int,
        showAll: Bool = false
    ) {
        self.items = items
        self.showMoreText = showMoreText
        self.showLessText = showLessText
        self.visibleItemsCount = visibleItemsCount
        self.showAll = showAll
        visibleItems = showAll ? items : Array(items.prefix(visibleItemsCount))
        toggleText =  showAll ? showLessText : showMoreText
    }
    
    func toggle() {
        showAll.toggle()
        update()
    }
    
    private func update() {
        visibleItems = showAll ? items : Array(items.prefix(visibleItemsCount))
        toggleText = showAll ? showLessText : showMoreText
    }
}
