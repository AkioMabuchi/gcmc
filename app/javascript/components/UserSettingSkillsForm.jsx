import React from "react"

class UserSettingSkillsForm extends React.Component {
    constructor(props) {
        super(props);
    }

    onClickButtonSkill(name, level){
        document.getElementsByName("name")[0].value = name;
        document.getElementsByName("level")[0].value = level;
    }

    render() {
        let nameWarning;
        let levelWarning;

        if(this.props.info.nameWarning !== null){
            nameWarning = (
                <div className={"warning"}>
                    {this.props.info.nameWarning}
                </div>
            );
        }

        if(this.props.info.levelWarning !== null){
            levelWarning = (
                <div className={"warning"}>
                    {this.props.info.levelWarning}
                </div>
            );
        }
        return(
            <div>
                <form action={"/settings/skills"} method={"POST"} className={"settings-form setting-skills-form"}>
                    <h3>スキルセット設定</h3>
                    <h4>現在のスキルセット</h4>
                    <div className={"skill-sets"}>
                        {
                            this.props.info.skills.map((skill)=>{
                                return(
                                    <div className={"skill"}>
                                        <div className={"name"}>
                                            <button type={"button"} onClick={()=>this.onClickButtonSkill(skill.name, skill.level)}>
                                                {skill.name}
                                            </button>
                                        </div>
                                        <div className={"level"}>
                                            {skill.level}
                                        </div>
                                    </div>
                                );
                            })
                        }
                    </div>
                    <h4>スキル名<small>（必須）</small></h4>
                    <input type={"text"} name={"name"} placeholder={"例）C#、Photoshop"} defaultValue={this.props.info.name}/>
                    {nameWarning}

                    <h4>レベル</h4>
                    <input type={"text"} name={"level"} placeholder={"例）初級レベル、実務経験1年"} defaultValue={this.props.info.level}/>
                    {levelWarning}

                    <div className={"detail"}>
                        現在のスキルセットからスキルを除外する場合は、スキル名に除外したいスキルを入力して、レベルを空欄にしてください
                    </div>
                    <button type={"submit"}>更新</button>
                </form>
            </div>
        )
    }
}

export default UserSettingSkillsForm
