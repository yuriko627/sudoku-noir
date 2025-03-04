const N: usize = 4;
const M: usize = 2;

type Board = [[u32; N]; N];

fn permutation_one_to_n(values: [u32; N]) {
    let mut values = values;
    values.sort();
    assert_eq!(values, core::array::from_fn(|i| (i as u32) + 1));
}

pub fn verify(init: &Board, solution: &Board) {
    let board: Board = core::array::from_fn(|row| {
        core::array::from_fn(|col| {
            if init[row][col] != 0 {
                init[row][col]
            } else {
                solution[row][col]
            }
        })
    });
    // Rows
    for row in 0..N {
        let values = core::array::from_fn(|col| board[row][col]);
        permutation_one_to_n(values);
    }
    // Columns
    for col in 0..N {
        let values = core::array::from_fn(|row| board[row][col]);
        permutation_one_to_n(values);
    }
    // Squares
    for square_y in 0..N / M {
        for square_x in 0..N / M {
            let row = square_y * M;
            let col = square_x * M;
            let values = core::array::from_fn(|i| board[row + (i / M)][col + (i % M)]);
            permutation_one_to_n(values);
        }
    }
}

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_0() {
        #[rustfmt::skip]
        let init = [
            [2, 0, 3, 0],
            [0, 3, 0, 2],
            [3, 0, 4, 0],
            [1, 4, 0, 0],
        ];

        #[rustfmt::skip]
        let solution = [
            [2, 1, 3, 4],
            [4, 3, 1, 2],
            [3, 2, 4, 1],
            [1, 4, 2, 3],
        ];
        verify(&init, &solution);
    }
}
