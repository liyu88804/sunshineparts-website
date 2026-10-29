# SUNSHINE PARTS product catalog extraction

Source: [Sunshinepower Made-in-China showroom](https://solvalve.en.made-in-china.com/)

## Extracted scope

The showroom publicly exposes these product groups:

- Hydraulic Pumps
- Hydraulic Valves
- Hydraulic Motors
- Solenoid Valves
- Pneumatic Valves
- Pneumatic Cylinders & Actuators
- Turbocharger
- Kawasaki
- EATON
- Others

The initial website catalog now contains 33 normalized product entries from the publicly visible homepage/category listings. Verified local product images are currently connected to K5V80, A11VO130, K3V63DT and K3V112DT. All other entries now display an original category-level representative visual labelled `REPRESENTATIVE VISUAL` until an exact model image is verified.

## Website data policy

- Product prices are not hard-coded into the website because they can change and different quantities may have different pricing.
- Source listing titles are retained in `src/catalog.js` for traceability and inquiry context.
- Missing model codes, specifications, MOQ, lead time, packaging, warranty, and product images remain to be confirmed unless explicitly visible and verified.
- No certifications, stock status, performance claims, or authenticity claims were added beyond the public source content.
- Product image mapping is conservative: an image is only rendered when it has been visually verified for the corresponding product.

## Next data pass

For each product, add a verified local image and, where applicable:

- exact model / part number;
- brand;
- product type;
- pressure / flow / displacement / size;
- applicable equipment;
- MOQ;
- lead time;
- package details;
- warranty or after-sales terms;
- authorized source image set.
