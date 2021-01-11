import React from "react"

class SnsForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <div className={"sns-box"}>
                    <form action={"/auth/twitter"} method={"POST"} className={"sns-form"}>
                        <button type={"submit"} className={"twitter"}>
                            <i className={"fab fa-twitter"}/> Twitterで{this.props.info.loginOrSignup}
                        </button>
                    </form>
                    <form action={"/auth/github"} method={"POST"} className={"sns-form"}>
                        <button type={"submit"} className={"github"}>
                            <i className={"fab fa-github"}/> GitHubで{this.props.info.loginOrSignup}
                        </button>
                    </form>
                </div>
            </div>
        )
    }
}

export default SnsForm
