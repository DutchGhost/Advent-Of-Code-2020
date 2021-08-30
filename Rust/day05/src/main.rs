static INPUT: &str = ::core::include_str!("../../../Inputs/day05.txt");

fn partition(characters: &str) -> u8 {
    let len = characters.len();

    characters
        .bytes()
        .enumerate()
        .fold(0, |place, (idx, c)| match c {
            b'B' | b'R' => place | (1 << (len - idx - 1)),
            b'F' | b'L' => place,
            _ => unreachable!(),
        })
}

fn main() {
    let mut max_seat_id = 0;
    let mut boarded = [false; 1000];

    for line in INPUT.lines() {
        let (row_line, column_line) = line.split_at(7);

        let row = partition(row_line) as u32;
        let column = partition(column_line) as u32;

        let seat_id = row * 8 + column;

        max_seat_id = core::cmp::max(max_seat_id, seat_id);

        boarded[seat_id as usize] = true;
    }

    let mut prv = 0;

    for (idx, b) in boarded.iter().enumerate() {
        if !*b {
            if idx == prv + 1 || idx == 0 {
                prv = idx;
            } else {
                prv = idx;
                break;
            }
        }
    }

    let boarding_id = prv;
    println!("Part 1: {}\nPart 2: {}", max_seat_id, boarding_id);
}
