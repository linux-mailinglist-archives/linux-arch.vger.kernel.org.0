Return-Path: <linux-arch+bounces-9125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2CC9D0910
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07CC9B21190
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D910823C3;
	Mon, 18 Nov 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YIxZt0ch"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632638B;
	Mon, 18 Nov 2024 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909007; cv=fail; b=ZsFSPoiDCrD5XMzdinibISA7cRUNaDY4FedISxGlQ9FA0D4s77SVPGKe5ZQJwu/JBfz2Me7jTk4J2zW1x/0mbblWgofZ2QtHAkvdL7kEoFsTvNCK83hQpOVQ+3Kyg20QsnNUi52L2lrLyPEuey1XoWETrjRsaGFx/wWvL4eKT6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909007; c=relaxed/simple;
	bh=nFDdWouLGlpM4wMMcKg6UHN1i/eStu0dbEiwYsfpj5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7SmQYUxNKeFQR8BD8RvUL1RqsH0G7HMwWQhi/IWb2ZxWu8kzGvEOJvLnUvP18TES2cg+4swY55Mw8Ynnq6ozExzSpKQ3tP2P3tJnu37bCUpR6zUr3va/O7YxmRduu5Ha7YcOpQZ9ez5zPTbaJdrxa5EHxOUWCloTGjTbK/sZdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YIxZt0ch; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsLiNwgHFr72WJbBRUKnFuX93GBPQxunUlbjtovyW4LVG8WzplDdTp+laRSmyoXjGfAFgmoNSPaIyY/JslJxrNbTYEBrJJM0zA6a0OgFGY0aeWB/2axe2PVWjbvuELGL1iHqhgbsGaB/PgElxFIfcl6nmDpFrLYxDOUHEfe8AlRRXUjpgAgxpbls5TiZhjmFH4ql7usAivaXpUPl5YqY+em3ifud6yfSBjhYiCkjrIixAUVMACe31A5s/K5nv3nAXVhRWkvtfclyk0lVZyeN2QReuCxW0cJGfWx3U+zD06YARLQNJEI9KqUtUhTEu4hSubI0VoP3h9OAte5RaaV96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fQ9rZMGKwc9ae2ugd71bJzQxdA4VRKytsg6GNZo+hQ=;
 b=f4BK/hXs+GbM3Q5E1a5LQu8uWwT/OAemHr6YfGaT0v4PXFLQNQ5RGDR6ppnD5CpbHnbmZWgqiXhGX7IZEMnhERVve+hMoJuDLMK5YZO2aHx6PpF0bOZKzwpw8IvSk/u1OUGX8gzrgSiY3YeI+DtJRYeQDS24CaJd5jR01lLHWmLioUZPyaeuPF1Nkdeq/irjPHp2e/WgwdwEmOVdkT7Q2MdmFDhTtXYDjyYXW4vhY3rprpXOgi3Q19mxz+OvLhLiWvz+fVtFmeVPl53nlIfAd7kG5NIx7EGExX+tsdJMzcTV9e3yRo7uBWjyKdtENLMtS8JSKtxjCLiRtBmqrUEbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fQ9rZMGKwc9ae2ugd71bJzQxdA4VRKytsg6GNZo+hQ=;
 b=YIxZt0chjD17ZuCDjnbtYPcS/7QY445hX8HELQcQDmerrqQZ3IDmybRWTNRMFitQTgFyul/ziYhLFBxTzreWks323ZIVlRodViJ2qTjQm3PQXbIJdeAkWSuhMw26f2+hbL/awTzfFM1QuMHtGzn8iok0LxdrT3hCXswE8LVVFDo=
Received: from CY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:930:3::10)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 05:50:03 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::85) by CY5PR20CA0001.outlook.office365.com
 (2603:10b6:930:3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 05:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:50:02 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:49:53 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 0/9] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Mon, 18 Nov 2024 05:49:28 +0000
Message-ID: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: c408cd1b-6b7d-4171-b328-08dd0794d855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ScMI/m1TG+R4+uQCAwVajTnznQde8kF8w6/ZkyLZ8CfxNyj3nXO0gRXAvrEZ?=
 =?us-ascii?Q?kczI9B45j2p6cVl6tbV2ksrO/fl+vkKXlWasbM+P8x+rXHsBQfE2CG6ptYr6?=
 =?us-ascii?Q?p/Wr0KLI3a/S0Verptxu3qnbS5ec0xq11ZCgoM2CJgtuP7Wkf0n7MrJ9bBOB?=
 =?us-ascii?Q?/sbzOeUVgB11lQKuwjuWgjOQpAGu+y75CkM1aUw4+FmfMYHyhKZRzgSaMQa5?=
 =?us-ascii?Q?LCUVmlCN4S1L+7Ib2do0nycblfx0QIQ0RFdA1LzOSAlMoa+GnvihBPkLixe7?=
 =?us-ascii?Q?g12d/N5yS0wZDX8NQG3/EenLy98l8pIpzuswNxSuUv+jIl+aLwFiCkRygRYU?=
 =?us-ascii?Q?EzpuAPXbuFuqII+qSXzT2VGeJl+YYiZKjMGYp8dQ9dNwo7KAEvD/bar8pVqs?=
 =?us-ascii?Q?Hznu3haCgbq6UPV/1TmhyYy2Ip2gokQJYwnyML2yGBFAHhb9u/x3s5PPQHS7?=
 =?us-ascii?Q?26rvEhD7B6ZqFxUrmhjIL1yoIsoHrdD2Jq5an5tXl42i89TLNQR3gabB3khU?=
 =?us-ascii?Q?GFyGj3riUtIvG6glDvGBOuErBDJf6QIuf4dr7jLkDMPMzgAaK3EvEqDRFOvK?=
 =?us-ascii?Q?+nHdI+P0U9G2uB2YRd2R32xfgicfbWhZbi511sdcSvlPEd84nGM8sHqsIzh1?=
 =?us-ascii?Q?kqF/PE6zYQGyMWqNTR6IKbekOzJolZcFGh5qXJdcW8Vz6qSQKWzINrOhyOKR?=
 =?us-ascii?Q?w2uwaDwY2M0tzGdBiLBPZjQ0GNTRlhJwxxxsFS1qVsueHthjkD01xUruqSzr?=
 =?us-ascii?Q?jWtKwiJ0RFnWxGztdVZKo/a5cWG++ZzDWqvF/pTlFZkwEFglCwkBo/eeP0/5?=
 =?us-ascii?Q?ao++d2bibMYWCg6a1WPSlXU8E7RM7kzpfBp//fXfhxBN14Obm1cbfSHY57CY?=
 =?us-ascii?Q?x3HPdKQ9+/um660rN3omQHVMrhxKxCjERXyM2THtgtYzsh5Nw7tnjTGQLcdb?=
 =?us-ascii?Q?1c1NIlUL1H20zHUndrimmDVLNGlXQwTnSGYdRi0vinrjNloVsy4Vd8bkrUv2?=
 =?us-ascii?Q?f1NB3xSnzPRCQyPznyvSBIia452V2f7W0RZB65+5aZXXx5JHRUygrlezAh9E?=
 =?us-ascii?Q?lw7hDcfo+wzS+mi3X+Yksg7sCrn5PTi0S70JiEn2zfyZnr3USlG7QGqcMgPZ?=
 =?us-ascii?Q?ChsQoLVqYP6gqM55W+SeTc/crcOsckCg0+LAkNPi1Z5PGtKzjNsv3411UWWf?=
 =?us-ascii?Q?mNTSuSqSCs0giQVLJXhc7OyMR5yMJRP0PZm1m7+cYrkzX0T0pPsv5DBxiIhh?=
 =?us-ascii?Q?OGT8OlBFXfZQgKmaTc++nbrsz5W1xd8MdLdZ9kdS1ep1MtrxmO1xDIMIt6+L?=
 =?us-ascii?Q?X1/Tc7M73XwBxyaXoeEGDyZvYjFpnyaO66bhZ4Tzk23Ep9himJPhIIS0rRv9?=
 =?us-ascii?Q?NywTH2UlkXpKrmNL0rKT0GLNr8Uf4tdEqrxDZzwesM6Ta1zam+dH8UgCr1Gu?=
 =?us-ascii?Q?e/IilS4aGJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:50:02.0809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c408cd1b-6b7d-4171-b328-08dd0794d855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194

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

Changes in v12:
* Patch 4: Use arch_cmpxchg128_local() instead in amd_iommu_atomic128_set()
  and add Reviewed-by tag from Uros.
* Patch 5: Add Reviewed-by tag from Jason.

v11: https://lore.kernel.org/lkml/20241114194436.389961-1-suravee.suthikulpanit@amd.com/
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


