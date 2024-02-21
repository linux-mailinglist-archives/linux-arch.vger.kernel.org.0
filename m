Return-Path: <linux-arch+bounces-2538-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB16E85CD5A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 02:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0F71C2288F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A57464;
	Wed, 21 Feb 2024 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTo9Hzqm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20063AE;
	Wed, 21 Feb 2024 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478265; cv=fail; b=KTPvFziJe2xVniZMgQwZjwxrCfc2doxQIkhnABPy06IcA+YkP2207s8XbAB8pfCc3SQ3T8HbB6qP59A28DiCyJxKdja+JANlSpAjYnZsQTzXb69Q4F+ATKsw62oihRKvVlBC1Z2IKpcxYHXlavsA7AeIMNBl3lr9lcm+CCnxOGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478265; c=relaxed/simple;
	bh=cIUzCB9Zv5RQ30ak8JSxkwh3fheJ9oWeXsNSpGVu3tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baQ2SHdooO7Ei9jlQIOkJ8DBlwFGBrYWZOWXnTtETPpLtE9Msuj7MBaX0EAxY+gnd6fLgWjkZjgroLcY4kputNw6P0wy1wk8BflaJRItbrP0ZMXAyJ/MR5jrqAF4dK6Ek/qPQKgCTgeaCwiLyf/new75NtjJ+IfZkA/x+DVQBGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTo9Hzqm; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu44itpysA6MKOHG5dqg2EpZKPfEhh8fsjXxfllOmptnlZpXAkIxfJyUaQVQrK2V5TvGdB3OfhMoD4HxbSCsu3oJctdvIwJ+3pTKFHCK+g1MbwqNIXQmh4E/DgJPjtv9aIK8wIIQp0j+wE6BFl+mMB748F1+pD+IcaNR/VGlRtkRugAXnWyGQxwTE0PKiOdEB60Szl84BFNhfKjeLRVUZ7J8ZRl9Y7QrbNbNbHnwbdSXvgIEtOcihmODXbJP4xWjGzIDFgVMEqNUp7Z3V3td1TINuS5F6C8HyDmlzxFyVZQwYID8NFNHEugo9CV4G2qHwcGRlTAGqOULzV/5vA6c1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T73MyyVmjQxk598poK2sg47B3XiSs68eQEg/tDbSpMw=;
 b=DkQ3DgWdjfkAwsBPWeioYBR2NPP98w4aHwNE/t7SoFvpIyCvri3dk2Q4PHUjsFQRhnKvplwWMeanM3g0uVXQRQfhq1Me3qLub97lbu7rE5kSNTwYxp1iE5Eqz4nR+UZXSkn9xYY7YAtbbzF0stJwqHGkR8YJH+VrLRn1XUjIwgBskq/FMKMAN1vrothHeGBVFkiVXwo2EG/vsW6pcYNedjoT/cjHHfKb7x4QTbFGvHnFmpQgh9f1v0IooW+JCLkDD7960Oa2Awk6mfr6a2b1lLr7SVHcNbWFtkZ9uZMgzsY/Wa5QR6Dv7QMD9jsvJ8GpWbEjq2hgH9+FaiyKUuYlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T73MyyVmjQxk598poK2sg47B3XiSs68eQEg/tDbSpMw=;
 b=DTo9HzqmZM1AGykT2yFC3c71fOz66fHk9t8odayR/d2YYRyPvf/RsLNw0GYams+ntkpVxCF8ntvgO3NTyD1lTXJVkgILK5CxWC/wMCblWESEhH/M8xABMYGaQZmx6eQgnlZbesPE8ySi7QWrQMDc5/El1BIq0ybq0vp/uKDTN46c+gHS2G5N5IIPhKKT/gW+lxfkDrE+p/Q5Ie3v9843Hk67icUyQ0WkIMx1denlymJj4G4oqchUCv6S+6XlueXyqBInc+dCik+2HDmItBcQtcw8e5PgRO1d5CvXQ15MX5gaf0BL3unkLZQjCkaOlpR+3ZwZCZeGJmnfqRik2fOnzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 01:17:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 01:17:14 +0000
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
Subject: [PATCH 1/6] x86: Stop using weak symbols for __iowrite32_copy()
Date: Tue, 20 Feb 2024 21:17:05 -0400
Message-ID: <1-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 2382273e-caf0-49eb-e778-08dc327ad4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fof1/7hPJgq85HlZOvdeyTNRI63XLJ8gm1vgWM0MeSnzmvbST2u6olyzwVpjMCLIRsKG2Q1jgYoJzr5/FDLsqygzZp/eiJ6n792qd5RTeP0NM7XnvormHfnZzncrdlkEYBvUapijKi1P/tG4HIbCKAQ6hoc41IJYDTdkqIjgwKxJw8a92OK9mFD5x67tPi/ogXAcnuIPiRt2ZQ9Br3WE9cezGqDSauhdl8zUgRGQ0cDhhN5r5AwjjxlwyQlwJOjtTxt0Yiolc0DctwlcyvGxDyTtoHtSu6HhN5JpxPkdJw1feGA7XIfcuX5gppoGnchZFBKWfUgH56Pfnn/pptf8NCRt1mIUmE27EiJNpzTuj4Y94mr5MB1S1hkc4LUP5+qP4Q8hj2Rem/2VWWIg3JGg27ul/RUw9pAksGNkyavcQxWq4FYzeTRAiMPt+YMuLy4oJ27H8XtVlH/VhJt2If/OjR0VsANjEr6+Mj4ydzte9rTaHWKa4Lje6P98uJwwknySpBmo1agOsivDZ0VkVM/EdDUHpzK/isp+gpAvuzgtRHNAw7r6maNb9VnkOEGpowMb77G0yorWLSACpaPS/w9Hgi98v2z6Bq9pegstXniXIyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbHs7xuZIEYRHsHORUssNSBw6nAtyQnTnwc2IJBcyT/S/ID04o2phiAaByyb?=
 =?us-ascii?Q?ivXA2/U5+VrHqhug6YrYloBgqdUgeZPoEDAtyMJG/VbaW9jT5oh9WhlSkYRG?=
 =?us-ascii?Q?rSq93lYzqWlGx4Sr0ck+TGDXxNtbGtzgW50dgd51R+sjPxq5qj+boEIw46in?=
 =?us-ascii?Q?1L5AG7SUBBbzvAXnMTcRQ4CtP+SrPaxdqTPzW6C1vgW+b0ahbos0KHYNZsD4?=
 =?us-ascii?Q?kAAs3qMmY7l5GroMpY2dxhku32t5aVM7vA1q7t/TbYJLeNqhvul6sGXKLx07?=
 =?us-ascii?Q?L/fUrFVNt057FIp4AFw1DZKbBAMH4b6yS2lPAwegogZIxPuADa222gcKnxZW?=
 =?us-ascii?Q?bGC9xUN1+QHtlYwsbITiHwoLz++35k3lCSKKU0FG9REJkqiz1J06ZEhoOtkf?=
 =?us-ascii?Q?K9BmPRTsoH3rsyfOhYkVum0XHj/8xD7ELSZZlhqFDbjAnL9litoyAQR3H/Tw?=
 =?us-ascii?Q?eHy9+Odr7dl+5eC3kwqITfuO3eQR06dLkj4ikQS7XTFG0RXE+fQIHVoNWPP7?=
 =?us-ascii?Q?pPz0TNti0tsTI1u2BAeMnrZXW26v22z1Xr1UU8bQ50Etht9lmuo/9DbCDUkA?=
 =?us-ascii?Q?2hjTIc4Nw78sLheNgDXQi1g1KICuIReoH7AVImoE6jknGuUrNvopqOALM0z7?=
 =?us-ascii?Q?puO7tM0d7sPMohnloRnp0xk4rXb0ppXkthnxpaAGUKDNMK8IoRwS135ds3Hp?=
 =?us-ascii?Q?LIqRSylCE8EN/t+WU3ue9kYg4EnvWFgimX+ObreExqAgpxUAp1dEgXMF9o3h?=
 =?us-ascii?Q?Dmf9u2zEqZxNRkmBvfScG5QUJjGd4vM38HSIukZiizeJm2TtL2ht2/LKMBlq?=
 =?us-ascii?Q?Bu8rinspm16Dlq60lk72IgQBxBdmwLUb/ZLpWHulN02XVWoncP5D93C12qyO?=
 =?us-ascii?Q?UV71PvmEHcusLGwbqCgTwYUTib2Vc1ksIKW7/hqr3TW7M/a1ZgWl3cw8Vt96?=
 =?us-ascii?Q?+H6CIpkcl+Zqogzmcvc2joyPHgjELFpD4kL610Mw3fJAa1hReeZGWaYT78sd?=
 =?us-ascii?Q?g9OcWEROQvPr4Ypv1ek54efrJSw/eD84OyB48wxnfbSecTgQGD5DLf7RValD?=
 =?us-ascii?Q?enKG5fdeWpFjlHl7ogib2Un5yuz1k6r8F8I0bsrPXXvkhKqZ/69owSr63g3W?=
 =?us-ascii?Q?k8XuKgF7x0KOD9SIZxY5wrJUHVlAGbT736UXZZnVAHtjRK6UjfZdcBiky7IB?=
 =?us-ascii?Q?nQwc/FbEGJ9Nb/HL7uKhq7oZtUEQ7Egj+U7gQwlStNh/AaZ1QqdKKh2OkWRZ?=
 =?us-ascii?Q?G7HyFFkFM0DIJr5R9tq8uq/zCW+zfb/x6od6jHI6mXnvr6YU3ypkkIrkoh+C?=
 =?us-ascii?Q?N1z8TBvjeU3NBwFVTTRauRz5g4dq7rWjcvw8E+nGAXOfdTi/UGfRXVeRemGI?=
 =?us-ascii?Q?/kGWyKge3v5PhHdiPH0KrEMyhZ9HbNI5vJHnAKu4qm0sDNpiDz1p/8W4I1vg?=
 =?us-ascii?Q?0NDmwjyxD8VdkderiFMjfptYhbDBnFelaEQ/PQEg111AraZA5ot9GAKKywF1?=
 =?us-ascii?Q?mhOB4DE6BYIhnIqrH3TZ7lVH1ElElxmJeTRaRTBoYH9axYsH1wUlNIrGY0NO?=
 =?us-ascii?Q?tLey/fWB/+wgOL1nH4qjrdqnTIEXER3Nh0CtzXU8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2382273e-caf0-49eb-e778-08dc327ad4ec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:17:12.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU7t9ar6pCH4LUBnlF3zaqOHNzEFN6UzRuKx1AqOmRdkwBy9hiSLZM/kvQ1pHSnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

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
index 3814a9263d64ea..2483988f0b7f7b 100644
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
index ea3a28e7b613cc..af4ea3d83ba1f6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -66,7 +66,6 @@ ifneq ($(CONFIG_X86_CMPXCHG64),y)
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
index 7304f2a69960a3..68cd551b6af112 100644
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


