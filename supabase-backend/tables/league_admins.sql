CREATE TABLE league_admins (
    id uuid not null,
    league uuid references public.leagues not null,
    admin uuid references public.players not null,
    joined_at timestamp with time zone not null,

    primary key (id)
);


-- Security Policies;
ALTER TABLE league_admins ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can view who are admins of their own leagues."
    ON league_admins for SELECT
    USING ( auth.uid() IN (SELECT player FROM league_players WHERE league = league_players.league) );

CREATE POLICY "Admins can view the admins of their leagues they administer."
    ON league_admins for SELECT
    USING ( auth.uid() IN (SELECT admin FROM league_admins WHERE league = league_admins.league) );

CREATE POLICY "Admins can add new admins to the leagues they administer."
    ON league_admins for INSERT
    WITH CHECK ( auth.uid() IN (SELECT admin FROM league_admins WHERE league = league_admins.league) );

CREATE POLICY "Admins can remove admins from the leagues they administer."
    ON league_admins for DELETE
   USING ( auth.uid() IN (SELECT admin FROM league_admins WHERE league = league_admins.league) );
