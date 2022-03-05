CREATE TABLE league_admins (
    id uuid not null,
    league references leagues not null,
    admin references players not null,
    joined_at timestamp with time zone not null,

    primary key (id)
);

-- TODO: think about the security of the league_admins table;
-- Security Policies;
ALTER TABLE league_players ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can view who are admins of their own leagues."
    ON players for SELECT
    WITH CHECK ( auth.uid() IN (SELECT player FROM league_players WHERE league = league_players.league) );

CREATE POLICY "Admins can manage the administration of their own leagues."
    ON players for SELECT, INSERT, UPDATE
    WITH CHECK ( auth.uid() IN (SELECT admin FROM league_admins WHERE league = league_admins.league) );
