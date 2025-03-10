// Board size is NxN
global N: u32 = 9;
// Sub-board size is MxM
global M: u32 = 3;

struct Board {
    values: [[u32; N]; N],
}

// NOTE: Noir doesn't have `core::array::from_fn`.  You can instead initialize an array with 0 values and then overwrite it wity your desired values.

fn permutation_one_to_n(values: [u32; N]) {
    let mut values = values;
    let sorted = values.sort();
    for i in 0..N {
        assert(sorted[i] == i as u32 + 1, "Invalid permutation");
    }
}

fn verify(init: Board, solution: Board) {
    // TODO: Create a board from init and solution
    let mut board = Board { values: [[0; N]; N] };

    for row in 0..N {
        for col in 0..N {
            if init.values[row][col] != 0 {
                board.values[row][col] = init.values[row][col];
            } else {
                board.values[row][col] = solution.values[row][col];
            }
        }
    }

    // Rows
    // TODO: Verify rows
    for row in 0..N {
        let mut row_values = board.values[row];
        permutation_one_to_n(row_values);
    }

    // Columns
    // TODO: Verify columns
    for col in 0..N {
        let mut col_values = [0, 0, 0, 0, 0, 0, 0, 0, 0];
        for row in 0..N {
            col_values[row] = board.values[row][col];
        }
        permutation_one_to_n(col_values)
    }

    // Squares
    // TODO: Verify squares
    let mut sq_values = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    for square_y in 0..M {
        for square_x in 0..M {
            let mut row_offset = square_y * M;
            let mut col_offset = square_x * M;

            println(f"row_offset: {row_offset}, col_offset: {col_offset}");

            for i in 0..N {
                let mut row_index = row_offset + i / M;
                let mut col_index = col_offset + i % M;
                println(f"row_index: {row_index}, col_index: {col_index}");
                sq_values[i] = board.values[row_index][col_index];
            }
            permutation_one_to_n(sq_values);
        }
    }
}

fn main(solution: Board) {
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
    verify(Board { values: init }, solution);
}

// // Example 9,3
// [solution]
// values = [
// ["2", "1", "5", "3", "7", "9", "8", "6", "4"],
// ["9", "8", "6", "1", "2", "4", "3", "5", "7"],
// ["7", "3", "4", "8", "5", "6", "2", "1", "9"],
// ["4", "5", "2", "7", "8", "1", "6", "9", "3"],
// ["8", "6", "9", "5", "4", "3", "1", "7", "2"],
// ["3", "7", "1", "6", "9", "2", "4", "8", "5"],
// ["5", "2", "7", "4", "1", "8", "9", "3", "6"],
// ["6", "4", "8", "9", "3", "7", "5", "2", "1"],
// ["1", "9", "3", "2", "6", "5", "7", "4", "8"],
// ]

#[test]
fn test_permutation_one_to_n_positive() {
    permutation_one_to_n([2, 3, 1, 4, 6, 5, 9, 7, 8]);
    permutation_one_to_n([4, 7, 6, 1, 9, 5, 3, 2, 8]);
}

#[test(should_fail)]
fn test_permutation_one_to_n_negative_1() {
    permutation_one_to_n([2, 3, 1, 4, 6, 5, 9, 7, 2]);
}

#[test(should_fail)]
fn test_permutation_one_to_n_negative_2() {
    permutation_one_to_n([2, 3, 1, 4, 6, 5, 9, 7, 10]);
}

#[test]
fn test_verify_positive() {
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
    verify(Board { values: init }, Board { values: solution });
}

#[test(should_fail)]
fn test_verify_negative_1() {
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
    let solution = [
        [2, 2, 5, 3, 7, 9, 8, 6, 4],
        [9, 8, 6, 1, 2, 4, 3, 5, 7],
        [7, 3, 4, 8, 5, 6, 2, 1, 9],
        [4, 5, 2, 7, 8, 1, 6, 9, 3],
        [8, 6, 9, 5, 4, 3, 1, 7, 2],
        [3, 7, 1, 6, 9, 2, 4, 8, 5],
        [5, 2, 7, 4, 1, 8, 9, 3, 6],
        [6, 4, 8, 9, 3, 7, 5, 2, 1],
        [1, 9, 3, 2, 6, 5, 7, 4, 8],
    ];
    verify(Board { values: init }, Board { values: solution });
}

#[test(should_fail)]
fn test_verify_negative_2() {
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
    let solution = [
        [2, 1, 5, 3, 7, 9, 8, 6, 4],
        [2, 8, 6, 1, 9, 4, 3, 5, 7],
        [7, 3, 4, 8, 5, 6, 2, 1, 9],
        [4, 5, 2, 7, 8, 1, 6, 9, 3],
        [8, 6, 9, 5, 4, 3, 1, 7, 2],
        [3, 7, 1, 6, 9, 2, 4, 8, 5],
        [5, 2, 7, 4, 1, 8, 9, 3, 6],
        [6, 4, 8, 9, 3, 7, 5, 2, 1],
        [1, 9, 3, 2, 6, 5, 7, 4, 8],
    ];
    verify(Board { values: init }, Board { values: solution });
}

#[test(should_fail)]
fn test_verify_negative_3() {
    let init = [
        [1, 2, 3, 4, 5, 6, 7, 8, 0],
        [9, 0, 0, 3, 0, 0, 0, 0, 0],
        [8, 0, 0, 2, 0, 0, 0, 0, 0],
        [7, 0, 0, 1, 0, 0, 0, 0, 6],
        [6, 0, 0, 9, 0, 0, 0, 0, 5],
        [5, 0, 0, 8, 0, 0, 0, 0, 4],
        [4, 0, 0, 7, 0, 0, 0, 0, 3],
        [3, 0, 0, 6, 0, 0, 0, 0, 2],
        [2, 0, 0, 5, 0, 0, 0, 0, 1],
    ];
    let solution = [
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [9, 1, 2, 3, 4, 5, 6, 7, 8],
        [8, 9, 1, 2, 3, 4, 5, 6, 7],
        [7, 8, 9, 1, 2, 3, 4, 5, 6],
        [6, 7, 8, 9, 1, 2, 3, 4, 5],
        [5, 6, 7, 8, 9, 1, 2, 3, 4],
        [4, 5, 6, 7, 8, 9, 1, 2, 3],
        [3, 4, 5, 6, 7, 8, 9, 1, 2],
        [2, 3, 4, 5, 6, 7, 8, 9, 1],
    ];
    verify(Board { values: init }, Board { values: solution });
}
