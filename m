Return-Path: <linux-arch+bounces-13729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511CAB96A4A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B52A3B5452
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89216273D6B;
	Tue, 23 Sep 2025 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Qt5i1mm"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB126D4C7;
	Tue, 23 Sep 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642409; cv=fail; b=kbb3SgWqUKFRL0SQ5i5U+q0HOtkONevwAE4GRJ/J6DBOhvOrNeqONru42cAZUUaNrHZlEHjl1V7CgcVFFxUkJWN/ipzX//fvqjRVqERr4xKdwco2e1S4cpQC65VrJrQIaUnnogLoEiARkX7y+BG3NEJg9hnplBCvfBly7Dwljio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642409; c=relaxed/simple;
	bh=UgwM+oT9E/6Zee3OSWfm8NIwUAgycgL2PVdMv6SJaR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5T5/1pXbvUraXNXf55oprryKQARO6Lj/p+Ou9L6hI9W+64xqq+3LSGVQ+Ea4DD3Tj31oF/tKGuTeP4DgvNSxQgYMvCEh+OLFYj/lXimK9zdu8kRkGOsz2MH4gEZhRcvkLn3+gn6YLQrhGw8bwH9gtQ8plEigg5smfw3ckbFJDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Qt5i1mm; arc=fail smtp.client-ip=52.101.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzr6V2NO0TAW4ecNMAcmhuzFqy0OBNqDg90ncRw1tGuebJsPc+p80QO5dHGtrcrcWcCrHTtcRc2Oid/GQbFbGmi+PYl9gAOO4cq5NjDZ4S9NGc0+GiNFDLG9E+TLmp0oxOMWj3w/LAeq0VKIIIgjZdnWfN2pphYyIX9qqiTr1PnJ/3o0se9eCmTOnz0wqqFkiMlAx9cEZRbqPR7S0mQoihuwimjp6m/iym4ffL0d5HFicCf91s4UuL8DT9C+C9lo2fUtbrV67sHuXjtBis5uK0lZV+kaCTFFzDBdO9ENjojVXun+AQ8e3y+1uAy/duN4ZVETpD1U2NAs1cXHGFxohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPA6N40kC0+iDcaAP2ZiXUQKYA5Zqhqurcamsg962v0=;
 b=GZDbHipqOpCz3ZceO6/inLAdIbRMvgyDxlUSS75Cbc0xzhscfRHetWLJHhcXQXRaqD4xc/MvMDbe/Yng03sz+IdWjTPpUjW1e3UyOkPe4VVCVkFAqrFF1O5p2M3QNduA100gbyr7URi4QbbgH9BGJUT4YIV3tcp78fVu8/vz8ThGzXHgVfttgwgW/S2XNOSrulZc+HEUC4n2T7KWqgQE1Bls24f4lqB80JBaoQ02K6Tfji8d5E06WhwUP8jV00P8ef0fqXTq1LIpwYtp9FYzG+LedpjAi98G6wCDYW171RSYpUrbqDBAbC3NOEJbjO27RRx2bcPuMiSlA6+Gf/OD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPA6N40kC0+iDcaAP2ZiXUQKYA5Zqhqurcamsg962v0=;
 b=4Qt5i1mmOS70PoPnFNmuVqvDuUJXmmw+y8YEs0OtqA3wD9f+3Sc29hL4aOq0hGxacuI6GdIvuQKDu0QI5+ScEDoWhGoEy6jDwTK+F7R/WfYb5oZdORoEToBxfjTW1jhXa1WzCdq93jmJp6LNunFrK+5w3rJdnX9hs+Ar5aehwVY=
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 15:46:39 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::f5) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 15:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 15:46:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 23 Sep
 2025 08:46:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Sep
 2025 10:46:37 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Sep 2025 08:46:30 -0700
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
Subject: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_readl_fifo() and i3c_writel_fifo()
Date: Tue, 23 Sep 2025 21:15:50 +0530
Message-ID: <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 265bc5fc-9f27-492f-5418-08ddfab86282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bKOdOjeYrIlNFTn5XFPJbC3IBhLwYlbmzEyl4UZSUE2zN6O4FGXoPoikyPkJ?=
 =?us-ascii?Q?XJKpuVxxVwh5FiRV5BOxmIMGDgKZvcHTk1HQt0pB6wGOXHRilUST60zvCPIb?=
 =?us-ascii?Q?tXTMdX1iTSLUg7N5WYODNpND14+FRwcPfS0lyhq9C0nc4iwbvWsBVQWvACSK?=
 =?us-ascii?Q?kWwzskryKKEd/M/fbhXrEr1Nk5Kg0yX0daK3Y8GDcH+3cAwNFr70VaSt9SWc?=
 =?us-ascii?Q?+/H7LUZh5+QwVt6oK5Pfibhd1+HsUaNnjGtc1NOdyvKTMGNixqShO6UOlPy9?=
 =?us-ascii?Q?pTv6fvboO0cVNbVPSthCxr3cAfacUwXnM0hu4UnjbV+btPBsAyNl4u+aJDsA?=
 =?us-ascii?Q?2ANWNw+gHsP7ODzeZOtIEMIlN3PF3kGs1/GS45wnqUhR+saGzm3eyPAuFXCL?=
 =?us-ascii?Q?OVn/bI2JGE482Egs8loRwiMGiM00+ZFkibjxJD+WE3I+NpwqIO5USSl6XQeB?=
 =?us-ascii?Q?oZDltK5BwH/KemY3UJZArBcF/netRtEbo1Rput6JqKU3xpkoVwUrtjVLjR5w?=
 =?us-ascii?Q?H6vEctWjmzPtC29bRS8/4zQ9SWgHXba99q0CunhePa2c6h2r2x2plMmM/4xC?=
 =?us-ascii?Q?3l6yghG0pm8iY4ThWKj7Y2Qw4sMkZf2V1AytHLxc+zN5VBIbbJ/n02u9Vlq8?=
 =?us-ascii?Q?H8BAWI15CJK62VVOOoAby8l0XjnXHvYok2UfdA0Gk37tQQs8OuIR2nMzU5tF?=
 =?us-ascii?Q?vwPWDnY+3SXY2mLQRVp3+kZpFI+lCeipHIegSRdgIeIXx5jHsX3b6nhPgeoB?=
 =?us-ascii?Q?8IMvI7rS0JRQ6Qyrp7AwSl6VxKQTp8IofIDsO84MM/vtgHGaxcHo+lmpz01B?=
 =?us-ascii?Q?25MV7byP1bInlnhukApvU4nzDY4Fbt4DpppOSbPnrbHPEWnc/PYtTOqfB1ZL?=
 =?us-ascii?Q?Z/osWra/JlVliB7LLxktmUTg63iRhiQyVBdL9xv4XswEkezV4GHzYvdzZTx+?=
 =?us-ascii?Q?DA8wPl/az7vBgv9wqQKr+REgJoOdbcPzCBHcAJG2lqapxC1bXtPx4Kzh5X27?=
 =?us-ascii?Q?40KNcPNIHRCkp1p1mJ83ddAzAlIy29LSLB09jt97P9KTScjdZCFqpI2ux5pK?=
 =?us-ascii?Q?8RYcv870haIauaRe3Rmvq1kTJJNFeNMxzCGFeWDjGxJ5btsIvosAHKi69qAD?=
 =?us-ascii?Q?JoQMPrkxF2eyi/XbmxtfPbquuYNeOlouTJwzFSKrLGJ7Nx6AEZrT2EgnZ2gT?=
 =?us-ascii?Q?XHTxoB394s5w80Mr03mZU7lT5IIBK4CnKI4moPxPm7KBemSmRZqexM8p+UkN?=
 =?us-ascii?Q?fZFrp0r84Kai5Ve8OYEp8JZSxInXVMkYmRAErAVwNXQ/5OFLJ5o2WUl7HUOg?=
 =?us-ascii?Q?RmUqlwkshNZyK7WBVGteMapD2nC/DBdjbd1Em710+gwZwGaHSmOge/PjxqPY?=
 =?us-ascii?Q?54Rzoe1ZC59eZwBoG17jmzrVNLwfZSHQdi9m7w0o8uCxy8mABbJU7Q8/7nAi?=
 =?us-ascii?Q?40UTE2hbpp9gpIf5v0/apKwldwO5Va4qMZTfOFp+rShCpBr4qxY/ZVqUvHGd?=
 =?us-ascii?Q?z5/P3Bopch0ckFSwYr9v916gdY4+4v7p0cNRwPfvoWe+71UULMHX3MI+gw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:46:38.9670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 265bc5fc-9f27-492f-5418-08ddfab86282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

Add endianness handling to the FIFO access helpers i3c_readl_fifo() and
i3c_writel_fifo(). This ensures correct data transfers on platforms where
the FIFO registers are expected to be accessed in either big-endian or
little-endian format.

Update the Synopsys, Cadence, and Renesas I3C master controller drivers to
pass the appropriate endianness argument to these helpers.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes since V7:
This patch introduced in V7.
---
 drivers/i3c/internals.h              | 35 +++++++++++++++++++++++-----
 drivers/i3c/master/dw-i3c-master.c   |  9 ++++---
 drivers/i3c/master/i3c-master-cdns.c |  9 ++++---
 drivers/i3c/master/renesas-i3c.c     | 12 ++++++----
 4 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5..399bbf006dcd 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,21 +24,35 @@ int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
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
-		writel(tmp, addr);
+
+		if (endian)
+			writel_be(tmp, addr);
+		else
+			writel(tmp, addr);
 	}
 }
 
@@ -47,15 +61,24 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
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
 
-		tmp = readl(addr);
+		if (endian)
+			tmp = readl_be(addr);
+		else
+			tmp = readl(addr);
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


