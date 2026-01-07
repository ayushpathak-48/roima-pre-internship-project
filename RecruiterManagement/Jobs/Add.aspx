<%@ Page Title="Jobs Page" Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="Add.aspx.cs"
    Inherits="RecruiterManagement.Jobs.Add" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .scroll_checkboxes {
            height: 120px;
            width: 100%;
            padding: 5px;
            overflow: auto;
            border: 1px solid #ccc;
        }

        .FormText {
            FONT-SIZE: 11px;
            FONT-FAMILY: tahoma,sans-serif
        }

        .skill-pill {
            display: inline-flex;
            align-items: center;
            background-color: #d1e7ff;
            color: #0b3d91;
            padding: 4px 10px;
            margin: 4px;
            border-radius: 20px;
            font-size: 14px;
            font-family: Arial, sans-serif;
        }

            .skill-pill .remove-btn {
                margin-left: 8px;
                cursor: pointer;
                font-weight: bold;
                color: #0b3d91;
            }

                .skill-pill .remove-btn:hover {
                    color: #ff0000;
                }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const table = document.getElementById("MainContent_requiredSkillsCheckboxList");
            const displayDiv = document.getElementById("MainContent_displayRequiredSkillsDiv");

            function createSkillPill(labelText, checkboxId) {
                const pill = document.createElement("span");
                pill.className = "skill-pill";
                pill.dataset.label = labelText;
                pill.textContent = labelText;

                const removeBtn = document.createElement("span");
                removeBtn.className = "remove-btn";
                removeBtn.textContent = "×";

                removeBtn.addEventListener("click", function () {
                    displayDiv.removeChild(pill);

                    const checkbox = document.getElementById(checkboxId);
                    if (checkbox) checkbox.checked = false;
                });

                pill.appendChild(removeBtn);
                return pill;
            }

            table.querySelectorAll("input[type='checkbox']:checked").forEach((checkbox) => {
                const label = table.querySelector(`label[for='${checkbox.id}']`);
                if (label) displayDiv.appendChild(createSkillPill(label.textContent.trim(), checkbox.id));
            });

            table.addEventListener("change", function (e) {
                if (e.target && e.target.type === "checkbox") {
                    const checkbox = e.target;
                    const label = table.querySelector(`label[for='${checkbox.id}']`);
                    const labelText = label ? label.textContent.trim() : "";
                    if (!labelText) return;

                    if (checkbox.checked) {
                        displayDiv.appendChild(createSkillPill(labelText, checkbox.id));
                    } else {
                        const existingPill = displayDiv.querySelector(`.skill-pill[data-label='${labelText}']`);
                        if (existingPill) displayDiv.removeChild(existingPill);
                    }
                }
            });
        });
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const table = document.getElementById("MainContent_preferredSkillsCheckboxList");
            const displayDiv = document.getElementById("MainContent_displayPreferredSkillsDiv");

            function createSkillPill(labelText, checkboxId) {
                const pill = document.createElement("span");
                pill.className = "skill-pill";
                pill.dataset.label = labelText;
                pill.textContent = labelText;

                const removeBtn = document.createElement("span");
                removeBtn.className = "remove-btn";
                removeBtn.textContent = "×";

                removeBtn.addEventListener("click", function () {
                    displayDiv.removeChild(pill);

                    const checkbox = document.getElementById(checkboxId);
                    if (checkbox) checkbox.checked = false;
                });

                pill.appendChild(removeBtn);
                return pill;
            }

            table.querySelectorAll("input[type='checkbox']:checked").forEach((checkbox) => {
                const label = table.querySelector(`label[for='${checkbox.id}']`);
                if (label) displayDiv.appendChild(createSkillPill(label.textContent.trim(), checkbox.id));
            });

            table.addEventListener("change", function (e) {
                if (e.target && e.target.type === "checkbox") {
                    const checkbox = e.target;
                    const label = table.querySelector(`label[for='${checkbox.id}']`);
                    const labelText = label ? label.textContent.trim() : "";
                    if (!labelText) return;

                    if (checkbox.checked) {
                        displayDiv.appendChild(createSkillPill(labelText, checkbox.id));
                    } else {
                        const existingPill = displayDiv.querySelector(`.skill-pill[data-label='${labelText}']`);
                        if (existingPill) displayDiv.removeChild(existingPill);
                    }
                }
            });
        });
    </script>
    <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
        <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8 flex items-center justify-center flex-col gap-2">
            <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Add Job</h2>
            <div class="flex flex-col gap-2 w-full">
                <div class="w-full">
                    <asp:Label ID="lblName" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Name</asp:Label>
                    <asp:TextBox
                        ID="txtName"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Name" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblDescription" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Description</asp:Label>
                    <asp:TextBox
                        TextMode="MultiLine"
                        ID="txtDescription"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Description" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblJobType" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Job Type</asp:Label>
                    <asp:RadioButtonList AutoPostBack="true" ID="radioJobType" runat="server">
                        <asp:ListItem Text="Internship" Value="INTERNSHIP" />
                        <asp:ListItem Text="Full Time Job" Value="JOB" />
                        <asp:ListItem Text="Both" Value="BOTH" Selected="True"/>
                    </asp:RadioButtonList>
                </div>

                <%
                    if (!radioJobType.SelectedValue.Equals("JOB"))
                    {
                %>
                <div class="w-full">
                    <asp:Label ID="Label3" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Stipend</asp:Label>
                    <asp:TextBox
                        ID="txtStipend"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Stipend" />
                </div>
                <%
                    }
                    if(!radioJobType.SelectedValue.Equals("INTERNSHIP"))
                    {
                %>
                <div class="w-full">
                    <asp:Label ID="lblSalaryRange" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Salary Range From</asp:Label>
                    <asp:TextBox
                        ID="txtSalaryFrom"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Salary From" />
                </div>
                <div class="w-full">
                    <asp:Label ID="Label2" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Salary Range To</asp:Label>
                    <asp:TextBox
                        ID="txtSalaryTo"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Salary To" />
                </div>
                <%

                    }
                %>

                <div class="w-full">
                    <asp:Label ID="lblSkills" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Required Skills</asp:Label>
                    <div id="displayRequiredSkillsDiv" runat="server"></div>
                    <div class="scroll_checkboxes">
                        <asp:CheckBoxList runat="server" ID="requiredSkillsCheckboxList" RepeatDirection="Vertical" RepeatColumns="1"
                            BorderWidth="0"
                            CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all">
                        </asp:CheckBoxList>
                    </div>
                </div>

                <div class="w-full">
                    <asp:Label ID="Label1" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Preffered Skills</asp:Label>
                    <div id="displayPreferredSkillsDiv" runat="server"></div>
                    <div class="scroll_checkboxes">
                        <asp:CheckBoxList runat="server" ID="preferredSkillsCheckboxList" RepeatDirection="Vertical" RepeatColumns="1"
                            BorderWidth="0"
                            CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all">
                        </asp:CheckBoxList>
                    </div>
                </div>



            </div>
            <div class="w-full text-center">
                <asp:Label runat="server" ID="lblError" CssClass="text-red-500 text-center" Text="" />
                <asp:Label runat="server" ID="lblSuccess" CssClass="text-green-500 text-center" Text="" />
            </div>
            <asp:Button runat="server" Text="Add Job" ID="btnSubmit" CssClass="min-w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 rounded-lg transition-colors" OnClick="btnSubmit_Click" />
        </div>
    </div>
</asp:Content>
