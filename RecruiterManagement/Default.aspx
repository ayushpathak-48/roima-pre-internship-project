<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="RecruiterManagement._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .job-card {
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 15px;
        background-color: #f9f9f9;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s ease-in-out;
    }

    .job-card:hover {
        transform: scale(1.02);
    }

    .job-card h3 {
        color: #333;
        margin-bottom: 10px;
    }

    .job-card p {
        margin: 5px 0;
    }
</style>

    <div class="p-5">
        <%
            if (Session["role"].Equals("admin") && stats.Count > 0)
            {
        %>
        <div class="flex items-center justify-between gap-3">
            <div class="bg-gray-200 rounded-md p-3 flex-1">
                <div>
                    Total users
                </div>
                <div class="text-xl font-bold"><%= stats["total_users"] %></div>
            </div>
            <div class="bg-gray-200 rounded-md p-3 flex-1">
                <div>
                    Total Jobs
                </div>
                <div class="text-xl font-bold"><%= stats["total_jobs"] %></div>
            </div>
            <div class="bg-gray-200 rounded-md p-3 flex-1">
                <div>
                    Total Skills
                </div>
                <div class="text-xl font-bold"><%= stats["total_skills"] %></div>
            </div>
            <div class="bg-gray-200 rounded-md p-3 flex-1">
                <div>
                    Total Candidates
                </div>
                <div class="text-xl font-bold"><%= stats["total_candidates"] %></div>
            </div>
        </div>
        <%
            }
        %>

        <%
            if (Session["role"].Equals("candidate"))
            {
        %>

        <asp:Repeater ID="rptJobs" runat="server">
            <ItemTemplate>
                <div class="job-card">
                    <h3><%# Eval("name") %></h3>
                    <p><strong>Type:</strong> <%# Eval("job_type") %></p>
                    <p><strong>Salary:</strong> ₹<%# Eval("salary_range_start") %> - ₹<%# Eval("salary_range_end") %></p>

                    <p>
                        <strong>Stipend:</strong>
                        <%# string.IsNullOrEmpty(Eval("stipend").ToString()) ? "N/A" : "₹" + Eval("stipend") %>
                    </p>

                    <p>
                        <strong>Status:</strong>
                        <%# Eval("status") %>
                    </p>

                    <p><strong>Posted on:</strong> <%# Eval("created_at", "{0:dd MMM yyyy}") %></p>

                    <p style="margin-top: 10px;"><%# Eval("description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>


        <%
            }
        %>
    </div>
</asp:Content>
