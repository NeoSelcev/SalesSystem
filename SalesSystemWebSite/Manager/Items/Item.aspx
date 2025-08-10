<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AuthenticatedMasterPage.Master" AutoEventWireup="true" CodeBehind="Item.aspx.cs" Inherits="SalesSystemWebSite.Manager.Items.Item" %>

<asp:Content ID="HeadCssPlaceHolder" ContentPlaceHolderID="HeadCssPlaceHolder" runat="server">
    <style>
        .card { margin-top: 20px }
        .mainForm { width: 80%; margin: auto; text-align: right; }
    </style>
</asp:Content>

<asp:Content ID="FormPlaceHolder" ContentPlaceHolderID="FormPlaceHolder" runat="server">
    <div class="card mainForm">
        <div class="card-header">
            <h3>
                מק"ט
                <u>
                    <asp:Label ID="SkuSbj" runat="server"></asp:Label>
                </u>
                שם
                <u>
                    <asp:Label ID="NameSbj" runat="server"></asp:Label>
                </u>
            </h3>
        </div>

        <div class="card-body">
            <div class="card-body">
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>מק"ט:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Sku" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>קטגוריה:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Category" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><u>שם:</u></label>
                            <div class="col-sm-10">
                                <asp:TextBox CssClass="form-control" ID="Name" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label"><u>תיאור:</u></label>
                            <div class="col-sm-10">
                                <asp:TextBox CssClass="form-control" ID="Description" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>מחיר:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Price" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>צבע:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Color" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>גובה:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Height" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>רוחב:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Width" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>אורך:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Length" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>משקל:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Weight" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>סה"כ מלאי:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Available" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>מלאי משורין:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Reserved" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>מלאי זמין:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="AvailableAfterReserved" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>תמונה:</u></label>
                            <div class="col-sm-8">
                                <asp:Image ID="Image" runat="server" style="width: 50px;" />
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>מיקום במחסן:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="WarehousePlace" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="form-group row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>מחיר:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Price" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-4 col-form-label"><u>צבע:</u></label>
                            <div class="col-sm-8">
                                <asp:TextBox CssClass="form-control" ID="Color" runat="server" disabled="disabled"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>--%>
            </div>
            <div class="card-footer">
                <asp:HyperLink CssClass="btn btn-success float-left mx-2" ID="MainBtn" runat="server">עדכן</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>
