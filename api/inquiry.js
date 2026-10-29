export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });
  const body = req.body || {};
  const { name, email, message } = body;
  if (!name || !email || !message) return res.status(400).json({ error: 'Name, email and requirement are required.' });
  const reference = `SP-${Date.now()}`;
  // Temporary validation endpoint. Connect a mail provider before production
  // so this validated payload is forwarded to INQUIRY_TO_EMAIL.
  return res.status(200).json({ ok: true, reference });
}
