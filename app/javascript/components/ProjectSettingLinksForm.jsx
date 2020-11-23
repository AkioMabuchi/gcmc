import React from "react"

class ProjectSettingLinksForm extends React.Component {
    constructor(props) {
        super(props);
    }

    onClickButtonLink(name, url){
        document.getElementById("react-link-name").value = name;
        document.getElementById("react-link-url").value = url;
    }

    render() {
        let nameWarning;
        let urlWarning;

        if(this.props.info.nameWarning !== null){
            nameWarning = (
                <div className={"warning"}>
                    {this.props.info.nameWarning}
                </div>
            );
        }

        if(this.props.info.urlWarning !== null){
            urlWarning = (
                <div className={"warning"}>
                    {this.props.info.urlWarning}
                </div>
            );
        }

        return(
            <div>
                <form action={`/projects/${this.props.info.permalink}/settings/links`} method={"POST"} className={"settings-form links-setting-form"}>
                    <h3>外部リンク設定</h3>
                    <h4>現在の外部リンク</h4>
                    <ul className={"project-links"}>
                        {
                            this.props.info.links.map((link)=>{
                                return(
                                    <li>
                                        <div className={"link-name"}>
                                            <button type={"button"} onClick={()=>{this.onClickButtonLink(link.name, link.url)}}>
                                                {link.name}
                                            </button>
                                        </div>
                                        <div className={"link-url"}>
                                            {link.url}
                                        </div>
                                    </li>
                                );
                            })
                        }
                    </ul>
                    <h4>外部リンク名</h4>
                    <input type={"text"} name={"name"} defaultValue={this.props.info.name} id={"react-link-name"}/>
                    {nameWarning}

                    <h4>URL</h4>
                    <input type={"url"} name={"url"} defaultValue={this.props.info.url} id={"react-link-url"}/>
                    {urlWarning}

                    <div className={"detail"}>
                        現在の外部リンクからリンクを削除する場合は、外部リンク名に削除したいリンク名を入力して、URLを空欄にしてください
                    </div>
                    <button type={"submit"}>更新</button>
                </form>
            </div>
        )
    }
}

export default ProjectSettingLinksForm
