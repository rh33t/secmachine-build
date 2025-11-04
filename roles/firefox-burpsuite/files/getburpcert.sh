#!/bin/bash
burp=$(find /usr/share/burpsuite -name "burp*.jar" 2>/dev/null | head -1)
[[ -z "$burp" ]] && exit 1
timeout 45 /usr/share/burpsuite/jre/bin/java -Djava.awt.headless=true -jar "$burp" < <(echo y) &
sleep 30
curl -sf http://localhost:8080/cert -o /tmp/cacert.der || exit 1
kill %1 2>/dev/null