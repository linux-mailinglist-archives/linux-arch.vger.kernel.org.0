Return-Path: <linux-arch+bounces-2535-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEF685CD4C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 02:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C022C1C228D5
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54571FDD;
	Wed, 21 Feb 2024 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1xDzRon"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282745CA1;
	Wed, 21 Feb 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478261; cv=fail; b=FvAEeWW+c1arMPDr1MJg9aPeHdgjFLvxUbqw+i4T8MZGn8284drrvSjoUDmjdTfGUJ5KimtzfUSaURjOf96lJjVQ8i39aZ+GIrxu+LC/1MHP6S8U4+Op7+xH5VvfUhqFsTzl5/bo95kZGkefu9PqPv1dGdnbYCBFPaCq2jkX6XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478261; c=relaxed/simple;
	bh=ADjX9ofpwPN0eGlm/Wkr4h1o2corjRiQaXNzMbzpS+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baAdMeTPfIpv8yKMeRexYQoPMaRMcNoa6EKo0cNgm88zW1WVvXjsNSOF2gF7l+9S6xg4xdM5U40uG79vcVy5LmRzaekiarRZtKlRdM9pkTDhEeBbEFgwtrrQqrpzAJzQJ+JXPyC2oNtfWKQGqXefPPhEDgSGGgf76Oke7azRTD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1xDzRon; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM6xmXTuPhpoXTezl3nyRFgTTu9ieZHHxPXfAphh2is8bOPb0itrxMfJWwhH9iX1MT+CobgoSiQjCbGKS99dh6pF1YpmYSWAoGlUMp9w724xZVx8YsbRP71BqsK/6OxVHmxTLmzrT0Qlm4fMSH57JPpLmXFTd4asHV7cmrlk91RKGfAnx53euzVf7orEQsiQSILiwaSR3AoM66h6a7HLX58UFi6uEso/Vr5zCSRLQZwa6LYYixpf34GdF28cSKZ08R0trXAVBiVKR2tiaIRCQAKQt4bb1ADkrCg0501mQDDZ5yHvgFKIqP0m/ghtHOn5jUJIi+UCJH1FXAxaXVdzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeUvBgwCcpebIW23s2L/TrJooqO0xbExf7wkitmek/g=;
 b=U7wAqpcpmN8nrFClkz0SrdLA6CT8ncmcEYoPu6y7RiYcVAQox5V006duEVUfGKbUxm6ndINF7qMaBgtlpcZpgUyJyjBReaQwLBVv2HhGg6Kcfd3zFL4zy3CR63xw3IdRP9RxSTPfR2ZsjT1/7crwmrJ17s1Szpu4YVz3ftaFNJkTrx5UY0jJCkR3OWuPLvzr7upUa14IEDQXw2mNPlvp0+3lHR9xHmjKiU9LYZwvV6qtEFI3G7b7oDP50uBngotXCZzXKX9arzjxnzK6V4Efnt0uYKQUSGGm8RuupPaacoWqPec/qd9YXr9KyKIdF0dilZAywRrGKz/L/zYiE0T5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeUvBgwCcpebIW23s2L/TrJooqO0xbExf7wkitmek/g=;
 b=N1xDzRondN5/j2fREWE+TN47HfeHVrRBpCZVH8fpWYB4hU4lKZJtPrkw3xvhY8MYE2zsEKcI3kkPiFhzZfqyRjN/9Rv6ADwaXED6PFri0eEqiC7zv9v1w1ve1LTdDWnzDbXJsQeznxIyrO5V86P0KhgHVMQ2RVtyGEj0JGyQx/RkvHIXmSYfHxvkAOzoFXNhZ2MtNFhZ67wKJmJH08yS77yKLYoSvI11V1NddLZekhpphqHy2sBjCjlpoQixJEWFWRqOrvR+nvgg7aTkFNdvBenEFrCM3xYxz64OksQ2bpCFgvxd9Yqeh+PU2lKBYD6Oad5pgkeYGeGlnxBYm2//QA==
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
Subject: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Date: Tue, 20 Feb 2024 21:17:08 -0400
Message-ID: <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8bb608-b44c-4789-e6f6-08dc327ad477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N0uu+jLwQteFY7HwpWZ0ppv8y9zJYgtCXw8ISzp4Q9pSpZA4O3hvT8UkOP0u0d9fzEEtzdmANIZT1pKbZGksT3CRD+an3+g6P2D3S0hnxDvIPeUD9uQqyd8qCF9ZM3+KhfLQ7ta5h3Gzt8ZIKDZPHQmWBBwJrXdTjuUxpo+pqdu/Xgz04/6ti+pqkZMsKaO0yF0Cc670hP7HTzYIWPenTyNd0KgEXsfIMF2bG1hF8i80nlAcwtE2m0nEWKF92XIA9jKJ6XFpQG/hRCw9v7Ng40v7PH1dOKmsORESU6qiS6Q2mE8BAIpKtQRt9g2ndm75BJB2Lx9EhH7nYnEkmIQ4HMforYtASggOlf/v9TGlZkfOdQwhq1A57yN10p1gBJgUwgoYz5+dpk15hOT03pCLflhIZ7fMK5VvaXGUF46Cf7q5Fs2mlvCH0LP41IbylHTMJgg3oGNd+IZG3p811QVUflAGf+BThMWvmzCKykRVo1bz1DNkY/cJGQ7lcdH7Q+kbwEAIakSqvFrSQIZdBE9MKe6/TpjkJ1Vj+CgCvpQ1xLrZvPsMbTGKP5e3GWLUCxIGFjfp4DLqZj7C0XZ0lwcOGDDds9aY8a1xVmMvUpOVpWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hpMUTpat2HTX8duJ3kVmO0MWjpAggq/l+skVbksfhjqZiHx+yoi4M2L+du7T?=
 =?us-ascii?Q?2JpdOlw9olYcz55REghDsc4halB3oOYHRIhCChTpGT8iKomINGiQIMd0j0WK?=
 =?us-ascii?Q?mMrN4UAC8+mu3TzHnBO2tUB+fdcUxAdTucnXZr8arTUsX48qh5uazPXY7Kg0?=
 =?us-ascii?Q?L3wujgEb7o9GFD2Dtdd6EKs9TaYqj+i9eRu7XANbw2wP0Vnjc3X+98AQdWQ5?=
 =?us-ascii?Q?8wsZ+Ts2XWQHuPksVp7BF7hW+VIHU5EHKCCOYAGKGFrehJdIdkFENjKx+sxN?=
 =?us-ascii?Q?tEvoV65qaEezOnjH2chR0OLfTwT01lZDkdX20Uzv0Tj/T7BZJZLh6BrFXnsy?=
 =?us-ascii?Q?s+qJ5YdOSduaIGcczqU8TIsHrnAPd5l97VlZmrIP/hcihOBQIwtOh1FobMnG?=
 =?us-ascii?Q?B7s/WHIC2cB39kquWsrlUBzvbVzFity5eNgiYja3ddV6Tss7cQUlZZONkb1I?=
 =?us-ascii?Q?prOvR9GyGAyBkqJiypqoi/A+fyfaKiBOJ0JOJ4D0MFq3x0prfl1e9cMJk9WY?=
 =?us-ascii?Q?e/9ip+biCgU0tAyXktRjHOJv031MNFxpnWPe9qgQa0bDG9YFZfRFrF1WVew0?=
 =?us-ascii?Q?0BLFj1WNTnzfEujiJdshSB4YtYw8d8OM4pbAyweqr8KuShyaoZJwa7qK8rxW?=
 =?us-ascii?Q?ojOA0iGE0qkQy6eKFAoa/xtEoKFLZ3SfDV3kgCI7QQaHdBs3u8+A8X2jPP8Z?=
 =?us-ascii?Q?Sz3+ZUWb1hzp3GxxbUl3LepNoWGNUZldhEbFD30Ez83WD+W3d0Gf8708k4aM?=
 =?us-ascii?Q?wadYrHuffK7R5Vq1/NYw39+pJ1bmvxPBDO72jKlvMWlQbEl60t0rrxraCMcC?=
 =?us-ascii?Q?1IvZB/OwcBUZaGtWkSOiMF1e6ZG3jK2ikGwL0F8nlmyBgryJEA7LyM1PEGSq?=
 =?us-ascii?Q?8uFs/+M/Am+MwlW9AhReI+vjZRo0L/ZS0CpX4kWPnOc/64re7244WfP7OqYb?=
 =?us-ascii?Q?vMPGCVIavN0meos2tCKPfUYGY8blPbHZIR10CPNo8awt47Q7U5/cc1EQBjVJ?=
 =?us-ascii?Q?pp2a9AKZ5/TMbBKX8C956nCd/yCyw3tHOv7RM85QzSFiK0x80sL1+T7cNaQS?=
 =?us-ascii?Q?7I2Y0uEK13P7p0k8y8+uIOJwMbLEs1UY1o8VYg+iPRzGQcarY/o/cKDGNRr8?=
 =?us-ascii?Q?d7g1AdqlpkEB1VYl4owt+Ov6Id7hhsfbPgi4+I3FcoZOn4Ek53B2Rs+Xn4z2?=
 =?us-ascii?Q?AOG1I1zWlJzZpFkrGcy+Y6gAgCfRzbzMmKz+fpPdLVhJ3t++d96kyk7HKf0x?=
 =?us-ascii?Q?de0v3a7vgmPGPcI9rGT++R/nDggotNZaTogEm/epbpg0LkXpKcNskHrMyImr?=
 =?us-ascii?Q?/65z45AMXi+9Z4NMgqj7vFgJGV/k6Wf5k2noasAP66iW3GnzapWYQWxwp0QU?=
 =?us-ascii?Q?zUAsdNESBIeU5i4byzhj0CL44j31ef3kYRvrjnQuOFeZiMT53UqijD60M7Sz?=
 =?us-ascii?Q?N6MLhxQyuKHMEwUeFRZMBKShg6bBJA39dpMZKG+jMEW4IlBJFvd8C0IgyGRU?=
 =?us-ascii?Q?QMl0ofDSGW0QFNydlWvErhHk0UMmt9r/pQodA32o69Q03zxskrHkO6FFUpVu?=
 =?us-ascii?Q?O4g1oKb2LxOJajGG81yTPYFjHEJKycDEqWMMZK0U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8bb608-b44c-4789-e6f6-08dc327ad477
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:17:11.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tt1ppLxSslR0zCEME2szRXW8B7PYk7hVyxFuDt2eeeTIscZJjY7DnJm5cpF/TyaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

The kernel provides driver support for using write combining IO memory
through the __iowriteXX_copy() API which is commonly used as an optional
optimization to generate 16/32/64 byte MemWr TLPs in a PCIe environment.

iomap_copy.c provides a generic implementation as a simple 4/8 byte at a
time copy loop that has worked well with past ARM64 CPUs, giving a high
frequency of large TLPs being successfully formed.

However modern ARM64 CPUs are quite sensitive to how the write combining
CPU HW is operated and a compiler generated loop with intermixed
load/store is not sufficient to frequently generate a large TLP. The CPUs
would like to see the entire TLP generated by consecutive store
instructions from registers. Compilers like gcc tend to intermix loads and
stores and have poor code generation, in part, due to the ARM64 situation
that writeq() does not codegen anything other than "[xN]". However even
with that resolved compilers like clang still do not have good code
generation.

This means on modern ARM64 CPUs the rate at which __iowriteXX_copy()
successfully generates large TLPs is very small (less than 1 in 10,000)
tries), to the point that the use of WC is pointless.

Implement __iowrite32/64_copy() specifically for ARM64 and use inline
assembly to build consecutive blocks of STR instructions. Provide direct
support for 64/32/16 large TLP generation in this manner. Optimize for
common constant lengths so that the compiler can directly inline the store
blocks.

This brings the frequency of large TLP generation up to a high level that
is comparable with older CPU generations.

As the __iowriteXX_copy() family of APIs is intended for use with WC
incorporate the DGH hint directly into the function.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/arm64/include/asm/io.h | 132 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/io.c      |  42 ++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 3b694511b98f83..471ab46621e7d6 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -135,6 +135,138 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
 #define memcpy_fromio(a,c,l)	__memcpy_fromio((a),(c),(l))
 #define memcpy_toio(c,a,l)	__memcpy_toio((c),(a),(l))
 
+/*
+ * The ARM64 iowrite implementation is intended to support drivers that want to
+ * use write combining. For instance PCI drivers using write combining with a 64
+ * byte __iowrite64_copy() expect to get a 64 byte MemWr TLP on the PCIe bus.
+ *
+ * Newer ARM core have sensitive write combining buffers, it is important that
+ * the stores be contiguous blocks of store instructions. Normal memcpy
+ * approaches have a very low chance to generate write combining.
+ *
+ * Since this is the only API on ARM64 that should be used with write combining
+ * it also integrates the DGH hint which is supposed to lower the latency to
+ * emit the large TLP from the CPU.
+ */
+
+static inline void __const_memcpy_toio_aligned32(volatile u32 __iomem *to,
+						 const u32 *from, size_t count)
+{
+	switch (count) {
+	case 8:
+		asm volatile("str %w0, [%8, #4 * 0]\n"
+			     "str %w1, [%8, #4 * 1]\n"
+			     "str %w2, [%8, #4 * 2]\n"
+			     "str %w3, [%8, #4 * 3]\n"
+			     "str %w4, [%8, #4 * 4]\n"
+			     "str %w5, [%8, #4 * 5]\n"
+			     "str %w6, [%8, #4 * 6]\n"
+			     "str %w7, [%8, #4 * 7]\n"
+			     :
+			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
+			       "rZ"(from[3]), "rZ"(from[4]), "rZ"(from[5]),
+			       "rZ"(from[6]), "rZ"(from[7]), "r"(to));
+		break;
+	case 4:
+		asm volatile("str %w0, [%4, #4 * 0]\n"
+			     "str %w1, [%4, #4 * 1]\n"
+			     "str %w2, [%4, #4 * 2]\n"
+			     "str %w3, [%4, #4 * 3]\n"
+			     :
+			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
+			       "rZ"(from[3]), "r"(to));
+		break;
+	case 2:
+		asm volatile("str %w0, [%2, #4 * 0]\n"
+			     "str %w1, [%2, #4 * 1]\n"
+			     :
+			     : "rZ"(from[0]), "rZ"(from[1]), "r"(to));
+		break;
+	case 1:
+		__raw_writel(*from, to);
+		break;
+	default:
+		BUILD_BUG();
+	}
+}
+
+void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count);
+
+static inline void __const_iowrite32_copy(void __iomem *to, const void *from,
+					  size_t count)
+{
+	if (count == 8 || count == 4 || count == 2 || count == 1) {
+		__const_memcpy_toio_aligned32(to, from, count);
+		dgh();
+	} else {
+		__iowrite32_copy_full(to, from, count);
+	}
+}
+
+#define __iowrite32_copy(to, from, count)                  \
+	(__builtin_constant_p(count) ?                     \
+		 __const_iowrite32_copy(to, from, count) : \
+		 __iowrite32_copy_full(to, from, count))
+
+static inline void __const_memcpy_toio_aligned64(volatile u64 __iomem *to,
+						 const u64 *from, size_t count)
+{
+	switch (count) {
+	case 8:
+		asm volatile("str %x0, [%8, #8 * 0]\n"
+			     "str %x1, [%8, #8 * 1]\n"
+			     "str %x2, [%8, #8 * 2]\n"
+			     "str %x3, [%8, #8 * 3]\n"
+			     "str %x4, [%8, #8 * 4]\n"
+			     "str %x5, [%8, #8 * 5]\n"
+			     "str %x6, [%8, #8 * 6]\n"
+			     "str %x7, [%8, #8 * 7]\n"
+			     :
+			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
+			       "rZ"(from[3]), "rZ"(from[4]), "rZ"(from[5]),
+			       "rZ"(from[6]), "rZ"(from[7]), "r"(to));
+		break;
+	case 4:
+		asm volatile("str %x0, [%4, #8 * 0]\n"
+			     "str %x1, [%4, #8 * 1]\n"
+			     "str %x2, [%4, #8 * 2]\n"
+			     "str %x3, [%4, #8 * 3]\n"
+			     :
+			     : "rZ"(from[0]), "rZ"(from[1]), "rZ"(from[2]),
+			       "rZ"(from[3]), "r"(to));
+		break;
+	case 2:
+		asm volatile("str %x0, [%2, #8 * 0]\n"
+			     "str %x1, [%2, #8 * 1]\n"
+			     :
+			     : "rZ"(from[0]), "rZ"(from[1]), "r"(to));
+		break;
+	case 1:
+		__raw_writel(*from, to);
+		break;
+	default:
+		BUILD_BUG();
+	}
+}
+
+void __iowrite64_copy_full(void __iomem *to, const void *from, size_t count);
+
+static inline void __const_iowrite64_copy(void __iomem *to, const void *from,
+					  size_t count)
+{
+	if (count == 8 || count == 4 || count == 2 || count == 1) {
+		__const_memcpy_toio_aligned64(to, from, count);
+		dgh();
+	} else {
+		__iowrite64_copy_full(to, from, count);
+	}
+}
+
+#define __iowrite64_copy(to, from, count)                  \
+	(__builtin_constant_p(count) ?                     \
+		 __const_iowrite64_copy(to, from, count) : \
+		 __iowrite64_copy_full(to, from, count))
+
 /*
  * I/O memory mapping functions.
  */
diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index aa7a4ec6a3ae6f..ef48089fbfe1a4 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -37,6 +37,48 @@ void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 }
 EXPORT_SYMBOL(__memcpy_fromio);
 
+/*
+ * This generates a memcpy that works on a from/to address which is aligned to
+ * bits. Count is in terms of the number of bits sized quantities to copy. It
+ * optimizes to use the STR groupings when possible so that it is WC friendly.
+ */
+#define memcpy_toio_aligned(to, from, count, bits)                        \
+	({                                                                \
+		volatile u##bits __iomem *_to = to;                       \
+		const u##bits *_from = from;                              \
+		size_t _count = count;                                    \
+		const u##bits *_end_from = _from + ALIGN_DOWN(_count, 8); \
+                                                                          \
+		for (; _from < _end_from; _from += 8, _to += 8)           \
+			__const_memcpy_toio_aligned##bits(_to, _from, 8); \
+		if ((_count % 8) >= 4) {                                  \
+			__const_memcpy_toio_aligned##bits(_to, _from, 4); \
+			_from += 4;                                       \
+			_to += 4;                                         \
+		}                                                         \
+		if ((_count % 4) >= 2) {                                  \
+			__const_memcpy_toio_aligned##bits(_to, _from, 2); \
+			_from += 2;                                       \
+			_to += 2;                                         \
+		}                                                         \
+		if (_count % 2)                                           \
+			__const_memcpy_toio_aligned##bits(_to, _from, 1); \
+	})
+
+void __iowrite64_copy_full(void __iomem *to, const void *from, size_t count)
+{
+	memcpy_toio_aligned(to, from, count, 64);
+	dgh();
+}
+EXPORT_SYMBOL(__iowrite64_copy_full);
+
+void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count)
+{
+	memcpy_toio_aligned(to, from, count, 32);
+	dgh();
+}
+EXPORT_SYMBOL(__iowrite32_copy_full);
+
 /*
  * Copy data from "real" memory space to IO memory space.
  */
-- 
2.43.2


