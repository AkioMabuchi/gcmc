import React from "react"

class ProjectsPagination extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            nextPage: 1
        }
    }

    onClickPageButton(page){
        this.setState({nextPage: page}, ()=>{this.nextPage()});
    }

    nextPage(){
        document.getElementById("react-submit").click();
    }
    render(){
        let inputQuery;
        let inputTags;
        if(this.props.query !== null){
            inputQuery = (
                <input type={"hidden"} name={"q"} value={this.props.query}/>
            );
        }

        if(this.props.tags !== null){
            inputTags = (
                <div>
                    {
                        this.props.tags.map((tag)=>{
                            return(
                                <input type={"hidden"} name={"tags[]"} value={tag}/>
                            );
                        })
                    }
                </div>
            );
        }
        return(
            <div>
                <form action={"/projects"} method={"GET"} className={"projects-pagination"}>
                    {inputQuery}
                    {inputTags}
                    <input type={"hidden"} name={"p"} value={this.state.nextPage}/>
                    <input type={"submit"} id={"react-submit"}/>
                    <div>
                        <button type={"button"} onClick={()=>{this.onClickPageButton(2)}}>2</button>
                    </div>
                </form>
            </div>
        );
    }
}

export default ProjectsPagination
