<input type="search" className="searchBox" onChange={event => {
  if(event.currentTarget.value) this.searchPost(event.currentTarget.value);
  else this.viewAll();
}}/>