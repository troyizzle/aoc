const fs = require("fs");

const choices = ["rock", "paper", "scissors"] as const;
type Choices = typeof choices[number];

const gameOptions: Record<
  Choices,
  { beats: Choices; points: number; values: string[] }
> = {
  rock: {
    beats: "scissors",
    points: 1,
    values: ["A", "X"],
  },
  paper: {
    beats: "rock",
    points: 2,
    values: ["B", "Y"],
  },
  scissors: {
    beats: "paper",
    points: 3,
    values: ["C", "Z"],
  },
};

function findPlayerChoice(value: string): Choices | undefined {
  for (const key of choices) {
    if (gameOptions[key].values.includes(value)) return key;
  }

  console.log("was unable to find a match for", value)

  return undefined;
}

type GameResults = "draw" | "win" | "lose"


function gameResults(myChoice: Choices, opponentChoice: Choices): GameResults {
  if (myChoice == opponentChoice) return "draw"

  if (gameOptions[myChoice].beats == opponentChoice) return "win"

  return "lose"
}

function addGameResultsPoints(results: GameResults, points: number): number {
  if (results === "lose") return points;
  if (results === "win") {
    return points += WIN
  } else {
    return points += DRAW
  }
}

function findChosenOutcome(value: string): GameResults {
  if (value === "X") {
    return "lose"
  } else if (value === "Y") {
    return "draw"
  } else {
    return "win"
  }
}

function findChoiceByChosenResult(chosenOutcome: GameResults, opponentChoice: Choices): Choices {
  for (const key of choices) {
    if (gameResults(key, opponentChoice) == chosenOutcome)  return key
  }

  throw Error("Couldn't find result")
}

let playerPoints = 0
let chosenPoints = 0
const WIN = 6
const DRAW = 3

const buffer = fs.readFileSync("../inputs/day2.txt");
buffer
  .toString()
  .replace(/\r/g, "")
  .split("\n")
  .forEach((line: string) => {
    if (line === "") return
    const myChoice = findPlayerChoice(line[2])
    const opponentChoice = findChosenOutcome(line[0])
    const chosenOutcome = findChosenOutcome(line[2])
    const chosenChoice = findChoiceByChosenResult(chosenOutcome, opponentChoice)
    chosenPoints += gameOptions[chosenChoice].points
    if (!myChoice || !opponentChoice) {
      throw new Error(`was unable to find a choice for myChoice: ${myChoice}, opponentChoice: ${opponentChoice}`)
    }
    playerPoints += gameOptions[myChoice].points

    const gameResult = gameResults(myChoice, opponentChoice)
    playerPoints = addGameResultsPoints(gameResult, playerPoints)
    chosenPoints = addGameResultsPoints(chosenOutcome, chosenPoints)
  });

console.log("part a", playerPoints)
console.log("part b", chosenPoints)
