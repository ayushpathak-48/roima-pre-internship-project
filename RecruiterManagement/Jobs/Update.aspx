<%@ Page Title="Update Job" Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="Update.aspx.cs"
    Inherits="RecruiterManagement.Jobs.Update" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .scroll_checkboxes {
            height: 120px;
            width: 100%;
            padding: 5px;
            overflow: auto;
            border: 1px solid #ccc;
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
        }

            .skill-pill .remove-btn {
                margin-left: 8px;
                cursor: pointer;
                font-weight: bold;
            }

                .skill-pill .remove-btn:hover {
                    color: red;
                }
    </style>

    <script>
        function initSkillSelection(checkboxListId, displayDivId) {
            const table = document.getElementById(checkboxListId);
            const displayDiv = document.getElementById(displayDivId);

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
        }

        document.addEventListener("DOMContentLoaded", function () {
            initSkillSelection("MainContent_requiredSkillsCheckboxList", "MainContent_displayRequiredSkillsDiv");
            initSkillSelection("MainContent_preferredSkillsCheckboxList", "MainContent_displayPreferredSkillsDiv");
        });
    </script>

    <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
        <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8 flex items-center justify-center flex-col gap-2">
            <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Update Job</h2>
            <div class="flex flex-col gap-2 w-full">
                <div class="w-full">
                    <asp:Label ID="lblName" runat="server" Text="Name" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <asp:TextBox ID="txtName" runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none"
                        placeholder="Enter Name" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblDescription" runat="server" Text="Description" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <asp:TextBox TextMode="MultiLine" ID="txtDescription" runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none"
                        placeholder="Enter Description" />
                </div>

                <div class="w-full" >
                    <asp:Label ID="lblJobType" runat="server" Text="Job Type" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <asp:RadioButtonList OnSelectedIndexChanged="jobTypeRadioButtonList_SelectedIndexChanged" AutoPostBack="true" ID="radioJobType" runat="server">
                        <asp:ListItem Text="Internship" Value="INTERNSHIP" />
                        <asp:ListItem Text="Full Time Job" Value="JOB" />
                        <asp:ListItem Text="Both" Value="BOTH" />
                    </asp:RadioButtonList>
                </div>

                <div class="w-full" id="stipendDiv" runat="server">
                    <asp:Label ID="Label3" runat="server" Text="Stipend" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <asp:TextBox ID="txtStipend" runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none"
                        placeholder="Enter Stipend" />
                </div>

                <div class="w-full" id="salaryFromDiv" runat="server">
                    <asp:Label ID="lblSalaryFrom" runat="server" Text="Salary Range From" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <asp:TextBox ID="txtSalaryFrom" runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none"
                        placeholder="Enter Salary From" />
                </div>

                <div class="w-full" id="salaryToDiv" runat="server">
                    <asp:Label ID="lblSalaryTo" runat="server" Text="Salary Range To" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <asp:TextBox ID="txtSalaryTo" runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none"
                        placeholder="Enter Salary To" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblReq" runat="server" Text="Required Skills" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <div id="displayRequiredSkillsDiv" runat="server"></div>
                    <div class="scroll_checkboxes">
                        <asp:CheckBoxList runat="server" ID="requiredSkillsCheckboxList" RepeatDirection="Vertical" />
                    </div>
                </div>

                <div class="w-full">
                    <asp:Label ID="lblPref" runat="server" Text="Preferred Skills" CssClass="block text-sm font-medium text-gray-700 mb-1" />
                    <div id="displayPreferredSkillsDiv" runat="server"></div>
                    <div class="scroll_checkboxes">
                        <asp:CheckBoxList runat="server" ID="preferredSkillsCheckboxList" RepeatDirection="Vertical" />
                    </div>
                </div>
            </div>

            <div class="w-full text-center">
                <asp:Label runat="server" ID="lblError" CssClass="text-red-500 text-center" />
            </div>

            <asp:Button runat="server" Text="Update Job" ID="btnUpdate"
                CssClass="min-w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 rounded-lg"
                OnClick="btnUpdate_Click" />
        </div>
    </div>
</asp:Content>
