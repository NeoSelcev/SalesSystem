<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Upsert.aspx.cs" Inherits="SalesSystemWebSite.Manager.Items.Upsert" %>

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
            <h3>יצירת מוצר חדש</h3>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h3>כללי</h3>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <asp:Panel ID="SkuWraper" runat="server">
                            <div class="col">
                                <asp:TextBox CssClass="form-control" ID="Sku" placeholder="מק''ט" runat="server"></asp:TextBox>
                            </div>
                        </asp:Panel>
                        <div class="col">
                            <asp:DropDownList ID="Category" CssClass="form-control loaded" DataValueField="Value" DataTextField="Text" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Name" runat="server" placeholder="שם"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Description" runat="server" placeholder="תיאור"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Price" runat="server" placeholder="מחיר"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:DropDownList ID="Color" CssClass="form-control" DataValueField="Value" DataTextField="Text" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Height" runat="server" placeholder="גובה"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Width" runat="server" placeholder="רוחב"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Length" runat="server" placeholder="אורך"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Weight" runat="server" placeholder="משקל"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="Available" runat="server" placeholder="סה''ב מלאי"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="WarehousePlace" runat="server" placeholder="מיקום במחסן"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col">
                            <asp:TextBox CssClass="form-control" ID="ImageUrl" runat="server" placeholder="תמונה"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:Image ID="Image" runat="server" Style="width: 50px;" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <asp:Button CssClass="btn btn-success float-left mx-2" Text="שמור" ID="MainBtn" OnClick="MainBtn_Click" runat="server" />
                <a href="../Dashboard.aspx" class="btn btn-danger float-left mx-2">ביטול</a>
            </div>
        </div>
</asp:Content>
