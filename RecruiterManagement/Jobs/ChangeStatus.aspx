<%@ Page Title="Jobs Page" Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="ChangeStatus.aspx.cs"
    Inherits="RecruiterManagement.Jobs.ChangeStatus" %>

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
            const table = document.getElementById("MainContent_candidatesCheckboxList");
            const displayDiv = document.getElementById("MainContent_displayCandidatesDiv");

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
    <div class="p-3 flex items-center justify-center">
        <div class="flex flex-col gap-3">
            <div>
                <div class="text-xl font-bold mb-3">Update: 
                <asp:Label runat="server" ID="lblJobName"/>
                </div>
                <asp:Label runat="server" CssClass="font-medium text-xl">Select status</asp:Label>
                <asp:DropDownList CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all" runat="server"
                    OnSelectedIndexChanged="statusDD_SelectedIndexChanged"
                    ID="statusDD" AutoPostBack="true">
                    <asp:ListItem Text="Open" Value="OPEN"  />
                    <asp:ListItem Text="Hold" Value="HOLD" />
                    <asp:ListItem Text="Closed" Value="CLOSED" />
                </asp:DropDownList>
            </div>
            <% if (statusDD.SelectedValue == "CLOSED")
                {
            %>
            <div class="w-full">
                <asp:Label runat="server" CssClass="block text-sm font-medium text-gray-700 mb-1">Selected Candidate</asp:Label>
                <div id="displayCandidatesDiv" runat="server"></div>
                <div class="scroll_checkboxes">
                    <asp:CheckBoxList runat="server" ID="candidatesCheckboxList" RepeatDirection="Vertical" RepeatColumns="1"
                        BorderWidth="0"
                        CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all">
                    </asp:CheckBoxList>
                </div>
            </div>
            <%
                }
            %>
            <div>
                <asp:Label runat="server" CssClass="font-medium text-xl">Comment</asp:Label>
                <asp:TextBox runat="server" ID="commentText" CssClass="min-w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 outline-none transition-all"
                    placeholder="Enter Comment" TextMode="MultiLine" />
            </div>
            <asp:Label runat="server" ID="lblMessage" CssClass="text-red-500"/>
            <asp:Button runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" Text="Update" CssClass="text-decoration-none bg-gray-700 p-2 px-3 !rounded-sm text-white"/>
        </div>
    </div>
</asp:Content>
