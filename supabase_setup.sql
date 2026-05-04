-- Execute este SQL no Supabase Dashboard → SQL Editor

-- Tabela principal de lançamentos
CREATE TABLE IF NOT EXISTS lancamentos (
  id        BIGINT PRIMARY KEY,
  usuario   TEXT NOT NULL DEFAULT 'default',
  data      TEXT,
  mes       TEXT,
  tipo      TEXT CHECK (tipo IN ('entrada', 'saida')),
  cat       TEXT,
  qtde      NUMERIC(10,2) DEFAULT 1,
  valor     NUMERIC(12,2) DEFAULT 0,
  total     NUMERIC(12,2) DEFAULT 0,
  obs       TEXT DEFAULT '',
  criado_em TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para busca por usuário (melhora performance)
CREATE INDEX IF NOT EXISTS idx_lancamentos_usuario ON lancamentos(usuario);

-- Habilitar Row Level Security (RLS)
ALTER TABLE lancamentos ENABLE ROW LEVEL SECURITY;

-- Política: qualquer pessoa com a chave anon pode ler e escrever
-- (para uso pessoal/familiar — adequado para este caso)
CREATE POLICY "Acesso público com chave anon"
  ON lancamentos
  FOR ALL
  USING (true)
  WITH CHECK (true);
