import React, { Component } from "react";
import "./index.css";
import * as ReactDOM from "react-dom";

function Square(props) {
  return (
    <button
      className="square"
      onClick={() => props.onClick()}
      disabled={props.disabled}
    >
      {props.value}
    </button>
  );
}

class Board extends Component {
  constructor(props) {
    super(props);

    this.state = {
      squares: Array(9).fill(null),
      xNext: true,
    };
  }

  render() {
    const winner = this.state.winner;
    let status = `Next player: ${this.state.xNext ? "X" : "O"}`;
    if (!!winner) {
      status = `Winner: ${winner}`;
    }

    return (
      <div>
        <div className="status">{status}</div>
        {Array(3)
          .fill(null)
          .map((_, r) => this.renderBoard(r))}
      </div>
    );
  }

  renderBoard(row) {
    return (
      <div className="board-row">
        {Array(3)
          .fill(null)
          .map((_, col) => this.renderSquare(row, col))}
      </div>
    );
  }

  renderSquare(row, col) {
    let i = row * 3 + col;
    return (
      <Square
        disabled={!!this.state.winner}
        value={this.state.squares[i]}
        onClick={() => this.handleClick(i)}
      />
    );
  }

  handleClick(i) {
    const squares = this.state.squares.slice();
    let isX = this.state.xNext;
    squares[i] = isX ? "X" : "O";

    const winner = this.findWinner(squares);
    this.setState({
      squares: squares,
      xNext: !isX,
      winner: winner,
    });
  }

  findWinner(squares) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (let i = 0; i < lines.length; i++) {
      const [a, b, c] = lines[i];
      if (
        squares[a] &&
        squares[a] === squares[b] &&
        squares[a] === squares[c]
      ) {
        return squares[a];
      }
    }
    return null;
  }
}

function Game() {
  return (
    <div className="game">
      <div className="game-board">
        <Board />
      </div>
      <div className="game-info">
        <div>{/*status*/}</div>
        <div>{/*TODO*/}</div>
      </div>
    </div>
  );
}

ReactDOM.render(<Game />, document.getElementById("root"));
