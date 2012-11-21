<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Expense Approval</title>
<link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="<c:url value="resources/javascript/jquery-1.8.1.js"/>"></script>
<script
	src="<c:url value="resources/javascript/jquery.tablesorter.js"/>"></script>
<script
	src="<c:url value="resources/javascript/jquery.tablesorter.min.js"/>"></script>
<script
	src="<c:url value="resources/javascript/jquery.tablesorter.pager.js"/>"></script>
<script type="text/javascript">
	function changeState(contextPath, expenseId, rowCount) {
		var actionVal = document.getElementById('action_' + rowCount).value;
		var url = contextPath + "/changeState?action=" + actionVal
				+ "&expenseId=" + expenseId;
		if (actionVal == null || actionVal == "") {
			return false;
		}
		document.forms[0].action = url;
		document.forms[0].submit();

	}
</script>
</head>
<body>
	<div id="contentWrapper">
		<div class="blue-b">
			<div class="inside-nav">
				<div class="logo">
					<img src="<c:url value="/resources/images/logo.png" />" />
				</div>
				<ul class="nav-a">
					<li><a href="#">Hi ${sessionScope.user.userName}</a></li>
					<li>|</li>
					<li><a href="<c:url value="/j_spring_security_logout" />">Logout</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="nav">
			<ul>
				<li><a href="${pageContext.request.contextPath}/">My
						Expenses</a></li>
				<li><a
					href="${pageContext.request.contextPath}/createNewExpense">New
						Expense</a></li>
				<c:if test="${sessionScope.user.role.roleName eq 'ROLE_MANAGER'}">
					<li><a
						href="${pageContext.request.contextPath}/loadApprovalExpenses">Approvals</a>
					</li>
				</c:if>
			</ul>
		</div>

		<div class="mc-a">
			<h2 class="header label-2">Approvals Pending
				${fn:length(approvedExpenseList)}</h2>

			<c:if test="${fn:length(approvedExpenseList) gt 0 }">
				<table id="table-a" class="table-a mtop80">
					<thead>
						<tr>
							<td class="td-a">
								<h5 class="label-3">
									Date<i class="bg-arrow-down-a"><img
										src="<c:url value="/resources/images/arrow-down-a.png"/>"></i>
								</h5>
							</td>
							<td class="td-b">
								<h5 class="label-3">Expense ID</h5>
							</td>
							<td class="td-c">
								<h5 class="label-3">Description</h5>
							</td>
							<td class="td-d">
								<h5 class="label-3">Status</h5>
							</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="expense" items="${approvedExpenseList}"
							varStatus="rowCounter">
							<input type="hidden" name="rowcount" value="${rowCounter.count}" />
							<tr class="tr-odd">
								<td>
									<h5 class="label-4">${expense.expenseDate}</h5>
								</td>
								<td>
									<h5 class="label-4">
										${expense.expenseId}<img class="clip-b-img"
											src="<c:url value="/resources/images/clip-b.png" />">
									</h5>
								</td>
								<td>
									<h5 class="label-4">${expense.description}</h5>
								</td>
								<td>
									<h5 class="label-4">
										<c:if test="${expense.state eq 'NEW' }">
											<form name="actionForm" id="actionForm" method="post">
												<select id="action_${rowCounter.count}"
													name="${rowCounter.count}" style="font-size: 11px;"
													onchange="changeState('${pageContext.request.contextPath}','${expense.expenseId}','${rowCounter.count}')">
													<option value="PENDING">Pending</option>
													<option value="APPROVED">Approve</option>
													<option value="REJECTED">Reject</option>
												</select>
											</form>
										</c:if>
										<c:if test="${expense.state eq 'REJECTED' }">
											<i class="alt-a label-5 red"><img class="cross-a-img"
												src="<c:url value="/resources/images/cross-a.png" />">
												Rejected</i>
											<i class="alt-b label-6"> <img class="right-b-img"
												src="<c:url value="/resources/images/cross-a.png" />">
												Rejected <a
												href="${pageContext.request.contextPath}/deleteExpense?expenseId=${expense.expenseId}"
												class="bg-cross-b"><img class="cross-b-img"
													src="<c:url value="/resources/images/cross-b.png" />">
											</a>
											</i>
										</c:if>
									</h5>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div id="pager" class="pagination">
					<form>
						<img src="<c:url value="/resources/images/first.png"/>"
							class="first" /> <img
							src="<c:url value="/resources/images/prev.png"/>" class="prev" />
						<input type="text" class="pagedisplay" /> <img
							src="<c:url value="/resources/images/next1.png" />" class="next" />
						<img src="<c:url value="/resources/images/last.png" />"
							class="last" /> <select class="pagesize">
							<option selected="selected" value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="40">40</option>
						</select>
					</form>
				</div>
			</c:if>
		</div>

		<script>
			jQuery(document).ready(function() {

				jQuery("#table-a")

				.tablesorter({
					widthFixed : true,
					widgets : [ 'zebra' ]
				}).tablesorterPager({
					container : $("#pager")
				});

			});
		</script>
	</div>
</body>
</html>




















