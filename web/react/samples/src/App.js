import "./App.css";
import {Clock} from "./components/Clock";
import {Counter} from "./components/Counter";
import {Hello} from "./components/Hello";

const App = () => {
  const components = [
    <Hello name="React"/>,
    <Clock/>,
    <Counter start={1} step={1} interval={1}/>,
  ];
  return (
    <div>
      {components.map((c) => (
        <div key={c.type} className="sample-component">
          {c}
        </div>
      ))}
    </div>
  );
};

export default App;
