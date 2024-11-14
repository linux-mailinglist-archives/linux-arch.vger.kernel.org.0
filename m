Return-Path: <linux-arch+bounces-9094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A19C9292
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF3CB25E29
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8D1AA785;
	Thu, 14 Nov 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iLJtgWTh"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5761A7273;
	Thu, 14 Nov 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613532; cv=fail; b=a0CpRAwOunWPWJv0U0qPrc7ZyrIOXLg4mHxT1K58yv8w9N5grOAAIMi32NGL82ZiVsys5IUBencArbieV5k1PJzZYqQxZj1bfKrc0rm8F1cVpBdQW035KpLjY1G4hXMAQCz9vx1V/3DBAoUdyKGRycMzx5xTmwD+Nf7lUZDpYO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613532; c=relaxed/simple;
	bh=PVeFMuYQvPc4Z9EFgnRoM8UBCA5/QxHSforThYuCECE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBVreplwOECQsVtwqvZod95k0DPBFV4OiXeuRLXhOh8NqxVYlI/ImtpVIGlG8Ybf32wmjsOj9F7yEAWNM76hvoPBbXma5h4usgO99JkkXP4fJqkSiwL3YIzHyBOMWDn1kGbGAgqSuaBH51vjYJkTVEzDZrA6kMGHQ+/+cjrrEAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iLJtgWTh; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzO9fcF1jzt8oyWC3VjW23duUN69CRkx/ePP+eAzrSSpsc0PI8S2osc1PPedDTKgNROuEmTZK6gCBVcTpBn5S6tjgcZRV91BM/XW5QkWQ2zvtMt/R47G1JKQ9dcaCubfEzT1IWQTbYV5SKvtm7ALYRP2ZPtphpv1Tuz017XvIDNd1MNA9KDT4pHtkTfa2CuyBRPcE7+QK75IJaGz746oJ5czTEbSV3LaNwo1ZBEnz8q+TfNsAwc+RG+Um/rJOf6yVq3e0qOBYz000pCRzipbIbXuX0FwM4+zmPeiH5g33KDRgh/kVBRsx/3kAbBBCiMsJxJc0fcATgqrwCJt3prmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOrXtdCdL+e7Hal6X6Ahv0U5lOZOePElZBx6wpLou4A=;
 b=cBHEl86alFg1cyo1wLJu6QfF/92tgGjx4Lj7ohuLWJMNl3twrV3BFUdTbn/pFRRe5cZvIgj23qgY1JGSTQdS9p7kNcqmCLFKfFl1q0MzUscO9xMe1pJ2Typ1rrJJRCmag6YeCI2Z7X8+7iAQfXM2Iaij+SJqSm+wdITcOomPB117lH5U7pomTBqeiB5uWTjWafWd+Bv7w+5SbTF4QxV96562tmwj1E4HoGnlu7g/bAPu3+leXfO9DEc6vgdBKV7pelxZWybK4/44SJUi3aoEXupSqwBYqQMPhU3+V8hb27S6McPjdwu0/RtRDgD/TIlc8akaj+MUU++RL3gMcGjvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOrXtdCdL+e7Hal6X6Ahv0U5lOZOePElZBx6wpLou4A=;
 b=iLJtgWThlJG5G8wGhFq42aRZMgxm54Iiu2MC1YxGTRr5Ws6sSbO3u8hKDcoYXq/PjbmyQD1He6Hh59I2wyAqlmxr4lcO6MJwlwhB0OXSPfVEhnJ67GawTiZMXtuuucuIfpnMlJOWIaDTbo5znn65iw/GhlhMAzglVPFY/wk6JH0=
Received: from BYAPR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:e0::46)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 19:45:20 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::6b) by BYAPR05CA0105.outlook.office365.com
 (2603:10b6:a03:e0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Thu, 14 Nov 2024 19:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:45:20 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:45:15 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 5/9] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Thu, 14 Nov 2024 19:44:32 +0000
Message-ID: <20241114194436.389961-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114194436.389961-1-suravee.suthikulpanit@amd.com>
References: <20241114194436.389961-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: df07596d-ff36-46e4-509d-08dd04e4df73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZXO0j/X/KApp/kDci/dhqtmt1moJu8FI+jATebkcD9QKLWJsrnbua4NIn5p?=
 =?us-ascii?Q?OV6YoIFfInVNEOc1hEaVrIsdvAVMMfaTvifKXIvPJaO67Qlmx8nCwi8An2HL?=
 =?us-ascii?Q?HUO/a1OJTebEM20LC+dTeXtuzerTfbuwKU6XhXiEE+PBOGbuaVu+lDqUU8rs?=
 =?us-ascii?Q?z2GuAudRIiv1UEL9LG2y5giyP+x9IhJRPVxe6/M3Ap51+EtXnmEshBXzrGts?=
 =?us-ascii?Q?sOmGrAWxqQgDLJ5M0U+q1rwkKLuipmJ8qdpwdXmo+SV7AOWla5dZTn9HUwUi?=
 =?us-ascii?Q?jcXC2NA9Aorso0Qz0UWGOI7/raghBHVRYUKTBcu/7yfWjgqXkc1I2Vs5A1pE?=
 =?us-ascii?Q?gA2SawDjvGin4s3yFAQJbqtMC80CSeY1oyi3kjYKHAQdqrJSSAK+dsk0tFTG?=
 =?us-ascii?Q?HLiyz2AGQfGauzLbOjcxlRS8+no1YiwZaqqduDY+WE73QQA46WoyVkmG9IiZ?=
 =?us-ascii?Q?aOL59hwLjTSRCUb6TAwHH4TLE9bCrQABhhpujaB9fgxhZuuNLTuOu5lS0YOH?=
 =?us-ascii?Q?nkRfOzVX8mbZgkbSkfPFoNx4urB9dhRWUPUfhUlHfzFBHxx46EDVSTxEZgrP?=
 =?us-ascii?Q?juZXiub/dKjSY7C9ODhibyn5xxAPGvQGL7oBRsQiWG515OrtXL0BZOnVUqqB?=
 =?us-ascii?Q?IWIvWsBwdYpDeUQYL/cSfj1k5/watQ99dpsrgaRyq5UHCPYUlyT5HQmIVset?=
 =?us-ascii?Q?n3kU6hDrG1qJkF/rt39wZUy2qQ25wu6MuxP1ZVOQfwM2RbmUVikzN705JPi8?=
 =?us-ascii?Q?UiSDRUne5Moe69tTFNjxJ//lzXDoakae7lmxxVengzFW5PzOjypJw468Hvy5?=
 =?us-ascii?Q?Y3hTFNvg0i2YKybZfRxMlWGpYlSrwS5tuoijnKlYtOGpd5Xp639bDlhXf0wM?=
 =?us-ascii?Q?kOSlJtqUaCUPzF48URAunTbY6SlY7FlNOfNILwlmlOueBVOu7zO1TO8/dvaa?=
 =?us-ascii?Q?ZVampd31zDFVdMAVqLllMfkMtN5HthYwHJzFyA4eLhfvqyB8xT/De7AdAfjX?=
 =?us-ascii?Q?sif/sUtaVYAcV32XXZVYBnM9kWhqmxz9lhsTloHDKhZcq6Jmv8b/XigjlRoD?=
 =?us-ascii?Q?OxQvC2mpWEXFu+NXlQKwjnNZohkgqa19uiqXkTscJBPR1wV6FDE3OzQRNxO8?=
 =?us-ascii?Q?kAt8J4rx/aIrEVP9mjiEoUaB8sdR3K/xjOlkDzn2Nso/4w9AJ1cFqCfj29+d?=
 =?us-ascii?Q?wjdQ+13MrZSRXCSI7KrXlDjtzI9+jnbVl0WwEDD9q2zU4KwS/sMSUmmXC+ia?=
 =?us-ascii?Q?9P6gzVtp7I579quN8LFChK2nIoRxDzFjWYkZ8R3G+NpmkKHIfdIS39HUo6Il?=
 =?us-ascii?Q?9IsP6WXFEj6zdTBiI3G9ifvEmYuGa5pNKaGH7q06LDjkyAjRpNCUtr2FoleF?=
 =?us-ascii?Q?Pzt2WNNnXQxgyFaZUG0wH0QRvT7SzGt0KhI/sSfwD4pP3hgHwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:45:20.2221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df07596d-ff36-46e4-509d-08dd04e4df73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
GLX, and GuestPagingMode into another function set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  13 +--
 drivers/iommu/amd/init.c            |  30 ++++++-
 drivers/iommu/amd/iommu.c           | 129 ++++++++++++++++------------
 4 files changed, 106 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 38509e1019e9..f9260bb8fc85 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -183,3 +183,5 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 #endif
+
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ea7922b06325..0bbda60d3cdc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -409,8 +409,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
-#define DTE_GLX_SHIFT	(56)
-#define DTE_GLX_MASK	(3)
+#define DTE_GLX		GENMASK_ULL(57, 56)
 #define DTE_FLAG_IR	BIT_ULL(61)
 #define DTE_FLAG_IW	BIT_ULL(62)
 
@@ -418,13 +417,9 @@
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DEV_DOMID_MASK	0xffffULL
 
-#define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
-#define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
-
-#define DTE_GCR3_SHIFT_A	58
-#define DTE_GCR3_SHIFT_B	16
-#define DTE_GCR3_SHIFT_C	43
+#define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
+#define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
+#define DTE_GCR3_51_31	GENMASK_ULL(63, 43)
 
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 015c9b045685..1e4b8040c374 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1089,11 +1089,9 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 			}
 			/* If gcr3 table existed, mask it out */
 			if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
-				tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-				tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+				tmp = (DTE_GCR3_30_15 | DTE_GCR3_51_31);
 				pci_seg->old_dev_tbl_cpy[devid].data[1] &= ~tmp;
-				tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
-				tmp |= DTE_FLAG_GV;
+				tmp = (DTE_GCR3_14_12 | DTE_FLAG_GV);
 				pci_seg->old_dev_tbl_cpy[devid].data[0] &= ~tmp;
 			}
 		}
@@ -1144,6 +1142,30 @@ static bool copy_device_table(void)
 	return true;
 }
 
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid)
+{
+	struct ivhd_dte_flags *e;
+	unsigned int best_len = UINT_MAX;
+	struct dev_table_entry *dte = NULL;
+
+	for_each_ivhd_dte_flags(e) {
+		/*
+		 * Need to go through the whole list to find the smallest range,
+		 * which contains the devid.
+		 */
+		if ((e->segid == segid) &&
+		    (e->devid_first <= devid) && (devid <= e->devid_last)) {
+			unsigned int len = e->devid_last - e->devid_first;
+
+			if (len < best_len) {
+				dte = &(e->dte);
+				best_len = len;
+			}
+		}
+	}
+	return dte;
+}
+
 static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
 {
 	struct ivhd_dte_flags *e;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7e0b62f2268a..cc778056bcd5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1944,90 +1944,109 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
+			   struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
+
+/*
+ * Note:
+ * The old value for GCR3 table and GPT have been cleared from caller.
+ */
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *target)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 gcr3;
+
+	if (!gcr3_info->gcr3_tbl)
+		return;
+
+	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
+		 __func__, dev_data->devid, gcr3_info->glx,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	target->data[0] |= DTE_FLAG_GV |
+			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
+			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
+	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+		target->data[0] |= DTE_FLAG_GIOV;
+
+	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
+			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
+
+	/* Guest page table can only support 4 and 5 levels  */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
+	else
+		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-	u64 pte_root = 0;
-	u64 flags = 0;
-	u32 old_domid;
-	u16 devid = dev_data->devid;
 	u16 domid;
+	u32 old_domid;
+	struct dev_table_entry *initial_dte;
+	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
 
+	make_clear_dte(dev_data, dte, &new);
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		new.data[0] = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
-	 * When SNP is enabled, Only set TV bit when IOMMU
-	 * page translation is in use.
+	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
+	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
+	 * do_iommu_domain_alloc().
 	 */
-	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
-
-	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+	WARN_ON(amd_iommu_snp_en && (domid == 0));
+	new.data[0] |= DTE_FLAG_TV;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
-
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+		new.data[0] |= DTE_FLAG_HAD;
 
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
-
-		tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-		flags    &= ~tmp;
-
-		/* Encode GCR3 table into DTE */
-		tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-		pte_root |= tmp;
-
-		tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-		flags    |= tmp;
-
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
 
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
+	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	if (initial_dte) {
+		new.data128[0] |= initial_dte->data128[0];
+		new.data128[1] |= initial_dte->data128[1];
 	}
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	update_dte256(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1


