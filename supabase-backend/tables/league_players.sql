CREATE TABLE league_players (
    id uuid not null,
    league references leagues not null,
    player references players not null,
    joined_at timestamp with time zone not null,

    primary key (id)
);

-- TODO: think about the security of the league_players table;
-- Security Policies;
ALTER TABLE league_players ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can only view their own profile."
    ON players for SELECT
    WITH CHECK ( auth.uid() = player );

CREATE POLICY "League admins can manage."
    ON players for SELECT, INSERT, UPDATE
    WITH CHECK ( auth.uid() IN (SELECT admin FROM league_admins WHERE league = league_admins.league) );
