Return-Path: <linux-arch+bounces-9127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD369D0913
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF83A1F213FA
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38E145A16;
	Mon, 18 Nov 2024 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R1y2fOz8"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7714126BF5;
	Mon, 18 Nov 2024 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909017; cv=fail; b=ltcJ1mokJJFU6LlDAp2BIe//yeFQfxywqM5niuRPNwghheeHGPohqt/XnkufaH8t/8NEb0O/L1F+i2fCDG67mUe37wRdXaauJXPiDh5G7vB2+X9WVixSF80ADpq2+ooLz6T83O5RANakE9z4wkCJ6zcMEY8pbMIe7Rf6D6KH82g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909017; c=relaxed/simple;
	bh=BsNnwUV2R/BfqocP4sWIcX7O5HMemYytLwFFbPlqykI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZjWZ7+UdAIT71Oa39MrPhKVg1mbs+js/lNrfyhYKcRiJNPTwO5+iHt9Gcn2IuIOrEfouh+0KtRBvSd2rLh24jOhtGESffWuymkZC7JyMiQ368Wr5kVHfdD6IUISjf6nNPMxO1stFkO8yAUmuhVKmpXIS1Dl1szWKYvuAYHhoBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R1y2fOz8; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDYCNzTFZRrKgYViS1NoWMwv1MDMz1pyYMSADr3T6LgbvJE7rIwuz3L6ErhfaNBpYZy9Z/68qGbupLnh3MS7P2vOLxHmm2Vyb2cc+p+wDB20c48rnhd3YLUElskPm9UcA5KbKVpUsNa3NNTp8Gl0JKjFq+/RPoRrOd8JR8lYzl8iP+PAd29ri9Hw1OWvgSZxFmU7wWjGDwivZvoTNlMIl8iWVVgQkxdot533xiJVb78YBZ9sINrW1zg9U3P/AEJ+n+s8FGDUoGpDDl5Zqvj0SfyUmBbiWNHHG9i1UJ2RYbC5cI9XMavfAe4tajpTiJkV6hjtXmdu+URD0eN9vvz8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=qEZm4+KUGhe3v+3r16xC+xMGAF1R8bRIkPKnpSuphBgl0mMd/mKRYbXNfnnEcfcHsym+oOjVB71RtImDepyoQzFx3xdUtcHlRogrL3z85/4I/f05CqSwSx0OvNmNDraP2gKAL5ChijP7P1Jzc43p8lOlaQYxPygP5w5qXYFs+rkmN/mOqeT7QkNKS/2cm7H9/66yy0hQn054MK8C4lQprxFk520zL94R0JQKsoS1aQBrKIcUwUY5XEHbVRNnTdgLJ1CAe79lPL6CY1wY2FUO1As37GZoQ11W5FM/ctDmQ7XJOQBOXgnF0NUkA8+VpyeXlBR/eWdWzbJEcxOHckeb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryS1c9CjW32vCe1i9lmLhp+TuU+jW5Gxo4i6WTEQ7Bk=;
 b=R1y2fOz8G92chY5jeadx0u/klWLFHtsiXjUH/y0jJDXH+5j9cN6Sa3HWEGyEiXx1mkqKiAbDA3Er/KamBpIjpn54yjoKHQa3zaf1szKgRbJCEaFZ0ArHBU/3i6v5UgDWj60OUwgTgNk0xXvMDm5OHgLlmXXugVpO7sJpwbEwpnc=
Received: from SJ0PR05CA0134.namprd05.prod.outlook.com (2603:10b6:a03:33d::19)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 05:50:12 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::1d) by SJ0PR05CA0134.outlook.office365.com
 (2603:10b6:a03:33d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 05:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:50:11 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:05 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 2/9] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
Date: Mon, 18 Nov 2024 05:49:30 +0000
Message-ID: <20241118054937.5203-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bb719e-0ad3-443c-d4e7-08dd0794de3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vhvn5rjYR0lLMUKj3p2LqFVDP0A8B9bbtWXq8LToyNFJcUpZG3E1V78+tMoo?=
 =?us-ascii?Q?vzYAbdcENDyULFDo58nel+q5K/vrP3foDGPDTmZyOEeS8nVoASpPqyJGRzvc?=
 =?us-ascii?Q?PcxI1MZKKptfsB1ylY9alT+zjpSGCb75b9rdkUbeMy+/qyku5HBimKbKWzr/?=
 =?us-ascii?Q?smKhd/HPsgcqUTSpAI1KokSRhB3mEprLY0dN1UQRoiXqsyWMuW6sTFpzOslH?=
 =?us-ascii?Q?llHNsLRnS4ty/T/9Yv+wKrCOj6iXCE/XiGvC9Pena/3DFAXXI4qp+3Gn7Pgs?=
 =?us-ascii?Q?T/TljBZAN8hPE7Pxt1wOSJnsDDj7eMf72FxWokUtgb/15DH9yZlOuPtKg7nD?=
 =?us-ascii?Q?xy3UKmfE5qCdTMEc2nEJM6alx1tBozpmMdtx3fDpliDLZZLfwN4d/zO1p/HH?=
 =?us-ascii?Q?wAMCKeGiHvgHyjFLPeqPjJIy4oNE7ir5m/x2gJCeB3IMtjFkQXvqzFwAZo2G?=
 =?us-ascii?Q?uAevam2/FN7r8HAtmIFbtNpkq+SNGOaF+Qky5CQDT3okn3w9CsMX2IHPvVab?=
 =?us-ascii?Q?hweR4ney8Nzko2oe+uJ118aMioKXrNH5uxv7QoFWCa+zj+JCgG4uD/y5tssy?=
 =?us-ascii?Q?eOReArr/E17HtJI7p0XJ1j40kvfchzQCKxXNxa0AytLV/1smlV863G86G3eW?=
 =?us-ascii?Q?YmnrJL8+joULMz4cr7jey0VMDoghTVwMb+yGYx3NMrW6DNVwZTnbJH/BZEee?=
 =?us-ascii?Q?6v+6MOuN6dB8elo4mWVx2F+dyaH1AIiD7PVIiypNH7O8SORqaOJYUTyw0urv?=
 =?us-ascii?Q?ROsDwF6g/cH6iglgjfTigujQngw36u53lK0/0BHTmcwKmkGl2R3cXIqpS29s?=
 =?us-ascii?Q?S5lH1+7B8cJlhEk9HtO6BBJ9k1DuddRs4hd/Kkb0n94eEdUv9/LzfSNFW+Gz?=
 =?us-ascii?Q?5DbeB1IQPkF/fjBMQkJ/r/NRJldP+G7DXKD043OObQs+Nj53sjcaD2EsS7o1?=
 =?us-ascii?Q?Zj/Ab3O6EBNX14XkzU9kJ6+QLi4/eriU5InldM4Bu48Dx+E/aAvXidvimTDX?=
 =?us-ascii?Q?tPmjomP1NzBaY1shWUtNhOnUgJttAQ6+4/hLUUao6TjPNWOFEV8Dc1hToxFz?=
 =?us-ascii?Q?iWsW1aY/UEw0aFE4ScFye0vZZCSS1SpoVhvXa9GRqgEiKAktWR41uGXocOBh?=
 =?us-ascii?Q?VoeM5Vbz5ZWd8tOKP11Mww7psa1PVXhT7IheEP82TalcFz5t5qpR1HQ+v8nv?=
 =?us-ascii?Q?RGax7o72TmE2HLcx2ZNcK8IKmjrhqG2kgPyDdBWW2dFKlR19HTS86vlzD/p1?=
 =?us-ascii?Q?wfZvc86Q0rSTVx9EXaD2swmiguBvkzndOlYt9S+lr+qzajrwGECxIdVtcF3r?=
 =?us-ascii?Q?IzchckWegAn5diR9OGMp3wPwWhMA704+XUd/jDXF2tT0iKXWN1KTvWGj/qVs?=
 =?us-ascii?Q?E9AfeAdSLcQSKpAviEuFxkeDVOuxaYTm5owP6rtpa5D00Il1sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:50:11.9908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb719e-0ad3-443c-d4e7-08dd0794de3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376

According to the AMD IOMMU spec, IOMMU hardware reads the entire DTE
in a single 256-bit transaction. It is recommended to update DTE using
128-bit operation followed by an INVALIDATE_DEVTAB_ENTYRY command when
the IV=1b or V=1b before the change.

According to the AMD BIOS and Kernel Developer's Guide (BDKG) dated back
to family 10h Processor [1], which is the first introduction of AMD IOMMU,
AMD processor always has CPUID Fn0000_0001_ECX[CMPXCHG16B]=1.
Therefore, it is safe to assume cmpxchg128 is available with all AMD
processor w/ IOMMU.

In addition, the CMPXCHG16B feature has already been checked separately
before enabling the GA, XT, and GAM modes. Consolidate the detection logic,
and fail the IOMMU initialization if the feature is not supported.

[1] https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/programmer-references/31116.pdf

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3a7b2b0472fa..c1607b29ebf4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1752,13 +1752,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling it.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
+		/* GAM requires GA mode. */
+		if ((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0)
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 		break;
 	case 0x11:
@@ -1768,13 +1763,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 
-		/*
-		 * Note: GA (128-bit IRTE) mode requires cmpxchg16b supports.
-		 * XT, GAM also requires GA mode. Therefore, we need to
-		 * check cmpxchg16b support before enabling them.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_CX16) ||
-		    ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0)) {
+		/* XT and GAM require GA mode. */
+		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 			break;
 		}
@@ -3028,6 +3018,11 @@ static int __init early_amd_iommu_init(void)
 		return -EINVAL;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_CX16)) {
+		pr_err("Failed to initialize. The CMPXCHG16B feature is required.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Validate checksum here so we don't need to do it when
 	 * we actually parse the table
-- 
2.34.1


