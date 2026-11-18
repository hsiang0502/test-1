-- 教學部教具借還系統：單一 JSON 狀態，透過 revision 避免多人同時寫入互相覆蓋。
create table if not exists public.teaching_app_state (
  id smallint primary key check (id = 1),
  payload jsonb not null,
  revision bigint not null default 1 check (revision > 0),
  updated_at timestamptz not null default now()
);

alter table public.teaching_app_state enable row level security;
revoke all on public.teaching_app_state from anon;
grant select, insert, update on public.teaching_app_state to authenticated;

drop policy if exists "tpech staff can read teaching state" on public.teaching_app_state;
create policy "tpech staff can read teaching state"
on public.teaching_app_state for select to authenticated
using (lower(coalesce(auth.jwt() ->> 'email', '')) like '%@tpech.gov.tw');

drop policy if exists "tpech staff can initialize teaching state" on public.teaching_app_state;
create policy "tpech staff can initialize teaching state"
on public.teaching_app_state for insert to authenticated
with check (lower(coalesce(auth.jwt() ->> 'email', '')) like '%@tpech.gov.tw');

drop policy if exists "tpech staff can update teaching state" on public.teaching_app_state;
create policy "tpech staff can update teaching state"
on public.teaching_app_state for update to authenticated
using (lower(coalesce(auth.jwt() ->> 'email', '')) like '%@tpech.gov.tw')
with check (lower(coalesce(auth.jwt() ->> 'email', '')) like '%@tpech.gov.tw');

comment on table public.teaching_app_state is
  '教具與借還資料。只有已登入且信箱網域為 @tpech.gov.tw 的使用者可讀寫。revision 用於樂觀鎖定。';
