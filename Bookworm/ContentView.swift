import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.rating)
    ]) var books: [Book]
    
    @State private var showingAddBookView = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating<2 ? .red : .white)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .navigationTitle("BookWorm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("ADD", systemImage: "plus") {
                        showingAddBookView.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddBookView) {
                AddBookView()
            }
        }
    }
    func deleteBook(for offSets: IndexSet) {
        for offSet in offSets {
            let book = books[offSet]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
