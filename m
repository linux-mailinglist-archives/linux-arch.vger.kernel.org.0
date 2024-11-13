Return-Path: <linux-arch+bounces-9053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B39C6F05
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 13:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FED9B23921
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD262038C1;
	Wed, 13 Nov 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0thSmpBG"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CC203711;
	Wed, 13 Nov 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499446; cv=fail; b=oBtMekAAlzdS96tjVQ+pKOCO8lMoc6sRazMCZcnpEIrLc2sUqh7M/mMri+CJMWv98gdV3S7srx1QOuyQvFmclw6wHm73MinIAoeHjSFr4VaBAuCZO8D089Kt1XCrfMimSvfzUfnCjLsrMYBubiOb2Vys4VLImtiZnvF0R7HcPBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499446; c=relaxed/simple;
	bh=7CK6PeL/T70JzmfvQ6FnxMe1fhYHuVE6okxe0Z9Wyes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nR1K4jdI6gHTwLC/ofLOwKJnimSuzOoqgFGsP/6Jk9ieqmIMkoGUbFe32xyyvBXtNPttq4QFuJ3hDUri66KFhOthI0pZxJHWDSFgQDn4uND3rBjsoUF5EFUEfV/2wkurZ9LlXcquMvivir1KZTU+cX6oH0yKx/KYBk6ibdKhEGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0thSmpBG; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozCVYva0gubYOTV8NL6SUegmeJUkWrbVmQXRulrYEgpD6nglYBCllSt1Ry8fagFAaEaDHhmj50gikYCzNTeOUGeXCheiNme2VS8ZZpIa7epQvQsyBAaRXxKnSDH/PkO4nYM2W3Xf1r4wC4HvP3uqs7MevPA/ggGeHnP4YbECt6cMK8wILkU4bi8pTSKyJybqaCrz/CXLuicdmAXwPp/mdDIXFQI3NL9rIeQirgkmzkCf0DawlelAdJPBCq5hOJzMF6qWkbHwK1LP51zvBVno1UEjJ/v0cY+0HvbZ5i6JycYBYGe6Fzk7tCiOYsDPWP3B1uO7hXVLk981tt+Vfp5GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdoNEDjWdlplp7xJvDbC2S0xxjmcPRz49IwcWb9zm5c=;
 b=xMFojQfluw/QwESxJq54pbUP1GswaB+aa6VEV/I7RqcpQM+xFFFfPTzpJN1ro6UHAS7I+xNvUFkja8wR+R7Tefh2AyUJE+yWUCxwPM3t+v6j46yc4Zn5KLWsbQaaP6NDHO8e4aG7R/NjoloWAdFcHDUz0WEDW/4a1OLojsUAM07YI9ywLn72Qpti+j7oyDQkYU2Aw+0vIAYgGYxSvxl7xqr698NQz7PcrFGuQKUDK9NjkjnzjNtoZE9rQTeDSCBA940j2UqlOvMjdiH37I3FFRW6sDQ12xBhQFf6wgcXWm1R1emejUTQUdC6rNoG59SzcJPvYYfhZHqJ+L+cud7wwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdoNEDjWdlplp7xJvDbC2S0xxjmcPRz49IwcWb9zm5c=;
 b=0thSmpBGsisNX1alZhabGFf4feac2c0gKBTNlHBbWVFPdHsA2koxmry4qdHiZ3kHpq/7MIEatjyYXp5uqEOyknaWTeyxvuMxvvMecFpGv77rt6CCOia/OkGoFLQx9xzvqmKzgGIENGePd9+lcC+D+fKUpZ1NDGksxUkM4g55fFI=
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:04:01 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::24) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 12:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:04:00 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:03:56 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v10 03/10] compiler_types.h: Introduce 128-bit unqualified scalar type support
Date: Wed, 13 Nov 2024 12:03:20 +0000
Message-ID: <20241113120327.5239-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab7b2f3-ebf0-4733-7201-08dd03db42e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tOdlur0yBRdsc57eoff114i9uibz3Ay1fI8BgeeUBr7LYRKSZmkQr7I394Jp?=
 =?us-ascii?Q?Vb1uIE4hZlHBzhRIpDtXt0WVT0GJL8YeZC7whx3yoV+yUks0LQKqM7xDlLCB?=
 =?us-ascii?Q?y0P5FvejGDggbA5ijS1z1YHcVmoDOM/Y1RLsQAAlmIJyvdlxw2KuUeeQ2JKB?=
 =?us-ascii?Q?fBXNtH4Wtn8X4fK52zkGCE+vFJEeez1IaObtCokvaEWB2MYE7EO+13eZlklr?=
 =?us-ascii?Q?mssV/KqiiMethaVTzHFYd/aYHNd+Rq3jzFCiHd2YmjpHF/4zpJcA2KLeEfAi?=
 =?us-ascii?Q?Hsl7GAz4ubBViXFrrbzQhJKQa76ZxOPx9Zq0BCvymAGDl21iVFjrS8KgGr64?=
 =?us-ascii?Q?3QH26mqqFvzAqvD0Lf07UAkNaQEkhz0yXTr3cSzjz+ePEbz07drXiEQCUN9q?=
 =?us-ascii?Q?RRli8A/298xFmYq5+LZ6dQBN/ApiG/m/M3ZGCKEnavLTnaF0O0ji8GD7SSx/?=
 =?us-ascii?Q?Y0ZjwdVB+QDvpsbCS8XQKGc8vQhBVfcN3kvAKj4quAEPVK1cyq+i6D3B6OzV?=
 =?us-ascii?Q?JQ+my6zerDeNzFn7qeGa8HNgjZyXJsGnV2XQnUUdmOSp23lcluqQE1Tl/y02?=
 =?us-ascii?Q?8VuHJ/AkZn3hhCuPU5LPbxy9QvH11WY6ZufyRaZCbJHkrpxnMsxtpvrI0iJ7?=
 =?us-ascii?Q?YQR1i9RebLC3+dMIljhgpHKRMe0u+OoukX++gmls1Ab71Us1ttEyq7dkd4IQ?=
 =?us-ascii?Q?349u4D2qSgEUu8bKEJo830UQvoysSG15T2vCoxiKVirUJMRlK48hvA/rimr4?=
 =?us-ascii?Q?iaOL+meZXK/8b/PC1nFs5DUuFmXi4ndx1NMgaX3H7uBikTVdmJ7St2qfWnKh?=
 =?us-ascii?Q?Wumpa4sEkFZBWQsEkejeyYbVsM5b5KBLdUlCcPWEHY5gb79e2wzx5RRWTYHB?=
 =?us-ascii?Q?C4EQZ2zxentwV+IdQalBQuzQfSk36RQJpFK8hcf7NpfD46i/Oy7pD3hdbFGC?=
 =?us-ascii?Q?9zbN5MVSq+9g3o5W2VEkcK5QzIlZXGzW3SSg8JG+Zeeg7WWv88M9KyeA3y3H?=
 =?us-ascii?Q?kZXiEEqamYxpN2o6YT4FpGlkASxb6fciKjo7jA4mc+YFd9vCbAvtV/rxZiF6?=
 =?us-ascii?Q?6OdPw0HBj/ZoovBwaxADJslgOH73JI93CTD8UKDFXzsxRbLNqAtcqcTYX52M?=
 =?us-ascii?Q?4PRd5hVzlsMdcAsNiQUopLA9pSzHXy2nBoo4kh7nCyhUBlOfAl1mgsIxjHIb?=
 =?us-ascii?Q?d6hqCp61TkD44+v+Te9Tnq8lGgWPOJAeaZZRy9wCL8zhKijNRVI97Yd2JfOI?=
 =?us-ascii?Q?SXDgsJulfkwR9gpCMc4K2r9M1CHDvGXdZ2IAYMp5WzWWC9ANTRaoB4Mspk5l?=
 =?us-ascii?Q?n4cST6/kIdaKLWCKu/YRa+RBnJCpxfOJjM5wqcpwnJ5lGrRsbuClmXiZcto1?=
 =?us-ascii?Q?lcIeWLF1qsE3W6TUhyXVlAsqlVcAdPiRallGLxRthA8rxFaCfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:04:00.9642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab7b2f3-ebf0-4733-7201-08dd03db42e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

From: Uros Bizjak <ubizjak@gmail.com>

Currently, __READ_ONCE() cannot support 128-bit data type due to the lack
of 128-bit support in __unqual_scalar_typeof() macro.

To ensure ordering for 128-bit data type when atomicity is not required,
introduce support for an unqualified scalar type __int128 if supported by
the architecture.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/linux/compiler_types.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1a957ea2f4fe..394e0e60bb27 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -469,6 +469,7 @@ struct ftrace_likely_data {
 		unsigned type:	(unsigned type)0,			\
 		signed type:	(signed type)0
 
+#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
 #define __unqual_scalar_typeof(x) typeof(				\
 		_Generic((x),						\
 			 char:	(char)0,				\
@@ -477,7 +478,19 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(int),		\
 			 __scalar_type_to_expr_cases(long),		\
 			 __scalar_type_to_expr_cases(long long),	\
+			 __scalar_type_to_expr_cases(__int128),		\
 			 default: (x)))
+#else
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(char)0,				\
+			 __scalar_type_to_expr_cases(char),		\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+#endif
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
-- 
2.34.1


