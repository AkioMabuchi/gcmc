import React from "react"

class UserVerifyForm extends React.Component {
    constructor(props) {
        super(props);
    }

    componentDidMount() {
        document.getElementById("react-user-verify-submit").click();
    }

    render(){
        return(
            <div>
                <form action={"/verify"} method={"POST"} className={"user-verify-form"}>
                    <input type={"hidden"} name={"hash"} value={this.props.info.hash}/>
                    <input type={"submit"} id={"react-user-verify-submit"}/>
                </form>
            </div>
        );
    }
}

export default UserVerifyForm
