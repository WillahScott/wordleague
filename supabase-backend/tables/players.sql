CREATE TABLE players (
    id uuid references auth.users not null,
    updated_at timestamp with time zone,
    username text unique,
    avatar_url text,

    primary key (id),
    unique(username),
    constraint username_length check (char_length(username) >= 3)
);

-- Security Policies;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can only view, insert, or update their own profile."
    ON players for SELECT, INSERT, UPDATE
    WITH CHECK ( auth.uid() = id );
