-- Вставка основных провайдеров аутентификации с UUID
INSERT INTO auth.sso_providers (id, resource_id, created_at, updated_at)
VALUES 
    (gen_random_uuid(), 'email', NOW(), NOW(),true),
    (gen_random_uuid(), 'phone', NOW(), NOW(),true),
    (gen_random_uuid(), 'google', NOW(), NOW(),true),
    (gen_random_uuid(), 'github', NOW(), NOW(),true),
    (gen_random_uuid(), 'gitlab', NOW(), NOW(),true),
    (gen_random_uuid(), 'azure', NOW(), NOW(),true),
    (gen_random_uuid(), 'apple', NOW(), NOW(),true),
    (gen_random_uuid(), 'discord', NOW(), NOW(),true),
    (gen_random_uuid(), 'facebook', NOW(), NOW(),true),
    (gen_random_uuid(), 'keycloak', NOW(), NOW(),true),
    (gen_random_uuid(), 'linkedin', NOW(), NOW(),true),
    (gen_random_uuid(), 'notion', NOW(), NOW(),true),
    (gen_random_uuid(), 'slack', NOW(), NOW(),true),
    (gen_random_uuid(), 'spotify', NOW(), NOW(),true),
    (gen_random_uuid(), 'twitch', NOW(), NOW(),true),
    (gen_random_uuid(), 'twitter', NOW(), NOW(),true),
    (gen_random_uuid(), 'workos', NOW(), NOW(),true),
    (gen_random_uuid(), 'zoom', NOW(), NOW(),true)
ON CONFLICT (id) DO NOTHING;