import { readFileSync } from "fs"

const fileName = process.argv[2].split("/").pop()

if (!fileName) {
  throw new Error("No file name")
}

console.log(`READING FILE --- ${fileName} --- `)

const file = readFileSync(fileName, "utf-8").trim().split("\n") as string[]

const [leftList, rightList] = file.reduce(
  (acc, line) => {
    const nums = line.split(" ").map(Number).filter((num) => num != 0)
    if (nums.length > 0) {
      acc[0].push(nums[0])
      acc[1].push(nums[1])
    }

    return acc
  },
  [[], []] as [number[], number[]]
)

const leftSorted = leftList.sort((a, b) => a - b)
const rightSorted = rightList.sort((a, b) => a - b)

let totalDistance = leftSorted.reduce((sum, left, i) => {
  return sum + Math.abs(left - rightSorted[i]);
}, 0);

console.log("part 1", totalDistance)

let similarityScore = 0;
let j = 0;

for (const left of leftSorted) {
  while (j < rightSorted.length && rightSorted[j] < left) {
    j++;
  }

  let count = 0;
  while (j < rightSorted.length && rightSorted[j] === left) {
    count++;
    j++;
  }

  similarityScore += count * left;
}

console.log("part 2", similarityScore)
