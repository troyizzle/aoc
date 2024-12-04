import { readFileSync } from "fs"

const fileName = process.argv[2].split("/").pop()

if (!fileName) {
  throw new Error("No file name")
}

console.log(`READING FILE --- ${fileName} --- `)

const file = readFileSync(fileName, "utf-8").trim().split("\n") as string[]

const part1 = file.reduce(
  (acc, line) => {
    const matches = line.match(/mul\((\d+),(\d+)\)/g)
    const cleanedMatches = matches ? matches.map(match =>
      match.match(/\d+/g)?.map(Number)
    ) : [];

    return acc + cleanedMatches.reduce((acc2, [a, b]) => acc2 + (a * b), 0)
  },
  0
)

console.log("part 1", part1)

const fileContents = readFileSync(fileName).toString();

const inputSplit = fileContents.split("mul(")
let followsDo = false;
let followsDont = false;
let result = 0

for (let i = 0; i < inputSplit.length; i++) {
  const previousItem = inputSplit[i - 1]
  if (previousItem) {
    followsDo = previousItem.includes("do()") && previousItem.indexOf("do()") > previousItem.indexOf("don't()")
    if (previousItem.includes("don't()")) {
      followsDont = true;
    }
    if (followsDo) followsDont = false;
    if (!followsDont) {
      const afterMulsAsArray = inputSplit[i].split(")")
      const possibleNumberString = afterMulsAsArray[0]

      const possibleNumbers = possibleNumberString.split(",").map(Number)
      const isValid = possibleNumbers.length === 2 && possibleNumbers.every(Number.isInteger)
      if (isValid) {
        result += possibleNumbers.reduce((acc, num) => acc * num, 1)
      }
    }
  }
}
console.log("part 2", result)
