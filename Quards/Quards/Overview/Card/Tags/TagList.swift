//
//  TagList.swift
//  Quards
//
//  Created by Max Fest on 19.08.20.
//

import SwiftUI

struct TagList: View {
	@EnvironmentObject var quardsModel: QuardsModel
	@Binding var tags: [String]

	var addTag: (String) -> Void
	var removeTag: (String) -> Void
	
	var body: some View {
		HStack(spacing: 5) {
			ForEach(tags, id: \.self) { tag in
				TagView(name: tag, removeTag: removeTag)
			}
			AddTagButton(saveTag: addTag)
				.padding(.leading, 10)
			Spacer()
		}
		.padding(.leading, 25)
	}
}

