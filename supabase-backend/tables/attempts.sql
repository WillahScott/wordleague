CREATE TABLE attempts (
    id uuid not null,
    challenge references challenges not null,
    player references players not null,
    attempt_date timestamp with time zone not null,
    attempt text not null,
    attempt_length integer GENERATED ALWAYS AS (char_length(attempt)) STORED,
    --attempt_num is an autoincrementing field that increments by 1 for each new attempt for the same challenge by the same player;
    attempt_num integer GENERATED ALWAYS AS (
        coalesce(
            (
                select max(attempt_num)
                from attempts
                where challenge = attempts.challenge
                and player = attempts.player
            ),
            0
        ) + 1
    ) STORED,
    is_correct boolean not null,
    letters_green text,
    num_green integer GENERATED ALWAYS AS (char_length(letters_green)) STORED,
    letters_yellow text,
    num_yellow integer GENERATED ALWAYS AS (char_length(letters_yellow)) STORED,
    letters_red text,
    num_red integer GENERATED ALWAYS AS (char_length(letters_red)) STORED,

    primary key (id),
)