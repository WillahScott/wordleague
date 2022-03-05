CREATE TABLE challenges (
    id uuid not null,
    league uuid references public.leagues not null,
    creator uuid references public.players not null,
    challenge_date timestamp with time zone,
    word text not null,
    word_length integer GENERATED ALWAYS AS (char_length(word)) STORED,
    language text,

    primary key (id),
    constraint word_length check (char_length(word) >= 4)
);

-- Security Policies;
ALTER TABLE challenges ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Players can create, view, update, and delete their own challenges."
    ON challenges for ALL
    WITH CHECK ( auth.uid() = creator );
