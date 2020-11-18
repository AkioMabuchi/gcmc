import React from "react"

class UserSettingCreateEmailForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return(
            <div>
                <form action={"/settings/email/create"} method={"POST"} className={"settings-form create-email-form"}>
                    <h3>{this.props.info.title}</h3>
                    <div className={"notice"}>
                        このアカウントにはメールアドレスが登録されていません
                    </div>
                </form>
            </div>
        )
    }
}

export default UserSettingCreateEmailForm
