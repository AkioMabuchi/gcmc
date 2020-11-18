import React from "react"

class ProjectSettingTagsForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <form action={`/projects/${this.props.project.permalink}/settings/tags`} method={"POST"} className={"settings-form"}>
                    <h3>タグ設定</h3>
                    <div className={"tags"}>
                        {
                            this.props.tags.map((tag) => {
                                return (
                                    <p>
                                        <input type={"checkbox"} name={`tags[]`} value={tag.id}
                                               defaultChecked={this.props.selectedTags.includes(Number(tag.id))}/>
                                        {tag.name}
                                    </p>
                                );
                            })
                        }
                    </div>
                    <button type={"submit"}>更新</button>
                </form>
            </div>
        );
    }
}

export default ProjectSettingTagsForm
