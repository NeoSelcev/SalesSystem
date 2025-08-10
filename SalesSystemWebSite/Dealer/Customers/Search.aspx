<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="SalesSystemWebSite.Dealer.Customers.Search" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
    </style>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>איתור לקוח</h3>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h3>חיפוש לפי:</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">מספר לקוח:</label>
                        <div class="col-sm-4">
                            <asp:TextBox CssClass="form-control" ID="Id" runat="server" placeholder="מספר לקוח"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">שם לקוח:</label>
                        <div class="col-sm-4">
                            <asp:TextBox CssClass="form-control" ID="Name" runat="server" placeholder="שם לקוח"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Button CssClass="btn btn-success float-left mx-2" Text="חפש" ID="SearchBtn" OnClick="SearchBtn_Click" runat="server" />
                    </div>
                    <asp:Panel ID="SearchResult" runat="server" Visible="false">
                        <div class="searchResult">
                            <hr />
                            <table class="pageTable table table-bordered">
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col">מספר לקוח</th>
                                        <th scope="col">שם לקוח</th>
                                        <th scope="col">סטטוס</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="CustomerSearchRpt" runat="server" OnItemDataBound="CustomerSearchRpt_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:HyperLink ID="CustomerLink" Target="_blank" runat="server"></asp:HyperLink>
                                                </td>
                                                <td>
                                                    <asp:Label ID="CustomerName" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="CustomerStatus" runat="server"></asp:Label>
                                                </td>
                                                <td><i class="fa fa-trash" aria-hidden="true"></i></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
