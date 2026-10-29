---
version: alpha
name: SUNSHINE PARTS — Precision Industrial Procurement
description: "A premium B2B industrial supplier interface for hydraulic and pneumatic component procurement, grounded in real SUNSHINE PARTS products, imagery, footage, and available company information."
colors:
  primary: "#E87524"
  primary-hover: "#F28A3A"
  primary-active: "#C85F16"
  primary-on: "#17202B"
  bg: "#0B1220"
  surface: "#111C2D"
  surface-elevated: "#17263A"
  surface-soft: "#203149"
  product-image: "#F7F8F8"
  engineering-bg: "#0E1827"
  fg: "#F5F7FA"
  fg-muted: "#B8C4D2"
  fg-dark: "#132033"
  fg-dark-muted: "#506174"
  border: "#314257"
  border-soft: "#24354A"
  border-light: "#D7DEE5"
  success: "#66C18C"
  success-surface: "#18372B"
  warn: "#F0B35E"
  warn-surface: "#3C2D18"
  danger: "#E85D5D"
  danger-surface: "#3A1E24"
  focus: "#FFB45F"
typography:
  display:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 58px
    fontWeight: 600
    lineHeight: 1.05
    letterSpacing: "-0.025em"
  h1:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 48px
    fontWeight: 600
    lineHeight: 1.08
    letterSpacing: "-0.02em"
  h2:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 32px
    fontWeight: 600
    lineHeight: 1.15
    letterSpacing: "-0.015em"
  h3:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 22px
    fontWeight: 600
    lineHeight: 1.25
    letterSpacing: "-0.01em"
  body-lg:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 18px
    fontWeight: 400
    lineHeight: 1.55
    letterSpacing: "0em"
  body-md:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "0em"
  body-sm:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "0.01em"
  label:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 12px
    fontWeight: 500
    lineHeight: 1.2
    letterSpacing: "0.08em"
  technical:
    fontFamily: "IBM Plex Sans, Arial, sans-serif"
    fontSize: 13px
    fontWeight: 500
    lineHeight: 1.4
    letterSpacing: "0.04em"
rounded:
  none: 0px
  sm: 4px
  md: 8px
  lg: 12px
  xl: 16px
  full: 9999px
spacing:
  hairline: 1px
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 24px
  2xl: 32px
  3xl: 48px
  4xl: 64px
  section: 96px
  section-mobile: 48px
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.primary-on}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.sm}"
    padding: "14px 20px"
    height: "48px"
  button-primary-hover:
    backgroundColor: "{colors.primary-hover}"
    textColor: "{colors.primary-on}"
    rounded: "{rounded.sm}"
    padding: "14px 20px"
    height: "48px"
  button-secondary:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.fg}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.sm}"
    padding: "14px 20px"
    height: "48px"
  button-quiet:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.fg}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.sm}"
    padding: "12px 16px"
    height: "44px"
  product-card:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.fg}"
    typography: "{typography.body-md}"
    rounded: "{rounded.md}"
    padding: "16px"
  input:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.fg}"
    typography: "{typography.body-md}"
    rounded: "{rounded.sm}"
    padding: "13px 14px"
    height: "48px"
  filter-chip:
    backgroundColor: "{colors.surface-elevated}"
    textColor: "{colors.fg-muted}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.full}"
    padding: "8px 14px"
  status-success:
    backgroundColor: "{colors.success-surface}"
    textColor: "{colors.success}"
    typography: "{typography.technical}"
    rounded: "{rounded.full}"
    padding: "6px 10px"
  status-warning:
    backgroundColor: "{colors.warn-surface}"
    textColor: "{colors.warn}"
    typography: "{typography.technical}"
    rounded: "{rounded.full}"
    padding: "6px 10px"
---

# SUNSHINE PARTS — Premium B2B Industrial Procurement

## Overview

SUNSHINE PARTS should feel like a high-end industrial supplier and engineering procurement interface, not a generic export template. The audience is practical and time-sensitive: mechanical equipment buyers, maintenance teams, distributors, and OEM project customers who need to identify a component, verify fit, inspect real imagery, and start an RFQ conversation with minimal uncertainty.

The visual direction is **Midnight Engineering**: deep navy structural surfaces, quiet technical lines, white-background product photography, and a restrained orange action signal. It should communicate precision, traceability, and industrial seriousness without pretending to be a laboratory dashboard. Use editorial pacing: one decisive hero, deliberate breathing room, then dense but highly ordered procurement content. Avoid decorative gradients, generic feature-card walls, invented performance metrics, and stock-photo language.

The first viewport has one dominant task: **help a qualified buyer understand what SUNSHINE PARTS supplies and move toward the right product or RFQ path**. Keep the navigation conventional and recognizable. Product categories and real visual evidence are more important than ornamental brand statements. All copy, product facts, company facts, contact details, images, videos, certifications, cases, and technical values must come from the existing project data and assets; never fill a missing fact with a plausible-sounding claim.

## Colors

The palette uses dark industrial neutrals for structure and a single orange action family for conversion. Orange is reserved for the primary action, selected state, or one small orientation cue; it must not flood product cards or turn every heading into a sales signal.

- **Primary orange (`{colors.primary}`):** RFQ, Quote, WhatsApp, View More, and other highest-priority actions. Use `{colors.primary-hover}` and `{colors.primary-active}` only for interaction states.
- **Midnight background (`{colors.bg}`):** page canvas, header, footer, and engineering-context bands. It is near-black but not pure black.
- **Surface navy (`{colors.surface}` / `{colors.surface-elevated}`):** product cards, filters, navigation panels, details panels, and raised content groups. Use the two values to establish order rather than adding many boxes.
- **Text (`{colors.fg}` / `{colors.fg-muted}`):** primary and secondary text on dark surfaces. Normal text must maintain at least 4.5:1 contrast against its surface.
- **Light product field (`{colors.product-image}`):** the default frame for white-background product photography. It is intentionally distinct from the dark engineering canvas.
- **Engineering image field (`{colors.engineering-bg}`):** the frame around factory footage, production-line stills, and contextual imagery with dark surroundings.
- **Light-surface text (`{colors.fg-dark}` / `{colors.fg-dark-muted}`):** use only when a section or image frame is light. Do not place light gray text on `{colors.product-image}`.
- **Structure (`{colors.border}` / `{colors.border-soft}` / `{colors.border-light}`):** one-pixel rules, input boundaries, gallery separators, and light image frames. Borders are quiet, never glowing.
- **Semantic states:** `{colors.success}` with `{colors.success-surface}` for confirmed/available information, `{colors.warn}` with `{colors.warn-surface}` for attention, and `{colors.danger}` with `{colors.danger-surface}` for validation or request failure. Never communicate state with color alone; pair it with a label or message.
- **Focus (`{colors.focus}`):** visible keyboard focus ring on both dark and light surfaces. It must contrast with the component and surrounding surface.

Do not use a purple/blue trust gradient, default indigo, neon cyan, or extra accent colors. Do not use raw white as a full-page background; reserve `{colors.product-image}` for product imagery and light content zones.

## Typography

Use IBM Plex Sans with the declared Arial fallback for a precise, compact but human industrial voice. Keep the type system to three visible weights: 400 for reading, 500 for navigation/metadata, and 600 for headings and primary actions. Do not introduce a second display face or a decorative condensed font.

- **Display and H1:** `{typography.display}` and `{typography.h1}` establish the hero entry point. Keep the hero heading to roughly 10–16 words and a maximum width of 12–15 characters per visual line where possible. Use negative tracking only at display sizes.
- **H2/H3:** `{typography.h2}` and `{typography.h3}` structure category, video, trust, and page sections. One heading should dominate each visual region; do not make every card title look like a headline.
- **Body:** `{typography.body-lg}` is for the hero support sentence and key introductions; `{typography.body-md}` is the default for product descriptions and page copy; `{typography.body-sm}` is for controls and compact metadata.
- **Labels and technical data:** `{typography.label}` is uppercase only for short navigation labels, section eyebrows, image provenance badges, and filter headings. `{typography.technical}` is for model names, units, MOQ/FOB/application labels, and technical metadata. All-caps labels require the declared positive tracking.
- Keep reading copy between 50 and 75 characters per line where possible, with a maximum body measure of approximately 65ch. Never use justified text.
- At 390px, the hero heading steps down to approximately 34px, page H1 to 32px, H2 to 26px, and body copy remains at least 16px for primary reading. Preserve the hierarchy through spacing and weight, not through tiny text.

## Layout

Use a fixed-max-width procurement frame: 1280px maximum content width, 24px desktop gutters, 16px tablet gutters, and 12px minimum phone gutters. The desktop grid is 12 columns with a 24px gutter. Product listing content may use a 3-column card grid beside a 240px filter rail; detail pages use a 7/5 gallery-to-information split. The grid should align across the header, hero, category index, and footer.

The composition deliberately alternates between two archetypes: a split hero with product/video evidence, and structured full-width procurement bands with restrained card groups. Do not make every section a symmetrical row of cards. Use full-bleed dark bands for engineering footage and the closing RFQ invitation; use lighter product fields only where the object needs to be read.

**Homepage hierarchy:**

1. **Header and first viewport:** compact wordmark, Products, Solutions, Industries, About, Cases, Certifications, Contact, and a clearly named Quote/RFQ action using only the existing route structure. On desktop, keep the primary action at the right. The hero is a split composition: left side contains the concise industrial positioning and two paths—browse Products and request a Quote—while the right side uses the existing homepage product video or a real product image. The first viewport should show a product/category cue, not an abstract decoration.
2. **Product category index:** immediately after the hero, present the six real families—hydraulic pumps, hydraulic valves, hydraulic motors, pneumatic valves, cylinders, and actuators—as an index, not an interchangeable feature grid. Each category module has its real available image, category name, one factual supporting line if present, and a direct Products/category path. If the image represents the family rather than a specific item, mark it as “Category representative”; never imply that it is the selected model.
3. **Factory production-line video:** use the existing factory video in a dark engineering band with a visible poster frame, native controls, captions when available, and a short factual caption. This is evidence of process, not a fabricated promise about capacity, lead time, or quality.
4. **Buyer trust bar:** place a quiet horizontal strip after the evidence section. Use only existing, supportable signals: real product imagery, six-image detail galleries, existing factory footage, available certification records, actual cases, and the real RFQ/contact path. Do not add client logos, certification marks, employee counts, capacity numbers, delivery claims, or “trusted by” language unless those assets and facts already exist.
5. **RFQ CTA:** close the homepage with a focused, high-contrast RFQ band. It should explain the next action in plain procurement language, offer the existing Quote route and any existing WhatsApp route, and show no floating overlay. Orange appears here as the primary action, with the secondary route treated as a quieter outlined action.

**Products page:** begin with a short page heading and search field, then keep the category index/filter controls visible. Filters should cover only available product categories and available data fields; do not create filters for unprovided pressure, flow, material, or compatibility values. Search should accept product name, category, and model text from the existing data. Cards use the same image field, provenance badge, category label, product name, and model summary. When several models share the same primary image, render one grouped card with the common image and a clearly labelled model list or expandable “View More” disclosure. Do not duplicate visually identical cards merely to increase catalog density. “View More” reveals existing model details and routes to the correct detail page; it is not an invented pagination promise.

**Product detail page:** use a 7/5 desktop split. The left side is a large `{colors.product-image}` main-image frame with the real primary product image and six-image gallery thumbnails below or beside it. Thumbnails must show selected state by border and label, not color alone. The right side places product name, model, category, and the primary Quote/RFQ action in the first scan. Show MOQ, FOB, application, and specifications as a compact labelled data panel only when those values exist. If a value is missing, omit the row or state “Not provided” rather than guessing. Keep the contact path close to the product context; WhatsApp may be offered only through the existing real link/number.

**Secondary pages:** keep the header, content frame, label style, border language, CTA treatment, and footer consistent while giving each route a different job. About focuses on existing company story and real facilities/process content. Solutions focuses on the existing application or procurement contexts without inventing engineering outcomes. Industries organizes only existing industry content. Cases presents only current cases and available evidence. Certifications lists only existing certifications with exact names and available documents or images. Contact prioritizes the current company contact details and a clear inquiry path. Quote is a calm form-led conversion page with labelled fields, preserved input on error, and no fabricated service-level promise. Product detail, RFQ, and WhatsApp paths must remain obvious without adding a second competing conversion system.

**Spacing and responsive behavior:** use the 4px base rhythm: 8–12px within a label/data group, 16–24px inside a card, 32–48px between related groups, and 64–96px between major desktop sections. Desktop sections use approximately `{spacing.section}` vertical rhythm; mobile sections use `{spacing.section-mobile}`. At 1024px and below, collapse the filter rail into a labelled control row, reduce the category index to two columns, and keep media above supporting copy. At 640px and below, use one column, allow the header navigation to become a compact menu, stack hero actions, and keep every route within the viewport.

At exactly 390px CSS width, the page must have no horizontal scroll. Use `width: 100%`, `min-width: 0` on grid children, responsive media with intrinsic aspect ratios, and wrapping model/metadata text. Do not pin a wide table or six thumbnails beyond the viewport; make the gallery a horizontal scroll region with an accessible label or let thumbnails wrap into a compact grid. Make cards full-width, keep 12px side gutters, stack CTA buttons when needed, and place any mobile action bar in normal document flow so it never covers content. All actionable controls, including menu, gallery, filter, clear, View More, Quote, and WhatsApp controls, must have at least 44×44 CSS-pixel touch areas.

## Elevation & Depth

Depth is conveyed by tonal separation, borders, and a restrained industrial shadow—not by glassmorphism or glow. Default content is flat on `{colors.bg}`. Product cards and panels use `{colors.surface}` with a one-pixel `{colors.border-soft}` boundary. Raised menus, filter drawers, and dialogs may use `{colors.surface-elevated}` with a subtle shadow of approximately `0 12px 32px rgba(0, 0, 0, 0.24)`; use it only when the element must sit above content. Avoid shadows on product image fields so the white-background object remains clean.

The primary depth cue for a product is the contrast between `{colors.product-image}` and the surrounding midnight frame. Engineering footage belongs on `{colors.engineering-bg}` with a thin border and a visible play/control affordance. Do not overlay text directly on busy factory footage unless a dark scrim preserves normal-text contrast. Hover may lift a card by 2px and strengthen its border, but motion is short and functional; respect `prefers-reduced-motion`.

## Shapes

The shape language is **machined restraint**: small radii, crisp edges, and consistent alignment. Use `{rounded.sm}` for buttons, inputs, and compact controls; `{rounded.md}` for product cards, video frames, and content panels; `{rounded.lg}` only for a large media container or modal. Use `{rounded.full}` only for status/provenance chips and never for the main card or primary CTA. Do not mix pill-shaped buttons with heavily rounded cards.

Product image frames are rectangular and calm. The object should be centered with generous breathing room, no artificial perspective, no decorative stickers, and no cropping that removes model-defining details. Real product imagery and category representative imagery must have different visible badges: “Actual product image” for a specific existing product image and “Category representative” for an illustrative category image. A representative image must never be presented as the exact item selected by the user.

## Components

**Buttons and links:** The primary button follows `button-primary`: orange fill, dark readable label, 48px height, and a minimum 44px hit area. Use one primary action per viewport: “Request a Quote”, “View Product”, or the existing equivalent route label. Secondary actions use `button-secondary` with a surface fill and border. Quiet actions use `button-quiet`; links should be text-led and visibly distinguishable without relying on orange everywhere. On hover, move the button no more than 2px or change fill to `{colors.primary-hover}`; on pressed use `{colors.primary-active}`. Disabled controls reduce contrast carefully but remain readable and explain why they cannot be used.

**Header and navigation:** use semantic header/nav landmarks. The active route is identified by text weight and a bottom or side rule in `{colors.primary}`, not by color alone. Keep the Quote/RFQ action distinct but not oversized. On mobile, the menu control is a native button with an accessible name, 44px minimum box, and a panel that can be closed with Escape and returned focus to the trigger.

**Product cards:** use `product-card` with one dominant image area, one provenance/category label, a concise product name, available model summary, and one clear route action. Do not add ratings, stock badges, delivery promises, invented numbers, or decorative icon rows. Preserve the aspect ratio and object clarity of local images. The card hover state may reveal a stronger border and a slight media scale, but the product name and View More path must remain available without hover.

**Filters, search, and model grouping:** the search input uses `input`, has a persistent visible label, and supports the current product/model vocabulary. Filter chips use `filter-chip`; selected chips use a border and a text label such as “Selected,” not color alone. Show applied filters in a removable row with a clearly labelled “Clear all” action. Group shared-primary-image models under one card and disclose the number or list only when that value already exists in the data. A “View More” control must be a button or real link, not a clickable div.

**Gallery and media:** the detail page main image has a descriptive alt derived from the existing product name/model. Every thumbnail is a 44px-or-larger button with an accessible name and selected state. The homepage and factory videos use native controls, a visible poster image, captions when supplied, and a non-video fallback image or text description. Never autoplay with sound. Do not replace real product or factory imagery with gradients, remote placeholders, or CSS-drawn mock images.

**Data panels and forms:** MOQ, FOB, application, and specification rows use a two-column label/value rhythm on desktop and a stacked rhythm on mobile. Preserve units and exact source wording. Quote and Contact forms use explicit labels, helper text where needed, and field-level error messages. Validate on blur, preserve entered values after a failed submit, and show a clear pending state without allowing duplicate submission. Use `{colors.success}` only for an actual confirmed submission; do not show success before the current flow confirms it.

**Focus, accessibility, and states:** every interactive element must have a visible `:focus-visible` indicator using `{colors.focus}` or an equivalent two-pixel outline with at least 3:1 contrast. Never remove focus outlines. Maintain heading order, landmarks, keyboard operation, descriptive alt text, and a document language appropriate to the supplied page language. Normal text must meet 4.5:1 contrast; UI boundaries and focus indicators must meet 3:1. Keep controls at least 44×44 CSS pixels, including icon-only buttons. Provide a skip link and do not rely on hover to expose essential information.

Every search/list/filter/gallery/form surface must cover five states: loading, populated, empty, error, and edge. Loading uses a layout-matched skeleton for longer requests; empty search results echo the query, explain that no current product matched, and offer clearing filters or browsing the six categories; never use a blank panel. Error states say what failed, preserve the query/form input, and provide retry or the existing Contact/RFQ path. Edge cases include long model names, absent optional MOQ/FOB/spec rows, a single result, many results, missing image variants, and narrow 390px screens. A failed video should retain its caption and fallback media. Do not use “Something went wrong” without a recovery action.

## Do's and Don'ts

- **Do** make the real product image, model identity, category path, and RFQ action easy to find.
- **Do** distinguish “Actual product image” from “Category representative” wherever imagery could be misread.
- **Do** use the homepage product video and factory production-line video as evidence with native controls and factual captions.
- **Do** keep the product category index focused on hydraulic pumps, hydraulic valves, hydraulic motors, pneumatic valves, cylinders, and actuators.
- **Do** merge products that share the same primary image and reveal their existing model options through View More.
- **Do** keep existing routes and make Products, detail, Quote/RFQ, and WhatsApp paths mutually consistent.
- **Do** keep orange scarce: one main action per visual region, plus its necessary interaction states.
- **Do** let whitespace and one-pixel rules establish hierarchy before adding boxes or shadows.
- **Do** test the full interface at 390px and ensure no fixed or floating control obscures content.
- **Do** use only current real products, company facts, contact details, assets, certifications, cases, and available technical data.
- **Don't** invent certification names, customer logos, production capacity, employee counts, delivery times, performance figures, specifications, or buyer outcomes.
- **Don't** use generic “best quality,” “one-stop solution,” or filler claims when the existing content does not substantiate them.
- **Don't** turn six product families into identical promotional cards or add metrics simply to fill a layout.
- **Don't** use default purple gradients, neon accents, glassmorphism, stock imagery, placeholder image CDNs, emoji icons, or decorative blobs.
- **Don't** make a category representative image look like a confirmed model photograph.
- **Don't** hide essential product information behind hover, truncate model names without an accessible full value, or use color alone for selected/error/provenance states.
- **Don't** create a floating WhatsApp or RFQ button that covers the 390px viewport; keep the path in the content flow.
- **Don't** reduce normal text below the declared accessible contrast, remove focus outlines, or make any primary control smaller than 44×44 CSS pixels.
