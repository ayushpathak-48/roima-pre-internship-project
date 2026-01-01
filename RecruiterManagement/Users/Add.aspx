<%@ Page Title="Add Users Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="RecruiterManagement.Users.Add" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
        <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8 flex items-center justify-center flex-col gap-2">
            <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Add User</h2>
            <div class="w-full">
                <asp:Label ID="lblName" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Name</asp:Label>
                <asp:TextBox
                    ID="txtName"
                    runat="server"
                    type="text"
                    CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                    placeholder="Enter Name" />
            </div>
            <div class="w-full">
                <asp:Label ID="lblEmail" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Email</asp:Label>
                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    type="email"
                    CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                    placeholder="your@email.com" />
            </div>
            <div class="w-full">
                <asp:Label ID="lblPassword" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Password</asp:Label>
                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    type="password"
                    CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                    placeholder="••••••••" />
            </div>

            <div class="w-full">
                <asp:Label ID="lblRole" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Role</asp:Label>
                <asp:DropDownList ID="RoleDropdown" runat="server" class="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"></asp:DropDownList>
            </div>
            
            <div class="w-full text-center">
                <asp:Label runat="server" ID="lblError" CssClass="text-red-500 text-center" Text="" />
                <asp:Label runat="server" ID="lblSuccess" CssClass="text-green-500 text-center" Text="" />
            </div>

            <asp:Button runat="server" Text="Add User" ID="btnSubmit" CssClass="min-w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 rounded-lg transition-colors" OnClick="btnSubmit_Click" />
        </div>
    </div>
</asp:Content>
