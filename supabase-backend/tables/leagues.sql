CREATE TABLE leagues (
    id uuid not null,
    name text not null,
    slug text unique not null,
    creator references players not null,
    created_at timestamp with time zone not null,

    primary key (id),
    unique(slug),
    constraint name_length check (char_length(name) >= 4)
);

-- Security Policies;
ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;

-- TODO: Add a constraint that requires the creator to be a member of the league.;
CREATE POLICY "Leagues can only be viewed by players that belong to them."
    ON players for SELECT
    USING ( true );  -- TODO: remove this line;
    -- WITH CHECK ( auth.id IN (SELECT player FROM league_players WHERE league = leagues.id) );

-- TODO: Add a constraint that requires the user to be an admin of the league.;
CREATE POLICY "Leagues can only be inserted, or updated by players that are league admins."
    ON players for INSERT, UPDATE
    USING ( true );  -- TODO: remove this line;
    -- WITH CHECK ( auth.id IN (SELECT player FROM league_players WHERE league = leagues.id AND admin = true) );
