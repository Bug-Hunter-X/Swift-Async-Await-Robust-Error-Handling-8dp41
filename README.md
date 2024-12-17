# Swift Async/Await Robust Error Handling

This repository demonstrates a common issue with error handling in Swift's async/await and provides a more robust solution.

## Problem
The original code uses a basic `catch` block which prints the error and doesn't handle specific network problems or retries.

## Solution
The improved solution uses a more refined error handling strategy, distinguishing between different error types and implementing a retry mechanism to improve reliability.
