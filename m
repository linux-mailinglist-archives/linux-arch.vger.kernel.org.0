Return-Path: <linux-arch+bounces-9132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79339D091E
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8795F281549
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33721145A18;
	Mon, 18 Nov 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4iPmXLf"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9438B;
	Mon, 18 Nov 2024 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909162; cv=fail; b=YQ22VmcLDzpMxMDWJ32VvW3csUBre6aDTzCi/9prpu3HA1DbctVHsiz1VMU2NB34yjBZMvAlxgyaO/nfmlZi2bXRQVhDiOZWUPzQVMiBvdZHHwYpMfbQo9Q8mPgW6hYzLlbEio6rlOZK5Qtli5t7oQUNMm3+H0Kx8NlrpUVSy6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909162; c=relaxed/simple;
	bh=pD3CmY8Vf1E5rTziOoui/AnVhcJWQmAJJ32cDLUAJww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZATLUtrYKl6t9O2muEV1c62UJ1XRDcQ5AmkNJ0Z5ZwrATZIx3HN9SmFLsIn0FnC2PZxOu3EYr3nI2cVqyZUUIwGmc1r9nYIcESLVlHmJ05O8r0avRBgaTv7uSX7gmKYy6bKRjGMmlcp3sog0NrPYxJ8yjdki9/QE6A+Huo8PKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4iPmXLf; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1YZl7mlhB+HweD5bm7QOkquonJs2sIAA6X3rcUsKvlmSYe5ZJypncoOz/dHaiXs9jx3RKBlHmgm/Ki8V4XOImLw8LM0A+EASXiMfzRvC1+hI8LAKEVCHykmv9xTkY7lUGw0ciyBGL8gcTGJs5t0FzfjvnCo5i9upYJkKUyEFVOpFouuu986SgH6zgnLoWJRyBMk6NYifA6CK+rOmm06meNvy3MI3b6DoPHWkwWuT0dAW5dtEZb+3wU1PJbD4X0+wLr9QhziYfe8HhCyCiATGeHDrAIMY8OzWlLA/nzzh13rbqSkzJmqwatYr/GwkOSEuHkMOKo0qKxX0h0xUmMmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=DSKIm5hxBW1E3BAvP+4eR1TT9g70X41+3H1W16nMOWB4WEsYZwlsunF1ln8v+zv1PbFNRFN0/1xnwLqRdh4o552w0XMX8SRkv1KN5SXTL4CTZ55rEsq7UFgnRDffvO6Md2e1nWImlzIEvllKkqPorXhtRNljzilbRkiZSvtYr+27LbKTgZzbLUx4wlhMsq1QI0xwOxtkJ5N2OnxZuDvsoOPQLdr1Yj8j0Aro52Ns4gfvYn7vQu1bYn/S8NXZT2BHwD0BZG3BSMS2tyf7jFyivM3WncNgKrddwYD14S8E5/xTMt01pjqvqe8OQW1mUuAQQqgfkN86KiN4Z4uw7pak5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=q4iPmXLfCB7kzvurQliKG88zQ6iE8UgiMRbXxgfk7vRfrSP4fsjUU8I5DtOetK8NzN4w9HQaJDa6p+O4/JoQgq2aYCmhmliT+2Kubj18YzmTv7NfRI48dQ6ZTISu3rd5pc777DOHpvdlftnR8lySJSIKXmNpNZcTlwsE8EG5byk=
Received: from MN2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:208:1b4::24)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 05:52:35 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::d1) by MN2PR15CA0011.outlook.office365.com
 (2603:10b6:208:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend Transport; Mon,
 18 Nov 2024 05:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Mon, 18 Nov 2024 05:52:35 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:36 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 9/9] iommu/amd: Remove amd_iommu_apply_erratum_63()
Date: Mon, 18 Nov 2024 05:49:37 +0000
Message-ID: <20241118054937.5203-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
References: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d15fd07-70a2-4269-d0a5-08dd07953391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TBXpiR2QLujuNTJS/QkAAYZwLnXkfzM3VnR4fkbWs9DncjozFRz4FwbnfQOB?=
 =?us-ascii?Q?t49bDv//mp/UdZA01pP1dvRR9S/OtyUCHC+EBPibs0QPpemlj1sDxaNUdyGn?=
 =?us-ascii?Q?yQRpH71yYbMLYJtwEJcaCRd+bBGtERL2H0ONfQ9ZWdY/NUx1HwHrpzsIcBqI?=
 =?us-ascii?Q?/I1klyocsWpiy7sPtGstYJnMEreIxKKWaBI2oszlek5b3mEmJ7/CgFLlgmcy?=
 =?us-ascii?Q?CuBoi4DwCkqTQd49C6Qkcd6B6vYmKZMr5HLJYi8LcqCB+orvzNvxVVU18gNb?=
 =?us-ascii?Q?Us6BwvhdwqjdvnAZX/bTOfOoX4LWyt0jI4zezilDHcEsnAiNFekRqS8B069b?=
 =?us-ascii?Q?z7gZVhKFheG71R0ij3nOSpHMv4GuW/S40vseBklsmfi/aOHaYo5/JOhuu4st?=
 =?us-ascii?Q?n3FrR6WwvxiXN9sLLq6/mNTtkpJsEQrhbNh/oK9W/eOXstItk1GNo4/EjiwA?=
 =?us-ascii?Q?eb015RX/hZp6dgwckfOCnIMiD9M3KCbXD0lW4AHwt0MbmI8ckFfT/gb7jRUZ?=
 =?us-ascii?Q?FHvtv0jwMaYDXNAR9co4foUfup90cR+SfPPPs+dN9c7Ymq2r/FvMSktO45wI?=
 =?us-ascii?Q?io7Wzfzu72kBFCuXchg/2hRYcrpROQ1+gcNP/phS5PtjytPiUw4pct0JyL6B?=
 =?us-ascii?Q?uLYa+2UHa/9rEuv5kevV0ytQ55HdQ6gV1OL1uzIUH6Eb/+dGQxRyqzUOoa4z?=
 =?us-ascii?Q?rzLAfGlMVG5Snq/lkFaZm1hrpR/qlshgR6N2kRyrROMwpOaAd+eeOmQuJq73?=
 =?us-ascii?Q?ULT2TzU9fs7fbMdBsQMGE9onsuWaoHhC75gV5DdxrFT4EQHbttENK0n6bQt0?=
 =?us-ascii?Q?2fNe3e1Ia7StU9AB90RrlChOyt3QZq6qpfqJO3cxZCat5+/tZGR98hfmL14n?=
 =?us-ascii?Q?aZydyo/YhLVmou1vZXTQBskgQkCfTsLRAXL8h6s8G3Jkbm0rwF/YlZ01Uihf?=
 =?us-ascii?Q?YlZnl05pw8b59L0AQd6t/R4oQdORemBq4rklvVXSsBuF/l7KAhKkuMu902X8?=
 =?us-ascii?Q?7Yf15eAZBtA5QvPKb6nnMkopRatU8wnd8HKYM2A4+x6IBpQyP4CJpZwNDC8y?=
 =?us-ascii?Q?AQS1RrBTKt1XVL9Mu6IVRcYTWHobuUxQb34KJiZrTsbQNtzBlWIojY6tEcFq?=
 =?us-ascii?Q?ktPuAtKzFGy3ky68ZpIC+B/puQrGBJ5pppKBJdQBC50tUpzXK9DS6kq1DfG1?=
 =?us-ascii?Q?9C6E9xUU4J62r7iA8hri5QGMWzZ6SWVkaROOy8w6NC0AOvX203e6v52Lo/Lg?=
 =?us-ascii?Q?b/OyRVGNzx+Nlx/qzg0y0q3qVHO8hNx4N21ma7TNwY58B21LM8A3+60CnUog?=
 =?us-ascii?Q?azRvF1c7FvzdEVGn3xVmiPpPJ0mxV1OG27J+IWOc4H5vTcsVhY5GNapEMkfq?=
 =?us-ascii?Q?V4xVMQQglQ1c277gC05ZJTb5DpOBhvWaHE2sHE2v2mTt7+gWcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:52:35.2520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d15fd07-70a2-4269-d0a5-08dd07953391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

Also replace __set_dev_entry_bit() with set_dte_bit() and remove unused
helper functions.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      | 50 +++--------------------------------
 2 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7b43894f6b90..621ffb5d8669 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,7 +16,6 @@ irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1e4b8040c374..41294807452d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -992,38 +992,6 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 	dte->data[i] |= (1UL << _bit);
 }
 
-static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
-				u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	dev_table[devid].data[i] |= (1UL << _bit);
-}
-
-static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __set_dev_entry_bit(dev_table, devid, bit);
-}
-
-static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
-			       u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
-}
-
-static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __get_dev_entry_bit(dev_table, devid, bit);
-}
-
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
 	u64 int_ctl, int_tab_len, entry = 0;
@@ -1179,17 +1147,6 @@ static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
 	return false;
 }
 
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
-{
-	int sysmgt;
-
-	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
-
-	if (sysmgt == 0x01)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
-}
-
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -2637,9 +2594,9 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
+		set_dte_bit(&dev_table[devid], DEV_ENTRY_VALID);
 		if (!amd_iommu_snp_en)
-			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+			set_dte_bit(&dev_table[devid], DEV_ENTRY_TRANSLATION);
 	}
 }
 
@@ -2667,8 +2624,7 @@ static void init_device_table(void)
 
 	for_each_pci_segment(pci_seg) {
 		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
-			__set_dev_entry_bit(pci_seg->dev_table,
-					    devid, DEV_ENTRY_IRQ_TBL_EN);
+			set_dte_bit(&pci_seg->dev_table[devid], DEV_ENTRY_IRQ_TBL_EN);
 	}
 }
 
-- 
2.34.1


