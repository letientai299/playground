import "./App.css";
import Clock from "./clock/Clock";

const App = () => {
  const components = [<Clock />];
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
