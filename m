Return-Path: <linux-arch+bounces-2536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E685CD51
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 02:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8142284863
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 01:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A935CA1;
	Wed, 21 Feb 2024 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTuRs4Ru"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00D46BF;
	Wed, 21 Feb 2024 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478263; cv=fail; b=YqIPfg2iidLKqL7Dwh9aAxBZTZthwp2N3+/lkvOslgOFaPvJkGeXaVfmYBOkKJ32wErUdWCwSzcHZPBi11gG1ede2wkSSIrSMpTOY0oWGWM61XpQYxgvgjjL3imDcwRq15U+KcPngFScUgSUKKeNs7zFJXxlQP5AQ75NogLsLcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478263; c=relaxed/simple;
	bh=7uzBHjAcC+WFWa3zp23Lhl8e8N4QKBudNzUWrDw367s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPl6rrk3xpSsR4VwbuRyNfd/KgXkmYpsTcS6+ZdAL2cGqiOV8WS0xuetpCEciCd7UjPu8cTpnA8UCn0Z0G+1YvAN46u9/SZ6wPD7MnFVEnUFxBUiEmM5pLjY7ynqOgOSq71MnwdEqrwmrjKAkaGKeWJFXw7pwgqZbwvGaPk5BKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTuRs4Ru; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF9YtUOOKUKaj+suKxk3wzvlTWIk+QK3nt/dOeBhws7A8o4Ixi9023GzMR9y4pMz3aBi5Ep8bKi3Ej7wIKA3CP1Ct1B8TCYwx1U5KbQU89xy8Lv6PaYisbTSalP8z40lZVoWMQjGJPKypH6fyrUgBfJX+ely8qCc2JOu0oRL4DnvWXgqbFvh5p5gu9Dum84NTP11b5Ka2YNOe21HtKfisBLPO7OT8naBClkLcRErTASF6IpUQDxe3iqv9HdXvTCrCDiv8tRp03SqHagc+Z2O3U9eFFP4gPPrurgr994O8I/oy/8tqmf1yE+kIW5a6qYTr/PqYBfL5EMl8qUMEcbdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8AAjccZiDocpI+iUhnHuPYfPmCAn0tQ1el49HyzkKg=;
 b=BKbI5vgc3+vYcBLDfBxIeGVXiN5mrbXgFQZLE87wFRDhf79dYMNpKc85V+bssSifzpSduYe3uQD0s4X+EbywMY2Nx0Xq/UhqL18RnZgXDDvRPh0Yu8LzdwPD7EC2HP0sjw8oWqZ3kEJsqe+9s1lSXp12yRWzrN7Z/zMgqVxMxlUJvO0XjBHQFTM3J7WnIVDE8lutrpAt0GjV4JWHnsajLy1Dt/Ntq/Iog4xp+Gr4W/Xs8MPBxYdekvgI0TaEBt4hkEcaSLmRoQqOV2b8gGyEbBms5Wjlv4onIum/3zGw+yzp6dhhoUoS/C7wsOwK/wmvxp56XhZE4PJLKcL9a8MV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8AAjccZiDocpI+iUhnHuPYfPmCAn0tQ1el49HyzkKg=;
 b=DTuRs4RuO3kRZ7VQ0o+K6SVfOREsUKEVc3nii+UbQr4jgMr33fcd01Kj9cpgXPeKADtt3rox1POh9L9U0EitZ5eIL+1TwLM1BFbqyUp8P6T8IhXTd9FHzvMREt+5NEnZG6FaMLBk22TlESRHOOlMWMhNfHwGZmWAyyuDpRXU9eWOLo+o8DoJCcdzhmRC4WnJVKhloUCh6nLv3EyNVxQdHEqy/2ShAWncGr7tRBnIBwLl0rOhQPwqTJYdRpDPddAUUoyNAokPO/3eeiPJ0IBYGgdhvPPRmOhwT6d8z6lTRQ8DNebEHq1Elx/sevt6Ijx8viW/coWljBdA6otgjuglFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 01:17:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 01:17:13 +0000
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
	Jijie Shao <shaojijie@huawei.com>,
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
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/6] s390: Stop using weak symbols for __iowrite64_copy()
Date: Tue, 20 Feb 2024 21:17:07 -0400
Message-ID: <3-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e41e24-5250-43a7-18e4-08dc327ad4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2obyQZaplIdlx9P1Oz/M8pb2d/0l3SYhM14cNXw+bZRp5q94u9zpGeU7u3PR+UWuEk26Q5VRDB11o5FmCtHAPiws4tcCzvd0QnS3ZM5YyGFnXL3yEvRVOmwhKoRm2NPch1ckyWWAtdQ63DdUllPaORwkAJM/70Yeg07wys+bPmFQups9tMp+8aR4DG78dsOG5pzECeNym8WbFt2I8cqzxgnmzwP6jmRyoHhQm4VYebGER/8mYY7Qn/Y2d9BtR3QuSmDBz81e3vmp7U5C7JYlbODqLU9jM+nkppY9x18vH9ujil48MEDhFuQxnrGUnckElNP+hEcIHmumfcTu3ejz8tT4GX44eZ6LAThp5blMiTnFNqOL7MOVF3syWmaSJJJmwssnLDbrltJ4YERoZVHk2sN6M6d+3+38g7r8B9hSDuzlSK5XtaVRM60eXNfK/tmP+5S5rQ01wubPi8x8TWJDbY+EAEqnUwCtCCdE4yBlihRLsF9vow43GCQ7Ic+75MRbPZ7higvmnRYOcDoKEtoqNI5410ANO9cOoBgIOuemES7H/FNDTEq92iHVfLBOuu8si9mroc1B6M9I74yX1U2jhxsLfL7l1LgZYZsSp6SIAII=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6QCh+3B4LZsdWASkKEXEQAaJ0ED+UcF0U4GCBjOfLcLx75/9jnIUF2ARb33H?=
 =?us-ascii?Q?f6yeWP712AEZ8hFTu3iRTtyo6dD29WsVaU+QJzmRno9eY1M/Vg/669LNtwbC?=
 =?us-ascii?Q?ZuOIu6SpJkwR328H9X3H9uG6FhGqzui/ipU3JTej7VWHrA50niCyMr5GTVKe?=
 =?us-ascii?Q?KH6NX/OBYw67lydZnnWUa655l53PkuuOiy+GqpkDEL0GMwFCQf8jUPVxgmy4?=
 =?us-ascii?Q?zAEdFSa4hct9d9VTwjxSy97xHxyc/ydfRMOgqcHh7dsuxdg3A0+YOsyMSPA7?=
 =?us-ascii?Q?R4FrWp7QTj7Gq2eszmEb048NSQl1EI4iDQ79P9w5G9R8cqFIhK6PbmHBaaPO?=
 =?us-ascii?Q?5/1tt/1jGXLgIrq/60tHS0ecyf4eUfQLVMUAuEMilUSbkSXzj9YvSK+1cidB?=
 =?us-ascii?Q?kgxPnRR3oYdIf/iGj+eWMenWL5+y3q5ljq+FAaTrQYEgHq6GZvagYppK+qsF?=
 =?us-ascii?Q?jmu4LY8EtU05iv0jSxSG5lM+oTHm4x0K0cEFlh7yamDdeoViKFrGbsVXUzxQ?=
 =?us-ascii?Q?xSVjW7msgkXlRDPVO9yBYH0SuwjQrLfx2nFSgMMf1sooCezLVzC8W6e+mlxG?=
 =?us-ascii?Q?5xVJinD2wySbljohKwZJ1zALrCFOl0MIzAIqHvZtmpuIo0GLhYpsHuOpVbse?=
 =?us-ascii?Q?4bJIpTju3/eA4o4dQz3DNAaEa/krJwZTLqrP9ic5UH/UvfyFOjjX6+T2a3pP?=
 =?us-ascii?Q?OsMPsr4qd5QeqrzMeiBiBUOpRT5Uwm7TKUDAwe8vdxgMgqz1CI045XwkGly/?=
 =?us-ascii?Q?fbPC724c6+teOAo/FC7J+vemTthW6j8VqUHyUSeMHsJ34RV6AnXp//Sj6Prc?=
 =?us-ascii?Q?NV07xRBSnbbFZXf+Is9whnaUSmUb+HNaMt7mK6hniBNgp2L3l7BwVuUhkNDv?=
 =?us-ascii?Q?ZIYYUs8/q0303YM4C55p3XUBMtDEXYTPhd2SXacX2J98OV/jjzuw489a05tH?=
 =?us-ascii?Q?7Yty6BFsHI7HGIBMuMnr2WOUZDcnEhCDeBNWFMKgIaFkEKQunpVJ/BRlIVhS?=
 =?us-ascii?Q?aNWNhkSCWi6TTLYzLHD3Sjb965yODbIBaTqVOl8zQrJdEiX7RrOBdJ2G2T8u?=
 =?us-ascii?Q?Qtm41MVud/wYPkqw6AkPZP/LaBNHdC2NT/eWfTHiGVjhEHhT7+K2q5oioFdm?=
 =?us-ascii?Q?KtORKGsR/kYfxxW+YcA8+LdL7sSS6ur2Knw0gZKBL/F25xoX03IbAE8JUSqc?=
 =?us-ascii?Q?dBDaJh0CyOaODmT/B657u63mZvQThIuDkg7mbEPbvLfiOZpBbS+ekJL6lXvr?=
 =?us-ascii?Q?GyWo2l3817qlWDwQGlGcN1KNXjY5uIOFG5BWjPaICC5+mk9MA38BOuy98Boa?=
 =?us-ascii?Q?boK4xIpNRDq+6XSEoEqEoJnUWHgGeR/srdZLJrggl+Q5Geb7tMIYIVYFHmmJ?=
 =?us-ascii?Q?qmZHI46F/FzGg1ViPeMyFeZz9RGEVRivNSipjEFsPtFiPEDu68qFpsEPYZAn?=
 =?us-ascii?Q?zjSHEuaQLLWHSgFngwQedRmoY1kixidX4P/Gks+w427U/P+SStnzK6m1blba?=
 =?us-ascii?Q?XQlujQUyjS2rt1kxSjOCCDnQ1RX1FIc0NCIJJiRgXn2gmf+qIIFY5KtTNm0w?=
 =?us-ascii?Q?HSkyXCXxdzFnGT6wXrTmYANYJlqpCQfbquB1Usoj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e41e24-5250-43a7-18e4-08dc327ad4c7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:17:11.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yL3XbDf/mk345/2Zj4GGpRePm34LGu0jbT17qVuDzUMY4Q4pVgiTWc5QL9hYMB6T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

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
index 52a44e353796c0..fb81337a73eaab 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -249,12 +249,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
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
index 68cd551b6af112..fe12be9de6f7a6 100644
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


