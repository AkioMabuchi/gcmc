import React from "react"

class CreateProjectForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            image: "/NoProjectImage.png",
            imageWarning: ""
        };
    }

    onChangeInputImage(e){
        let createObjectURL = (window.URL || window.webkitURL).createObjectURL || window.createObjectURL;
        let file = e.target.files[0];
        let imageInput = document.getElementById("react-image");
        if(!(imageInput.value === "")) {
            let fileNameRegExp = /\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/;
            if (!(file.type.match("image.*"))) {
                this.setState({image: "/NoProjectImage.png"});
                this.setState({imageWarning: "画像ファイルをアップロードしてください"});
                imageInput.value = "";
            }else if(!(fileNameRegExp.test(file.name))){
                this.setState({image: "/NoProjectImage.png"});
                this.setState({imageWarning: "gif、png、jpegのいずれかの画像をアップロードしてください"});
                imageInput.value = "";
            }else if(file.size>4194304){
                this.setState({image: "/NoProjectImage.png"});
                this.setState({imageWarning: "4MB以下の画像ファイルをアップロードしてください"});
                imageInput.value = "";
            }else{
                this.setState({image: createObjectURL(file)});
                this.setState({imageWarning: ""});
            }
        }else{
            this.setState({image: "/NoProjectImage.png"});
            this.setState({imageWarning: ""});
        }
    }

    render(){
        let warningPermalink;
        let warningTitle;
        let warningImage;
        let warningIsNotAdult;

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

        if(this.props.isNotAdultWarning !== ""){
            warningIsNotAdult = (
                <div className={"warning"}>
                    {this.props.isNotAdultWarning}
                </div>
            );
        }

        return(
            <div>
                <form action={"/new"} method={"POST"} className={"new-project-form"} encType={"multipart/form-data"}>
                    <h4>プロジェクトID<small>（必須、英数字および「_」のみ）</small></h4>
                    <h5>リンク名に使われます</h5>
                    <input type={"text"} name={"permalink"} defaultValue={this.props.permalink}/>
                    {warningPermalink}

                    <h4>タイトル<small>（必須）</small></h4>
                    <input type={"text"} name={"title"} defaultValue={this.props.title}/>
                    {warningTitle}

                    <h4>トップ画像</h4>
                    <h5>4MB以下のgif、png、jpgファイル<br/>1200x630px推奨</h5>
                    <img src={this.state.image} alt={""}/>
                    <input type={"file"} name={"image"} id={"react-image"} onChange={(e)=>{this.onChangeInputImage(e)}}/>
                    {warningImage}

                    <h4>プロジェクト内容</h4>
                    <textarea name={"description"}/>

                    <p><input type={"checkbox"} name={"is_not_adult"}/>アダルトゲームのプロジェクトではありません</p>
                    {warningIsNotAdult}

                    <button type={"submit"}>作成</button>
                </form>
            </div>
        )
    }
}

export default CreateProjectForm
