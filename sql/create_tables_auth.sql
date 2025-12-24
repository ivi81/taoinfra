-- Создаем недостающие таблицы в схеме auth (если они не существуют)
-- 1. Таблица sso_providers
CREATE TABLE IF NOT EXISTS auth.sso_providers (
    id TEXT PRIMARY KEY,
    resource_id TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Таблица identities (связь пользователь-провайдер)
CREATE TABLE IF NOT EXISTS auth.identities (
    id TEXT NOT NULL,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    identity_data JSONB NOT NULL,
    provider TEXT NOT NULL,
    last_sign_in_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    email TEXT GENERATED ALWAYS AS (identity_data->>'email') STORED,
    UNIQUE(provider, id)
);

-- 3. Добавляем обязательный столбец banned_until в auth.users
ALTER TABLE auth.users 
ADD COLUMN IF NOT EXISTS banned_until TIMESTAMPTZ NULL;

-- 4. (Опционально) Вставляем базовые провайдеры
INSERT INTO auth.sso_providers (id, resource_id) 
VALUES ('email', 'email'), ('phone', 'phone')
ON CONFLICT (id) DO NOTHING;

-- 5. Проверяем результат
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'auth' 
ORDER BY table_name;