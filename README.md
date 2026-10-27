# searchlightsystems.com

One-page site for SearchLight Systems (Andrew Duquet). Plain HTML and CSS, no
build step: `index.html`, `styles.css`, `assets/`. `CNAME` is for GitHub Pages.

Preview locally:

```bash
python3 -m http.server 8411 --bind 127.0.0.1
```

then open http://127.0.0.1:8411/.

Going live: see [GO-LIVE.md](GO-LIVE.md). DNS checks: `./check-dns.sh`,
compared with `dns-baseline-2026-10-27.txt`.

## Copy rules

- Invent nothing: no testimonials, logos, stats, fees, rates or URLs that
  Andrew has not supplied. Facts in use: solo recruiter, founded 1995, 2000+
  placements, BSEE.
- Name no client or employer without Andrew's explicit OK.
- No em dashes anywhere.

## Still needed from Andrew

1. **Headshot.** Square photo, at least 600x600, saved as `assets/andrew.jpg`.
   It replaces the "AD" monogram (see the comment in `index.html`).
2. **Copy review**, especially lines that describe how he works rather than
   bare facts: "no junior recruiters and no hand-offs", the four "For
   engineers" promises, the four "How I work" steps, and the short contract
   recruiting description.
3. **LinkedIn link**: `https://www.linkedin.com/in/andrewduquet` is used, taken
   from his email signature standard. Confirm it is right.
4. **Testimonials** (optional): exact quotes with permission to use them, and
   how each person should be credited. None are on the site until then.
5. **Clients or companies to name** (optional): only ones he explicitly
   approves.
6. **Location** (optional): the site names none. Add one if he wants it.
7. **Go-ahead** to create the public GitHub repo and turn on Pages.
