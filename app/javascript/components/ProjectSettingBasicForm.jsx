import React from "react"

class ProjectSettingBasicForm extends React.Component {
    constructor(props) {
        super(props);
        this.state={
            image: this.props.project.image.url,
            imageWarning: ""
        };
    }

    render(){
        let warningPermalink;
        let warningTitle;
        let warningImage;

        if(this.props.permalinkWarning !== ""){
            warningPermalink = (
                <div className={"warning"}>
                    {this.props.permalinkWarning}
                </div>
            );
        }

        if(this.props.titleWarning !== ""){
            warningTitle = (
                <div className={"warning"}>
                    {this.props.titleWarning}
                </div>
            );
        }

        if(this.state.imageWarning !== ""){
            warningImage = (
                <div className={"warning"}>
                    {this.state.imageWarning}
                </div>
            );
        }
        return(
            <div>
                <form action={`/projects/${this.props.project.permalink}/settings`} method={"POST"} className={"project-settings-form"}>
                    <h3>基本設定</h3>
                    <h4>プロジェクトID<small>（必須、英数字および「_」のみ）</small></h4>
                    <h5>リンク名に使われます</h5>
                    <input type={"text"} name={"new_permalink"}/>
                    {warningPermalink}

                    <h4>タイトル<small>（必須）</small></h4>
                    <input type={"text"} name={"title"}/>
                    {warningTitle}

                    <h4>トップ画像</h4>
                    <h5>4MB以下のgif、png、jpgファイル<br/>1200x630px推奨</h5>
                    <img src={this.state.image} alt={""} className={"thumbnail"}/>
                    <input type={"file"} name={"image"} id={"react-image"} onChange={(e)=>{this.onChangeInputImage(e)}}/>
                    {warningImage}

                    <h4>プロジェクト内容</h4>
                    <textarea name={"description"}/>

                    <button type={"submit"}>更新</button>
                </form>
            </div>
        );
    }
}

export default ProjectSettingBasicForm
