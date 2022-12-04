var fs = require("fs");
var choices = ["rock", "paper", "scissors"];
var gameOptions = {
    rock: {
        beats: "scissors",
        points: 1,
        values: ["A", "X"]
    },
    paper: {
        beats: "rock",
        points: 2,
        values: ["B", "Y"]
    },
    scissors: {
        beats: "paper",
        points: 3,
        values: ["C", "Z"]
    }
};
function findPlayerChoice(value) {
    for (var _i = 0, choices_1 = choices; _i < choices_1.length; _i++) {
        var key = choices_1[_i];
        if (gameOptions[key].values.includes(value))
            return key;
    }
    return undefined;
}
console.log("hello");
var buffer = fs.readFileSync("../inputs/day2_sample.txt");
buffer
    .toString()
    .split("\n")
    .forEach(function (line) {
    var myChoice = findPlayerChoice(line[2]);
    console.log(myChoice);
});
