const sb = supabase.createClient(CFG.url, CFG.key);
const $ = (s, r = document) => r.querySelector(s);
const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const STORE = {amazon: 'أمازون', noon: 'نون'};
const safeUrl = u => /^https?:\/\//i.test(u) ? u : '#';
const hd = $('#hd'), ft = $('#ft');
if (hd) hd.innerHTML = `<div class="w"><a class="logo" href="index.html">ن<b>قوة</b></a><nav><a href="index.html">المنتجات</a><a href="page.html?p=about">عن الموقع</a><a href="page.html?p=contact">تواصل</a></nav></div>`;
if (ft) ft.innerHTML = `<div class="w"><p><strong>إفصاح:</strong> قد يحصل موقع نقوة على عمولة عند الشراء عبر روابطه، دون أي تكلفة إضافية عليك. الشراء والدفع والتوصيل تتم بالكامل لدى أمازون الإمارات أو نون.</p><p><a href="page.html?p=about">عن الموقع</a> · <a href="page.html?p=privacy">الخصوصية</a> · <a href="page.html?p=contact">تواصل</a></p></div>`;
if (!location.pathname.endsWith('admin.html')) sb.from('visits').insert({path: location.pathname + location.hash}).then(() => {});
