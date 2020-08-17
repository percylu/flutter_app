package com.example.flutter_app;;

public enum LinkingProgress {

    SCAN_AP,
    CONNECT_AP,
    CONFIG_AP,
    /**
     * @deprecated the progress 'RESTART_AP' will be not invoked by {@link OnLinkListener#onProgress(LinkingProgress)}
     */
    RESTART_AP,
    CONNECT_ORIGINAL_AP,
    FIND_DEVICE
}
