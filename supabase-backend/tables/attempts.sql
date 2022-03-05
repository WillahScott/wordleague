CREATE TABLE attempts (
    id uuid not null,
    challenge uuid references public.challenges not null,
    player uuid references public.players not null,
    attempt_date timestamp with time zone not null,
    attempt text not null,
    attempt_length integer GENERATED ALWAYS AS (char_length(attempt)) STORED,
    --attempt_num is an autoincrementing field that increments by 1 for each new attempt for the same challenge by the same player;
    -- CANNOT BE CREATED WITH A GENERATED COLUMN: https://www.postgresql.org/docs/13/ddl-generated-columns.html
    -- attempt_num integer GENERATED ALWAYS AS (
    --     coalesce(
    --         (
    --             select max(attempt_num)
    --             from attempts
    --             where challenge = attempts.challenge
    --             and player = attempts.player
    --         ),
    --         0
    --     ) + 1
    -- ) STORED,
    is_correct boolean not null,
    feedback text,
    letters_green text,
    num_green integer GENERATED ALWAYS AS (char_length(letters_green)) STORED,
    letters_yellow text,
    num_yellow integer GENERATED ALWAYS AS (char_length(letters_yellow)) STORED,
    letters_red text,
    num_red integer GENERATED ALWAYS AS (char_length(letters_red)) STORED,

    primary key (id)
);

-- Security Policies;
ALTER TABLE attempts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can view their own attempts."
    ON attempts for SELECT
    USING ( auth.uid() = player );

CREATE POLICY "Players can create their own attempts."
    ON attempts for INSERT
    WITH CHECK ( auth.uid() = player );
