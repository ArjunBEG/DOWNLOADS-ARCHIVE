let posts = '', postLinks = '';
if(this.state.posts && this.state.posts.data){
  posts = this.state.posts.data.map(post => {return <Post post={post} key={"post_"+post.id}/>;});
  postLinks = this.state.posts.data.map(post => {return <a href={"#"+post.id} key={"post_link_"+post.id} className="button">{post.title}</a>})
}