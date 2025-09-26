Return-Path: <linux-arch+bounces-13788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863CBA36AA
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 13:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4DE7AF371
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734B2F3C15;
	Fri, 26 Sep 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DNde8Hmz"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C11A0728;
	Fri, 26 Sep 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884392; cv=fail; b=Q1NBckKF+AmijLQNNW6HFnhfkKrooROSXrq3d8+Q04xv/R9EMBFJPcyNUDYWtDW82P0dk5kOcqm8Qht0sRbf0pSzlaaSE3lS51ng6107NxmxPs5LeVWZ98rmzXLCEjtw2KJqfN2Fr3MZ2kHUiUWbPGBBoZRf2MBbe2pNW7HHyEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884392; c=relaxed/simple;
	bh=M6gFHvaJVpiZKJqHjNf4N7eJIblRQjW489JnTU3J9zE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJeFSFZKxaj5L+uSNZoSoH1npQnXG7RdPWL7dG6H9o2nk08WEqrjnrBSCBOj1+x0rOPg8VgXQUc5S7kXTsIYkoxNWqpjzAxx0Y9L0AHJmvGLMY7uMzKIqWfGEHvDifwmHfQm1SqH2TwvSd26zWscDFAVUPDLi8OzpOE+rAxWJHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DNde8Hmz; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtuzHUHggKE38dd4hCrVJH98U8o46GezL85H1LHoYOQZM/BElpTPg50zwFQ07DD2CIgvpidQGH6ni3RIICsAvih3qbwQzgc7phnKtivox51PjKdBczb7pTtD+y3wiShwgJ55EFMFfMJLjiJ//mBY3kZ9tTlns46JSB6jQw1ZAt8zwqlTDfmOXFKA52q0JB9BMg0ke4a/rI6NwsqhoXem6aVWYIidXafqDu+mZuHcabmhtxPosAfXZRCb7ks5EGOWS7kShw85ZrrbJ1Bw4bSPTuRMlN8zJ5J7d7KP6DjOGQ349XOL0yNDlSJX/acivMeseN63s5U3sBfELGtkQUKIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3hBq9Fzr7MFqIOU0wU2Fuhlzau0yLKsxJp0QqKOawU=;
 b=fNPcb+rQpoQjlKb1xOaNTtg6ZqCqyXq+UMoNtZrUYNRzNuSqVu5q6ZjgE6bV3XVGUgQJlV7EcOobj5kgD5TAG4v2kLf1cF8pejax1jAPzu6jGfb67n0VAxKWJhNE8XZKj7TQf2ceE5emlBM9HCGkvB+gKtdyU+GR/XgBP10XrANWhwb00RaaH5M5744ePZYAwVrAEC803au6zlPrHV4OGOHfzXDm5t0MaL6CmU29/ib8RalMJineBmjk05etHR15YGsRikqPRdf8H84MtbqEX1TnCiH5wfBwW/QDCUlyzXodxs6woRvizDfrTG0xpXGwurwX0hBUmZTWLLYOGRuSgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3hBq9Fzr7MFqIOU0wU2Fuhlzau0yLKsxJp0QqKOawU=;
 b=DNde8Hmz95ugLSKC5r2AfQJP3J2raZ2tZo8PXaKmn9lvpdZykDhDC5e2HVsguxr5BF3DaVZa7Rbr8Yz9/r4ajjONtkrOzuxPhxPt51Sd/6AbuWcME1a6rSwKdyh50e/CUyHOR8+EGEUarbDyBVSAhE7Rczv68iK/3QhtBbvv3S0=
Received: from BL1PR13CA0062.namprd13.prod.outlook.com (2603:10b6:208:2b8::7)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 10:54:19 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e0) by BL1PR13CA0062.outlook.office365.com
 (2603:10b6:208:2b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Fri,
 26 Sep 2025 10:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 10:54:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 03:54:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 05:54:17 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 26 Sep 2025 03:54:10 -0700
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
Subject: [PATCH V8 2/5] asm-generic/io.h: Add big-endian MMIO accessors
Date: Fri, 26 Sep 2025 16:23:46 +0530
Message-ID: <20250926105349.2932952-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926105349.2932952-1-manikanta.guntupalli@amd.com>
References: <20250926105349.2932952-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf62e7f-5023-40f9-c62c-08ddfceb0af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VmNIdXFqNGxxWS9McVdWck5yN0FUaTY4cVFSRlZ6ekV6M0JrY3VXL2FUMWkr?=
 =?utf-8?B?Vmw1ek1oS005NXpYNEFTZ2FhSExFNnkrQnVPRVVSY0dwNEVETVp6ZlVMeUpM?=
 =?utf-8?B?bS8vL0JWTTZ1dXBpdkU1RitqRmNQaW1EeU9Cdmg5L2JNaGEvb2RxVENMUnNN?=
 =?utf-8?B?bkV1MTMxY1dBc2NZK1Z0eldBaHVoek4xaEtXUlRxeGR0MWZKM3V2dHN5UC9L?=
 =?utf-8?B?ZjE1QUh0YU9ldEZtSUJPby9kN0JNMlQzZFlVaXhTWW1qL2hkN2NSOThGY1I1?=
 =?utf-8?B?QTNoMklVQW9ScytWMXh0QkVkc001a29ZbzRxZmY5ek9iY3Z6VUVTUkUvaUl4?=
 =?utf-8?B?YkV6TEE1TXFkOWtkU0JZMGpSRnpocXFHcXpoZDRKQ1hLc25HeVNHWG9Yb09V?=
 =?utf-8?B?a1NvRHorY2JmdjU2RDJycWF4WTduVHRTSzU0aTNTZEJEMldxT0M1akd2b0M3?=
 =?utf-8?B?WUFwNWhmcW5UWFAyVEwrL3FTUHpQNmpLQ0xqZFM5WlNUbGQ5SnZmcjRyT3Fx?=
 =?utf-8?B?Tlcwa1V4bThvL2JEc2w1YThDczBMbjQ1T3l3dlZySUFMbXREcEZsLytvR0ky?=
 =?utf-8?B?N0NrN3oxd3ZZeFpWZHhJMzF1YWczS2ZuRHlXcjUvUjFKY001b0RkWVA1TC9T?=
 =?utf-8?B?WmUyMSs2QkNITFJ5dVhINDArT3Y3c0MrZm50M3dLZGVZQ2JtU0hLcFNoekMr?=
 =?utf-8?B?VTRJY3BZRGJIZmhIbTUySTUyZTA4MXFtdGkyMnVVQWVoRXpQWVI4OUVjRU45?=
 =?utf-8?B?bHpBNXJSRFBaYklyUEtPYUJtaTJLanhmUHNudDRETHVIY2xVL0hvSmR2Uktl?=
 =?utf-8?B?Q25nSmE0YThPclBTVHRHcjVkOURoRGVrSE5wdWlGb3BNUVdDNUt3SWRpME9k?=
 =?utf-8?B?bUdsOE1aMWw5aFN4NHVTQ2Q3cEhZZ3FKZHRYdEUxODhhOGRKWWk2SzZZSmww?=
 =?utf-8?B?bDRqbHc4ZXc5ank0S3hQb1ZsdXQ1aGtLYTlhUU5VWGhhVXRENDFXSFVsSCs3?=
 =?utf-8?B?OU0yRmhURTZNRTRqL2t6Ujc1SDV3Y1cxY0lab0pFOW1CNlhCYjV5YVZMNDFu?=
 =?utf-8?B?SFBsYm9BL2g2YnBGZTVORHVsTS9JbFRkR2NvUTFmeVZSUUh3OFBWZWpRWkx4?=
 =?utf-8?B?MldJY0tja1BwZTVlN1V1elF5cEpUSk10V2hRTFN5K3NLWkhlMFBrSkp5bUZZ?=
 =?utf-8?B?azRCckoxc01sNlhLWTVkTjdGTFlkSVFpbjlBbVBFR21vRTU0TUVtVllMdDRk?=
 =?utf-8?B?REVRYngvaTdKb0dpakRKN1FTMnhWeHRWVEtaQlk2UkRjUFZyWXpkREExQWsx?=
 =?utf-8?B?WmJjdFQvRmQ0dDNTWnNycXZXaEplZTltcTFDUy81dzQyamVnYlRKZFRWQWRo?=
 =?utf-8?B?eWxrU3lxK05PMStpeGx6d1U5dlZLWitmQ2xnU1V1Kzl6L2VXY2xsY2JBS09x?=
 =?utf-8?B?aVNuR2xVeEt1YzdzTXUwVUs3WWRxRjd0YzBuTkdCb0gxekFNRjRrS2p1bU5p?=
 =?utf-8?B?dXBhRHNpU1lhdlViNmRocUtRUVJvQXdyZC8yQTFQNlRqMTdGa0dFM3ZTNEdV?=
 =?utf-8?B?am1hSGFtbndqaWNYcTNQaFJBazNoQVNDSldtdGphVDNnc3piYlMyeW5mWWtW?=
 =?utf-8?B?QWpNWXFITEQxVkg4TXRjMG5rbGErTHk5TTlhWkNZYUUvMHhONGN0Zlk3N1U0?=
 =?utf-8?B?MTdDSXN3aEY2Y2ZVMSt4ZjNPQksyWWx5Qk5Ta2dVcDFUdzhITUlmeCtmbUNp?=
 =?utf-8?B?MEVNck1ZL2ZvM24rdVJlL2NRUzh3eis2SGh4blJValRoRXgwaWlHbzZiUHhH?=
 =?utf-8?B?QW9PN1pMeXFXZFdDNzVsZXk1eDdQNk1xVlJISjlwdTlUV0tkdExJakdRRFhY?=
 =?utf-8?B?NnBJcUIzZklxNElvOEo1MitLdmNYN1RweXNoSE1Zd2dPZVdtbTBUQnBPMFhv?=
 =?utf-8?B?TE1IZE84Q2FnZ25PT0hidXhxNDY4disyc3JMa2E1dExwNEtVVHpvSFZOZEVo?=
 =?utf-8?B?Z2ZITDFRWWN6QW4wWWVYM0NRbld2ZkZCcEt2dVZjb05hUFJNd2xtL0NNTkJp?=
 =?utf-8?B?U1JXVG1nNHZ6cjlkWWtiVXlIRkJyaEtCUVlMZz09?=
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:54:18.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf62e7f-5023-40f9-c62c-08ddfceb0af5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

Add MMIO accessors to support big-endian memory operations. These helpers
include {read, write}{w, l, q}_be() and {read, write}s{w, l, q}_be(),
which allows to access big-endian memory regions while returning
the results in the CPU’s native endianness.

This provides a consistent interface to interact with hardware using
big-endian register layouts.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes since V7:
This patch introduced in V7.

Changes for V8:
None.
---
 include/asm-generic/io.h | 202 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 11abad6c87e1..d18a8ca6c06c 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -295,6 +295,96 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #endif
 #endif /* CONFIG_64BIT */
 
+/*
+ * {read,write}{w,l,q}_be() access big endian memory and return result
+ * in native endianness.
+ */
+
+#ifndef readw_be
+#define readw_be readw_be
+static inline u16 readw_be(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __be16_to_cpu((__be16 __force)__raw_readw(addr));
+	__io_ar(val);
+	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifndef readl_be
+#define readl_be readl_be
+static inline u32 readl_be(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __be32_to_cpu((__be32 __force)__raw_readl(addr));
+	__io_ar(val);
+	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef readq_be
+#define readq_be readq_be
+static inline u64 readq_be(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	__io_br();
+	val = __be64_to_cpu((__be64 __force)__raw_readq(addr));
+	__io_ar(val);
+	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	return val;
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef writew_be
+#define writew_be writew_be
+static inline void writew_be(u16 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writew((u16 __force)__cpu_to_be16(value), addr);
+	__io_aw();
+	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifndef writel_be
+#define writel_be writel_be
+static inline void writel_be(u32 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writel((u32 __force)__cpu_to_be32(value), addr);
+	__io_aw();
+	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef writeq_be
+#define writeq_be writeq_be
+static inline void writeq_be(u64 value, volatile void __iomem *addr)
+{
+	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	__io_bw();
+	__raw_writeq((u64 __force)__cpu_to_be64(value), addr);
+	__io_aw();
+	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+}
+#endif
+#endif /* CONFIG_64BIT */
+
 /*
  * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
  * are not guaranteed to provide ordering against spinlocks or memory
@@ -524,6 +614,118 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 #endif
 #endif /* CONFIG_64BIT */
 
+/*
+ * {read,write}s{w,l,q}_be() repeatedly access the same memory address
+ * in big endianness in 16-, 32- or 64-bit chunks (@count times) and
+ * return result in native endianness.
+ */
+
+#ifndef readsw_be
+#define readsw_be readsw_be
+static inline void readsw_be(const volatile void __iomem *addr,
+			     void *buffer,
+			     unsigned int count)
+{
+	if (count) {
+		u16 *buf = buffer;
+
+		do {
+			u16 x = __be16_to_cpu((__be16 __force)__raw_readw(addr));
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef readsl_be
+#define readsl_be readsl_be
+static inline void readsl_be(const volatile void __iomem *addr,
+			     void *buffer,
+			     unsigned int count)
+{
+	if (count) {
+		u32 *buf = buffer;
+
+		do {
+			u32 x = __be32_to_cpu((__be32 __force)__raw_readl(addr));
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef readsq_be
+#define readsq_be readsq_be
+static inline void readsq_be(const volatile void __iomem *addr,
+			     void *buffer,
+			     unsigned int count)
+{
+	if (count) {
+		u64 *buf = buffer;
+
+		do {
+			u64 x = __be64_to_cpu((__be64 __force)__raw_readq(addr));
+			*buf++ = x;
+		} while (--count);
+	}
+}
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef writesw_be
+#define writesw_be writesw_be
+static inline void writesw_be(volatile void __iomem *addr,
+			      const void *buffer,
+			      unsigned int count)
+{
+	if (count) {
+		const u16 *buf = buffer;
+
+		do {
+			__raw_writew((u16 __force)__cpu_to_be16(*buf), addr);
+			buf++;
+		} while (--count);
+	}
+}
+#endif
+
+#ifndef writesl_be
+#define writesl_be writesl_be
+static inline void writesl_be(volatile void __iomem *addr,
+			      const void *buffer,
+			      unsigned int count)
+{
+	if (count) {
+		const u32 *buf = buffer;
+
+		do {
+			__raw_writel((u32 __force)__cpu_to_be32(*buf), addr);
+			buf++;
+		} while (--count);
+	}
+}
+#endif
+
+#ifdef CONFIG_64BIT
+#ifndef writesq_be
+#define writesq_be writesq_be
+static inline void writesq_be(volatile void __iomem *addr,
+			      const void *buffer,
+			      unsigned int count)
+{
+	if (count) {
+		const u64 *buf = buffer;
+
+		do {
+			__raw_writeq((u64 __force)__cpu_to_be64(*buf), addr);
+			buf++;
+		} while (--count);
+	}
+}
+#endif
+#endif /* CONFIG_64BIT */
+
 #ifndef PCI_IOBASE
 #define PCI_IOBASE ((void __iomem *)0)
 #endif
-- 
2.34.1


