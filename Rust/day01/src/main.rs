static INPUT: &str = ::core::include_str!("../../../Inputs/day01.txt");
const TARGET: u32 = 2020;

use {
    core::ops::{Add, Mul},
    core::str::FromStr,
};

pub fn parse<T: FromStr>(input: &'_ str) -> impl Iterator<Item = Result<T, T::Err>> + '_ {
    input.lines().map(|elem| elem.parse::<T>())
}

pub fn solve<I, T>(it: I, target: T) -> Option<T>
where
    I: Clone + Iterator<Item = T>,
    T: Copy + PartialEq + Add<Output = T> + Mul<Output = T>,
{
    for (idx, x) in it.clone().enumerate() {
        for y in it.clone().skip(idx) {
            if (x + y) == target {
                return Some(x * y);
            }
        }
    }

    None
}

pub fn solve2<I, T>(it: I, target: T) -> Option<T>
where
    I: Clone + Iterator<Item = T>,
    T: Copy + PartialEq + Add<Output = T> + Mul<Output = T>,
{
    for (idx, x) in it.clone().enumerate() {
        for (idx2, y) in it.clone().enumerate().skip(idx) {
            for z in it.clone().skip(idx2) {
                if (x + y + z) == target {
                    return Some(x * y * z);
                }
            }
        }
    }

    None
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let v = parse(INPUT).collect::<Result<Vec<u32>, _>>()?;

    let p1 = solve(v.iter().copied(), TARGET);
    let p2 = solve2(v.iter().copied(), TARGET);

    println!("Part 1: {:?}\nPart 2: {:?}", p1, p2);
    Ok(())
}
