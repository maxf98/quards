//
//  HierarchyRoot.swift
//  Quards
//
//  Created by Max Fest on 03.09.20.
//

import SwiftUI

struct TagHierarchy: View {
	@StateObject var tagHierarchySelection = TagHierarchySelection()
	@FetchRequest (entity: TagDeck.entity(), sortDescriptors: [
									NSSortDescriptor(keyPath: \TagDeck.createdAt, ascending: true)],
								 predicate: NSPredicate(format: "%K == nil", (\TagDeck.parent)._kvcKeyPathString!)) var roots: FetchedResults<TagDeck>
	
	@Binding var selectedDecks: Set<TagDeck>
	var onCommit: () -> Void
	
	var body: some View {
		VStack(alignment: .leading) {
			ForEach(roots, id: \.self) { child in
				NodeWrapper(tagDeck: child, level: 0).environmentObject(tagHierarchySelection)
			}
			
			HStack {
				Spacer()
				
				Button(action: {
					selectedDecks = tagHierarchySelection.selectedDecks
					tagHierarchySelection.selectedDecks = Set<TagDeck>()
					onCommit()
					
				}) {
					Image(systemName: "play.circle.fill")
						.resizable()
						.scaledToFit()
						.frame(width: 50, height: 50)
				}
				.disabled(tagHierarchySelection.selectedDecks.count == 0)
				
				Spacer()
			}
		}
	}
}
