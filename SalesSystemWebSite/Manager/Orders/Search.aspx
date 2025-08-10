<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="SalesSystemWebSite.Manager.Orders.Search" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
        .mainForm select.loaded option:nth-child(1) { display: none }
    </style>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>איתור הזמנה</h3>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h3>חיפוש לפי:</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">מספר הזמנה:</label>
                        <div class="col-sm-4">
                            <asp:TextBox CssClass="form-control" ID="Id" runat="server" placeholder="מספר הזמנה"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">תאריך הזמנה:</label>
                        <div class="col-sm-4">
                            <asp:TextBox CssClass="form-control" ID="Date" runat="server" placeholder="תאריך הזמנה"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">סטטוס:</label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="Status" CssClass="form-control loaded" runat="server">
                                <asp:ListItem Text="סטטוס"></asp:ListItem>
                                <asp:ListItem Value="0" Text="הזמנה חדשה"></asp:ListItem>
                                <asp:ListItem Value="1" Text="ממתין לליקוט"></asp:ListItem>
                                <asp:ListItem Value="2" Text="הזמנה לוקטה"></asp:ListItem>
                                <asp:ListItem Value="3" Text="הזמנה הסתיימה"></asp:ListItem>
                            </asp:DropDownList>
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
                                        <th scope="col">מספר הזמנה</th>
                                        <th scope="col">תאריך הזמנה</th>
                                        <th scope="col">תאריך הספקה</th>
                                        <th scope="col">סטטוס</th>
                                        <th scope="col">שווי הזמנה</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="OrdersSearchRpt" runat="server" OnItemDataBound="OrdersSearchRpt_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:HyperLink ID="OrderLink" Target="_blank" runat="server"></asp:HyperLink>
                                                </td>
                                                <td>
                                                    <asp:Label ID="DateCreated" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="ShipmentDate" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Status" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="TotalPrice" runat="server"></asp:Label>
                                                </td>

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
