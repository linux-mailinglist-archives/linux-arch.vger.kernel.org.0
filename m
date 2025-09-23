Return-Path: <linux-arch+bounces-13727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F7AB96A35
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E4148716C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCEC1E491B;
	Tue, 23 Sep 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hzJN+WEq"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6C1A23B9;
	Tue, 23 Sep 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642389; cv=fail; b=VPtyZbyiOZHQDxpeuLpUGwybrhQ/Rdm/KV64SolYzDKVcKGLncuEtj/ZC3qovYg5/Gbi5RrjdrrShckn2XHWPmMWZ3s/FzKMZDwdyaQ2x2Wu6rQZZ/AXTLKpPeV0McvKGjRIbzIIomfaEe7d2WVS/4hMdtX5gZYkDqHk8dyNVx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642389; c=relaxed/simple;
	bh=J5TYhwDz7oyKaDjtklNYLnY6ciHgxEgP6JmiZbuMaos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9kAtKL0Hb0njpTbnwvj4MU+E2waSGKg1o2h3NBNBMMxkXlXSpIdwNScJb0qYq7fFLhKLODUKsy1w5HqCi1T69cqRtgQGeeM8ggTVPGGqzbF7KLhhXsajf0nj5S+Fp4VpR14ZVkzz6bzMvkznwlb0k1ohKxMzxsBCSr9FRYkOiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hzJN+WEq; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxgvssG0lixNZ1h4EWOvtEaFeyGXJbhxUzFi/qXP5njK93QDVC9KDxDnJ4TdQ9ovggvXRsvZOvjH/u6mS/IQ7XhRl2lYOhGW50wMLK1DkhwyGza/TodoMIqFoCRDj2+s6J7o1i1t17Ws25K0TkSrTWPL16JFXHG/qnmvbuWbeo7+VWiA7VhrF8kFfyzKZulWo6QcFziE6LMQhbyZE/aC5PLa5A43PxR1jJ0XCz1Bn+URciuunjn2o+M/KW/mdZBcqhSaWI6IG6Vpv9hGJtPfDcWqQc20zIZpa2tMtTUpcB8VCvF+S0TGW5yFtoaNcPPPZEFQ2tnIH+Q+Ak29OG0Pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRhuU8P6a7o0uhH4BOdZaAKP1Vw6TSt4skkMrXvX/nY=;
 b=fViOYnlvZcftO372Fvebqo0bIdfQLEiFdcUfrGGAF4ym9cJNC5wxnzKpfY3Qdaq8VOkuPQB0K4zxwhTv7lvt4sAZv6BZQWTzNNBtZmP0alLMjZ4IcaR3H9mX7VPdsAVEp6aEQ+7DyV3q+3OIb3C6GiE3qYCcR96GnE8jJuKkJJj6B037NZrwIZjYQYnc7CY3+Y3qq4A/OovFfA71d5UoQOQJ8UH4KHZ2VJqBgw4ug5AhGkrs1ACUVp+G6neO4lhI0L5X0Kgl9f+s9j34/2myKC0gd7wVxb/e5m82BsDPvaRPqYksqluNZE86WDebIgm2v8jNauB6xbeSLdABah8s2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRhuU8P6a7o0uhH4BOdZaAKP1Vw6TSt4skkMrXvX/nY=;
 b=hzJN+WEqkWCIcxADiuQfo9d3MAm47ETwxKupchqiTQ1AcGpzaOcXkuGG1eu+l8WuddmkdhYcPzNC3XMRWJ/Le+IembIBl3idWEbXZQ4rrVYACTViKKtUgeCz76IUss2eOga+eqiK4A+XUPRupkdcRKlj/2UT3ZM+KvG73Hlo90g=
Received: from BN0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:408:ec::26)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Tue, 23 Sep
 2025 15:46:21 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::97) by BN0PR04CA0111.outlook.office365.com
 (2603:10b6:408:ec::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 15:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 15:46:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 08:46:18 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Sep 2025 08:46:11 -0700
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
Subject: [PATCH V7 1/4] dt-bindings: i3c: Add AMD I3C master controller support
Date: Tue, 23 Sep 2025 21:15:48 +0530
Message-ID: <20250923154551.2112388-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeaf330-dc58-4641-b1d6-08ddfab85797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFYaUHvmLRFWDY9kQJfABMeu5bVIgWnmHyeIrUB/69IMPagutgesvQgjyrCe?=
 =?us-ascii?Q?VPgT2J4rWP9a3CPLcvGwz+g8WkE6KVb7Ex49WJnUPdBDlYBFmRo2GDtsyQJx?=
 =?us-ascii?Q?es/yGsUBMq37V9m9i0ze0ZTsbZoZOk7wals9qs2eFUzRIICfvntM43Q4qzhb?=
 =?us-ascii?Q?hb48kWRmkotVG88f2kczmfOrdvVsvkIxdd4+PmoWaKu5vlrx70BFtDCHKpwO?=
 =?us-ascii?Q?RgxQx15+WBRD8BC6OY75INAlewyQZuMJcv3OAR3CcsAwAOlEhsMFnKBplLoK?=
 =?us-ascii?Q?ph0aYtMHb4yZmbnJb7Jzq7vUgOX/qn2p5/GmBzAof9TaMVcdiZyx8GaSqhtj?=
 =?us-ascii?Q?7f0iodfTapS7HcaRCDRZoYdu0mQ3BBtHT51p3r1hz0Y0YaDw1lvGN+lHsINK?=
 =?us-ascii?Q?26TPg45uvRwQArRI4BIsa97O/+WnMvyfu4D5iEjcMcbBBlhjgayyd/A/9IX8?=
 =?us-ascii?Q?VcvTFrTTwGB24MZNlYwP/6QCmZ/Q2cp6XlIq13kGJRjeDbmb+7vh3nNYoPja?=
 =?us-ascii?Q?lJkPTgi6uSt9cqJyTV9A0QL6c287nlFoffpT7ZVCdFyRnqqpMRZP/oHp96wt?=
 =?us-ascii?Q?Yxw9XNWExswTvBzeZ54wrkZl1ZcnJ/l8ztn+jr0XpNg6A6lkHZEzf436jayV?=
 =?us-ascii?Q?ZsjLkOALwZMvl27jOvq7r6sUuZAt6GLjnnwMHozRE8zo6qISnyhJ4bLm1TNT?=
 =?us-ascii?Q?E450qGjJOF4Re/R5pe0nfuQ475RbQnHXN3fArm4N+fyxqYr6RVEMwgscwgto?=
 =?us-ascii?Q?KgT18GddSxNiGjjS8TrV9iEJiWPnu1rLKvlgiEn42p/cGFWKqJJa2l1WU+ed?=
 =?us-ascii?Q?Qa3UT40Fi4CotCgksHA5UW8g4yki/HEvwSQjvtRjYUGPhuBVuhrmpItEFgIW?=
 =?us-ascii?Q?YC0tH4Jwi+OAtJCq42f66wvr8xZ3FdtJ8a4X1Zt1nV0A6wrv7eXr/JG6ixkU?=
 =?us-ascii?Q?ivo1QR2st5JXfxT+qjejwyiVPmc16UZoxJmtePuj1hX8RWrg+JuUgu8yEV/u?=
 =?us-ascii?Q?rLhQg6Tzum1VJZkBWwCBd02MrIcaAyh9f86dhk46kDuPnad3vsTF1SX0PQVd?=
 =?us-ascii?Q?h1dCcAqQjaf/Jdbb59JSdaKvJ9q5qSFOfzwdPg4/ZDZvfaBeeSe1Ffbg+80w?=
 =?us-ascii?Q?2cDhcaZu/t4S10/HoU16yVnh7tQ5am7mn9qZ5XiyQfZRA2UzXcIko3eleQIQ?=
 =?us-ascii?Q?T26/++bYurnn+a+3l+AAY6Z31Y6ptxJgD8anw/bfcfV0mtyn+J5FIQ+C570E?=
 =?us-ascii?Q?dmUm0E5Hy/Lqg5pyITu+2VnLQwWJB9SXmojkAw4IJ3OKm9+V8Cz8Gs65/mno?=
 =?us-ascii?Q?0s1NhSkqNvJmIJ2KUOseYLm04Lcgt3gS5OG70owLwjKmWHnGyLO9Mi/JKI5R?=
 =?us-ascii?Q?dSJp69Jv5Wlkxlo8c+mmR5JI7Kkh1b6fT4HDwV3riKDVjQ+cTOSrCKD04XNK?=
 =?us-ascii?Q?bf1B0qFn16WEv1g5PL/EJyAntVFaYsd1w9INszb1jp+3f5U8R9pjGpTUrxvz?=
 =?us-ascii?Q?H05ZqBdceO6xBx8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:46:20.6521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeaf330-dc58-4641-b1d6-08ddfab85797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069

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
Added Reviewed-by tag.
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


