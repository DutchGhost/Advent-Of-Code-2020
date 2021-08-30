static INPUT: &str = ::core::include_str!("../../../Inputs/day03.txt");
const TREE: u8 = b'#';

#[derive(Copy, Clone, Eq, PartialEq, Ord, PartialOrd, Debug)]
struct Config {
    right: usize,
    down: usize,
}

fn traverse(map: &str, config: Config) -> usize {
    let mut lines = map.lines();
    let mut trees = 0;

    let mut x = 0;

    while let Some(line) = lines.next() {
        let skip = config.down - 1;

        for _ in 0..skip {
            lines.next();
        }
        let vx = x % line.len();

        if let Some(square) = line.as_bytes().get(vx) {
            if *square == TREE {
                trees += 1;
            }
        }

        x += config.right;
    }

    trees
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
        .fold(1, |acc, trees| acc * trees)
}
fn main() {
    let p1 = part1(INPUT);
    let p2 = part2(INPUT);

    println!("Part1: {}\nPart2: {}", p1, p2);
}
