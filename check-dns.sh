#!/usr/bin/env bash
# Print the records that matter for searchlightsystems.com from GoDaddy's
# authoritative server. Compare the email section with dns-baseline-2026-10-27.txt.
NS=${NS:-ns71.domaincontrol.com}
q() { echo "== $1 $2"; dig +short "$1" "$2" @"$NS" | sort; echo; }
echo "# Website"
q A searchlightsystems.com
q AAAA searchlightsystems.com
q CNAME www.searchlightsystems.com
echo "# Email (must not change)"
q MX searchlightsystems.com
q TXT searchlightsystems.com
q TXT dc-aa8e722993._spfm.searchlightsystems.com
q TXT google._domainkey.searchlightsystems.com
q TXT _dmarc.searchlightsystems.com
q NS searchlightsystems.com
