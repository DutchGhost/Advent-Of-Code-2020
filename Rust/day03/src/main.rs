static INPUT: &str = ::core::include_str!("../../../Inputs/day03.txt");
const TREE: u8 = b'#';

#[derive(Copy, Clone, Eq, PartialEq, Ord, PartialOrd, Debug)]
struct Config {
    right: usize,
    down: usize,
}

fn traverse(map: &str, config: Config) -> usize {
    let mut x = 0;
    map.lines()
        .step_by(config.down)
        .filter_map(|line| {
            let vx = x % line.len();
            x += config.right;
            line.as_bytes().get(vx)
        })
        .filter(|square| **square == TREE)
        .count()
}

fn part1(map: &str) -> usize {
    traverse(map, Config { right: 3, down: 1 })
}

fn part2(map: &str) -> usize {
    const CONFIGS: &[Config] = &[
        Config { right: 1, down: 1 },
        Config { right: 3, down: 1 },
        Config { right: 5, down: 1 },
        Config { right: 7, down: 1 },
        Config { right: 1, down: 2 },
    ];

    CONFIGS
        .iter()
        .map(|config| traverse(map, *config))
        .product()
}
fn main() {
    let p1 = part1(INPUT);
    let p2 = part2(INPUT);

    println!("Part1: {}\nPart2: {}", p1, p2);
}
