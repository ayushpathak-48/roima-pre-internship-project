<%@ Page Title="Users Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="RecruiterManagement.Users.Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex flex-col gap-3 p-5">
        <div class="flex items-center justify-between">
            <div class="font-semibold text-xl">
                All Users
            </div>
            <%if (!Session["role"].Equals("viewer"))
                {
            %>
            <a href="/Users/Add" class="text-decoration-none bg-gray-700 p-2 px-3 !rounded-sm text-white">Add User</a>

            <%
                }
            %>
        </div>
        <div class="relative overflow-x-auto">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 border">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 !border-b-2">
                    <tr>
                        <th scope="col" class="px-6 py-3">Id
                        </th>
                        <th scope="col" class="px-6 py-3">Name
                        </th>
                        <th scope="col" class="px-6 py-3">Email
                        </th>
                        <th scope="col" class="px-6 py-3">Role
                        </th>
                        <%if (!Session["role"].Equals("viewer"))
                            {
                        %>
                        <th scope="col" class="px-6 py-3">Actions
                        </th>
                        <%
                            }
                        %>
                    </tr>
                </thead>
                <tbody>
                    <%
                        UsersList.ForEach((user) =>
                        {
                    %>
                    <tr class="bg-white border-b border-gray-200">
                        <td class="px-6 py-4"><%= user.Id%>
                        </td>
                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap ">
                            <%= user.Name %>
                        </th>
                        <td class="px-6 py-4"><%= user.Email %>
                        </td>
                        <td class="px-6 py-4"><%= user.Role %>
                        </td>
                        <%if (!Session["role"].Equals("viewer"))
                            {
                        %>
                        <td class="px-6 py-4">
                            <a href="/Users/Update?id=<%=user.Id %>" class="text-decoration-none font-medium border border-primary p-1 px-2 rounded-sm">Update</a>
                            <a href="/Users/Delete?id=<%=user.Id %>" class="text-decoration-none font-medium border !border-red-500 !text-red-500 p-1 px-2 rounded-sm" onclick="return confirm('Are you sure you want to delete?');">Delete</a>
                        </td>
                        <%
                            }
                        %>
                    </tr>
                    <%
                        });
                    %>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
