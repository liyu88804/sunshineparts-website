# SUNSHINE PARTS B2B Landing Page

A Vercel-ready React/Vite B2B product inquiry landing page for SUNSHINE PARTS.

## Included

- High-contrast industrial hero section with original generated visuals
- Local authorized product images for the initial K5V80/product catalog test
- Product family filters and model search
- Product inquiry modal with name, company, email, phone, quantity, destination, requirement and image upload fields
- WhatsApp CTA using `+86 133 8223 0654`
- Temporary inquiry receiving address shown as `wxldpack@gmail.com`
- Responsive desktop/mobile navigation and layout
- Vercel configuration and a temporary `/api/inquiry` validation endpoint

## Run locally

```bash
npm install
npm run dev
```

## Build

```bash
npm run build
```

## Deploy to GitHub + Vercel

1. Upload this folder to a GitHub repository.
2. Import the repository in Vercel.
3. Framework preset: Vite (or Other if Vercel detects static output automatically).
4. Build command: `npm run build`.
5. Output directory: `dist`.
6. Deploy from the main branch.

## Important before production

The inquiry endpoint currently validates and returns a reference number, but does not send an email. Connect an approved email provider and set the final `INQUIRY_TO_EMAIL` in Vercel Environment Variables before relying on production inquiries.
