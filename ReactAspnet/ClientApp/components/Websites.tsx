import * as React from 'react';
import { RouteComponentProps } from 'react-router';
import 'isomorphic-fetch';

interface WebsitesExampleState {
    websites: WebsiteDetails[];
    loading: boolean;
    topNumber: number;
    searchDate: string;
    searchColumns: string;
    currentOption: string;
    responseJsonColumns: Array<string>;
    errorMessage: string;
}

interface WebsiteDetails {
    WebsiteId: number;
    Url: string;
    TotalVisits: number;
    VisitDate: string;
}


export class Websites extends React.Component<RouteComponentProps<{}>, WebsitesExampleState> {

    constructor() {
        super();
        this.state = {
            websites: []
            , loading: true
            , topNumber: 5
            , searchDate: "2018-11-01"
            , searchColumns: this.listColumns[0]
            , currentOption: this.listColumns[0]
            , responseJsonColumns: []
            , errorMessage: ""
        };
    };

    listColumns: Array<string> = ["Url,TotalVisits,VisitDate", "Url,TotalVisits"];

    async componentDidMount() { this.getData(); }

    getData() {
        let apiOptions = "?";
        apiOptions += (this.state.searchDate.trim() !== "" ? "&searchDate=" + this.state.searchDate.trim() : "");
        apiOptions += (this.state.topNumber !== null ? "&topNumber=" + this.state.topNumber.toString() : "");
        apiOptions += (this.state.currentOption.trim() !== "" ? "&columns=WebsiteId," + this.state.currentOption.trim() : "");
        fetch('api/Websites/Index' + apiOptions)
            .then(response => {
                this.setComponentState({
                    loading: false
                    , errorMessage: 'reading'
                });
                return response.json()
            })
            .then(data => {
                this.setComponentState({
                    websites: data as WebsiteDetails[]
                    , loading: false
                    , searchColumns: this.state.currentOption.trim()
                    , responseJsonColumns: data[0] !== undefined ? Object.keys(data[0]) : []
                    , errorMessage: ""
                });
            })
            .catch(err => {
                this.setComponentState({
                    loading: false
                    , errorMessage: err
                });
                console.log(err)
            });
    }

    setComponentState(stateOptions: any) {
        this.setState({...this.state,...stateOptions });
    }

    topNumberChange(event: { currentTarget: { value: string; }; }) {
        var safeSearchTypeValue: string = event.currentTarget.value;
        let newValue: number = parseInt(safeSearchTypeValue);
        this.setComponentState({ topNumber: newValue });
    }

    dateChange(event: { currentTarget: { value: string; }; }) {
        var safeSearchTypeValue: string = event.currentTarget.value;
        this.setComponentState({ searchDate: safeSearchTypeValue });
    }

    columnsChange(event: { currentTarget: { value: string; }; }) {
        var safeSearchTypeValue: string = event.currentTarget.value;
        this.setComponentState({ currentOption : safeSearchTypeValue });
    }

    public render() {
        let contents = (
            this.state.loading
                ? <p><em>Loading...</em></p>
                : (
                    this.state.errorMessage.trim() === ""
                        ? Websites.renderwebsitesTable(this.state.websites, this.state)
                        : (this.state.errorMessage.trim() === "reading" 
                            ? <p><em>Loading...data fetched...reading...</em></p>
                            : <p><em>Error caused : {this.state.errorMessage.trim()}</em><br /><em>Kindly retry..</em></p>
                          )
                  )
            );

        return <div>
            <h1>Website Tracking Details</h1>
            <p>This component demonstrates top websites by visits data from the server.</p>
            <p>Get top&nbsp;&nbsp;
                <select id="topNumberSelect"
                    value={this.state.topNumber.toString()}
                    onChange={e => this.topNumberChange(e)}
                    style={{ width:"45px"}}
                >
                    {
                        [1,2,3,4,5,6,7,8,9,10].map((val) => {
                            var setVal = val;
                            return <option key={setVal} value={setVal} >{setVal}</option>
                        })
                    }
                </select>
                &nbsp;&nbsp;websites for&nbsp;&nbsp;
                <input type="date" id="searchDateSelect" min="2018-11-01" max="2018-11-10"
                    value={this.state.searchDate}
                    onChange={e => this.dateChange(e)}
                />
                &nbsp;&nbsp;with columns as &nbsp;&nbsp;
                <select id="columnsSelect"
                    value={this.state.currentOption}
                    onChange={e => this.columnsChange(e)}
                    style={{ width: "200px" }}
                    ref="columnsSelect"
                >
                    {
                        this.listColumns.map((val) => {
                            var setVal = val;
                            return <option key={setVal} value={setVal} >{setVal}</option>
                        })
                    }
                </select>
                &nbsp;&nbsp;
                <button id="btnSubmit" onClick={e => this.getData()} >View</button>
            </p>
            {contents}
        </div>;
    }

    private static renderwebsitesTable(websites: WebsiteDetails[], state: Readonly<WebsitesExampleState>) {
        return <table className='table'>
            <thead>
                <tr>
                    {state.responseJsonColumns.map(s => (s.toUpperCase().trim() !== 'WEBSITEID' ? <th key={s}>{s}</th> : null)) }
                </tr>
            </thead>
            <tbody>
            {   websites.map(website =>
                    <tr key={website.WebsiteId}>
                        {!websites.every(s => s.Url === undefined)          && <td> {website.Url}   </td>}
                        {!websites.every(s => s.TotalVisits === undefined)  && <td> {website.TotalVisits}   </td>}
                        {!websites.every(s => s.VisitDate === undefined)    && <td> {website.VisitDate !== undefined ? (new Date(website.VisitDate).toLocaleDateString()) : null}   </td>}
                    </tr>
                )
            }
            </tbody>
        </table>;
    }
}