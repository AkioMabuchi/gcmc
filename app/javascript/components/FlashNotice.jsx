import React from "react"
class FlashNotice extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    setTimeout(()=>{document.getElementById("react-flash-notice").style.height = "0"},3000);
  }

  render () {
    return(
        <div>
        </div>
    )
  }
}

export default FlashNotice
