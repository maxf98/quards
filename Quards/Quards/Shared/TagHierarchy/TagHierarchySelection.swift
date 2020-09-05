//
//  TagHierarchySelection.swift
//  Quards
//
//  Created by Max Fest on 03.09.20.
//

import Foundation

class TagHierarchySelection: ObservableObject {
	@Published var selectedDecks = Set<TagDeck>()
	
	func exOrSelection(tagDeck: TagDeck) -> Bool {
		if selectedDecks.contains(tagDeck) {
			selectedDecks.remove(tagDeck)
			return false
		} else {
			selectedDecks.insert(tagDeck)
			return true
		}
	}
	
	func contains(_ tagDeck: TagDeck) -> Bool {
		return selectedDecks.contains(tagDeck)
	}
	
	func setSelected(tagDeck: TagDeck, isSelected: Bool) {
		if isSelected {
			selectedDecks.formUnion(allChildren(of: tagDeck))
		} else {
			selectedDecks.subtract(allChildren(of: tagDeck))
		}
	}
	
	func allChildren(of tagDeck: TagDeck) -> Set<TagDeck> {
		var all = Set<TagDeck>()
		all.insert(tagDeck)
		var queue = [tagDeck]
		while !queue.isEmpty {
			let node = queue.popLast()!
			all.formUnion(node.wrappedChildren)
			queue.append(contentsOf: node.wrappedChildren)
		}
		return all
	}
}
