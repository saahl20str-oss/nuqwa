-- نقوة: شغّله كاملًا في Supabase > SQL Editor
create table if not exists admins(user_id uuid primary key references auth.users on delete cascade);
create or replace function is_admin() returns boolean language sql stable security definer set search_path=public as
$$ select exists(select 1 from admins where user_id=auth.uid()) $$;

create table if not exists categories(id uuid primary key default gen_random_uuid(), name text not null, sort int default 0);
create table if not exists products(id uuid primary key default gen_random_uuid(), title text not null, description text, benefits text, notes text,
  image_url text, category_id uuid references categories on delete set null, sort int default 0, hidden boolean default false, is_demo boolean default false, created_at timestamptz default now());
create table if not exists product_links(id uuid primary key default gen_random_uuid(), product_id uuid not null references products on delete cascade,
  store text not null check (store in ('amazon','noon')), url text not null, price text, price_date date);
create table if not exists clicks(id bigserial primary key, product_id uuid references products on delete cascade, store text, created_at timestamptz default now());
create table if not exists visits(id bigserial primary key, path text, created_at timestamptz default now());

alter table admins enable row level security; alter table categories enable row level security; alter table products enable row level security;
alter table product_links enable row level security; alter table clicks enable row level security; alter table visits enable row level security;

create policy "admin self" on admins for select using (user_id=auth.uid());
create policy "cat read" on categories for select using (true);
create policy "cat admin" on categories for all using (is_admin()) with check (is_admin());
create policy "prod read" on products for select using (hidden=false or is_admin());
create policy "prod admin" on products for all using (is_admin()) with check (is_admin());
create policy "link read" on product_links for select using (exists(select 1 from products p where p.id=product_id and (p.hidden=false or is_admin())));
create policy "link admin" on product_links for all using (is_admin()) with check (is_admin());
create policy "click insert" on clicks for insert with check (true);
create policy "click admin" on clicks for select using (is_admin());
create policy "visit insert" on visits for insert with check (true);
create policy "visit admin" on visits for select using (is_admin());

-- بعد إنشاء حساب المدير من Authentication > Users، شغّل (بدّل البريد):
-- insert into admins select id from auth.users where email='you@example.com';

-- بيانات تجريبية (اختياري، تظهر بشارة "منتج تجريبي"):
insert into categories(name,sort) values ('المنزل',1),('المطبخ',2),('الإلكترونيات',3),('العناية الشخصية',4);
insert into products(title,description,benefits,notes,category_id,is_demo,sort)
select 'منتج تجريبي للمطبخ','وصف تجريبي لإظهار شكل الصفحة.','فائدة تجريبية أولى
فائدة تجريبية ثانية','ملاحظة تجريبية: احذف هذا المنتج قبل النشر.',id,true,1 from categories where name='المطبخ';
insert into product_links(product_id,store,url) select id,'amazon','https://www.amazon.ae/' from products where is_demo;
insert into product_links(product_id,store,url) select id,'noon','https://www.noon.com/uae-ar/' from products where is_demo;
