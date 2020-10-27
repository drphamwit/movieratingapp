import React, { Component } from 'react';
import './App.css';
import { ratingContract, account0 } from "./config";
import { ShowMovies } from "./ShowMovies";
class App extends Component {
    constructor(props) {
        super(props)
        this.state = {
            movies: [
                { name: 'Avatar', rating: 0 },
                { name: 'Inception', rating: 0 },
                { name: 'Spider Man: Home Coming', rating: 0 },
                { name: 'Star Wars: The last Jedi', rating: 0 }
            ]
        }

        this.handleVoting = this.handleVoting.bind(this)
    }

    handleVoting(movie) {
        let app = this
        ratingContract.methods.vote(movie).send({ from: account0 }, (error, transactionHash) => {
            console.log("vote clicked!!!");
            if (!error) {
                ratingContract.methods.getTotalVotes(movie).call().then(function (votes) {
                    app.setState({
                        movies: app.state.movies.map(
                            (el) => el.name === movie ? Object.assign({}, el, { rating: votes }) : el
                        )
                    })
                })
            }
        });
    }
    render() {
        return (<div className="App" >
            <p className="App-intro" >
                Movie Rating Application in Ethereum and React
                    </p>
            <div className="movie-table" >
                <
                    ShowMovies movies={this.state.movies}
                    vote={this.handleVoting}
                />
            </div >
        </div>
        );
    }
}
export default App;