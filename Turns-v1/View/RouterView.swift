//
//  MainView.swift
//  Turn
//
//  Created by dave on 08/07/24.
//

import Foundation
import SwiftUI

struct RouterView: View {
    @State private var router = Router()
    
    //@Environment(MPCInterface.self) var mpcInterface
    @Environment(ViewModel.self) var viewModel

    var body: some View {
        @Bindable var mpcInterface = viewModel.mpcInterface

        NavigationStack(path: $router.navigationPath) {
            EntryView()
                .environment(router)
                .environment(viewModel)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        case .entryView:
                            EntryView()
                                .environment(router)
                                .environment(viewModel)
                        case .startView:
                            StartView()
                                .environment(router)
                                .environment(viewModel)
                                .onAppear(perform: {
                                    viewModel.resetState()
                                    if(viewModel.mpcInterface.mpcSession != nil){
                                        if(viewModel.mpcInterface.isPaired()){
                                            viewModel.mpcInterface.disconnect()
                                        }
                                    }
                                })
                        case .pairView:
                            PairView()
                                .environment(router)
                                .environment(viewModel)
                                .onAppear(perform: {
                                    viewModel.resetState()
                                })
                                
                        case .platformView:
                            PlatformView()
                                .environment(router)
                                .environment(viewModel)
                    }
                }
        }
        .tint(.orange)
    }
}
