<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SalesSystemWebSite.Dealer.Dashboard" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        img.center { display: block; margin-left: auto; margin-right: auto; max-width: 1000px; }
    </style>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <img src="../Styles/Images/dashboard1.jpg" class="center" />
</asp:Content>