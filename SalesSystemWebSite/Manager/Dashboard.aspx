<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SalesSystemWebSite.Manager.Dashboard" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        img.center { display: block; margin-left: auto; margin-right: auto; max-width: 500px; }
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
        .pageTable { width: 50%; }
        .pageTable td:nth-child(2) { text-align: center; }
    </style>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>עמוס עבודה יומי
                <u><asp:Label ID="Date" runat="server"></asp:Label></u>
            </h3>
        </div>
        <div class="card-body">
            <table class="pageTable table">
                <tbody>
                    <tr>
                        <td>מספר הזמנות</td>
                        <td><asp:Label ID="NewOrders" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>סה"כ פריטים בהזמנות</td>
                        <td><asp:Label ID="Items" runat="server" Text="0"></asp:Label></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:HyperLink ID="ToSearch" CssClass="button btn btn-success float-left mx-2" runat="server">לקט הזמנות</asp:HyperLink>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="card mainForm">
        <div class="card-header">
            <h3>עמוס עבודה ביחס לממוצע יומי
            </h3>
        </div>
        <div class="card-body">
            <img src="../Styles/Images/dashboard2.jpg" class="center" />
        </div>
    </div>

</asp:Content>
