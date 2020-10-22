import React from "react"

class CreateProjectForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            image: "/NoProjectImage.png"
        };
    }

    render(){
        return(
            <div>
                <form action={"/new"} method={"POST"} className={"new-project-form"}>
                    <h4>プロジェクトID<small>（必須）</small></h4>
                    <h5>リンク名に使われます</h5>
                    <input type={"text"} name={"permalink"}/>
                    <h4>タイトル<small>（必須）</small></h4>
                    <input type={"text"} name={"title"}/>
                    <h4>トップ画像</h4>
                    <h5>4MB以下のgif、png、jpgファイル<br/>1200x630px推奨</h5>
                    <img src={this.state.image} alt={""}/>
                    <input type={"file"} name={"image"}/>
                    <h4>プロジェクト内容</h4>
                    <textarea name={"content"}/>
                    <h4>ゲームエンジン</h4>
                    <select name={"engine"}>
                        <option value={"undefined"}>未定</option>
                        <option value={"Unity"}>Unity</option>
                        <option value={"Unreal Engine"}>Unreal Engine</option>
                        <option value={"Cocos2d-x"}>Cocos2d-x</option>
                        <option value={"RPGツクールMV"}>RPGツクールMV</option>
                        <option value={"RPGツクールMZ"}>RPGツクールMZ</option>
                        <option value={"HSP"}>HSP</option>
                        <option value={"others"}>その他</option>
                    </select>
                    <h4>プラットフォーム</h4>
                    <select name={"platform"}>
                        <option value={"undefined"}>未定</option>
                        <option value={"iOS Android"}>iOS、Android</option>
                        <option value={"iOS"}>iOS</option>
                        <option value={"Android"}>Android</option>
                        <option value={"WebGL"}>WebGL</option>
                        <option value={"Windows Mac"}>Windows、MacOS X</option>
                        <option value={"Windows"}>Windows</option>
                        <option value={"Mac"}>MacOS X</option>
                        <option value={"Switch"}>Nintendo Switch</option>
                        <option value={"others"}>その他</option>
                    </select>
                    <h4>ジャンル</h4>
                    <input type={"text"} name={"genre"}/>
                    <h4>開発規模</h4>
                    <select name={"scale"}>
                        <option value={"未定"}>未定</option>
                        <option value={"極めて小規模"}>極めて小規模</option>
                        <option value={"小規模"}>小規模</option>
                        <option value={"中規模"}>中規模</option>
                        <option value={"大規模"}>大規模</option>
                    </select>
                    <h4>プロジェクトの特徴、環境</h4>
                    <input type={"text"} name={"features"}/>
                    <p>
                    <input type={"checkbox"} name={"is_not_adult"}/>アダルトゲームのプロジェクトではありません
                    </p>
                    <button type={"submit"}>作成</button>
                </form>
            </div>
        )
    }
}

export default CreateProjectForm
