Return-Path: <linux-arch+bounces-9050-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891D9C6E9D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7091F2322B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9BA20262C;
	Wed, 13 Nov 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Po2msYv1"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D820013C;
	Wed, 13 Nov 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499433; cv=fail; b=rLFRqpE2a3wbaGrbHA+xQ9uIGQPNDx+fyxkKnqGid6lO8+Rvd0o8neABe3MU263qFD+ayKLjrJ5QLNK6kv67nu6MP+OO7d45xKkgOhbDHe2tGEOfqzok7iNndQ5hfr4bwHYdR0wRjpDoAbuKbUARrNHeNfKOM8hUCpaiLagG0TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499433; c=relaxed/simple;
	bh=KZ1vjjhuuZlMT4PhoF5G+JMw1a4VDk+xmdCDz0FNeM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qgKMTgNX6L77nSMnAFvqmQKxf1ufLYexNLyJr/1zaI9guONlIOiWMh1ulDLZQNAErzLdNl/nqJkCRMa9szJIhIyxDDeYZUAMn/eDHYr+S6Sryxnmuo15IKTyykDb1IsUnimqFynrDQBGk3tu8udNat7vvWwBXSJTeSACpEVRHgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Po2msYv1; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=la6FBV9rrfk/sIvcggfVykfH6P/QuKc1Ueu84JI6IljfVdyW1khHt+bOpeDPQ0oW7f5lEP0iiiEe7Ab1IsTcQgRIQxW8QjXpfU6LYBphuBEy1U9Cv1FPzvOpvalZB3XgdwXguE0bgQNmtbUN13JMYwk5BXsJ2bgzm8iRtFwBQP6fxoos6rQBT0X80OTEUT+dreOdDjocDkRsGw2UFgJpqpPowzroeg8a6f2vSUGu/1YtnAVvuTYNsV7aPuxPmjpxco8CJpIyAcDCCNfgSxeIyt6d53u1GecxYxpUUJknZHQiWEPU20Pi3Or3nwJoIvkZv6hCuzb3m9ZqI3v3HCEYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71yb5Zt8Yl2345mrvkA7PQOsvwSghRTspsQS5+c5nZ4=;
 b=eO9bjhnRQojX4juvyi9iGZWf65PVvBs3luGHNWCBSaAIl+MU74LdhzoX1pck2RpfX7gHHcYQwkMgfSAZQvOhUJ8WiAblo5fZEPAq6QsqcSBYzILx0Iz5Xac8q+yCaggRIkeDlvdHF1BXyzv5+6GvgEy7KtfkxzbP95FINa6ZtvbWrlVVYiw5cxhuz9R3nVP7nI1fHrNxNfYJ82DfKX/bFEmO4YP6c6vKqaE223qS21lEoSwZbsYBmg7mYUmFuQTk01OiSEsr8OJ0TyXFF56RuP/es5Yytr4CZ5YD2Ugg7XWQ63lAzsovpPLzxdbbPZyrhaIQANAyBWYI9kVG/TEN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71yb5Zt8Yl2345mrvkA7PQOsvwSghRTspsQS5+c5nZ4=;
 b=Po2msYv1gVZQnxLzLXcwW+fwmDvlC9qpAGpYRKnmokF4Lmi9v6ySuFvn9qHR1QQLC6CZRIZII8zQVmIu6jQNlfbN6KD0W69821lv+dFeFeYICziBXL0Eqt7U6DVK2+3TqGBXZewci/uNsvJbuD+xIQYgkAsKL0y62Gj5eCloTlE=
Received: from MN2PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:160::40)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 12:03:48 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::9a) by MN2PR13CA0027.outlook.office365.com
 (2603:10b6:208:160::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Wed, 13 Nov 2024 12:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:03:48 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:03:43 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 00/10] iommu/amd: Use 128-bit cmpxchg operation to update DTE
Date: Wed, 13 Nov 2024 12:03:17 +0000
Message-ID: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f66d4d-e213-4c4a-b188-08dd03db3b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJxhKpCT3afexDLnrHa9CmPXFlzfN0+X3er397vBXG6D5hcnxxHk7lgi1cFN?=
 =?us-ascii?Q?DWWaAuwMmZaUFxW0WZQJ5WW0lojbgWVn5WHehcmDVaTJ1O06fCyWSTs4Ht/Y?=
 =?us-ascii?Q?SbK/qcOwh+qIPC7QAKVofGAUueHOsgcHENCidkJPolJ4EgzZBC3hICbg5/u6?=
 =?us-ascii?Q?ieEA1bRvOO3IYdThssUZRImcCXeVF9lDUdY7vybQSSNM8G4Nc2O1wkCBoXtd?=
 =?us-ascii?Q?tHc9nPbga0XUFbn0AShp+oaURG9ewb1Rj7Iwc2XJvk7R5AL8n9JWngmYqaF7?=
 =?us-ascii?Q?ghr4Q4oz0P5NV+zV4ZdtZkGJfLobhcKiV2gyVT5yK6TuSdcVr7Jp1FIlFSit?=
 =?us-ascii?Q?OcdYuvSiyoJuv7sZS1WGP5+t1htyVg/L74U4/DFt9Nb6OmWsP+i0dCmpovNy?=
 =?us-ascii?Q?OUKO021CODzleGav3HTYBX8I4LTcH7sManws3CzJUdOHA2OXMiSDJCSDH+8d?=
 =?us-ascii?Q?FbPPo9Nuf75FVuzwZ/xqdEYK+SUag4h6sdLmi/Ej79xJvHjpKeUN6S1puNtX?=
 =?us-ascii?Q?2fCH4pKC34FvfEMngrbWdcbZkTlwFRubgpNYRZ048EItzXrIxYSZDZw51NiR?=
 =?us-ascii?Q?euuGCzKnzZOQMaJQnEqbkngWh+03bFhcIqezEChT2iKmfKTZE/wAfYYoUwxY?=
 =?us-ascii?Q?fWM4j/kCmzCF692VZO1cDqjRIjvYCUOSFhikoHdVy4X2GJ6Lxk4uKefcqnqU?=
 =?us-ascii?Q?1aaZQ5pX7Dpx7fn09gH92Q7/4jfYkdkRzMi5gfdDPPkDeJP3oq6iPFQ/1mOY?=
 =?us-ascii?Q?kpW6Tw80g4dwvtkLWnwDxP73LLGLxnjTbDo+3DUihMpYVgf0Xv6Z/Hk47MJK?=
 =?us-ascii?Q?LwRKeApBPY5scaxeiqpzqIDp8ORXWYQaFQ8L9ROgpAKTGWForDYs11Y+Ouub?=
 =?us-ascii?Q?VlGfO4WOizkz3utEu98S6RXwfd8qOmv/VjL7MhBf0/LBHlPlT0kAK+J6ASSB?=
 =?us-ascii?Q?OVCSHki/toQGp917W7AZzNXc8J9CWe9zgWuGYNpzhN55DfN+FVmBPbsNO7J6?=
 =?us-ascii?Q?OhmB+uDTPbAq4LmnUh+biuIA+rPvHtFsikF+Y/u9rTIRtJid7vAwQ9epPDke?=
 =?us-ascii?Q?GM01LQh60S5tN54vbNbogSj6co0Og2QXYhXn7+HqhLKXQxpWegKyC2C+CaOM?=
 =?us-ascii?Q?fII/f5wrd2WZiKTL5/+jLGTryMAGZNFRSOP/PcdlVphP6pF4/K/kX966qDSs?=
 =?us-ascii?Q?fZyJeL6OvAchdHe0n3aGGATzdCrwLQ4+eTxqiDpw8H3TJBY8wjG60JBcyZMZ?=
 =?us-ascii?Q?6+yW6+nys0IKtNSuP9mOTO9w7M1pETDF2X7xW6c/zg7m8FEH+dUS6aSCq+G/?=
 =?us-ascii?Q?MOZBHc8u8V1uWORcclHea2bR+j50UUmakR/v6uGRW9ZKGX0jXiVGVMK4RvhH?=
 =?us-ascii?Q?nx7NVi84oIAhCxf3nj6Iu/3ge6r7PhibwC3HUB+zTvqKWJ0K2pUuVT2Te5Qh?=
 =?us-ascii?Q?3ovl0hy3Uss=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:03:48.0321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f66d4d-e213-4c4a-b188-08dd03db3b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

This series modifies current implementation to use 128-bit cmpxchg to
update DTE when needed as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

Please note that I have verified with the hardware designer, and they have
confirmed that the IOMMU hardware has always been implemented with 256-bit
read. The next revision of the IOMMU spec will be updated to correctly
describe this part.  Therefore, I have updated the implementation to avoid
unnecessary flushing.

Changes in v10:
* Patch 3: Update patch from Uros.
* Patch 5,7: Change to use __READ_ONCE() with 128-bit data type.

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

Uros Bizjak (1):
  compiler_types.h: Introduce 128-bit unqualified scalar type support

 drivers/iommu/amd/amd_iommu.h       |   4 +-
 drivers/iommu/amd/amd_iommu_types.h |  41 ++-
 drivers/iommu/amd/init.c            | 229 +++++++++--------
 drivers/iommu/amd/iommu.c           | 370 ++++++++++++++++++++--------
 include/linux/compiler_types.h      |  13 +
 5 files changed, 445 insertions(+), 212 deletions(-)

-- 
2.34.1


