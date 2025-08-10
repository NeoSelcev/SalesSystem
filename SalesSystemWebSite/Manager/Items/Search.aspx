<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="SalesSystemWebSite.Manager.Items.Search" %>


<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
    </style>
</asp:Content>
<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>איתור מוצרים</h3>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h3>חיפוש לפי:</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">מק''ט:</label>
                        <div class="col-sm-4">
                            <asp:TextBox CssClass="form-control" ID="SkuText" runat="server" placeholder="מק''ט"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">שם מוצר:</label>
                        <div class="col-sm-4">
                            <asp:TextBox CssClass="form-control" ID="NameText" runat="server" placeholder="שם מוצר"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Button CssClass="btn btn-success float-left mx-2" Text="חפש" ID="SearchBtn" OnClick="SearchBtn_Click" runat="server" />
                    </div>
                    <asp:Panel ID="SearchResult" runat="server" Visible="false">
                        <div class="searchResult">
                            <hr />
                            <table class="pageTable table">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>מק"ט</th>
                                        <th>תיאור</th>
                                        <th>תמונה</th>
                                        <th>מלאי זמין</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="ItemSearchRpt" runat="server" OnItemDataBound="ItemSearchRpt_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:HyperLink ID="Sku" Target="_blank" runat="server"></asp:HyperLink>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Name" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Image ID="Image" runat="server" style="width: 50px;" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="Available" runat="server"></asp:Label>
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
