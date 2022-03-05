CREATE TABLE league_players (
    id uuid not null,
    league uuid references public.leagues not null,
    player uuid references public.players not null,
    joined_at timestamp with time zone not null,

    primary key (id)
);


-- Security Policies;
ALTER TABLE league_players ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can view the leagues they are members of."
    ON league_players for SELECT
    USING ( auth.uid() = player );

CREATE POLICY "Players can leave leagues they are members of."
    ON league_players for DELETE
    USING ( auth.uid() = player );

CREATE POLICY "League admins can view the players from the leagues they administer (belong to)."
    ON league_players for SELECT
    USING ( auth.uid() IN (SELECT admin FROM public.league_admins WHERE league = league_admins.league) );

CREATE POLICY "League admins can add new players from the leagues they administer (belong to)."
    ON league_players for INSERT
    WITH CHECK ( auth.uid() IN (SELECT admin FROM public.league_admins WHERE league = league_admins.league) );

CREATE POLICY "League admins can remove players from the leagues they administer (belong to)."
    ON league_players for DELETE
    USING ( auth.uid() IN (SELECT admin FROM public.league_admins WHERE league = league_admins.league) );
