static INPUT: &str = ::core::include_str!("../../../Inputs/day02.txt");

use {
    core::{convert::TryFrom, fmt, num::ParseIntError},
    std::error::Error,
};

pub fn parse<'a, T: TryFrom<&'a str> + 'a>(
    input: &'a str,
) -> impl Iterator<Item = Result<T, <T as TryFrom<&'a str>>::Error>> + 'a {
    input.lines().map(T::try_from)
}

struct Password<'a> {
    begin: usize,
    end: usize,
    letter: u8,
    password: &'a str,
}

impl Password<'_> {
    pub fn nappearance(&self) -> bool {
        let count = self
            .password
            .bytes()
            .filter(|byte| *byte == self.letter)
            .count();

        self.begin <= count && count <= self.end
    }

    pub fn position_appearance(&self) -> bool {
        let bytes = self.password.as_bytes();

        let a = bytes[self.begin - 1] == self.letter;
        let b = bytes[self.end - 1] == self.letter;

        a != b
    }
}

impl<'a> TryFrom<&'a str> for Password<'a> {
    type Error = PasswordParseErr;

    fn try_from(input: &'a str) -> Result<Self, Self::Error> {
        let mut split = input.split(' ');
        let range = split.next().ok_or(PasswordParseErr)?;
        let letter = split
            .next()
            .ok_or(PasswordParseErr)?
            .as_bytes()
            .get(0)
            .copied()
            .ok_or(PasswordParseErr)?;
        let password = split.next().ok_or(PasswordParseErr)?;

        split = range.split('-');
        let begin = split.next().ok_or(PasswordParseErr)?.parse::<usize>()?;
        let end = split.next().ok_or(PasswordParseErr)?.parse::<usize>()?;

        Ok(Self {
            begin,
            end,
            letter,
            password,
        })
    }
}

#[derive(Debug)]
struct PasswordParseErr;

impl From<ParseIntError> for PasswordParseErr {
    fn from(_: ParseIntError) -> Self {
        Self {}
    }
}

impl fmt::Display for PasswordParseErr {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "PasswordParseErr")
    }
}

impl Error for PasswordParseErr {}

fn main() -> Result<(), Box<dyn Error>> {
    let mut valids_part1 = 0;
    let mut valids_part2 = 0;

    for passwd in parse::<Password>(INPUT).filter_map(|passwd| passwd.ok()) {
        if passwd.nappearance() {
            valids_part1 += 1
        }
        if passwd.position_appearance() {
            valids_part2 += 1
        }
    }

    println!("Part1: {}\nPart2: {}", valids_part1, valids_part2);

    Ok(())
}
