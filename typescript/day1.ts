let calories = {}
const fs = require('fs');

const buffer = fs.readFileSync("../inputs/day1.txt")
const split = buffer.toString().split("\n\n")
split.forEach((snacks, index) => {
  calories[index] = snacks.split("\n").map((snack) => +snack).reduce((a, b) => a +b, 0)
})

let sorted_keys = Object.keys(calories).sort((a, b) => calories[b] - calories[a])
console.log("part a", calories[sorted_keys[0]])
console.log("part b", [0, 1, 2].reduce((acc, num) => calories[sorted_keys[num]] + acc, 0))
