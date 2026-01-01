<%@ Page Title="Add Candidate Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Add.aspx.cs" Inherits="RecruiterManagement.Candidates.Add" %>

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
            const table = document.getElementById("MainContent_skillsCheckboxList");
            const displayDiv = document.getElementById("MainContent_displaySkillsDiv");

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
            <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Add Candidate</h2>
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
                    <asp:Label ID="lblEmail" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Email</asp:Label>
                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Email" />
                </div>
                <div class="w-full">
                    <asp:Label ID="lblPhone" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Phone</asp:Label>
                    <asp:TextBox
                        ID="txtPhone"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Phone" />
                </div>
                <div class="w-full">
                    <asp:Label ID="lblSkills" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Skills</asp:Label>
                    <div id="displaySkillsDiv" runat="server"></div>
                    <div class="scroll_checkboxes">
                        <asp:CheckBoxList runat="server" ID="skillsCheckboxList" RepeatDirection="Vertical" RepeatColumns="1"
                            BorderWidth="0"
                            CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all">
                        </asp:CheckBoxList>
                    </div>
                </div>


                <div class="w-full">
                    <asp:Label ID="lblGender" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Gender</asp:Label>
                    <asp:RadioButtonList ID="radioGender" runat="server">
                        <asp:ListItem Text="Male" Value="Male" />
                        <asp:ListItem Text="Female" Value="Female" />
                        <asp:ListItem Text="Other" Value="Other" />
                    </asp:RadioButtonList>
                </div>

                <div class="w-full">
                    <asp:Label ID="lblDateOfBirth" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Date of Birth</asp:Label>
                    <asp:TextBox
                        ID="dateOfBirth"
                        type="date"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Name" />
                </div>
                <div class="w-full">
                    <asp:Label ID="lblAddress" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Address</asp:Label>
                    <asp:TextBox
                        ID="txtAddress"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Address" />
                </div>
                <div class="w-full">
                    <asp:Label ID="lblCity" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">City</asp:Label>
                    <asp:TextBox
                        ID="txtCity"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter City" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblState" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">State</asp:Label>
                    <asp:TextBox
                        ID="txtState"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter State" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblEducation" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Education</asp:Label>
                    <asp:TextBox
                        ID="txtEducation"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Education" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblExperienceYears" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Experience In Years</asp:Label>
                    <asp:TextBox
                        ID="txtExperienceYears"
                        runat="server"
                        type="number"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Experience In Years" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblCurrentPosition" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Current Position</asp:Label>
                    <asp:TextBox
                        ID="txtCurrentPosition"
                        runat="server"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Current Position" />
                </div>

                <div class="w-full">
                    <asp:Label ID="lblExpectedSalary" runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Expected Salary</asp:Label>
                    <asp:TextBox
                        ID="txtExpectedSalary"
                        runat="server"
                        type="number"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                        placeholder="Enter Expected Salary" />
                </div>

            </div>
            <div class="w-full text-center">
                <asp:Label runat="server" ID="lblError" CssClass="text-red-500 text-center" Text="" />
                <asp:Label runat="server" ID="lblSuccess" CssClass="text-green-500 text-center" Text="" />
            </div>
            <asp:Button runat="server" Text="Add Candidate" ID="btnSubmit" CssClass="min-w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 rounded-lg transition-colors" OnClick="btnSubmit_Click" />
        </div>
    </div>
</asp:Content>
