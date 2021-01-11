import React from "react"

class TwitterCallback extends React.Component {
    constructor(props) {
        super(props);
    }

    componentDidMount() {
        document.getElementById('react-twitter-callback-button').click();
    }

    render() {
        return (
            <div>
                <form action={"/auth/twitter/callback/done"} method={"POST"} className={"auth-form"}>
                    <input type={"hidden"} name={'provider'} value={this.props.info.provider}/>
                    <input type={"hidden"} name={'twitter_uid'} value={this.props.info.twitterUid}/>
                    <input type={"hidden"} name={'name'} value={this.props.info.name}/>
                    <input type={"hidden"} name={'image'} value={this.props.info.image}/>
                    <input type={"hidden"} name={'description'} value={this.props.info.description}/>
                    <input type={"hidden"} name={'url'} value={this.props.info.url}/>
                    <input type={"hidden"} name={'twitter_url'} value={this.props.info.twitterUrl}/>
                    <input type={"hidden"} name={'location'} value={this.props.info.location}/>
                    <input type={"submit"} id={'react-twitter-callback-button'}/>
                </form>
            </div>
        );
    }
}

export default TwitterCallback
