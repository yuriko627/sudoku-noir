const N: usize = 9;
const M: usize = 3;

type Board = [[u32; N]; N];

fn permutation_one_to_n(values: [u32; N]) {
    let mut values = values;
    values.sort();
    assert_eq!(values, core::array::from_fn(|i| (i as u32) + 1));
}

pub fn verify(init: &Board, solution: &Board) {
    // We replace the zero values in the initial board with the solution values.
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
            let row_offset = square_y * M;
            let col_offset = square_x * M;
            let values =
                core::array::from_fn(|i| board[row_offset + (i / M)][col_offset + (i % M)]);
            permutation_one_to_n(values);
        }
    }
}

fn main() {
    println!("I ❤️ sudoku!");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_0() {
        #[rustfmt::skip]
        let init = [
        [2, 0, 5, 0, 0, 9, 0, 0, 4],
        [0, 0, 0, 0, 0, 0, 3, 0, 7],
        [7, 0, 0, 8, 5, 6, 0, 1, 0],
        [4, 5, 0, 7, 0, 0, 0, 0, 0],
        [0, 0, 9, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 2, 0, 8, 5],
        [0, 2, 0, 4, 1, 8, 0, 0, 6],
        [6, 0, 8, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 2, 0, 0, 7, 0, 8],
        ];

        #[rustfmt::skip]
        let solution = [
        [2, 1, 5, 3, 7, 9, 8, 6, 4],
        [9, 8, 6, 1, 2, 4, 3, 5, 7],
        [7, 3, 4, 8, 5, 6, 2, 1, 9],
        [4, 5, 2, 7, 8, 1, 6, 9, 3],
        [8, 6, 9, 5, 4, 3, 1, 7, 2],
        [3, 7, 1, 6, 9, 2, 4, 8, 5],
        [5, 2, 7, 4, 1, 8, 9, 3, 6],
        [6, 4, 8, 9, 3, 7, 5, 2, 1],
        [1, 9, 3, 2, 6, 5, 7, 4, 8],
        ];
        verify(&init, &solution);
    }
}
