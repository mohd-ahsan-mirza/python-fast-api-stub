CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS "companies"
(
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v1(),
    description TEXT NOT NULL,
    symbol TEXT UNIQUE NOT NULL,
    currency TEXT DEFAULT NULL,
    type TEXT DEFAULT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "corporate_structures"
(
    description TEXT PRIMARY KEY NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO corporate_structures(description)
VALUES ('assoc'),('bros'),('cie'),('co'),('corp'),('inc'),('ltd'),
('mfg'),('mfrs'),('etf'),('adr'),('corporation'),('sa'),('acq'),
('plc'),('cl a'),('cl b'),('co/the'),('in'),('se'),('oyj'),('international'),
('lt'),('tr'),('group'),('v-a'),('gdr'),('trust'),('a'),('management'),('lp'),
('inc/the'),('holdings'),('global');

CREATE TABLE IF NOT EXISTS "words_to_ignore"
(
    word TEXT PRIMARY KEY NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO words_to_ignore(word)
VALUES ('current'),('stock'),('price');

SET TIME ZONE 'UTC';