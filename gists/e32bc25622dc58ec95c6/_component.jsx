var Status = React.createClass({
    mixins: [ListenToMixin],
    componentDidMount: function() {
        this.listenTo(store, this.onStatusChange);
    },
    onStatusChange: function(status) {
        this.setState({
            status: status
        });
    },
    renderList: function () {
        return this.state.status.a.map(function (item) {
            return <li>{item}</li>
        });
    },
    render: function() {
        return <ul>{this.renderList}</ul>;
    }
});