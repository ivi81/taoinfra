# 🗺️ Детализированные RLS матрицы по схемам

## 📋 Условные обозначения
- **Full-RW (Bypass)**: Полный доступ на чтение/запись, обходит RLS (`rolbypassrls=true`)
- **Full-RW (RLS)**: Полный доступ на чтение/запись, подчиняется RLS политикам
- **Read-Only**: Только чтение (глобально или через политики)
- **Switcher**: Посредник, переключается на другие роли
- **No Access**: Нет прямого доступа к таблицам схемы
- **Svc-Only**: Доступно только через служебные функции/API

---

## 🏠 СХЕМА: `public` (Пользовательские таблицы)

| Роль / Таблица | projects | users | subscriptions | deployments | canvas | messages | ...другие таблицы |
|----------------|:--------:|:-----:|:-------------:|:-----------:|:------:|:--------:|:-----------------:|
| **anon** | RLS-Only | RLS-Only | RLS-Only | RLS-Only | RLS-Only | RLS-Only | RLS-Only |
| **authenticated** | RLS-Only | RLS-Only | RLS-Only | RLS-Only | RLS-Only | RLS-Only | RLS-Only |
| **authenticator** | Switcher | Switcher | Switcher | Switcher | Switcher | Switcher | Switcher |
| **service_role** | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) |
| **supabase_admin** | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) | Full-RW (Bypass) |
| **supabase_read_only_user** | Read-Only | Read-Only | Read-Only | Read-Only | Read-Only | Read-Only | Read-Only |

**Контекст RLS для `public`:**
- `anon`/`authenticated`: Полностью контролируются политиками. Типичные политики:
  ```sql
  -- Для projects
  CREATE POLICY "Users can view their own projects" ON projects
    FOR SELECT USING (auth.uid() = owner_id);
  
  -- Для messages (чаты)
  CREATE POLICY "Users can see messages in their conversations" ON messages
    FOR SELECT USING (conversation_id IN (
      SELECT id FROM conversations WHERE user_id = auth.uid()
    ));