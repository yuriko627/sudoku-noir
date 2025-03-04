// Board size is NxN
global N: u32 = 9;
// Sub-board size is MxM
global M: u32 = 3;

struct Board {
    values: [[u32; N]; N],
}

fn permutation_one_to_n(values: [u32; N]) {
    let sorted = values.sort();
    let mut expected = [0; N];
    for i in 0..N {
        expected[i] = i+1;
    }
    assert(sorted == expected, f"{sorted} != {expected}");
}

fn verify(init: Board, solution: Board) {
    let mut board = Board{values: [[0; N]; N]};
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
    for row in 0..N {
        let mut values = [0; N];
        for col in 0..N {
            values[col] = board.values[row][col];
        }
        permutation_one_to_n(values);
    }
    // Columns
    for col in 0..N {
        let mut values = [0; N];
        for row in 0..N {
            values[row] = board.values[row][col];
        }
        permutation_one_to_n(values);
    }
    // Squares
    for square_y in 0..N / M {
        for square_x in 0..N / M {
            let row = square_y * M;
            let col = square_x * M;
            let mut values = [0; N];
            for i in 0..N {
                values[i] = board.values[row + (i / M)][col + (i % M)];
            }
            permutation_one_to_n(values);
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
    verify(Board{values: init}, solution);
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
fn test_permutation_one_to_n() {
    permutation_one_to_n([2, 3, 1, 4, 6, 5, 9, 7, 8]);
}

#[test]
fn test_verify() {
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
    verify(Board{values: init}, Board{values: solution});
}
