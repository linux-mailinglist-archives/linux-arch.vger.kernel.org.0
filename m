Return-Path: <linux-arch+bounces-3599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FC8A1D37
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344A9B24D82
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331223717B;
	Thu, 11 Apr 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HVLy/bM1"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC81C8213;
	Thu, 11 Apr 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854003; cv=fail; b=PkycivK05EwYisBSgqAV3ceXdrxhnOr4pbH1Ij6VzthEsqffqyQsWYmDI9PkwwfkAvcztkItpg4CxR76mDkIfi21pfbtmC6skOt/1i6vcCz5h+TjjM0Q0nNU7stGsw5F8LQOywOTMkEhyqRZ1K3KAOoU5vOm56cJd+MmBnAiHfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854003; c=relaxed/simple;
	bh=5ff3E288+fhUxGKUV3tFiuspGfkKquvphHosVWIrJ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpEdr6fdqTS5vRmdeq7NWEPtHp4MgAiWA+dZwYWvDbYkrgeZfjGKQ74LzXhmSD+r3oDKkBuVlsJ+FXsyA1UvqTa/w32RVGMzN5hkeph3+vjCEVBW+ka8MR4VyLwPvsychEWRSqM3yrf240zEQdYpAzhShdjvEXXqE7/+3+1HDco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HVLy/bM1; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+oQNLGQa/NbW6tJ37APPnOvjTVVe+iHEeWg04fNIXtWJJrQcR/NBHjqwjUWjjUP4fAJq9l5rZd1p5eRriuaQuLMRcH55gJupA80G2Pl/R09OtTutWpYwwwCdPNhKkXQ0VmjjFlymrDpQ2tzZK5WKIPvKMngKPl60vMjYfGUzkJ77OEteC+Rxd2KeV5HaylOGJgKCVUYpGozIqQxZbfliShA2Zi2jhCVmHZavaFu0sb5JBrbwI8KbPJM9MXiZ9XdhuJz6Kl7Cuz2HxAICHcT9KhtZCG256kQ+dxzCZ4i+vU+r40Vdw20iDe8Mbt1gCm9cy9g6RkYkcB4CF4z/WdBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NrN9Dwl70wQUv0Iu7xVFQtRrGzGbWKrTpmtmyKfgvc=;
 b=jxvlnCDd2ZKlgbO5AW9FKOHzatHVeEEcZYY5kuaFmSZ/xXrXV5CJFBr8RTVSQk9YB9GjZkSxPYMPEwYHB0KRd8EIQR74jw23NoEKiDMLciGoyPoPGIFMjzww1gt8B3f0EHvYC5CPsjTv/9Gk3o5nSQYn/oCqNtFu6fAqqGgFIQEsSFrSmvsrV/guTwktkAobCLcsLr/dVl5AcdAWMFafKT1Rhxm11tbjpH/rqL80i9iBJ2cA4vkD8wYB2M/MzRFPloztbUogipHKXsTaR1HrSq/cs3dllHwm5L+fzUetsbc/a3E3HlQWRZq70Wy72EgAvqqx7hDVM6g3BjUaY4fF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NrN9Dwl70wQUv0Iu7xVFQtRrGzGbWKrTpmtmyKfgvc=;
 b=HVLy/bM132ITWpF3knAxICOesuDINLarM5PcDtjPmCJxNHbbSxjJNX2BOAQtjjGhh2J6yPIiNqPPaAuZqhcbxMKoOsvRBHmA9ErJEuQqaTFPeZA4nFzARtEB7JTLBjGcbUFRuC6GB5ODcffoaFbCHh3HD1WUsEv4vDNvtoYMESn537I/6xae7UPYGVxks4ULoDBbBsdf2P0jOH61hb9FQQfpmYI6zTqUL1AZIoYDdz3PiyzQgUBDUsz2XhWkZQGzzsCtpAxXHQoydhJMi9CBhHLBYiLWrU7IGHf27kcUh8q7rlkYGPYavHnFn9ejnjIjiNZ+8mBWHbwwwGfY5A9Zhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:46:30 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:46:30 +0000
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
Subject: [PATCH v3 3/6] s390: Stop using weak symbols for __iowrite64_copy()
Date: Thu, 11 Apr 2024 13:46:16 -0300
Message-ID: <3-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e18661-fd39-4a1a-89fe-08dc5a46eba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KlfCzdrYJw0UEuCsLzFWUViNz0Atr7Qx3yp8rN9mlnkVJImYi4CCpjFR0MCeWHvm2gEfZOlW2aqtNTqvQHb4zus5Q1yjpZDq2SOtVSsDZipAYkpoGRT3lOLN26oFi67SUt72RNwDkjQXbrqM2shg9FlvwD38TlIHFxhAQYKD1M9OF4ymgibhfmfybfB/6lnNSGuZ1oBmTZkK2gYT7bIkFzPPXqkzcU/8KUBn61A5n27cGbh943LRT1mfgzApOLEiNvIVx7ynTyHv5CmSxatjgVkKgZJQB0+Bgl/RA7PzqDNadFTiG12erE/xX9F3wBOt104C7OqztHLyqafAhminsw7SZTN3H1nCnOPyfyaU4yW1WGeMCf6XNWv1CC1dBlTP375PIDnHU7hzsuuqeKpDx6tYyGSnNW7OVmhgZhXOEEeDlrjljd9LS08jxnBw1mi1TlbWKgXo8pc3i3VRyhMSMwMD8hHmCMQk3jcFgjK8G+q/v8KW5ZBtHqudkQcEDYu0tR24AqcojR3WnyUHZ0LYYqJE0EXSnOhzk/0uaokOEr9nsBDeD4IO7sStUKw+5F3vYcnUBWjzh78/RmoxXernnYgT6esvzdx8q39XjFYFvQHN7+PMbvZwZjLsD5ip13OyWYi2yOy5pCvPTUZNkVsttfb/0BQkO4g+j4YNoFJRf5IM2PolzwAHs2+r+bJcvNMRtu+PvCW4AvsO7cuKkSpEOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uL8NMwQjLrc6AX25m86UiRvzHhp8hmcrYiEXeqBcC57cJTbfuFR+8T44OEeY?=
 =?us-ascii?Q?Cx7tdGV1d/HAYFkr+UZe+bU93JFBKHIBr519CY7slxbYCHkAvR0hkK1QVjSn?=
 =?us-ascii?Q?535nxBr6btGwNg/H/SqpwUNvtJkTfMiGH9daIyxMo7Xtwxp/eswLhdeAsWkZ?=
 =?us-ascii?Q?Hjc69Pxrzxk7ABWxrtSsthihjKUlBruAUxAubaJjaDqxLbI2rGqy75Uwsi0Z?=
 =?us-ascii?Q?qoIGHltEuNGgJUOTJhqnBAyO60fycUVGQY8Fp+aLfy6sYPGB1t/7xPmn70hj?=
 =?us-ascii?Q?DEnYsI4Zd7g2tfAuV4/V3e5j584Byyaw6VM7LOjoeOnsdF9h2+3PGpc5fSNK?=
 =?us-ascii?Q?iIAaD+DnfowH/WCXvxZwbjBr+JMGUQZ+jnX+KxfgbxmtJERsEOPb0YYSvx8M?=
 =?us-ascii?Q?KTTQPaDBgDVpxx7t2W3xTp5R0W1fRMeAQTMv/nNs1PpVGR6rvXKA5BCnlCn+?=
 =?us-ascii?Q?KB0pXaPJ9VVFHqJeWP3/WBGHaX8Xy+AkKa4OGmgMFAdtC1Vzftbv7u4Oa8oW?=
 =?us-ascii?Q?ivEdWuGdZApaHGfg44DOqBVfOVhMkbCUVApbJ3xvjpbqDv3WBNAiiz7ZQo3A?=
 =?us-ascii?Q?hK6Be/3MrJhNHLTO6MFkhklpZ1lg3PeECXNpQFV8qgt6E2VH6lrq1CAZaXPz?=
 =?us-ascii?Q?H1IUKGHbMAYGVgKNaYaeZ2ppIK6NQMIESRkc7MnQv0eWh2BBrryNMdZL1bqG?=
 =?us-ascii?Q?4FptOTwdFp9mvQgS2Df1JRZ1iIfgGzo4KL0NyiMmItM2eTHxfcwINjOK6oAf?=
 =?us-ascii?Q?8Z2y7mxgmcfuYfhukwX4mDv1zANdfCumoiPL5/n2PPCKjUwGEiIy9LCE7+WK?=
 =?us-ascii?Q?h4+yg3Q8JuTxJgi6XLd+J3Rek3OnJKoE4rOvxugjUTBpYWS32KGPFkDSBga+?=
 =?us-ascii?Q?Rk3qlk/T/FdINcGEcL6fihRM0Np0g4BJEJbGD4sno3U69S8uXLLxoHhPsX6Z?=
 =?us-ascii?Q?q5GgpdsGHf3h2wPxmACYO+R5ijvKE6q3GCR7vRVhE0/AYNhU+7SV8tzK86bq?=
 =?us-ascii?Q?paX7Hreg4wKlPeATHu702pxGdza+Clb1PyzmklsHMkKh1o9rruNH7wSHj8zi?=
 =?us-ascii?Q?3QFuFd/HEU3/qiBkGohuy/Em2bnogLxAZ7CHPASZxNys6nVTPw8edwMuqQOk?=
 =?us-ascii?Q?c+67qJigkd6Pk2xMh/gxToaTbus3bf7t5xStlzI8sPZNMhvqHOSAgVPmnxxv?=
 =?us-ascii?Q?kXXefYlHiPFWgNDbLlohkhx4xo1KEpt4LhjQlwvgO/bz+a0zUJjQYqa2y2fV?=
 =?us-ascii?Q?vxugjE9sfcrZwikMCzZ622lFaRVyXo2grtIHZE9xgKuOll72HuyPduil7jZ4?=
 =?us-ascii?Q?uCK2jCsWSL+sFtRghtbmql8BReTkIdU0myZDdvt9ojG7YD8T57KqLx9n6Wqe?=
 =?us-ascii?Q?aQtVG5DDyF/kOJQ4WQKygvX/SY5+Vqo1lAYK8PeRQYK6P+FNxlpt9csna+4z?=
 =?us-ascii?Q?JYLiraO30PCBcB/myB2SU9GMdWmuM1qA1qrDKKzuc6JuIN6g+OCXvuj6rnMe?=
 =?us-ascii?Q?c6d9y0TLXWVY/GdYYTAcC78ZQSLWhZ4osj6GHTmv5oEHilRdq5NIszXLQ32k?=
 =?us-ascii?Q?l0ALntWy3f0ogeFACQGhkGQXrlhvtM0QFrxuIjd2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e18661-fd39-4a1a-89fe-08dc5a46eba3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:46:22.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMIENZXDu35ZSoupm9JlXaDrxm9gEzo5m+94C+//A7yeYNvlId6XS51RoRP92YfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

Complete switching the __iowriteXX_copy() routines over to use #define and
arch provided inline/macro functions instead of weak symbols.

S390 has an implementation that simply calls another memcpy
function. Inline this so the callers don't have to do two jumps.

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/s390/include/asm/io.h | 7 +++++++
 arch/s390/pci/pci.c        | 6 ------
 include/linux/io.h         | 3 +++
 lib/iomap_copy.c           | 7 +++----
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 00704fc8a54b30..0fbc992d7a5ea7 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -81,6 +81,13 @@ static inline void __iowrite32_copy(void __iomem *to, const void *from,
 }
 #define __iowrite32_copy __iowrite32_copy
 
+static inline void __iowrite64_copy(void __iomem *to, const void *from,
+				    size_t count)
+{
+	zpci_memcpy_toio(to, from, count * 8);
+}
+#define __iowrite64_copy __iowrite64_copy
+
 #endif /* CONFIG_PCI */
 
 #include <asm-generic/io.h>
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 26afde0d1ed34c..0de0f6e405b51e 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -250,12 +250,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return 0;
 }
 
-/* combine single writes by using store-block insn */
-void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
-{
-	zpci_memcpy_toio(to, from, count * 8);
-}
-
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot)
 {
diff --git a/include/linux/io.h b/include/linux/io.h
index ce86120ce9d526..42e132808f0035 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -21,7 +21,10 @@ void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
 #endif
 
 void __ioread32_copy(void *to, const void __iomem *from, size_t count);
+
+#ifndef __iowrite64_copy
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
+#endif
 
 #ifdef CONFIG_MMU
 int ioremap_page_range(unsigned long addr, unsigned long end,
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index 8ddcbb53507dfe..2fd5712fb7c02b 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -60,9 +60,8 @@ EXPORT_SYMBOL_GPL(__ioread32_copy);
  * time.  Order of access is not guaranteed, nor is a memory barrier
  * performed afterwards.
  */
-void __attribute__((weak)) __iowrite64_copy(void __iomem *to,
-					    const void *from,
-					    size_t count)
+#ifndef __iowrite64_copy
+void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 {
 #ifdef CONFIG_64BIT
 	u64 __iomem *dst = to;
@@ -75,5 +74,5 @@ void __attribute__((weak)) __iowrite64_copy(void __iomem *to,
 	__iowrite32_copy(to, from, count * 2);
 #endif
 }
-
 EXPORT_SYMBOL_GPL(__iowrite64_copy);
+#endif
-- 
2.43.2


