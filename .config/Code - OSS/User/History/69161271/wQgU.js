import { useState, useEffect } from "react";

const App = () => {
  const [movieData, setMovieData] = useState([]);
  useEffect(() => {
    fetch("https://ghibliapi.herokuapp.com/films")
      .then((res) => res.json())
      .then((json) => {
        setMovieData(JSON.stringify(json));
      });
  }, []);
  return (
    <div className="App">
      <h1>Movie API</h1>
      <pre>{movieData}</pre>
    </div>
  );
};

export default App;
