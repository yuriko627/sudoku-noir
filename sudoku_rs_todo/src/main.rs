const N: usize = 9;
const M: usize = 3;

type Board = [[u32; N]; N];

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
    todo!("Check that each row contains 1 to 9 without repeats");
    // Columns
    todo!("Check that each column contains 1 to 9 without repeats");
    // Squares
    todo!("Check that each 3x3 square (at offsets multiple of 3) contains 1 to 9 without repeats");
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
