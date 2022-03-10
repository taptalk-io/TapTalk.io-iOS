Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.name         = "TapTalk"
    s.version      = "1.5.0"
    s.summary      = "TapTalk.io is a complete in-app chat SDK and messaging API. TapTalk.io provides UI-based and code-based implementation & fully customizable."
    s.homepage     = "https://taptalk.io"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.authors = { 'TapTalk.io' => 'hello@taptalk.io' }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.platform     = :ios, "11.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.source       = { :git => 'https://github.com/taptalk-io/taptalk.io-ios.git', :tag => s.version }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.source_files  = "TapTalk", "TapTalk/*{h,m}", "TapTalk/**/*.{h,m}", "TapTalk/**/**/*.{h,m}"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    #s.resources = "TapTalk/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,ttf,otf}"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

   s.static_framework = true

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.dependency "AFNetworking", "~> 4.0.0"
    s.dependency "SocketRocket"
    s.dependency "JSONModel", "~> 1.1"
    s.dependency "Realm", "10.1.0"
    s.dependency "SDWebImage"
    s.dependency "PodAsset"
    s.dependency "GooglePlaces"
    s.dependency "GoogleMaps"
    s.dependency "ZSWTappableLabel", "~> 2.0"

    # ――― Prefix Header ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

    s.prefix_header_contents ='#import "Configs.h"', '#import "TAPStyle.h"', '#import "AFNetworkActivityIndicatorManager.h"', '#import "NSBundle+Language.h"', '#import "NSUserDefaults+MPSecureUserDefaults.h"', '#import "PodAsset.h"', '#import "TapTalk.h"', '#import "TapUI.h"', '#import "TAPUtil.h"', '#import "TapCoreChatRoomManager.h"', '#import "TapCoreContactManager.h"', '#import "TapCoreErrorManager.h"', '#import "TapCoreMessageManager.h"', '#import "TapCoreRoomListManager.h"', '#import "TAPChatManager.h"', '#import "TAPConnectionManager.h"', '#import "TAPContactManager.h"', '#import "TAPContactCacheManager.h"', '#import "TAPCustomBubbleManager.h"', '#import "TAPDataManager.h"', '#import "TAPDatabaseManager.h"', '#import "TAPEncryptorManager.h"', '#import "TAPFetchMediaManager.h"', '#import "TAPFileDownloadManager.h"', '#import "TAPFileUploadManager.h"', '#import "TAPLanguageManager.h"', '#import "TAPGroupManager.h"', '#import "TAPLocationManager.h"', '#import "TAPMessageStatusManager.h"', '#import "TAPNetworkManager.h"', '#import "TAPNotificationManager.h"', '#import "TAPOldDataManager.h"', '#import "TAPStyleManager.h"', '#import "TAPGrowingTextView.h"', '#import "TAPImageView.h"', '#import "TAPSearchBarView.h"', '#import "UIImage+Color.h"'

    # ――― Bundle ------―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    
    s.resource_bundles = {
        'TapTalk' => [
            'Pod/**/*.xib',
            'Pod/**/*.storyboard',
            'Pod/**/*.{png,jpeg,jpg,xcassets,ttf,otf,caf}',
            'TapTalk/**/*.xib',
            'TapTalk/**/*.storyboard',
            'TapTalk/**/*.{png,jpeg,jpg,xcassets,ttf,otf,caf}',
            'TapTalk/*.lproj/*.strings'
        ]
    }

    # ――― XCConfig ------―――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    #uncomment to disable bitcode
#    s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'DEBUG_INFORMATION_FORMAT' => 'dwarf' }
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
