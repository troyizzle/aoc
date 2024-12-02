import { readFileSync } from "fs"

const fileName = process.argv[2].split("/").pop()

if (!fileName) {
  throw new Error("No file name")
}

console.log(`READING FILE --- ${fileName} --- `)

const file = readFileSync(fileName, "utf-8").trim().split("\n") as string[]

const part1 = file.reduce(
  (acc, line) => {
    const numbers = line.split(" ").map(Number)

    const isValid = isValidLevel(numbers)

    return isValid ? acc + 1 : acc
  },
  0
)

console.log("part 1", part1)

const part2 = file.reduce(
  (acc, line) => {
    const numbers = line.split(" ").map(Number)

    const isValid = isValidLevel(numbers, true)

    return isValid ? acc + 1 : acc
  },
  0
)

console.log("part 2", part2)

type ValidLevelReturnType = {
  valid: boolean
  invalidIndex: number | undefined
}

function validLevel(numbers: number[]): ValidLevelReturnType {
  let direction: "up" | "down" | undefined = undefined;

  for (let i = 0; i < numbers.length; i++) {
    const currentNumber = numbers[i]
    const nextNumber = numbers[i + 1]

    if (!nextNumber) {
      return {
        valid: true,
        invalidIndex: undefined
      }
    }

    if (direction) {
      if (direction === "up") {
        if (nextNumber < currentNumber) {
          return {
            valid: false,
            invalidIndex: i
          }
        }
      } else {
        if (nextNumber > currentNumber) {
          return {
            valid: false,
            invalidIndex: i
          }
        }
      }
    }

    const result = Math.abs(currentNumber - nextNumber)

    if ((Math.abs(result) > 3 || result === 0)) {
      return {
        valid: false,
        invalidIndex: i
      }
    }

    if (!direction) {
      direction = currentNumber < nextNumber ? "up" : "down"
    }

  }

  return {
    valid: true,
    invalidIndex: undefined
  }
}

function isValidLevel(numbers: number[], remove = false): boolean {
  let result = false;

  const { valid } = validLevel(numbers)

  result = valid

  if (!result && remove) {
    let index = 0;

    while (index < numbers.length) {
      const newNumbers = numbers.filter((_num, i) => i !== index)
      const { valid: newValid } = validLevel(newNumbers)

      result = newValid
      if (result) break;
      index++
    }
  }

  return result
}

