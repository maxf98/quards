//
//  HierarchyNode.swift
//  Quards
//
//  Created by Max Fest on 03.09.20.
//

import SwiftUI

struct HierarchyNode: View {
	let tagDeck: TagDeck
	let level: Int
	@Binding var isSelected: Bool
	
	var body: some View {
		Text(tagDeck.name)
			.font(Font.title3)
			.foregroundColor(isSelected ? Color(tagDeck.secondaryColor) : .black)
			.padding([.leading, .trailing], 7)
			.padding([.top, .bottom], 3)
			.background(RoundedRectangle(cornerRadius: 7)
										.foregroundColor(isSelected ? Color(tagDeck.wrappedColor) :
																			Color(white: 0.9 - Double(level) * 0.12, opacity: 1))
										.animation(nil))
		
	}
}

/*
struct HierarchyNode_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			HierarchyNode(title: "helllo", level: 0)
			HierarchyNode(title: "how it be", level: 1)
			HierarchyNode(title: "helllo", level: 2)
			HierarchyNode(title: "helllo", level: 3)

		}
	}
}
*/
