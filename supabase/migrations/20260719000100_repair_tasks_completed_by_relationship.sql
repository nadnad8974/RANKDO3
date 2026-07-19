-- Priority Tasks: repair the named tasks -> profiles relationship expected by
-- the v2.1 client. Safe to run again. Existing completion-name snapshots remain.

begin;

do $$
begin
  if to_regclass('public.tasks') is null then
    raise exception 'public.tasks does not exist';
  end if;

  if to_regclass('public.profiles') is null then
    raise exception 'public.profiles does not exist';
  end if;

  if not exists (
    select 1
    from information_schema.columns
    where table_schema = 'public'
      and table_name = 'tasks'
      and column_name = 'completed_by'
  ) then
    alter table public.tasks add column completed_by uuid;
  end if;

  -- An interrupted earlier update may have created completed_by without its
  -- foreign key. Keep the saved employee name but clear only orphaned IDs so
  -- the relationship can be added safely.
  update public.tasks task
  set completed_by = null
  where task.completed_by is not null
    and not exists (
      select 1
      from public.profiles profile
      where profile.id = task.completed_by
    );

  if not exists (
    select 1
    from pg_constraint
    where conname = 'tasks_completed_by_fkey'
      and conrelid = 'public.tasks'::regclass
  ) then
    alter table public.tasks
      add constraint tasks_completed_by_fkey
      foreign key (completed_by)
      references public.profiles(id)
      on delete set null;
  end if;
end;
$$;

create index if not exists tasks_completed_by_idx
  on public.tasks(completed_by);

-- Ask PostgREST/Supabase to notice the relationship immediately.
notify pgrst, 'reload schema';

commit;

select conname as installed_relationship
from pg_constraint
where conname = 'tasks_completed_by_fkey'
  and conrelid = 'public.tasks'::regclass;
