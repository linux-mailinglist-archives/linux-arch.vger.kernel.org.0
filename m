Return-Path: <linux-arch+bounces-13785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698F3BA367D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 12:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236DD627551
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE192F530E;
	Fri, 26 Sep 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nEMT0oe2"
X-Original-To: linux-arch@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25673299AB3;
	Fri, 26 Sep 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884082; cv=fail; b=Cnj5GNsxpl4inpiZzEUFcvp+5onw4BDAFXy7+44I8DNQlxibox20H/jbbuJsIWWXdbDkCADStIBBaLdqLNT3e8C9e82EoCdUFF8siA03Fm3JlVpVBEg9r/T5wZFfiNqGa05fyHnrtFQu9E+rCULUWxDGYk4jdsSl+1zqjQGe6sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884082; c=relaxed/simple;
	bh=DFyJC7STV+17J1YWBhrKUGvUrnZLNgHRTuQ08vU/+Js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBPTkst7Wsodb6hrNYFEPvatH1mokygl14J/Jnpi3MTZsYbpqk1pvzCGp5YkXCV8UJxat4FUG1qGSse+WLafOAY0muovxMZtgZdRXzLWN/LfK2LkEME+6LienScDCgPPi5bVuXLgurBxCXu6usK3H60PicMNg9ekF7krHofdG7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nEMT0oe2; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0pswIPbOQYEswlIH97Zyh7+Vp8BaRFQa43PoWfB9sQWXMvc2h6avnzHtr/4u29qrp9IM5YsXQn2WQ1mSTwSp0hplPpBBby0/Qz+sTcusRT6EIh+Smbi42hhEBEguyGuZDBesIAfKF8bkTdklYpnJesN6RB9TzmCk2drS46DWUJy8ohf5T3MigEMv4vBcEByLYUVRLkCD31jFB9VycecLVXaXXnMp2lY7Mi11M9Hz5/d6upKyf9qczNy03X+x0nCFs0P3VbMtYchruc+WeS+iiEW+e2HcjU5CdTygi76hpyH8IStjCGXQRnO75Ckp728ZDljbL3YoTvnH32798EjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+nGQnzoYt8BiKll2m81rvMUAkQ4MfOUHiR5pL8D268=;
 b=fnb8r1MF4Fk2IRGOeLu8Q2bZSD4wxs/bxOhAXKD9kHB6W329dKn1mIozFT0NYmFyIpDopvxk6gISwXxSWEKKM4ZPqB5rZEFEmVP1RKeaGUTAiS9cx6DdJIgj7776aeD7RwhsDUoE2UR4c19xT2RW8ql3hAwUb/9FFlvgo3OuB4Afei1k8ZwKpHKNNpX6XKnUJ+Hc5U47mqZ3/UvBXoC1s1DwDVopDooWNbgkeKUjYjKmUiaQSsz8FXNJG1r/PyK7o/pNiWTVCcTy2MDdoOoQoLSfcYAd7olsMZ89o3VVMn5CrxjllszwDWZovZlCQCcV0rscDMooesBBY0MMHamumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+nGQnzoYt8BiKll2m81rvMUAkQ4MfOUHiR5pL8D268=;
 b=nEMT0oe26Yr+vddmKB2Dnl/TFuyKDmtxWODNXAtPJbf7FvuvCmno/bjDdrkDXsTfgZvlUddrlYEBqF5a4Uz2Gq9gbxq+TYftb9X42ehjdcrhHc/KjbFoh2AzqmhgC2eUtx7fKxodVepwWYv6kTsnI/bb5CFC/96AXG44W7ckQxs=
Received: from BN0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:e8::16)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 10:54:36 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::3e) by BN0PR04CA0041.outlook.office365.com
 (2603:10b6:408:e8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.13 via Frontend Transport; Fri,
 26 Sep 2025 10:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 10:54:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 03:54:35 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 03:54:34 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 26 Sep 2025 03:54:27 -0700
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
Subject: [PATCH V8 4/5] i3c: master: Add endianness support for i3c_readl_fifo() and i3c_writel_fifo()
Date: Fri, 26 Sep 2025 16:23:48 +0530
Message-ID: <20250926105349.2932952-5-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f85e83-db9b-4cd8-d938-08ddfceb1501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0u2VA92aSvOYvzx0u14r82m61YuvpSiLMCCVEyVlxuW2xjXIqz2AonLqfs/o?=
 =?us-ascii?Q?9Tx2ztK8f8pq/y/koPrDXg9Nt/g45c7tQfXV9Trm/ZBN79FuzEhEjQtj22BG?=
 =?us-ascii?Q?Jnyugzl3WJhrwRoekuUyGT/j+z6ym39ujMn07Q45gH6BYg6dEAdnHPc4Nmuo?=
 =?us-ascii?Q?g3cqd3RhS3NC9E90oJ1zuwF4hsuN+p60tgfh9TYahFvcwtnNJbbpl6f80GD3?=
 =?us-ascii?Q?fVCZmhw21zHC22RTnaHoK24bUu3hPkFw3A5HrzxO/0rhz4raC+8T9o4oYdUz?=
 =?us-ascii?Q?/dUnwlDM4NC9JT/4pv8EKwUKftVvW/je+nFDQScAUUwBXt/HsQUf2ez6hyZ0?=
 =?us-ascii?Q?yJ7mUFDxMRA4QfViZy1KX413n36+mjrRhh67gFfY9zJnIVpkjATEzc9hc9tW?=
 =?us-ascii?Q?H6TbJX9qflJqv6SYfs4Gr7FR427Qt6JTRMMszO7XuKV3Wipucm7w1Dwv3KLM?=
 =?us-ascii?Q?PmjXHwtcepyRSGARFjLF3ecnVEmYHcBv7c0GTA9PkKf7Sy3IKlYS39eQhDNI?=
 =?us-ascii?Q?QM7/r8qlsqziic7ZgRV+qAF5TerWoQSV//5ax+jymMao44JCzz2Zu5azFTmD?=
 =?us-ascii?Q?TPzpbEjvQ13a99FVEtuUFh1g6ycqe3w1UyvXjwvCOP+EAQWr3RKgAqQy264U?=
 =?us-ascii?Q?37TmROTIlpnGOLp8xaNBprIHDcPb+FqzDGjvl+ryNBokhBkfdRRRRs0Fy9K7?=
 =?us-ascii?Q?Y7g1ipVJP6AvyZ9VU2fMd+f3sAuA09Qann5KqB/SpufISZKTeEnOwvtO3Ua6?=
 =?us-ascii?Q?TuOzQiWPh9iHYo4MYCAvekBtkkNaIc5dT/fSpADMVKZ6qd03m1GoNVDRdV8f?=
 =?us-ascii?Q?sDQ5VvjGjOrhaoQpXOYfGm/Y0g3P6uDAl+H2ovwloFhW+1/WmNkswrmeONMH?=
 =?us-ascii?Q?j3Ad8anHyxXIVSGcpmQTLEkS/a8UMHEm6ZzB2M1Fj5Krvh7I3GIRVzEzR8iS?=
 =?us-ascii?Q?blj8t3jpfj1qqk4wI+gV+D+B0M2OiqAJOM3qaIBI6vUN4IkovyjgYgODCldm?=
 =?us-ascii?Q?9YOfC9TQqwKzDutun8su9V7Ufh7JX6TPP70GiBLqGdfRdQTMFucnNktGuG7A?=
 =?us-ascii?Q?oruJAYG4Vj5Yi2lMeT1AWP487z+T90bg/TxyX3ZiESjoNPAujvhAWWk+CDZl?=
 =?us-ascii?Q?ggvMjTLVpTzZTCB6bBDE/qo5aDmZTSlvH5I4Id4wHKYRSI8BYlDkjTiBh/RH?=
 =?us-ascii?Q?3K2f77UJZt3rmzsY2GfF+8maDrtAY7cFKv2Y6DBmI7ZYvBo83JWQW8D6bi5G?=
 =?us-ascii?Q?r/l/1DSR6s4nEdGdnh3ad4eOQywTp2flBc5XpM94v7P3eXD2xS1EhzpvCXae?=
 =?us-ascii?Q?gCxY3GfbASYAixW47BPJv3WsSLB/M1v52gSDgsFRqZLMhvfiLwN48SUnzT2/?=
 =?us-ascii?Q?W0DUSm5ocYV7i3+NTzSY5mG7W3KAXjPpxukuVhEOA5cy+4h1J1M1xCTUPSTY?=
 =?us-ascii?Q?0YckYtOaJdgdtPZJ3fPwAyBm9LFY2Euli/hw4XhDBUj+pueuiO0w6ZY5hgcj?=
 =?us-ascii?Q?vSbVqGBDda8fIc7Z6wTxP/dnk7KiTRhfWb8citZpGmFQ73EWuHXJ4OKabRHQ?=
 =?us-ascii?Q?xCjL5cCGVEavMLkm67XMWsayF/kW+WSmwRc0uIes?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:54:35.6010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f85e83-db9b-4cd8-d938-08ddfceb1501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

Add endianness handling to the FIFO access helpers i3c_readl_fifo() and
i3c_writel_fifo(). This ensures correct data transfers on platforms where
the FIFO registers are expected to be accessed in either big-endian or
little-endian format.

Update the Synopsys, Cadence, and Renesas I3C master controller drivers to
pass the appropriate endianness argument to these helpers.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes since V7:
This patch introduced in V7.

Changes for V8:
Resolved conflicts with "i3c: fix big-endian FIFO transfers".
Updated description.
---
 drivers/i3c/internals.h              | 45 +++++++++++++++++++++-------
 drivers/i3c/master/dw-i3c-master.c   |  9 ++++--
 drivers/i3c/master/i3c-master-cdns.c |  9 ++++--
 drivers/i3c/master/renesas-i3c.c     | 12 +++++---
 4 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 77d56415cb99..d3630e9129ae 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,25 +24,40 @@ int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
 
+enum i3c_fifo_endian {
+	I3C_FIFO_LITTLE_ENDIAN,
+	I3C_FIFO_BIG_ENDIAN,
+};
+
 /**
  * i3c_writel_fifo - Write data buffer to 32bit FIFO
  * @addr: FIFO Address to write to
  * @buf: Pointer to the data bytes to write
  * @nbytes: Number of bytes to write
+ * @endian: Endianness of FIFO write
  */
 static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
-				   int nbytes)
+				   int nbytes, enum i3c_fifo_endian endian)
 {
-	writesl(addr, buf, nbytes / 4);
+	if (endian)
+		writesl_be(addr, buf, nbytes / 4);
+	else
+		writesl(addr, buf, nbytes / 4);
+
 	if (nbytes & 3) {
 		u32 tmp = 0;
 
 		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
+
 		/*
-		 * writesl() instead of writel() to keep FIFO byte orderer to match
-		 * the order in the buffer regardless of the CPU endianess.
+		 * writesl_be()/writesl() instead of writel_be()/writel() to keep
+		 * FIFO byte orderer to match the order in the buffer regardless
+		 * of the CPU endianess.
 		 */
-		writesl(addr, &tmp, 1);
+		if (endian)
+			writesl_be(addr, &tmp, 1);
+		else
+			writesl(addr, &tmp, 1);
 	}
 }
 
@@ -51,19 +66,29 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
  * @addr: FIFO Address to read from
  * @buf: Pointer to the buffer to store read bytes
  * @nbytes: Number of bytes to read
+ * @endian: Endianness of FIFO read
  */
 static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
-				  int nbytes)
+				  int nbytes, enum i3c_fifo_endian endian)
 {
-	readsl(addr, buf, nbytes / 4);
+	if (endian)
+		readsl_be(addr, buf, nbytes / 4);
+	else
+		readsl(addr, buf, nbytes / 4);
+
 	if (nbytes & 3) {
 		u32 tmp;
 
 		/*
-		 * readsl() instead of readl() to keep FIFO byte orderer to match
-		 * the order in the buffer regardless of the CPU endianess.
+		 * readsl_be()/readsl() instead of readl_be()/readl() to keep
+		 * FIFO byte orderer to match the order in the buffer regardless
+		 * of the CPU endianess.
 		 */
-		readsl(addr, &tmp, 1);
+		if (endian)
+			readsl_be(addr, &tmp, 1);
+		else
+			readsl(addr, &tmp, 1);
+
 		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
 	}
 }
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 974122b2d20e..5d723ac041c2 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -337,19 +337,22 @@ static int dw_i3c_master_get_free_pos(struct dw_i3c_master *master)
 static void dw_i3c_master_wr_tx_fifo(struct dw_i3c_master *master,
 				     const u8 *bytes, int nbytes)
 {
-	i3c_writel_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes);
+	i3c_writel_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes,
+			I3C_FIFO_LITTLE_ENDIAN);
 }
 
 static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
 				       u8 *bytes, int nbytes)
 {
-	i3c_readl_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes);
+	i3c_readl_fifo(master->regs + RX_TX_DATA_PORT, bytes, nbytes,
+		       I3C_FIFO_LITTLE_ENDIAN);
 }
 
 static void dw_i3c_master_read_ibi_fifo(struct dw_i3c_master *master,
 					u8 *bytes, int nbytes)
 {
-	i3c_readl_fifo(master->regs + IBI_QUEUE_STATUS, bytes, nbytes);
+	i3c_readl_fifo(master->regs + IBI_QUEUE_STATUS, bytes, nbytes,
+		       I3C_FIFO_LITTLE_ENDIAN);
 }
 
 static struct dw_i3c_xfer *
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 97b151564d3d..de3b5e894b4b 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -428,13 +428,15 @@ to_cdns_i3c_master(struct i3c_master_controller *master)
 static void cdns_i3c_master_wr_to_tx_fifo(struct cdns_i3c_master *master,
 					  const u8 *bytes, int nbytes)
 {
-	i3c_writel_fifo(master->regs + TX_FIFO, bytes, nbytes);
+	i3c_writel_fifo(master->regs + TX_FIFO, bytes, nbytes,
+			I3C_FIFO_LITTLE_ENDIAN);
 }
 
 static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master *master,
 					    u8 *bytes, int nbytes)
 {
-	i3c_readl_fifo(master->regs + RX_FIFO, bytes, nbytes);
+	i3c_readl_fifo(master->regs + RX_FIFO, bytes, nbytes,
+		       I3C_FIFO_LITTLE_ENDIAN);
 }
 
 static bool cdns_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
@@ -1319,7 +1321,8 @@ static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
 	buf = slot->data;
 
 	nbytes = IBIR_XFER_BYTES(ibir);
-	i3c_readl_fifo(master->regs + IBI_DATA_FIFO, buf, nbytes);
+	i3c_readl_fifo(master->regs + IBI_DATA_FIFO, buf, nbytes,
+		       I3C_FIFO_LITTLE_ENDIAN);
 
 	slot->len = min_t(unsigned int, IBIR_XFER_BYTES(ibir),
 			  dev->ibi->max_payload_len);
diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 174d3dc5d276..5610cf71740e 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -835,7 +835,8 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer
 		}
 
 		if (!i3c_xfers[i].rnw && i3c_xfers[i].len > 4) {
-			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len);
+			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len,
+					I3C_FIFO_LITTLE_ENDIAN);
 			if (cmd->len > NTDTBP0_DEPTH * sizeof(u32))
 				renesas_set_bit(i3c->regs, NTIE, NTIE_TDBEIE0);
 		}
@@ -1021,7 +1022,8 @@ static irqreturn_t renesas_i3c_tx_isr(int irq, void *data)
 			/* Clear the Transmit Buffer Empty status flag. */
 			renesas_clear_bit(i3c->regs, NTST, NTST_TDBEF0);
 		} else {
-			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len);
+			i3c_writel_fifo(i3c->regs + NTDTBP0, cmd->tx_buf, cmd->len,
+					I3C_FIFO_LITTLE_ENDIAN);
 		}
 	}
 
@@ -1061,7 +1063,8 @@ static irqreturn_t renesas_i3c_resp_isr(int irq, void *data)
 			if (NDBSTLV0_RDBLV(renesas_readl(i3c->regs, NDBSTLV0)) && !cmd->err)
 				bytes_remaining = data_len - cmd->rx_count;
 
-			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, bytes_remaining);
+			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, bytes_remaining,
+				       I3C_FIFO_LITTLE_ENDIAN);
 			renesas_clear_bit(i3c->regs, NTIE, NTIE_RDBFIE0);
 			break;
 		default:
@@ -1203,7 +1206,8 @@ static irqreturn_t renesas_i3c_rx_isr(int irq, void *data)
 			cmd->i2c_bytes_left--;
 		} else {
 			read_bytes = NDBSTLV0_RDBLV(renesas_readl(i3c->regs, NDBSTLV0)) * sizeof(u32);
-			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, read_bytes);
+			i3c_readl_fifo(i3c->regs + NTDTBP0, cmd->rx_buf, read_bytes,
+				       I3C_FIFO_LITTLE_ENDIAN);
 			cmd->rx_count = read_bytes;
 		}
 
-- 
2.34.1


