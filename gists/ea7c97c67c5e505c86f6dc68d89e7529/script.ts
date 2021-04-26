function App() {
    return <div>
        <h1>Hi, I'm GistPad 👋</h1>
        <p>Feel free to edit the HTML, JavaScript and CSS in this playground. The preview will update in real-time, so that you can visually explore your ideas.</p>
        <button onClick={() => alert("Hi!")}>Say Hi <span className="fa fa-heart" /></button>
    </div>;
}

ReactDOM.render(<App />, document.getElementById("app"));