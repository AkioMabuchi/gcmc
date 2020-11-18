import React from "react"

class ProjectSettingEnvironmentForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        let usingLanguageWarning;
        let platformWarning;
        let sourceToolWarning;
        let communicationToolWarning;
        let projectToolWarning;
        let periodWarning;
        let frequencyWarning;
        let locationWarning;

        if(this.props.info.usingLanguageWarning !== null){
            usingLanguageWarning = (
                <div className={"warning"}>
                    {this.props.info.usingLanguageWarning}
                </div>
            );
        }

        if(this.props.info.platformWarning !== null){
            platformWarning = (
                <div className={"warning"}>
                    {this.props.info.platformWarning}
                </div>
            );
        }


        if(this.props.info.sourceToolWarning !== null){
            sourceToolWarning = (
                <div className={"warning"}>
                    {this.props.info.sourceToolWarning}
                </div>
            );
        }

        if(this.props.info.communicationToolWarning !== null){
            communicationToolWarning = (
                <div className={"warning"}>
                    {this.props.info.communicationToolWarning}
                </div>
            );
        }

        if(this.props.info.projectToolWarning !== null){
            projectToolWarning = (
                <div className={"warning"}>
                    {this.props.info.projectToolWarning}
                </div>
            );
        }

        if(this.props.info.periodWarning !== null){
            periodWarning = (
                <div className={"warning"}>
                    {this.props.info.periodWarning}
                </div>
            );
        }

        if(this.props.info.frequencyWarning !== null){
            frequencyWarning = (
                <div className={"warning"}>
                    {this.props.info.frequencyWarning}
                </div>
            );
        }

        if(this.props.info.locationWarning !== null){
            locationWarning = (
                <div className={"warning"}>
                    {this.props.info.locationWarning}
                </div>
            );
        }

        return(
            <div>
                <form action={`/projects/${this.props.info.permalink}/settings/environment`} method={"POST"} className={"settings-form"}>
                    <h3>開発環境設定</h3>
                    <h4>使用言語</h4>
                    <input type={"text"} name={"using_language"} defaultValue={this.props.info.usingLanguage} placeholder={"例）C#（Unity）"}/>
                    {usingLanguageWarning}

                    <h4>プラットフォーム</h4>
                    <input type={"text"} name={"platform"} defaultValue={this.props.info.platform} placeholder={"例）iOS、Android"}/>
                    {platformWarning}

                    <h4>ソースコード管理ツール</h4>
                    <input type={"text"} name={"source_tool"} defaultValue={this.props.info.sourceTool} placeholder={"例）GitHub"}/>
                    {sourceToolWarning}

                    <h4>コミュニケーションツール</h4>
                    <input type={"text"} name={"communication_tool"} defaultValue={this.props.info.communicationTool} placeholder={"例）Slack、Zoom"}/>
                    {communicationToolWarning}

                    <h4>プロジェクト管理ツール</h4>
                    <input type={"text"} name={"project_tool"} defaultValue={this.props.info.projectTool} placeholder={"例）Redmine"}/>
                    {projectToolWarning}

                    <h4>制作期間</h4>
                    <input type={"text"} name={"period"} defaultValue={this.props.info.period} placeholder={"例）2021年1月から3カ月間"}/>
                    {periodWarning}

                    <h4>制作頻度</h4>
                    <input type={"text"} name={"frequency"} defaultValue={this.props.info.frequency} placeholder={"例）週に2回"}/>
                    {frequencyWarning}

                    <h4>場所</h4>
                    <input type={"text"} name={"location"} defaultValue={this.props.info.location} placeholder={"例）オンライン"}/>
                    {locationWarning}

                    <button type={"submit"}>更新</button>
                </form>
            </div>
        );
    }
}

export default ProjectSettingEnvironmentForm
