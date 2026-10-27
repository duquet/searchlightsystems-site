# Putting www.searchlightsystems.com live

Nothing here has been done yet. Every step below is for Andrew to do himself,
or to tell Claude to do, after he has said go.

## Recommendation: GitHub Pages (free), DNS stays at GoDaddy

| | GitHub Pages | Cloudflare Pages | GoDaddy Website Builder |
|---|---|---|---|
| Cost | Free | Free | Monthly fee |
| HTTPS | Automatic, free certificate, auto-renewed | Automatic | Included on paid plans |
| Works with DNS at GoDaddy, apex included | Yes, with 4 A records | `www` yes; the apex needs the domain's nameservers moved to Cloudflare | Yes |
| Uses this site as written | Yes, push the folder | Yes | No, rebuild it in their editor |
| Account | You already have one (`duquet`) | New signup | Existing |

Why GitHub Pages: it is free, HTTPS is automatic, the apex domain works
without moving DNS away from GoDaddy (Cloudflare Pages needs that for the
apex), and the site stays a plain folder of files you own and can move
anywhere. GoDaddy Website Builder costs money every month and locks the site
into its editor, and its current "WebsiteBuilder Site" records are what is
serving the broken page today.

One thing to know: on a free GitHub account, Pages needs a **public**
repository. The site is public anyway, and the repo holds only these files,
no `.env`, database or candidate data.

## Step 1. Publish the site on GitHub (done 2026-10-27)

- Public repo: https://github.com/duquet/searchlightsystems-site
- Pages serves `main` at https://duquet.github.io/searchlightsystems-site/
- The custom domain is NOT set yet, on purpose: setting it now would redirect
  the github.io preview to www.searchlightsystems.com, which doesn't work
  until the DNS change. It is set in Step 3.
- Optional but recommended, any time: GitHub profile Settings > Pages >
  "Add a domain" to verify `searchlightsystems.com`. GitHub shows one NEW TXT
  record named `_github-pages-challenge-duquet` to add at GoDaddy. Adding it
  does not change any existing TXT record.

## Step 2. DNS changes at GoDaddy (Andrew makes these)

GoDaddy > My Products > searchlightsystems.com > DNS > DNS Records.

**Delete only these three records:**

| Type | Name | Value | Note |
|---|---|---|---|
| A | @ | 76.223.105.230 | "WebsiteBuilder Site" |
| A | @ | 13.248.243.5 | "WebsiteBuilder Site" |
| CNAME | www | @ (searchlightsystems.com) | |

If GoDaddy refuses to delete the Website Builder A records, go to the Website
Builder product and unpublish or disconnect the domain there first, then come
back. If a "Forwarding" rule is set for the domain (DNS page, Forwarding
section), remove it too.

**Add these records:**

| Type | Name | Value | TTL |
|---|---|---|---|
| A | @ | 185.199.108.153 | 1 hour |
| A | @ | 185.199.109.153 | 1 hour |
| A | @ | 185.199.110.153 | 1 hour |
| A | @ | 185.199.111.153 | 1 hour |
| CNAME | www | duquet.github.io | 1 hour |

Optional IPv6 (fine to skip): AAAA `@` to 2606:50c0:8000::153,
2606:50c0:8001::153, 2606:50c0:8002::153, 2606:50c0:8003::153.

**Do not touch anything else.** In particular leave alone:

- All 5 **MX** records (aspmx.l.google.com and the alt ones): Google Workspace mail.
- **TXT @** `v=spf1 include:_spf.google.com include:dc-aa8e722993._spfm...`: SPF.
- **TXT** `dc-aa8e722993._spfm`: the record SPF points to.
- **TXT** `google._domainkey`: DKIM.
- **TXT** `_dmarc`: DMARC.
- Both **TXT @** `google-site-verification=...` records.
- The NS and SOA records.
- The old GoDaddy mail CNAMEs (`e`, `imap`, `mail`, `mobilemail`, `pda`,
  `pop`, `smtp`, `webmail`). They are unused but harmless; leave them for now.

## Step 3. Set the custom domain, then turn on HTTPS

Right after the DNS change, in the repo's Settings > Pages, enter
`www.searchlightsystems.com` as the Custom domain and Save (or tell Claude to
set it). GitHub then serves the apex as a redirect to `www`. Wait until the DNS check passes (minutes
to an hour), then tick **Enforce HTTPS**. The certificate can take up to an
hour to appear after DNS is right.

## Step 4. Check it

```bash
./check-dns.sh
```

- Website: A @ shows the four 185.199.x.153 addresses, CNAME www shows
  `duquet.github.io.`
- Email: every line under "# Email (must not change)" matches
  `dns-baseline-2026-10-27.txt` exactly.

```bash
curl -sI https://www.searchlightsystems.com | head -1
```

```bash
curl -sI https://searchlightsystems.com | head -3
```

Expect `200` for www, and a `301` from the apex to `https://www.searchlightsystems.com/`.
Then send a test email to andrew@searchlightsystems.com from another account
to confirm mail still arrives.
