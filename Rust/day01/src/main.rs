static INPUT: &str = ::core::include_str!("../../../Inputs/day01.txt");
const TARGET: u32 = 2020;

use core::{
    hash::Hash,
    ops::{Mul, Sub},
    str::FromStr,
};

pub fn parse<T: FromStr>(input: &'_ str) -> impl Iterator<Item = Result<T, T::Err>> + '_ {
    input.lines().map(|elem| elem.parse::<T>())
}

fn solve<I, T>(it: I, target: I::Item) -> (Option<I::Item>, Option<I::Item>)
where
    I: Iterator<Item = T>,
    T: Copy + PartialEq + Mul<Output = T> + Sub<Output = T> + Eq + Hash,
{
    use std::collections::HashSet;

    let mut set = HashSet::new();
    let mut p1 = None;
    let mut p2 = None;

    for x in it {
        let search_value = target - x;
        p1 = p1.or(set.get(&search_value).map(|y| x * *y));

        for y in set.iter() {
            let search_value = target - x - *y;
            p2 = p2.or(set.get(&search_value).map(|z| x * *y * *z));
        }

        set.insert(x);
    }

    (p1, p2)
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let (p1, p2) = solve(parse(INPUT).filter_map(Result::ok), TARGET);
    println!("Part 1: {:?}\nPart2: {:?}", p1, p2);
    Ok(())
}
