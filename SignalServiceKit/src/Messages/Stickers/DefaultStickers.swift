//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

import Foundation

class DefaultStickerPack {
    public let info: StickerPackInfo
    public let shouldAutoInstall: Bool

    private init?(packIdHex: String, packKeyHex: String, shouldAutoInstall: Bool) {
        guard let info = StickerPackInfo.parsePackIdHex(packIdHex, packKeyHex: packKeyHex) else {
            owsFailDebug("Invalid info")
            return nil
        }

        self.info = info
        self.shouldAutoInstall = shouldAutoInstall
    }

    private class func parseAll() -> [StickerPackInfo: DefaultStickerPack] {
        let packs = [
            // AIVAN
            DefaultStickerPack(packIdHex: "c476059cb15a7660fbbe075332fd8619", packKeyHex: "cc95ecfbe523643ec131c15b68b20be2bcacf25615f37027b5358c7982907310", shouldAutoInstall: true)!
            // SANTALINA
            DefaultStickerPack(packIdHex: "1c03b91dee7e8679203c3dbed97b440b", packKeyHex: "e5198b58f634fb255269eef2891d4859179be380cd42e048f77a3a9b7da42035", shouldAutoInstall: true)!
            // FELINA
            DefaultStickerPack(packIdHex: "c2aa13de9a36acdb3cef4de48c22e4e2", packKeyHex: "7c973ff3dd64832332e2fa1edf3555bdeb008b13bde73f52fc9e9e815430141c", shouldAutoInstall: true)!
        ]
        var result = [StickerPackInfo: DefaultStickerPack]()
        for pack in packs {
            result[pack.info] = pack
        }

        return result
    }

    private static let all = DefaultStickerPack.parseAll()

    static var packsToAutoInstall: [StickerPackInfo] {
        return all.values.filter {
            $0.shouldAutoInstall
            }.map {
                $0.info
        }
    }

    static var packsToNotAutoInstall: [StickerPackInfo] {
        return all.values.filter {
            !$0.shouldAutoInstall
            }.map {
                $0.info
        }
    }

    class func isDefaultStickerPack(stickerPackInfo: StickerPackInfo) -> Bool {
        return all[stickerPackInfo] != nil
    }
}
