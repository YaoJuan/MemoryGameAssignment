//
//  EmojiMemoryContentView.swift
//  Memories
//
//  Created by 赵思 on 2020/9/22.
//

import SwiftUI
import CoreData

struct EmojiMemoryContentView: View {
    @ObservedObject var emojiMemoryGame = EmojiMemoryGame()
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        
        Grid(emojiMemoryGame.cards) { card  in
            SingleCard(card: card).onTapGesture {
                emojiMemoryGame.choose(card: card)
            }.padding(5)
        }
        .foregroundColor(.orange)
        .padding()
        

//        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct SingleCard: View {
    
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader(content: { geometry in
            body(for: geometry.size)
        })

    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if !card.isMatched || card.isFaceUp {
            ZStack {
               Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90), closeWise: true).padding(5).opacity(0.4)
               Text(card.content)
            }.clarify(isFaceUp: card.isFaceUp).font(Font.system(size: Self.fontSize(size: size)))
        }
    }
    
    static let fontScaleFactor: CGFloat = 0.75
    static func fontSize(size:CGSize) -> CGFloat {
        let minFloat = min(size.width, size.height)
        return minFloat * Self.fontScaleFactor
    }
}
