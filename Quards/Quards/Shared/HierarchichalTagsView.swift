//
//  HierarchichalTagsView.swift
//  Quards
//
//  Created by Max Fest on 02.09.20.
//

import SwiftUI

struct NodeWrapper: View {
	let tagDeck: TagDeck
	var level: Int
	
	@State var isSelected = false
	
	var body: some View {
		VStack {
			HierarchyNode(title: tagDeck.name, level: level)
				.onTapGesture {
					isSelected.toggle()
				}
			
			if isSelected {
				ForEach(tagDeck.wrappedChildren, id: \.self) { child in
					HStack {
						Spacer().frame(width: 40)
						NodeWrapper(tagDeck: child, level: level + 1)
					}
				}
			}
		}
	}
}
