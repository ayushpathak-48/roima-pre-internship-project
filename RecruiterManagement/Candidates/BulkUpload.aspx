<%@ Page Title="Add Candidate Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BulkUpload.aspx.cs" Inherits="RecruiterManagement.Candidates.BulkUpload" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex items-center w-full border-b-2 border-gray-500 py-2">
        <div class="flex items-center justify-center text-center w-full">
            <asp:Button Text="CSV Upload" runat="server" />
        </div>
        <div class="flex items-center justify-center text-center w-full">
            <asp:Button Text="CV Upload" runat="server" />
        </div>
    </div>
    <div class="flex flex-col gap-2 items-center justify-center mt-5">
        <div class="text-xl text-center texxt-gray-700 font-semibold">Upload CSV</div>
        <asp:FileUpload ID="fileUploadControl" runat="server" class="border border-gray-500 p-3 rounded-sm" />
        <asp:Button ID="uploadBtn" runat="server" OnClick="uploadBtn_Click" Text="Upload" class="bg-gray-700 rounded-md text-white p-2 px-3" />
        <asp:Label runat="server" ID="lblMessage" Text="" />
        <asp:Label ID="lblCSVStatus" runat="server" ForeColor="Red"></asp:Label>
        <asp:GridView ID="gvCandidates" runat="server" AutoGenerateColumns="true"
            BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px"
            GridLines="Both" CellPadding="5" CellSpacing="2" />
    </div>
</asp:Content>
