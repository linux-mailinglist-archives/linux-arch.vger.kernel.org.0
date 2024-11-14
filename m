Return-Path: <linux-arch+bounces-9089-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5229C9288
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0151F22637
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235A16EB4C;
	Thu, 14 Nov 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qbtT2WcC"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AE17588;
	Thu, 14 Nov 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613507; cv=fail; b=DnIhHbJqu9LX499/0oaFt16ss7ZeNoR693li+8gfZee7s4tWNpdLkMMNU6OZmXWhEql9AeFR8hW0fLcKYVNWmTFMQn1vUIcv470oVZPZ6U2zNmiL0HfQr0kqM9G35tYVpFMhkJuBiY0La3WJdY9cmblJtKXXjak/4d+DMN699MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613507; c=relaxed/simple;
	bh=BzZMBl0ZI5d41vTWurFPH8JjHhk9io3o7HBBNfK+DK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HwoXMtM+DDICoB6Tv4XwrE/a1fsGqcAKzDTQPAFtHoMxWcpDjF87+MBnLiMGoBDyaGcY2S8fhp6DL6D9uSnsVX4Wy2pL6YOLYeqQ6i+UZVlW8Jhn0MSwoN27u4rgSZZkQ2swzpRs1FICHWh5hTiBr+1WMV7vbPuoXgvC5Dc9qnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qbtT2WcC; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTF1wxWLQ5UYJ1fimex7j31sMhshkehLKdTPulf53lTR8ozSIJqmyUDBU6B7anxgXKwDrlMz0kPFk4J7/G8ou70S/cR9sD31aAG/+af2Wt1DnuG5F205C8Y0P/tzMxDpUmooDZPyrVz5ZMIZO8nMoG7vgjDbryf0cPjsRHtbs5H0CTskouwMK6OuMECBOLS+w27AABvYPAyTkCbgdR8UrKTIxV5t1ZXdaI9M2QQPXckRA05WTJ5yYE+2JxIHOzqBPFBhVk2ApD6KSVvgiyay2OW5ltJgquSHaiRlCuDmC+IG3bemt6vb1ICJYIcN3zcpdSX1onm0o6jUQIhGY3pKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtSPAe3v4yW1KK4BtXQSQuWC1hzhUMVJk+ESvEAUvPA=;
 b=VpKU6O+81o6OhEMGKWXYHKl9suUkUwAyXyz/8aEd0pHL4af+bFAr4L+yBhWhihQ2whzBvxgyN8LMHD2x8HsOyphK5Ql8dnhXP0TVlJdKd5ppJgASei0vxPyy5xTuAE1HOM1UL+YXR3LuXHa7ARz/EXuF5806lOK/bPowf4ql/1B5iEPwtmmMgHx+2TUel7exymnEse3I1fpQGuD92eUsQTASo5SJdZI6MJFWA1Z793QhhVhB/iEAxW5tgbzub+A/mWFKWUD0Ft+GAK//r2n1xZdTcLkifhTiIgEENlF4IJQTgLMF3EM2diZRDo1mHdRZLB7ldABTDMUN8AdqKOB//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtSPAe3v4yW1KK4BtXQSQuWC1hzhUMVJk+ESvEAUvPA=;
 b=qbtT2WcCVzh0A3hJia6O1I5WFJZux8cfrkFTYCAnhfIF15TfUdKZraYKywEyqK4MXqSuC/Qhyxl4n9K6T2J0wdqwtbfH2y8vN8lJ3jei66q7o7roJ+DCAj7nfk5E1Z97meY+5VTxbJcS2aCYd0Ca4BdGxfRd0QAgBKa2oPaNa0c=
Received: from SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 19:44:58 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ca) by SJ0PR03CA0208.outlook.office365.com
 (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 19:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 19:44:58 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 13:44:53 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v11 0/9] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Thu, 14 Nov 2024 19:44:27 +0000
Message-ID: <20241114194436.389961-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: cea7c3aa-a747-4c40-d635-08dd04e4d26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qX+idfDyLtJsHF8ijYkdaz95VrBC/+rGNj0P7Z3fEUAsEM5URyF6qkPN6qVP?=
 =?us-ascii?Q?zF6RFVy+PCJG7VU+d8fBkG/mCe91scJ1cAq/8TS0hrVylihLw6n7OpXvZuKg?=
 =?us-ascii?Q?FiDNK8ZmBFlLBdb4/dDQKtZlmurua3YZO8/PqRzS6GD9jE+jFXuvCIRndSg1?=
 =?us-ascii?Q?mphw8rV+MNtGWgU2t3lmK3NvrvR7uz5yDimNFXLqgRoYi6YlNoFq/DoIpMm0?=
 =?us-ascii?Q?2n7S+foZwIdwXkwgOq+2AWGdiGvhmHd4XXBLOPh5Ym+s4fRZ5yaycGAcmHh1?=
 =?us-ascii?Q?zvNI3QuipXpjQgbyRYRX1LhSS7YulCNYEodIywwaC+fn+78G5EQxKoRJNzDb?=
 =?us-ascii?Q?g7ql5HFNaT9r5w1pV5fn3hoXgtNG6UCc3f9PN1VkgzSWN3d9a044we/6F9Oj?=
 =?us-ascii?Q?8B7I5+o1lbOCofPUR88PvxWbhQrP1kJRCqENLpD0y04CSvOCsDhoGOg2uwm7?=
 =?us-ascii?Q?SZwpNNPEyGB/7CtYxdqHT1mjecftPdQOjG+3JJrqEt9zM0PszGFSMC3zqJ6e?=
 =?us-ascii?Q?E0NQI57LqPzrpXtMzqtnMwm+Hab8wVkzCoYB+HtLPsG+hDehLyLLqbyHH2zh?=
 =?us-ascii?Q?KPqFOA/iMB6pDOlpU3oEzN/+79SqtR/znGdVuPsiAEonmkPGTH60eT0ZCZxF?=
 =?us-ascii?Q?a0p3dDlaEtoHxnk+erbi8vyZoBbSUEvM+8PS4h06baJF68gCurdsDHVOTpKX?=
 =?us-ascii?Q?8+qSPWq5ybjV+cYi7/6kBpF/s9JZxw6oilSTNWw+xaGdPzElePxVxN6oaGRX?=
 =?us-ascii?Q?T0Y/K6zo+kGKHxC8dncQ30oGpWRSsNDa8Yc0XXBv0Nsbggg0mduyrQAYl1Ts?=
 =?us-ascii?Q?VHC48kn90YKn99VGqoRe170McO1tpzsNifEJfn4rqTq792yi55mQXVMhlxlA?=
 =?us-ascii?Q?4HDwjUBNv94A8hYdP4Lr0PoaJaUQyTH7lDv2ii2ugCx/FDynSE8gAQqTsoCG?=
 =?us-ascii?Q?EqiNPWL+YGJj7IFDIe635mRcNSuRxhAIkRKCPUiqXYYyT9r9bubbg3O6aO2H?=
 =?us-ascii?Q?hsH1/85svZODh3Z4EhHpQ5xgKeVMYQv4YA+1KdZ9SoEyTrLhf8ENbQwd6Sq9?=
 =?us-ascii?Q?XfB9LRasDgrw5iaAxEtaKx8+8t5Ic91LvsvF3UXM39tNbBiFovtIUXWFIoAk?=
 =?us-ascii?Q?pimEfN9UGX7gVwA5vtnjWlkK5QGlFZMddiA/vqZ8rhwsIoIn3RgYufvUXoF5?=
 =?us-ascii?Q?/c9Qrkbv9TR1TnfU2oEvrcDLCVk3RYrEiRcsh6vD1uQn36ayjLOf5fygFgvf?=
 =?us-ascii?Q?FOXNbbqCgWxDK7Jy8KID9zTCpnAv3DFaQlnk0uzyHNtgoJguL4z8LPhz+lAv?=
 =?us-ascii?Q?QY5QtRdT0JwVH4JF9w3ZN7gY3+0nign0kDYkiZyr7k6uLsYSMSYETQMgGlMh?=
 =?us-ascii?Q?cIpHYFH1UnruL6LcVOyrARYe5pACmJ5lgDcr9Jdwq81wXwR3gwj+sLgQec/2?=
 =?us-ascii?Q?lHtM3kGEJMc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:44:58.4384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea7c3aa-a747-4c40-d635-08dd04e4d26d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Also, this has been a long series. I would like to thank several folks who
have helped review and provide suggestions along the way :)

Changes in v11:
* Remove the patch to introduce __READ_ONCE() for 128-bit data type
  since all 128-bit DTE access is currently done under per-DTE spin_lock.
  This is to help avoid complicating __unqual_scalar_typeof() further (Per Arnd).

* Patch 4, 6:
  -  Replace spin_lock/unlock() with spin_lock_irqsave/spin_unlock_irqrestore()
     due to the following dmesg warning:

    =====================================================
    WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
    6.12.0-rc5+ #29 Not tainted
    -----------------------------------------------------
    cc1/145047 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
    ffff93737e255cb8 (&dev_data->dte_lock){+.+.}-{2:2}, at: update_dte256+0x5f/0x1b0
   
    and this task is already holding:
    ffff937371782150 (&domain->lock){-.-.}-{2:2}, at: alloc_pte.constprop.0+0x175/0x5e0
    which would create a new lock dependency:
     (&domain->lock){-.-.}-{2:2} -> (&dev_data->dte_lock){+.+.}-{2:2}
   
    but this new dependency connects a HARDIRQ-irq-safe lock:
     (&domain->lock){-.-.}-{2:2}
   
    ... which became HARDIRQ-irq-safe at:
      __lock_acquire+0x399/0xbb0
      lock_acquire.part.0+0xb0/0x250
      __raw_spin_lock_irqsave+0x49/0x90
      amd_iommu_flush_iotlb_all+0x1b/0x50
      fq_flush_iotlb+0x22/0x40
      queue_iova+0x12d/0x150
      __iommu_dma_unmap+0xc2/0x140
      iommu_dma_unmap_page+0x44/0x90
      dma_unmap_page_attrs+0x202/0x240
      nvme_pci_complete_batch+0xb3/0xd0 [nvme]
      nvme_irq+0x7f/0x90 [nvme]
      __handle_irq_event_percpu+0x81/0x270
      handle_irq_event+0x34/0x70
      handle_edge_irq+0x9f/0x240
      __common_interrupt+0x70/0x140
      common_interrupt+0xb2/0xd0
      asm_common_interrupt+0x22/0x40
      cpuidle_enter_state+0x11d/0x540
      cpuidle_enter+0x29/0x40
      cpuidle_idle_call+0x100/0x170
      do_idle+0x96/0xf0
      cpu_startup_entry+0x25/0x30
      start_secondary+0x11d/0x140
      common_startup_64+0x13e/0x141
   
    to a HARDIRQ-irq-unsafe lock:
     (&dev_data->dte_lock){+.+.}-{2:2}
   
    ... which became HARDIRQ-irq-unsafe at:
    ...
      __lock_acquire+0x399/0xbb0
      lock_acquire.part.0+0xb0/0x250
      _raw_spin_lock+0x34/0x80
      update_dte256+0x5f/0x1b0
      set_dte_entry+0x1d1/0x290
      dev_update_dte+0x53/0x120
      attach_device.isra.0+0x120/0x4f0
      amd_iommu_attach_device+0x83/0xd0
      __iommu_attach_device+0x1d/0xd0
      __iommu_device_set_domain+0x5b/0xb0
      __iommu_group_set_domain_internal+0x68/0x120
      iommu_setup_default_domain+0x204/0x350
      iommu_device_register+0x156/0x250
      iommu_init_pci+0x18f/0x570
      amd_iommu_init_pci+0xcb/0x2b0
      state_next+0x7e5/0x8e0
      amd_iommu_init+0x1f/0x80
      pci_iommu_init+0xe/0x40
      do_one_initcall+0x5f/0x2c0
      do_initcalls+0xb9/0x180
      kernel_init_freeable+0x149/0x230
      kernel_init+0x16/0x1c0
      ret_from_fork+0x2d/0x50
      ret_from_fork_asm+0x1a/0x30

* Patch 4:
  - Introduce helper function iommu_atomic128_set() (Per Uros)
  - In write_dte_update128(), remove unnecessary do-while() loop for
    try-cmpxchg and remove __READ_ONCE() since the function is called
    under DTE spin_lock;

* Patch 6: In get_dte256(), remove __READ_ONCE(), since the 128-bit data read
           is inside DTE spin_lock.

* Patch 8: Remove READ/WRITE_ONCE() from amd_iommu_set_dirty_tracking()
           since called inside DTE spin_lock.

v10: https://lore.kernel.org/lkml/20241113120327.5239-1-suravee.suthikulpanit@amd.com/
v9: https://lore.kernel.org/lkml/20241101162304.4688-1-suravee.suthikulpanit@amd.com/
v8: https://lore.kernel.org/lkml/20241031184243.4184-1-suravee.suthikulpanit@amd.com/
v7: https://lore.kernel.org/lkml/20241031091624.4895-1-suravee.suthikulpanit@amd.com/
v6: https://lore.kernel.org/lkml/20241016051756.4317-1-suravee.suthikulpanit@amd.com/
v5: https://lore.kernel.org/lkml/20241007041353.4756-1-suravee.suthikulpanit@amd.com/
v4: https://lore.kernel.org/lkml/20240916171805.324292-1-suravee.suthikulpanit@amd.com/
v3: https://lore.kernel.org/lkml/20240906121308.5013-1-suravee.suthikulpanit@amd.com/
v2: https://lore.kernel.org/lkml/20240829180726.5022-1-suravee.suthikulpanit@amd.com/
v1: https://lore.kernel.org/lkml/20240819161839.4657-1-suravee.suthikulpanit@amd.com/

Thanks,
Suravee

Suravee Suthikulpanit (9):
  iommu/amd: Misc ACPI IVRS debug info clean up
  iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
  iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE
    flags
  iommu/amd: Introduce helper function to update 256-bit DTE
  iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
  iommu/amd: Introduce helper function get_dte256()
  iommu/amd: Modify clear_dte_entry() to avoid in-place update
  iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
  iommu/amd: Remove amd_iommu_apply_erratum_63()

 drivers/iommu/amd/amd_iommu.h       |   4 +-
 drivers/iommu/amd/amd_iommu_types.h |  41 ++-
 drivers/iommu/amd/init.c            | 229 +++++++++--------
 drivers/iommu/amd/iommu.c           | 378 +++++++++++++++++++++-------
 4 files changed, 440 insertions(+), 212 deletions(-)

-- 
2.34.1


