// Board size is NxN
global N: u32 = 9;
// Sub-board size is MxM
global M: u32 = 3;

struct Board {
    values: [[u32; N]; N],
}

// NOTE: Noir doesn't have `core::array::from_fn`.  You can instead initialize an array with 0 values and then overwrite it wity your desired values.

fn permutation_one_to_n(values: [u32; N]) {
    assert(0 == 1, "(a) Remove me and fill this function");
}

fn verify(init: Board, solution: Board) {
    assert(0 == 1, "(b) Remove me and fill this function");

    // TODO: Create a board from init and solution

    // Rows
    // TODO: Verify rows

    // Columns
    // TODO: Verify columns

    // Squares
    // TODO: Verify squares
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
    verify(Board{values: init}, Board{values: solution});
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
    verify(Board{values: init}, Board{values: solution});
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
        [2, 8, 6, 1, 2, 4, 3, 5, 7],
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

#[test(should_fail)]
fn test_verify_negative_3() {
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
        [9, 2, 6, 1, 2, 4, 3, 5, 7],
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
