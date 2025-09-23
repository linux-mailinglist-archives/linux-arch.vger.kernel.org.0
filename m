Return-Path: <linux-arch+bounces-13731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE6B96A62
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0D418A31FB
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719626F296;
	Tue, 23 Sep 2025 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V2GVX/m0"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D826C3A5;
	Tue, 23 Sep 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642427; cv=fail; b=G7QosH2+3CjjHQbFgVu2csKSV8VwxWSw3IrBhHITMgI2WmYs72sFDnR17en0muA1lSXT3A5D8FPpLlu2UJ51Q4lvdAzgqpyNsA4H8CgIAkm8X7DiqbR3s/51vgBr32w6Zo1tndHoM7Jz9UtggMXiKm1AIqC8+C2lE0NFEhGQGL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642427; c=relaxed/simple;
	bh=LuTD8DNbViTS0agyHSSoofmw4nfjksaiYYEuN39Srgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWnVDveb9lD90RAe0MTXAQmWXu7/CgoB8lluGjcc6WnzXdrdQgTjevIaylvIFpre48ibu7VmnkiFn+12O7Tf/8c9KGNSVL/LoJqV6C+lj4mVLOzF8xAdG3M5T5/nH3lWc8z64SgLi8MFBCHtlqTO5GGTM6fIZpFiWvBDeyMBZ1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V2GVX/m0; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGmyuGQRlaVd33PUZg/YG9TbfILIWhtkBfSo3jD4kHTQklNInLxAy5qhtMzjDq3Ca9WdJ/Bcj4xxfC+s8KGbsCaLKuAzyAu1y3xMbawq18FxyHX/cW/KOF35kPh40EBMmBHiT2maccGfFuKrrpjzX2SkUCmFozq8bjvqAZv2tjklnxx3z9Kdxg7QXChBY3dDuZV5uy+VhtKVgpP82SP4dIF9YIc0qCMFtN9wc7jlIda1ffmyk1+tzHsb3hXFSx4o0G2ea2L3JPD5u/LlDBTvyr70gbCpqphl5Wj26uOzSqs+PkwinMG2bXusg7SyEV/Mny5NDMkL92trVGuN3Gl59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN6Rms9ZWlmB51/0a2t2eVkqTDK/TfL+wO5M1aUkQ0E=;
 b=sOUVDfnBPWko903DnZ99Bq2ADhJcDrGoT2ht8qP7bLrAAizXq1WoOHhgKvpktHakoKVbsq89DaQuE+O9BPSfoCIRimSONGDv8hhsveej4xwpjtaC3ifmdWvBWQkaHLmqdZ/7Wd/MiG13J5taPRNj+hMPfLoA1Bw+tHQTROUj0KgQvbJnvVACN+MhD/sVxvLE5ncjqKF4RBvxgvwb/7oZQiYr2mqdzru0Ze75H9Ejx4CaFEzPPrUNfWepUhenKnVdQsIIq1OxqHeQTDex2JdDtHbxy/A1I+6gaaMl2jsHQWknyTUueZw04Nu0qLYaZCfMXJFrQUS2zn9FeiNZ3Y/F3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN6Rms9ZWlmB51/0a2t2eVkqTDK/TfL+wO5M1aUkQ0E=;
 b=V2GVX/m0DRF046+199NPs8/mGJEYkWeT8J/EBQeY2EXcKNiSUggLKy+fN0DDSFpaALcyluStlBN/fa4QQOa18wushNil8U/PISFQ8PSW9UFmLnjA2u04yP9KKpnUqAivVNobOLhJ54VpS91hrAm3zbl0AmpeI4X/aMoKpupSPsE=
Received: from PH8P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::8)
 by IA4PR12MB9836.namprd12.prod.outlook.com (2603:10b6:208:5d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 15:46:59 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::98) by PH8P223CA0002.outlook.office365.com
 (2603:10b6:510:2db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 15:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 15:46:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 23 Sep
 2025 08:46:29 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Sep
 2025 10:46:27 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Sep 2025 08:46:21 -0700
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
Subject: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
Date: Tue, 23 Sep 2025 21:15:49 +0530
Message-ID: <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA4PR12MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcb56d4-bac8-4633-34d9-08ddfab86d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amFrOHlzT3hsYVAyVWhVR2s3V3Y1OThUSVRkRmovTmdCL25kc2lpT29ZSDls?=
 =?utf-8?B?dXcvU29lWUNDMVNjcEMzZGFJQ3VtdEF2SHRDdUFwOEg0aDF4K0Q1Rmo4V29K?=
 =?utf-8?B?bVVpQnFEWGx6TmNyWUVuaU5tbTBqZDAwMk1QS3FLcXExMTJQRXdZbkxFR205?=
 =?utf-8?B?WEErWi9UaGVMdEFXbzFhR0p2SGZ1NEp6VXliNkx4ekpnbEpaZ3hkeUZIZXVE?=
 =?utf-8?B?V3N0NmdHUXZReExWVEgyb2RFV1JaN0FjblZVQnBwQWhranFhNjFra0Y5QXFw?=
 =?utf-8?B?ajM4cm1IUnB1S0lFNzZtTUJwb2U0TDVSUjMrcWFzLytyQUplaFRYZDlDalhx?=
 =?utf-8?B?WEpNZ1orU0s0bDRIMmMxUlcyOTdsSnZCakZteEFDWmJZSlNsNEtsNy9WU3NV?=
 =?utf-8?B?bmdaMHY1Skc1OWdLRzZwemVpNmlYOFhkWElZQUV2T2hrWjN2TDFhWmc4Zmta?=
 =?utf-8?B?QStBVjVlaVB3N3RDQVlHUDhLcDI1VVgyTjhLM3doVHcxUU0rNUhhaVFYWFY3?=
 =?utf-8?B?ZmV3SUNtZHZVUjJ1My8zeTJPeDA5MUs5N0RSeldpemRON1hXVGRQcVZtSkl4?=
 =?utf-8?B?cTdFd3FiT2Uya1F4MTFXaVhxaERzTzZFTkQrVUxxTUIzS3djQ3NhRjVJQnFn?=
 =?utf-8?B?QW9VUmZUVHQrNXFlQkQyYW5Icjl2cEhmMGNsN0d2K2hNcVExd2pLUng4RjZM?=
 =?utf-8?B?SmF4RSs2YXhIdU54STgrOVFIMHROc1FPcmh3R2FZUzF3ZGx2UHRiSThYZDFy?=
 =?utf-8?B?TGRQc1ZFQzJGZDVwUitSdkJrR3hmVTdTT0lPTHQvcmpvYmR4cno0cGFtcTRQ?=
 =?utf-8?B?ZjIvamMzWW9iVzFHVmlvclhUd0NOVEF4RjM5clhqT0FrWERzdTZYQnk2VlFT?=
 =?utf-8?B?SXRoM2IvOGVrY0FaUmpIUGFaUE13c09NekRCcHdPN1FNWHBVNHFXK2Fha2s3?=
 =?utf-8?B?UFN3K0FuK1NOOHF0VkFtRkdDZlNIc0o5bW9EcXlyYzhSeVlVR2ozdnkrV0lx?=
 =?utf-8?B?aDhOMHZqTTlJb05tandBRWxVdDduRVBKbnJJeXFvcDlGcGljUnVROXZINjZw?=
 =?utf-8?B?cjQ4cGJWS1kzaWlvc29JaEt0aStLR2pwTTRnRW9zZjNWQ0NBcmkyRWhkQmF4?=
 =?utf-8?B?blFEYTdGMktYakdKa01ZVHZBa3Bsbmw0M3hnV2JBaG10cDFEQUQzMm84OVlm?=
 =?utf-8?B?RkF0K2ZkQWdzRi9XdDJMRnNwa3h4OHlVTGJabHd5ZUJXMVFWMXhKdm5JNndO?=
 =?utf-8?B?MzZ3QmNzdlRncVNINUhTczl2M3VielVCbnVpYzU2Z3RBRzU0RnpEM1JFNU5R?=
 =?utf-8?B?ZFk2OHNBMVo1ZkFaY0lXY2tZc0FxcmFvKzEyUEFxRUlrRkVDTC9ZSmdNZkx3?=
 =?utf-8?B?aERJRmRNZHhKTElVcjVzcS9NNHdRVXo1c2Y4SStHQkloOCtxbko4SVh2WmRo?=
 =?utf-8?B?ejgwRGQ4eXdOMnhxWHl6RlZJdnNvU0JvK2duSS9ZdGgvYWtOZm50RzVZZ3BI?=
 =?utf-8?B?VGZCVEtYRWpwcWZuVHpMdERURitBbndVQjdzMVNMcFNYQVNKM0c1TE1ERGlr?=
 =?utf-8?B?WXorV2dPdjFuWFk4eEtkQWV5YlJjclYvYkhCaC8weGxSK2JHL0Z6OTFnekVv?=
 =?utf-8?B?T011QnFOYjdHck5WZHpWbjB0YmIvZVNQbkcyaVk5Yjl1WjZFZUh2RkpUUlNx?=
 =?utf-8?B?MlBMakNrclJ1blA5WDBvRk16a0V0LzE2UTgyWExGbmtodEF6YzFJV0U3OFNz?=
 =?utf-8?B?d2duNVhiMng2UExYcHV2Q0U1bVZEVFNmVXNHMjRCYlZpcXFMdDFvTENHV0Nz?=
 =?utf-8?B?SUpWbnlkYVdGK00zSWF3cW41ai9KU3p3a2xCcWE0K1BNZ2UxUFgwSFgyaklB?=
 =?utf-8?B?UDFhVGQ1aThTRlR3RWNpdXdSWFJlUWszdTZvNHV6K1d0ZWovc096OXk3YjRK?=
 =?utf-8?B?UHdkWHBjZWJlSEFUZ3lZOU9vUmZOdklmZEp2UTlwVGhDeERJMHZERzAxQ1BT?=
 =?utf-8?B?L0JVaUo5NVVyc3gvVC9ua0g5YWpNaDBBOFFTSHNLMmI5YTdWVGZONkluOHUv?=
 =?utf-8?B?TmdqSXRabUNVWUpvQkpQcXdYV3JDZVV1blBjZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:46:57.5081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcb56d4-bac8-4633-34d9-08ddfab86d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9836

Add MMIO accessors to support big-endian memory operations. These helpers
include {read, write}{w, l, q}_be() and {read, write}s{w, l, q}_be(),
which allows to access big-endian memory regions while returning
the results in the CPU’s native endianness.

This provides a consistent interface to interact with hardware using
big-endian register layouts.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes since V7:
This patch introduced in V7.
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


