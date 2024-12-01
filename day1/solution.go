package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("No filename")
		os.Exit(1)
	}

	fileName := os.Args[1]

	file, err := os.Open(fileName)
	if err != nil {
		fmt.Printf("Error opening file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	var leftList, rightList []int
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Fields(line)
		if len(parts) == 2 {
			left, _ := strconv.Atoi(parts[0])
			right, _ := strconv.Atoi(parts[1])
			leftList = append(leftList, left)
			rightList = append(rightList, right)
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Printf("Error reading file: %v\n", err)
		os.Exit(1)
	}

	sort.Ints(leftList)
	sort.Ints(rightList)

	totalDistance := 0
	for i := 0; i < len(leftList); i++ {
		totalDistance += abs(leftList[i] - rightList[i])
	}
	fmt.Printf("Part 1: %d\n", totalDistance)

	tally := make(map[int]int)
	for _, right := range rightList {
		tally[right]++
	}

	similarityScore := 0
	for _, left := range leftList {
		similarityScore += tally[left] * left
	}
	fmt.Printf("Part 2: %d\n", similarityScore)
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
