Return-Path: <linux-arch+bounces-13783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBFEBA366B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FAA6235E3
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A492F3C01;
	Fri, 26 Sep 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nn4DiteV"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDB299AB3;
	Fri, 26 Sep 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884059; cv=fail; b=Q3WrKtYa5cqntgOaGm0TWPL0ZBFzRuZ4fmGvxewTBPDsFA3zkcJKEuMpURzfkV5fSSbB9g3gtYLzgCPv/d2yTcnqpOcFhAGNCDSyp9Fw5PztF3Q7GsF5wvshrUCJbQq7rxZq/xl/6/xGpwPyCJE5MJk9HlLzStPgYIdlRmjI1eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884059; c=relaxed/simple;
	bh=sSqr/oUbOSFIc25Rs5dZOBHBJh3QW6Zpxi1JKBKdIHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyCQAzh8/MvrggOq9NeB7/+ECht2gDusJMRXUtp7gxOmkRyGoBC96jdH03Z1cO5nG81X7oqplC2RBxg9sUBXhHZkZGBFx+bYna1U3bh/VDnHkS3BqGMtsfbdWP1zzGchYuJTqkT18CQURSD39C3rAb40BvT3ycNOVERltOWXi7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nn4DiteV; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unMMwTxpTJGLSkhcS7oPhH6MJSGagrZPjhAVQ6d0sc55jOru3h0dO/vFudj9GBPFtMUpUS0Q6KfUmV+XBvyv4WZj85LSU+YCxz6ImlJzb53WFLMssRemnr8mdolVxapnVDOhrdvKGU6gdGeIUKzj81Evd/YTYFv88aS5TCuV32SdCji+bxqQ/s75c+jZ3Zg0pMHGOf15U9XwDUbn/5IAnLiqMeplhurRcKgc1pttLmoGCp6Kq1Y3SJrC9aonDDHVu53ijL7W7ep3aVzkq/dklZN9bSkgDsGTwvMpKLkzd3LMSG/yhBEFtsxlsMDq71fuyC3Q/7CsC5vqv+RUlleH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIlS8VG9BhAuPq8+q2wxIohgg8u2w+HSy/2b+JV/3Ac=;
 b=X/6pLUKiBviXz2wQd+pLL67THTjdQ85k+TFRLguXe9Mpa+Uj72qQ0UopmQ08j8GSHKJWEYKZRD+7jMHupNJbgvJ07CF6UU+Hj0to82JgpEyk3RNMy3WH//qs6DGg9EfbtM3CTm0OlZ39l0eSBwJ7MPDm8Nt1lzDjDnhrK41wWSO9B0n9MLfo1uXFMNwx9WrBcRZYXmnfH7+PJj0K0aCAWBysRxOKY+Ymqt1tY1lbChV3dkQa++9l5c1sqaNmsmzWwIGiWIiVGUn/6Fq62uZwKNmyw2FVifmgJLeuxcWaNwpqbd2c5VhM6bi04y0Hr0gYpRld7XB9ILsTha5f59saBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIlS8VG9BhAuPq8+q2wxIohgg8u2w+HSy/2b+JV/3Ac=;
 b=nn4DiteVCeXmePzO4JG3eQNkt810tl68HEwRUkuxBv2I9TS2wI8/3BYODXd8DOITzAuE42KE4CsB6Uz5VN7Q4uV3a5GncwEeByKGojcCdSK1947v1krksxnu9lAEz8cxkDkgzHxSACLlUhl6T5Tv6c+054nSeewbq/l+tpba5mM=
Received: from BL0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:91::39)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 10:54:10 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::71) by BL0PR05CA0029.outlook.office365.com
 (2603:10b6:208:91::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.6 via Frontend Transport; Fri,
 26 Sep 2025 10:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 10:54:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 03:54:09 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 05:54:08 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 26 Sep 2025 03:54:01 -0700
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <pgaj@cadence.com>,
	<wsa+renesas@sang-engineering.com>, <tommaso.merciai.xr@bp.renesas.com>,
	<arnd@arndb.de>, <quic_msavaliy@quicinc.com>, <Shyam-sundar.S-k@amd.com>,
	<sakari.ailus@linux.intel.com>, <billy_tsai@aspeedtech.com>,
	<kees@kernel.org>, <gustavoars@kernel.org>, <jarkko.nikula@linux.intel.com>,
	<jorge.marques@analog.com>, <linux-i3c@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V8 1/5] dt-bindings: i3c: Add AMD I3C master controller support
Date: Fri, 26 Sep 2025 16:23:45 +0530
Message-ID: <20250926105349.2932952-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926105349.2932952-1-manikanta.guntupalli@amd.com>
References: <20250926105349.2932952-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b2568b-9039-4c02-2b6c-08ddfceb0626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UtHl8W6p/cNIMpFW8hyh8MZLiU/j90fBbsKQ3ZsHgDG17ZJsJ6anayiU0EVz?=
 =?us-ascii?Q?H9tGRv9t6CFMFCNjfQr7DIx6BBnkokcxWzxsKxqRo/itxn6eeFsjSB7/m8du?=
 =?us-ascii?Q?jdy/i8M1y4GUk6YhevKDbtviERBBLNyCOkVac9/+yBvlSPxG6GsViOP4eoSp?=
 =?us-ascii?Q?8M+RqdSP3BbqLYIXFPhklYUlxIs91DgJD9A5NmwiKxuH7VbcAy+y0JHZuHOk?=
 =?us-ascii?Q?nH2sSgKRkW9gLZCzd9lk4tRsSkxghSGZC0mXpWr0JyzuT3Pv7/aq3FhdFn9O?=
 =?us-ascii?Q?m9R7kMPyyJLWgmpT5NfTdPyF+MnVGNBrKffRwyNZMIM7TDHTSNOKCFB6rKMn?=
 =?us-ascii?Q?Lq7nC8GrpwC4I0PCKwy8YOMjAMas1vmWzRcWOsdjltzMGpgGlczyWsiVJYIN?=
 =?us-ascii?Q?0RsHNVotdx6vkkX7BiRVw5UXuCb7JcyrSC4Cc885am9jwMsrDlBoSiPkgngQ?=
 =?us-ascii?Q?9SydnWdNOxD4kHnL4aaiSQUr6hD8AzEJSHgtDQXW8nLdq1kFCEIn1v7uIPuo?=
 =?us-ascii?Q?Bp+QXAD+llJbaVR7f0i/Q9Y10EDuO3VzBxHkROLmFiXPqZUsua5uexKEOHPo?=
 =?us-ascii?Q?3cqb6breOf19/z7fkrfrfRYdYVVQE/IKZKK4kJZzOd+/zISKmnKJMUbrJukU?=
 =?us-ascii?Q?t26Qwec259cmTrGBIH/IW7qOu3JkV59YRxRqnaDwSO7/EvJyINkZlxOm4scT?=
 =?us-ascii?Q?VD6NXf1F4cFWSufGLFKntLtA728aHt5fQscNXeMYzNhnB63L72PI8NBagZYz?=
 =?us-ascii?Q?0nU1aJoiAxjlkslAiDcLpk8nQDE/j/+LEjePlx6jwGFCqlBDbI8h41grClB/?=
 =?us-ascii?Q?GfOo55K9Pg3bj27OOhtSXNomJnU93naT6ikhL+dG8EO6EwJRCnlBJYv1mTp2?=
 =?us-ascii?Q?OPkgY0wVJUyqlFNzEgl7xfgVwXXz3/WnJLMpgvs3Gbs22RuVata0F63li1U2?=
 =?us-ascii?Q?AFZltz11Wvy7YSXt/O0I1IYqT7PQGgGB2tMW2SSsBy/jOSLYCwUBZJly0rRA?=
 =?us-ascii?Q?Ruf8433V4/PiHrAO8QRWzcd1tpxUiBpH9fEpRabSQ7/PnKtXdtXqyUNIlskA?=
 =?us-ascii?Q?ZzbP7i9ul5nMmXGVbiJFraEFAJzmggjfNliL/Wp8D95MQiAM+VKwTdxbFG7b?=
 =?us-ascii?Q?fDy9ENvyWjpWofkE310GJF9YyP+QmNOFeKZ2a8uMValcnB0Ws/5WyCDaRX6j?=
 =?us-ascii?Q?bNX0Vu+JI1+GTDgussl3BX0xoeEKWc9mEeKdVGmRw89bHY6DabdXCSFx+JeS?=
 =?us-ascii?Q?zExGIfax8pxBJ8HnDQ/2UHlm17Pg0pleOydNzG4j679bVlE0d+NU2JCqFdDt?=
 =?us-ascii?Q?Jd8fjfHGUfcgM9LpNI/fbd9g7/IjtorlRM01cKeqAMzEQtdmaVmSZbkgju1D?=
 =?us-ascii?Q?HR851XwOmM3FH3lxyW0n1tSWryYhnEpkRPYoQ4QichUlFmpoCE9JsZE+2s71?=
 =?us-ascii?Q?+Yh1jJdXXVWsCSmLunlFzJS8bPK0mVb6nhzDa/eKZs1h6UYxKnQyDnStmq4m?=
 =?us-ascii?Q?KohqNgvwd3kH1hMoLwqDewjYPD/yz4H5WeWCX81yLTk2IMWmpZ3h86eyWA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:54:10.6722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b2568b-9039-4c02-2b6c-08ddfceb0626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954

Add device tree binding documentation for the AMD I3C master
controller version 1.0.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes for V2:
Updated commit subject and description.
Moved allOf to after required.
Removed xlnx,num-targets property.

Changes for V3:
Updated commit description.
Corrected the order of properties and removed resets property.
Added compatible to required list.
Added interrupts to example.

Changes for V4:
Added h/w documentation details.

Changes for V5:
Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.

Changes for V6:
Corrected the file name for $id in yaml to fix the dtschema warning.

Changes for V7:
Added i3c controller version details to commit description.

Changes for V8:
None.
---
 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
new file mode 100644
index 000000000000..17c63807dbcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD I3C master
+
+maintainers:
+  - Manikanta Guntupalli <manikanta.guntupalli@amd.com>
+
+description:
+  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
+  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
+  buffers that implement open collector drivers for the SDA and SCL signals.
+  External pull-up resistors are required to properly hold the bus at a Logic-1
+  level when the drivers are released.
+
+  For more details, please see https://docs.amd.com/r/en-US/pg439-axi-i3c
+
+properties:
+  compatible:
+    const: xlnx,axi-i3c-1.0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - $ref: i3c.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i3c@80000000 {
+        compatible = "xlnx,axi-i3c-1.0";
+        reg = <0x80000000 0x10000>;
+        clocks = <&zynqmp_clk 71>;
+        interrupt-parent = <&imux>;
+        interrupts = <0 89 4>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };
+...
-- 
2.34.1


