#!/bin/bash -

if pidof firefox &> /dev/null; then
    echo "ABORTING: firefox is running, so any changes would be overwritten when it quites" >&2
    exit 1
fi

files=( ~/.mozilla/firefox/*/prefs.js )
case ${#files[@]} in
    0)
        echo "ABORTING: missing, or corrupt, profile" >&2
        exit 1
        ;;
    1)
        file=${files[0]}
        ;;
    *)
        PS3="file?"
        select file in "${files[@]}"; do
            [ "$file" ] && break;
        done
        ;;
esac

searchEngine="DuckDuckGo"

cat >> "$file" <<EOF
user_pref("browser.backspace_action", 0);
user_pref("browser.download.dir", "/home/johs/download");
user_pref("browser.download.useDownloadDir", true);
user_pref("browser.download.folderList", 2);
user_pref("browser.fixup.alternate.enabled", false);
user_pref("browser.feeds.handler.default", "web");
user_pref("browser.fullscreen.animateUp", 0);
user_pref("browser.link.open_newwindow.restriction", 0);
user_pref("browser.panorama.animate_zoom", false);
user_pref("browser.newtab.url", "about:blank");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.pocket.api", "localhost");
user_pref("browser.pocket.enable", false;
user_pref("browser.pocket.site", "localhost");
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.search.defaultenginename", "$searchEngine");
user_pref("browser.search.defaultenginename.US", "$searchEngine");
user_pref("browser.search.log", false);
user_pref("browser.search.isUS", false);
user_pref("browser.search.order.1", "$searchEngine");
user_pref("browser.search.order.2", "$searchEngine");
user_pref("browser.search.order.3", "$searchEngine");
user_pref("browser.search.order.1.US", "$searchEngine");
user_pref("browser.search.order.2.US", "$searchEngine");
user_pref("browser.search.order.3.US", "$searchEngine");
user_pref("browser.search.showOneOffButtons", false);
user_pref("browser.search.update.log", 0);
user_pref("browser.startup.homepage", "http://www.smallsoft.com/johs");
user_pref("browser.startup.page", 3);
user_pref("browser.tabs.animate", false);
user_pref("browser.tabs.closeButtons", 1);
user_pref("browser.tabs.tabClipWidth", 32);
user_pref("browser.tabs.tabMinWidth", 32);
user_pref("browser.tabs.tabMaxWidth", 32);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.urlbar.delay", 0);
user_pref("browser.urlbar.clickSelectsAll", false);
user_pref("browser.urlbar.doubleClickSelectsAll", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.zoom.full", true);
user_pref("browser.zoom.siteSpecific", false);
user_pref("dom.disable_window_move_resize", true);
user_pref("font.name.serif.x-western", "sans-serif");
user_pref("full-screen-api.exit-on-deactivate", false);
user_pref("general.warnOnAboutConfig", false);
user_pref("intl.charset.default", "UTF-8");
user_pref("pdfjs.disabled", true);
user_pref("plugin.disable_full_page_plugin_for_types", "application/pdf");
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("security.dialog_enable_delay", 0);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("security.tls.version.min", 1);
user_pref("signon.rememberSignons", false);
user_pref("view_source.editor.args", "-e nvim");
user_pref("view_source.editor.external", true);
user_pref("view_source.editor.path", "/usr/bin/xterm");
EOF
