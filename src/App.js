import './App.css';
import imageRickMorty from './img/rick-morty.png';
import { useState } from 'react';
import Character from './components/Characters';

function App() {
  const [characters, setCharacters] = useState(null);

  const reqApi = async () => {
    const api = await fetch('https://rickandmortyapi.com/api/character');
    const characterApi = await api.json();
    setCharacters(characterApi.results);
  }
  return (
    <div className="App">
      <header className="App-header">
        <h1 className="title">Rick & Morty</h1>
        {characters ? (
          <Character characters={characters} setCharacters={setCharacters}/>
        ) : (
          <>
            <img src={imageRickMorty} alt="Rick & Morty" className="img-home"></img>
            <button onClick={reqApi} className="btn-search">Buscar Personajes</button>
          </>
        ) }
      </header>
    </div>
  );
}

export default App;
