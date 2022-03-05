CREATE TABLE leagues (
    id uuid not null,
    name text not null,
    slug text unique not null,
    creator uuid references public.players not null,
    created_at timestamp with time zone not null,

    primary key (id),
    unique(slug),
    constraint name_length check (char_length(name) >= 4)
);

-- Security Policies;
ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;

-- Add a constraint that requires the creator to be a member of the league.;
CREATE POLICY "Players can view the leagues they belong to."
    ON leagues for SELECT
    USING ( auth.uid() IN (SELECT player FROM public.league_players WHERE league = leagues.id) );

-- Add a constraint that requires the user to be an admin of the league.;
CREATE POLICY "League admins can view the leagues they administer (belong to)."
    ON leagues for SELECT
    USING ( auth.uid() IN (SELECT admin FROM public.league_admins WHERE league = leagues.id) );

CREATE POLICY "League admins can edit the leagues they administer (belong to)."
    ON leagues for UPDATE
    WITH CHECK ( auth.uid() IN (SELECT admin FROM public.league_admins WHERE league = leagues.id) );
