import React from "react"

class ProjectSettingLinksForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return(
            <div>
                <form action={`/projects/${this.props.info.permalink}/settings/links`} method={"POST"} className={"settings-form"}>
                    <h3>外部リンク設定</h3>
                    <button type={"submit"}>更新</button>
                </form>
            </div>
        )
    }
}

export default ProjectSettingLinksForm
