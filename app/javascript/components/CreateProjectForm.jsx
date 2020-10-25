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
                <form action={"/new"} method={"POST"} className={"new-project-form"} encType={"multipart/form-data"}>
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
                    <h4>制作環境</h4>
                    <select name={"engine"}>
                        {
                            this.props.engines.map((engine)=>{
                                return(
                                    <option value={engine.id}>{engine.name}</option>
                                )
                            })
                        }
                    </select>
                    <h4>対応機種</h4>
                    <select name={"platform"}>
                        {
                            this.props.platforms.map((platform)=>{
                                return(
                                    <option value={platform.id}>{platform.name}</option>
                                )
                            })
                        }
                    </select>
                    <h4>ジャンル</h4>
                    <select name={"genre"}>
                        {
                            this.props.genres.map((genre)=>{
                                return(
                                    <option value={genre.id}>{genre.name}</option>
                                )
                            })
                        }
                    </select>
                    <h4>開発規模</h4>
                    <select name={"scale"}>
                        {
                            this.props.scales.map((scale)=>{
                                return(
                                    <option value={scale.id}>{scale.name}</option>
                                )
                            })
                        }
                    </select>
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
