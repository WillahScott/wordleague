CREATE TABLE test_challenges (
    id uuid not null,
    league text not null, -- uuid references public.leagues not null,
    creator text not null, -- uuid references public.players not null,
    challenge_date timestamp with time zone,
    word text not null,
    word_length integer GENERATED ALWAYS AS (char_length(word)) STORED,
    language text,

    primary key (id),
    constraint word_length check (char_length(word) >= 4)
);
