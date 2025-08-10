<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AnonymousMasterPage.Master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="SalesSystemWebSite._404" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
    </style>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>שגיאה טכנית</h3>
        </div>
        <div class="card-body">
            אנחנו עובדים על זה.
        </div>
    </div>
</asp:Content>

