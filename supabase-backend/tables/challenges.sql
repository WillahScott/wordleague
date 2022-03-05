CREATE TABLE challenges (
    id uuid not null,
    league references leagues not null,
    creator references players not null,
    challenge_date timestamp with time zone,
    word text not null
    word_length integer GENERATED ALWAYS AS (char_length(word)) STORED,
    language text,

    primary key (id),
    constraint word_length check (char_length(word) >= 4)
);

-- Security Policies;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can only view, insert, or update their own challenges."
    ON players for SELECT, INSERT, UPDATE
    WITH CHECK ( auth.uid() = creator.id );
