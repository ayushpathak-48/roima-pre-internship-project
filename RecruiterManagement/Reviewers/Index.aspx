<%@ Page Title="Reviewers Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="RecruiterManagement.Reviewers.Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex flex-col gap-3 p-5">
        <div class="flex items-center justify-between">
            <div class="font-semibold text-xl">
                All Reviewers
            </div>
            <a href="/Reviewers/Add" class="text-decoration-none bg-gray-700 p-2 px-3 !rounded-sm text-white">Add Reviewers</a>
        </div>
        <div class="relative overflow-x-auto">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 border">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 !border-b-2">
                    <tr>
                        <th scope="col" class="px-6 py-3">Id
                        </th>
                        <th scope="col" class="px-6 py-3">Name
                        </th>
                        <th scope="col" class="px-6 py-3">Actions
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        UsersList.ForEach((skill) =>
                        {
                    %>
                    <tr class="bg-white border-b border-gray-200">
                        <td class="px-6 py-4"><%= skill.Id%>
                        </td>
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= skill.Name %>
                        </th>
                        <td class="px-6 py-4">
                            <a href="/Reviewers/Update?id=<%=skill.Id %>" class="text-decoration-none font-medium border border-primary p-1 px-2 rounded-sm">Update</a>
                            <a href="/Reviewers/Delete?id=<%=skill.Id %>" class="text-decoration-none font-medium border !border-red-500 !text-red-500 p-1 px-2 rounded-sm" onclick="return confirm('Are you sure you want to delete?');">Delete</a>
                        </td>
                    </tr>
                    <%
                        });
                    %>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
