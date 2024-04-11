Return-Path: <linux-arch+bounces-3597-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A848A1D04
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C1A1C23D0D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E71C6615;
	Thu, 11 Apr 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/N5Z7rI"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AF1C68B2;
	Thu, 11 Apr 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853998; cv=fail; b=SW0g651/D/D7xBW8BoMoMuL31vFU+zmEoNIrs81kixk5BzYzkS7DwbV+bjkCSX5e/xrTtMkVZe8qjlkjPpdbGs+PRTbmvr5pJOI4Tf6jJ3T3Tlq3xRPQAP0sbggudd9fInb/LJj/6B1G2b64zsHoHqAaBciHnEE13nxWbQbqm+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853998; c=relaxed/simple;
	bh=NUipXhdaaRbATGALtrVTUHfMEWRHr3DeCPjCoPkzMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGWBBVYXLqeThYXmGG3KPhvRPoc+TuV0/3JTSkQePcTud6iWoUiyi5q2g8uP70ugSzwk6L8lu7L5fWs/P8i/cDB2GG1k/eLu9CT8FG8xG6u0sSE0Hv4+qpndg8KubRyws4rdtVqPdaL+Owz2IGD7r4ro9ddgjXiF5J5kpqRJUwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/N5Z7rI; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB9VDzG8p/ueiEuC7nw9ZIZ8lmrzeblEMsBJXtxYkCwNLeeb/WqOSbCaAoYAgIvDV4k6rsGeRZ2BGJBv0DcFZ85511PiYFicR04fswPJWWWZhZXKdQWr/yvl9AqFnwXFFMvljSsloldrIGN8vrNzlnrIi4fCFciE9u5TQQzpSrDVFcvuzoaZy8y2PUnTcLLBcDQXiWtQelA4evIR13yMfAyHyaNS2FV6vre6dkCfIn9/wLPCnuitIHA5r7ptOxvL9bymjzhjAk5VHonEJhZ65YRVdFtDngOdWIxaC91wYD5Jq1aCbzw9MzzxGbHPakBjRiao47VWxJ/rOCtXQnrVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gPpaTPtg1xHqEwWLlT6hLXfYBWsyZWBrYOYzEf2EXU=;
 b=ntbtklFo7HOxmuueCXtpCkPSeswGHpNShcjtB6eiT6+GkyXMBH4VSVx0C0k/wMQiNMyClgzBMUQrkxGQrBKT1CDEYJg1xI85/GdQAajPFLyP8fnRF9lbdcrJPj/1SgNyX4z8p85Cs3//s6T6vfuBWkynzif1kBp773FP/l4Yqw0Gfy+YMBKDWTORVIZZsV10yAXR+L4aQlm8uCdtamaPOwwzSmUMO9AfiPxv2HjRSdGWQ7GTr+DW8VBIrLFhJ29R7vD85awDESRkS4NOx8hcSFSybf2HwNTsbZDFgkU3qUscCd4qvP4I3Zf0RKPqF5J+3/FU+eXFeYpUBtRMir9sCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gPpaTPtg1xHqEwWLlT6hLXfYBWsyZWBrYOYzEf2EXU=;
 b=H/N5Z7rIrxMcLVyGToQM8H8QaxYxl/xYpS55Gbaj0ItEvcY1U2uWaJE1wJh0F/IT3+VHYdg2Wx0f3XNWuNJO3OSWj0UJBc0zIzAjby3cVA+j7gRJ0EncvKko5xA4dn6w3WELLeQiZvbHpt0W503wi1tf2UXXQdwjn8CBy4GX4ku6Rg8Lr90RecLVQ7XTEE/Ubi0QaZ/2ZUKky0wqNxrJrdlDHRq7xG4HCnHTjuxEybKJXDkorW0I9VRfm4WUN9aqsNXG0gfTxdqcudb+da+/4wlMkV5jTB0JfQo7hNZjJe6PGGJTnfTNNWjoQjXzCVfLS5Fx9IKWym010hNESqaDHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:46:23 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:46:23 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	llvm@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/6] x86: Stop using weak symbols for __iowrite32_copy()
Date: Thu, 11 Apr 2024 13:46:14 -0300
Message-ID: <1-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::36) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: f32dd621-6a5c-425c-9cc4-08dc5a46eace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OU7S7Hl+VBNhs9Wa8WCFye8hSOeQ4H02MR1sEZ9H3/0TOKntdBY4VfIbNv+TFFus2t3Iwzu1Ci/sYHJMIl5BZCdq3VBLAUhjGEb0amxb4lP2/8LUscLJVrASIfeccbISmOZ7F14NpmYlPkvXM/tPT9noKnA/uJA6J7VnxY1IiFTwl5nEVVUN68Hb3n5GTtefv12NhUU3ywLtqJjHhnzPAVUdpGitdybIcGSyZ7cSTkz9A09FJ3DDTJv3nIh6aMs1VohosHayjYYt8PXrGjB8ec4JLuT4ApE4g+JLUgY3J/nYQYOiJqwzIiJUnygSWDPsO/lG6t8duH7K1NCzoREcLLMpGKxScD5c7c0n8sTJAfuUk8/X6TbdlWd0PWPr2emmjmbUnNLSd3WHKhViNN0gwyAcohXaF2BxoK2rHpL6h8hkwdVMJY5nA8I1oZw2PhGyw15gq0Bl7nLuKdKY0p1IY1kNOS8QCXsf7dsWcU49XqV8z8c22T5ulyf2WZeQJPPAC6SF3CR/rN5dmXX5rkFSPbaxFsozLZAj2Brbsro5aLd8hqJKxTdyQ9OAb8/L19SSahDVc7v5rLsDNnNKcL0szFvFUMFkZV1yjDhPhqTGEY1WuvbO+uEDYuvZAK9xGHVbi5NAEUBSIbXBJXJ//P15S+3svfPwIKBx/nauDRwW3Sbr0uCH/EbAUwgA62UgIV+ygEJd5x4fLcg0VikGD5TNsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Txg6XFOW/9TquxGDKyNZXljB30YxpUzdYu5hAM7DraLSVT0ndSxqJsx1neLG?=
 =?us-ascii?Q?yTUFPX00WOCTmFBOo2Rn3RiuS8SDuNiNVq1/sRP/8dK+HpAK1Ns+qtZW9LFs?=
 =?us-ascii?Q?dyIEg3/hXQLl3btwP0WBeCANLRmSQVwYzBaqbGlZLOSb46LwGt8zldnUgVXY?=
 =?us-ascii?Q?I+eNHZxaa7W0iYN2UKSaKslCeCE+339PKgQNRk5HmgfL0lrB+UpUzYO7r0pW?=
 =?us-ascii?Q?MCrRXYWsATwRVASG6RduY2HketyBKk2dSOXZwcHFE37BkVTnwkgKAGLfiWdL?=
 =?us-ascii?Q?6arZszUx9xutdPomNJHZC6A2WpgwdAc1lDwAWEKLX0yDyb750C/orz9d43eM?=
 =?us-ascii?Q?Kl9yo91Y1yc8k0qVXuTN3gZx/Vpjc1EOB3k2cB3LkExBWKLwBhLT+1FQmB0I?=
 =?us-ascii?Q?2/cv2WfTQnoT+AhFEVKfVqPdNeQUJL4wrhVD03jf24wnpxkVHOteQ0kQvgo4?=
 =?us-ascii?Q?jHJN7UT1f4stfcuOQ/REjlDEHDSH6TtHnoe9n1F1xgWW0dw2x48zHYpHG9pZ?=
 =?us-ascii?Q?DQYhLMnOlWF+gsRQTID9nH57oC0GzSZF0kjsKPAPBmbiqPE4Yh2PIKEmaWz9?=
 =?us-ascii?Q?il4qqDnXvMwd2aluD+ORJ4IMxSq5BWGGpT3xLOUKLJoU5vrfD2iFP91fFo6f?=
 =?us-ascii?Q?Dj07Ed37lkKu7F5aPMUSxK0g63cwOY7fhPk1vVFEWHompo2sADbWWc7iHR0d?=
 =?us-ascii?Q?4VCPmj8aPxT4CMLRzebcyy4ZZotXpiVSkb16KnuiMCU+E9Evm4UAwjxEBDhO?=
 =?us-ascii?Q?bIXcPqBlmLa1HsEqN0zmGNfmERmHrI1GrrS3ILDZh1cSmRLKp8Z4ZhClLjZ8?=
 =?us-ascii?Q?KfSVJ3cfZngdHmnn+4JzIGZ5whEw4zs9GGXeFU3zQlKw+osoqmV37ZsLNxMl?=
 =?us-ascii?Q?i0+ULwETaHXK8ftWUU3iintFo8Fn8ccLj0D51YT2W3yokrVXG34EUiwEbQep?=
 =?us-ascii?Q?kGDemuuJKXk9YEXcO5z0fSNJIT5WGmDKu2IQFyVvPxNLS0SLT3lBpOwYxAFK?=
 =?us-ascii?Q?bdh6JPVQeEb8VWFHRv+Pvcdd0tVjx6gvlhpwE5xVn/AZceE1fwvS2c/MYRq1?=
 =?us-ascii?Q?cX0dAlwtwPYsN29aRYBPYnvNM+MYJkPwMeEDBoBHbKJzFZOY69e2lK4ZQtRc?=
 =?us-ascii?Q?FO4JNMG0cmLYb4AIyVb0nTAMsHCBhjuxG9p9xH6lAdYRDFZd54xk4H+quXsT?=
 =?us-ascii?Q?Ok0tBI3HVXArxygSL1kHymnNKp7hv8051x2i14YNCNrIwYBB4Diq2JA2Z0o7?=
 =?us-ascii?Q?wVBjWS6vH7nL+ciaxWftwg4X1pDypIUwTZ+0y0OwdDI2u9T4f4bZ3TLW+oWA?=
 =?us-ascii?Q?M4TPA3Z4NAs2VCeepQJUU5gqk/5RGEf98MrpSi0p7ZAz0hFYf1I8i1SpU/7/?=
 =?us-ascii?Q?Gos5UU8TFEe4rLsTSs0GwYP+xmeCoFztefFj1qdv9Lhyv5rOPG8/BxeMoQ+/?=
 =?us-ascii?Q?QgZrmdByFSh0sTTScRUfOzOs8ZhnO7ClF/2J6cz+A1J1tLFjD0VRkyH2E6dx?=
 =?us-ascii?Q?3nQuZW6QXuki443HdYgSmsg/cYwErB7qi9z60s0NvxZawvyXr4UYPzCwY1A2?=
 =?us-ascii?Q?rbJX0zV4pFPvWMpgTTPCa9zQXaWquZI17qUNFJGC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32dd621-6a5c-425c-9cc4-08dc5a46eace
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:46:21.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdCiKkIt5BwwTn8c2VYAXmiqGIPWwW6B1wLC+j+bGnFl+i34PF2akqQepPwAn50Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

Start switching iomap_copy routines over to use #define and arch provided
inline/macro functions instead of weak symbols.

Inline functions allow more compiler optimization and this is often a
driver hot path.

x86 has the only weak implementation for __iowrite32_copy(), so replace it
with a static inline containing the same single instruction inline
assembly. The compiler will generate the "mov edx,ecx" in a more optimal
way.

Remove iomap_copy_64.S

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/x86/include/asm/io.h    | 17 +++++++++++++++++
 arch/x86/lib/Makefile        |  1 -
 arch/x86/lib/iomap_copy_64.S | 15 ---------------
 include/linux/io.h           |  5 ++++-
 lib/iomap_copy.c             |  6 +++---
 5 files changed, 24 insertions(+), 20 deletions(-)
 delete mode 100644 arch/x86/lib/iomap_copy_64.S

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 294cd2a4081812..4b99ed326b1748 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -209,6 +209,23 @@ void memset_io(volatile void __iomem *, int, size_t);
 #define memcpy_toio memcpy_toio
 #define memset_io memset_io
 
+#ifdef CONFIG_X86_64
+/*
+ * Commit 0f07496144c2 ("[PATCH] Add faster __iowrite32_copy routine for
+ * x86_64") says that circa 2006 rep movsl is noticeably faster than a copy
+ * loop.
+ */
+static inline void __iowrite32_copy(void __iomem *to, const void *from,
+				    size_t count)
+{
+	asm volatile("rep ; movsl"
+		     : "=&c"(count), "=&D"(to), "=&S"(from)
+		     : "0"(count), "1"(to), "2"(from)
+		     : "memory");
+}
+#define __iowrite32_copy __iowrite32_copy
+#endif
+
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
  * explicitly ioremap() it. The fact that the ISA IO space is mapped
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 6da73513f02668..98583a9dbab337 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -53,7 +53,6 @@ ifneq ($(CONFIG_X86_CMPXCHG64),y)
         lib-y += atomic64_386_32.o
 endif
 else
-        obj-y += iomap_copy_64.o
 ifneq ($(CONFIG_GENERIC_CSUM),y)
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
 endif
diff --git a/arch/x86/lib/iomap_copy_64.S b/arch/x86/lib/iomap_copy_64.S
deleted file mode 100644
index 6ff2f56cb0f71a..00000000000000
--- a/arch/x86/lib/iomap_copy_64.S
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2006 PathScale, Inc.  All Rights Reserved.
- */
-
-#include <linux/linkage.h>
-
-/*
- * override generic version in lib/iomap_copy.c
- */
-SYM_FUNC_START(__iowrite32_copy)
-	movl %edx,%ecx
-	rep movsl
-	RET
-SYM_FUNC_END(__iowrite32_copy)
diff --git a/include/linux/io.h b/include/linux/io.h
index 235ba7d80a8f0d..ce86120ce9d526 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -16,7 +16,10 @@
 struct device;
 struct resource;
 
-__visible void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
+#ifndef __iowrite32_copy
+void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
+#endif
+
 void __ioread32_copy(void *to, const void __iomem *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index 5de7c04e05ef56..8ddcbb53507dfe 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -16,9 +16,8 @@
  * time.  Order of access is not guaranteed, nor is a memory barrier
  * performed afterwards.
  */
-void __attribute__((weak)) __iowrite32_copy(void __iomem *to,
-					    const void *from,
-					    size_t count)
+#ifndef __iowrite32_copy
+void __iowrite32_copy(void __iomem *to, const void *from, size_t count)
 {
 	u32 __iomem *dst = to;
 	const u32 *src = from;
@@ -28,6 +27,7 @@ void __attribute__((weak)) __iowrite32_copy(void __iomem *to,
 		__raw_writel(*src++, dst++);
 }
 EXPORT_SYMBOL_GPL(__iowrite32_copy);
+#endif
 
 /**
  * __ioread32_copy - copy data from MMIO space, in 32-bit units
-- 
2.43.2


