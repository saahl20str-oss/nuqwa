# نقوة: تعليمات التشغيل (خطوة بخطوة)

## 1) قاعدة البيانات (Supabase)
1. أنشئ مشروعًا جديدًا في supabase.com.
2. افتح SQL Editor والصق محتوى ملف supabase.sql كاملًا ثم Run.
3. من Project Settings > API انسخ Project URL ومفتاح anon public، والصقهما في config.js (لا تستخدم service_role أبدًا).

## 2) حساب المدير
1. Authentication > Users > Add user: أدخل بريدك وكلمة مرور قوية (فعّل Auto Confirm).
2. Authentication > Sign In / Providers: عطّل "Allow new users to sign up" حتى لا يسجّل غيرك.
3. في SQL Editor شغّل (بدّل البريد):
   insert into admins select id from auth.users where email='بريدك@example.com';

## 3) النشر على GitHub Pages
1. أنشئ مستودعًا جديدًا وارفع كل الملفات في جذره (config.js و index.html و admin.html و page.html و app.js و style.css).
2. Settings > Pages > Source: Deploy from a branch > main > /root.
3. افتح الرابط، ولوحة الإدارة على /admin.html.
4. من Supabase > Authentication > URL Configuration ضع رابط موقعك في Site URL.

## 4) أول استخدام
- في لوحة الإدارة احذف المنتج التجريبي، وعدّل التصنيفات، وأضف منتجاتك بروابط العمولة الخاصة بك.
- في config.js ضع بريد التواصل الحقيقي.

## ما يعمل وما يحتاج خدمة خارجية
- يعمل مباشرة: التصفح، البحث، الفلاتر، المفضلة (في متصفح الزائر)، الصفحات، لوحة الإدارة، عدّاد الزيارات والنقرات.
- السعر: يظهر فقط إذا أدخلته يدويًا مع تاريخه؛ وإلا تظهر عبارة "تحقق من السعر لدى المتجر".
- جلب بيانات المنتج من الرابط: غير مفعّل؛ يتطلب واجهة رسمية (Amazon Creators API أو ما يتيحه برنامج نون) وخادمًا وسيطًا (Supabase Edge Function). الإدخال اليدوي هو البديل الحالي.
- المبيعات والعمولات المؤكدة: تؤخذ من تقارير برامج الشراكة، ولا يمكن حسابها من الموقع.
- الصور: الصق روابط صور لديك حق استخدامها؛ لا تنسخ صور المتاجر إلا بما تسمح به شروط البرنامج.
