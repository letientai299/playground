import React, {PureComponent} from "react";

export class Counter extends PureComponent {
  constructor(props) {
    super(props);
    this.state = {val: 1, created: new Date()};
  }

  render() {
    return (
      <div>
        <h1>Counter ({this.state.created.toLocaleTimeString()})</h1>
        <pre>start={this.props.start}</pre>
        <pre>step={this.props.step}</pre>
        <pre>interval={this.props.interval}</pre>
        <b>
          <pre>val={this.state.val}</pre>
        </b>
      </div>
    );
  }
}
