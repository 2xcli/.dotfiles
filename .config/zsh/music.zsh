music() {
    local url

    url=$(
        ytfzf -c yt -L --type=video "$*" |
        grep -E '^https?://' |
        tail -n 1
    )

    [[ -n "$url" ]] || {
        echo "Не удалось получить ссылку"
        return 1
    }

    rm -f /tmp/cmus-now.{mp3,m4a,webm,opus}

    yt-dlp --no-playlist -x --audio-format mp3 \
        -o '/tmp/cmus-now.%(ext)s' "$url" &&
        cmus-remote -f /tmp/cmus-now.mp3
}
