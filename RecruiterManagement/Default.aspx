<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="RecruiterManagement._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .job-card {
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
        <div class="flex gap-2 items-center justify-center py-2 bg-gray-100 mb-3 rounded-lg" id="uploadResumeDiv" <%= !String.IsNullOrEmpty(cvFilePath) ? "hidden" : "" %>>
            <div class="text-red-500">Update Resume to be able to apply in jobs</div>
            <a href="/Candidates/Update" class="bg-gray-700 rounded-md p-2 px-3 h-max text-white text-decoration-none">Update Cv</a>
        </div>

        <asp:Repeater ID="rptJobs" runat="server">
            <ItemTemplate>
                <div class='<%# "job-card border " + (Convert.ToBoolean(Eval("isEligible")) ? "!border-green-500" : "!border-red-500") %>'>
                    <div class="flex items-center justify-between">
                        <h3><%# Eval("name") %></h3>
                        <div class="flex items-center gap-2">
                            <div class='<%# "rounded-full px-2 rounded-full " + (Convert.ToBoolean(Eval("isEligible")) ? "text-green-700 bg-green-100" : "text-red-700 bg-red-100") %>'>
                                <%# Convert.ToBoolean(Eval("isEligible")) ? "Eligible":"Not Eligible" %>
                            </div>
                            <asp:Button
                                runat="server"
                                Enabled='<%# Convert.ToInt32(Eval("is_applied")) == 1 ? false : true %>'
                                Visible='<%# (Convert.ToBoolean(Eval("isEligible")) && !String.IsNullOrEmpty(cvFilePath)) %>'
                                Text='<%# Convert.ToInt32(Eval("is_applied")) == 1 ? "Applied" : "Apply Now" %>'
                                CssClass='<%# "rounded-md px-4 p-1 border " +  (Convert.ToInt32(Eval("is_applied")) == 0 ? "bg-slate-700 text-white" : "border-gray-500 text-gray-500")  %>'
                                CommandName="Apply"
                                CommandArgument='<%# Eval("id") %>'
                                OnCommand="ApplyCommand" />
                        </div>
                    </div>
                    <p><strong>Type:</strong> <%# Eval("job_type") %></p>
                    <p
                        hidden='<%# Eval("job_type").Equals("INTERNSHIP") %>'>
                        <strong>Salary:</strong> ₹<%# Eval("salary_range_start") %> - ₹<%# Eval("salary_range_end") %>
                    </p>
                    <p>
                        <strong>Stipend:</strong>
                        <%# string.IsNullOrEmpty(Eval("stipend").ToString()) ? "N/A" : "₹" + Eval("stipend") %>
                    </p>

                    <p>
                        <strong>Status:</strong>
                        <%# Eval("status") %>
                    </p>
                    <p><strong>Required Skills:</strong> <%# Eval("required_skills") %></p>
                    <p><strong>Preferred Skills:</strong> <%# Eval("preferred_skills") %></p>
                    <p><strong>Posted on:</strong> <%# Eval("created_at", "{0:dd MMM yyyy}") %></p>
                    <p style="margin-top: 10px;"><%# Eval("description") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <div runat="server" id="noJobsFound">
            <div class="flex flex-col text-center">
                <h3>No Jobs Found</h3>
                <div>There is no jobs present here.</div>
            </div>
        </div>

        <%
            }
        %>
    </div>
</asp:Content>
