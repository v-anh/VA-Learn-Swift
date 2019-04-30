////
////  AppDelegateExtensions.swift
////  STRServiceExample
////
////  Created by Ngo Chi Hai on 3/21/19.
////
//import OHHTTPStubs
//
//extension AppDelegate {
//    func setupOHHTTPStubForRunDemo() {
//        setupOHHTTPStubForListCharacters()
//        setupOHHTTPStubForShowCharacter()
//    }
//    
//    func setupOHHTTPStubForListCharacters() {
//        stub(condition: isPath("/listCharacters") ) { _ in
//            return OHHTTPStubsResponse(
//                jsonObject: [
//                    "characters": [
//                        [
//                            "name": "Barbarian",
//                            "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
//                        ],[
//                            "name": "Witch Doctor",
//                            "description": "Deemed the successor of the Necromancer. The Witch Doctor uses death, disease, curses and undead minions to swarm his would be opponents and drain their health and inflict impeding statuses on them."
//                        ],[
//                            "name": "Wizard",
//                            "description": "Manipulating the primal forces of the storm, arcane and even time itself, the Wizard is not afraid to destroy all in the path to victory. Successor of the Sorceress and Sorcerer."
//                        ],[
//                            "name": "Monk",
//                            "description": "A religious warrior of the light, they are masters of the martial arts and speed."
//                        ],[
//                            "name": "Demon Hunter",
//                            "description": "A stealthy warrior, specializes in crossbows and launching explosives with a focus mainly on ranged combat."
//                        ],[
//                            "name": "Crusader",
//                            "description": "A middle-ranged melee class with a combat style centered around shields, flails, and spells (introduced in Reaper of Souls)"
//                        ],[
//                            "name": "Necromancer",
//                            "description": "A re-imagining of the class from Diablo II, available with the Rise of the Necromancer pack."
//                        ]
//                    ]
//                ],
//                statusCode: 200,
//                headers: [ "Content-Type": "application/json" ]
//            )
//        }
//    }
//    
//    func setupOHHTTPStubForShowCharacter() {
//        stub(condition: isPath("/character") ) { _ in
//            return OHHTTPStubsResponse(
//                jsonObject: [
//                    "name": "Barbarian",
//                    "description": "Brute force makes a successful return, the Barbarian devastates foes with mighty power."
//                ],
//                statusCode: 200,
//                headers: [ "Content-Type": "application/json" ]
//            )
//        }
//    }
//}
