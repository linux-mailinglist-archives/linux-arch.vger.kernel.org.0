Return-Path: <linux-arch+bounces-3596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430E8A1D02
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127EB1F22A55
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5FD1C68AD;
	Thu, 11 Apr 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5b3yzMw"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037461C689F;
	Thu, 11 Apr 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853995; cv=fail; b=NQXjK3ZsiadK7OsHs1fvX4J9aBqmpOGOvSj77kyEv27DXQvpcZnfxgBaMdM+KULJVUjo/hySVVn0YxCcdv6wA2br17BmF2seXMHtDdXFCse9AFodSDHXKg8+/gzeMHE3nAOJS1drTVNJ2+/VVTZGDlIRmdphz8evrn7vCYK0TgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853995; c=relaxed/simple;
	bh=NOJg/hPWHhcWU41gXULSFdl2k7IGpgNTF2ccfXto48c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovpMYzH9oBOaYUbVQhpeayyHzGAIBvEGidH42pTM5srRMUaEN+l1pYrHGgAg9Z+AqLvXMOq21fHP2THCgIc0XY3zvZHCWZqijSGcTxpoBRMlI9CAIZfu1OjR3iZ0iVUIK87V19wyu1zIhbTeqtEbNFMYnl6iE7OQE3/ViI+IAS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5b3yzMw; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJEMRd1Tx0CtllvCZUIu6q7Fl4LV4yJCj7nzJuH8p+EzuH/jMriR/JT3rq0zAx7OnOS0ZXGU3lgYQKYQkzvYv3L5Je5n3e7uUGbXn4tp12fG55ypLj736xhjjau9FCsSyQxSlseVvw+7HtGy3yqaYeOWzskauPr1bLVjvRqTzN4wJ4tpaDgcZYR4LgrpwOMwCCxOORXqxaZZPx+e+Y0ibJ9GOXWFx/GCekE7phMB8kMg0xz/B/oHJSwVbTBGV8wfpfSUB8EZ5v6jcJdP1hwd4SwYF4AM8dqY8DbHxIAv2opR76GOd8Kk1LQaNqal//R9//8uMLn4H+ZE4EUv5zJHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdkM2UeXpLcuC+zg1KbbyqRpkGfk4PfuMlT6xAklK9E=;
 b=Y1kL+svoKTmo08Ir8vy2mQ6rUWm1Q4n7WYM7c4oEfGz1X8vfXGrN6NclA9fhlPu47KMbVYsv34Hv9hOdxHO7tL6AkG1SoHTRVuNTyb1K0f+kzEixUVUfemgVIxkulMwwKCHkMD3CLgrGGCDxYKa0bXOWi7tjP0zWUxH5LZXFMdUnC8VQRux1Jguc3CC1S+qkDnUQRehFwUAbbRQ4Rhh0VEysYYmZBgxYfkhLrU2GcXOLVq31NNie6IokR1LX05rZiJKR1myFFPoGRjznyANKqffzfj1fhBPHbDS0GAz8CczJtSY9fXQIAwMlK8hLlfR8Fm/dEFLo415XcLQbS6B8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdkM2UeXpLcuC+zg1KbbyqRpkGfk4PfuMlT6xAklK9E=;
 b=d5b3yzMwZp2PfMPIDS5x7ziKGCf4mR8hJ+OGbldd51xr2V2qPfTgm7T2ACF6oCQjsEmvW8i2/Ic6AlcmWyzf8qpIIohGoovG7SiiffvBPzlLWy9aLI8+5SiYoIcUiK/1Xd6VFJwp64PPaiRjIPrIb9flM/qmuRB0X3antaRhKjpCppBhZLx0gMBQChzm0b7FgDD21cMxrmFrupigbqrY7SlWFkOfHwTQYAg0yQa2X3cUB7QK+20GrndVdvQlRBuk9j8IogxYrHwW0HUravuz9t7Jgba3inzsBdfwVNBtcr2ep3t86gs1nH4DRikmjid4oMbqdyltgAGnugGynPd5tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:46:21 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:46:21 +0000
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
Subject: [PATCH v3 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Date: Thu, 11 Apr 2024 13:46:17 -0300
Message-ID: <4-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: c64ce94c-f38d-4ded-fb14-08dc5a46ea88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FrMUx/egIULNisnlgtTRQjHeUD1fYlXWH3Fr+pttxLHUwtbUq0OXKk/91UfBuXlJjr/mUtrkpdZtgcpxBEsHievATJhHWv/YyU+b0PIkqBtx3B0ACFWsNOlyVZ2rW1ysIUfg8eHuRdAozlUtyzOb4J3bpFDThnsmf3s1AKsnDrzivNTeJHKbjl72pXAW3LxLpYY6ZjAWpXI5LL65bs0FgCHU/INZj82XQAjiQ9qR8nhUCnrL28KLHNye7j9lQDM1Fia1gj2C3LWDxbUF/gsvoykek8ay2OI0HaMCXA4x34SG5ptWQ4ukdrIx/T293QlI7Tt4lMsvnP3HZ0kHaWp5MiyDv/QkeIAGI0SIaYaN9qeVYAZuVmqoyS80/WmgJxE0OtClX4el1KuBUVXazfNidHJvHBMbGTcm4gmo/pDlmkwk6YgnjbwAm7pxoKzDkf/UU+nyu+0g5X6cRQhu7t7/mfIMU2sTuC8OydamA8JlTt4tw0swapwNi/uAetrmHQr+O1V/NhhGNwox5MiCYKK+CwiDBH6+B7ABb5tcBVyvVUzZuNP+iBda15lnWQ93uyMSRmWKPUJ4C3WUXleJZ7kr0dJE+Us3F2lOncQkp0ULAJiiGbzwn7WDfuJWOBAlxWkX0sLggsN4UoPmEsGYrKYWaWQiFup+fKjX+aNA2qIOG3Lt4dvt34Yx5Vu/BDLmQlaCMsEz3+hmD1+eMSV+ljSHaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Krto3W5Rf/xWe+ysl1hDaR34+oixAHavmGDs5wLMd0ZMa4niOyJURnoAqahj?=
 =?us-ascii?Q?mJMSHarihLYcUwKaULISaCgS/iNTIoAhzAgNn6weeEeLX0ZizeibithMpXHX?=
 =?us-ascii?Q?DiwNykXWYeuCg1PzTPIZgdoD7xZ/Qamm5crxTE24FOlg8XOtL4tQoxFzIAYG?=
 =?us-ascii?Q?e9PT8JbmXeReVm0mRbtbTpUKEiLcMZ7CMP5/ffjf0JwsV/pXyOeBt74fP1EJ?=
 =?us-ascii?Q?8jzWPNmafggVRfXh8qc82jxl/okACa49tmFZsiir0ToQzTOAEcGdk02apxvu?=
 =?us-ascii?Q?wpdSQvNvKE46wNxwYb5rijbAtI/B8RvHCVAAcWKQtHBZ7rMhR4eGzXxUe3Re?=
 =?us-ascii?Q?b0Paoy635dX4zRtIAWk5rGDoL9kP7Da/1LGqAMAbjl3OORNxR0ErIj3XDuWP?=
 =?us-ascii?Q?E8VsGc6NgC9ZO459JtEOOlDb4Hlp7rGU/pnP+VVUDJXUh1Oz+Zvwq2g6J5gQ?=
 =?us-ascii?Q?tf9toQvTKQha0Jn2ixoUbNFbYsYtOsRR2OXrhKo6n+jURNHR1csXpqjVQVXS?=
 =?us-ascii?Q?MqPtUQ++BY/i713oZasIom6ORZiVuJunR5y20gEukUwIdxbW7eDJa/voSZg7?=
 =?us-ascii?Q?7NUjW1GAL5Hr0tMWkl1LeEY8JFrVv3gN3inqrSik2Pd8Onz1rUoPB/p8yHfb?=
 =?us-ascii?Q?1R0fJAvNJIpXgoSdMNB+uYzHujAiZEix39ZWrmIDRk4uE7f+7Ptr9/VELcvC?=
 =?us-ascii?Q?VDsYHX+4YCIuydBiVDUl5upv2HsxyaYEd3gBETxaaaNQn6y5B8sVP5GlgKfQ?=
 =?us-ascii?Q?8V+exsCkrvcKqp9P79tK40fawz2yT4OX/w1gOdU89GKyxTK2HHiQ3oyL//rK?=
 =?us-ascii?Q?tziMirnGgtxq+1k2vX6WZU3xzKA6edVrVjkgEnQrJNPS2BBFB1dhEeP0lpog?=
 =?us-ascii?Q?lxVY0PpAIZ9MDMxgQAwaUVRdNp6YlhK1cJLede5e0RGtZEP9zc/7XPZ/igsV?=
 =?us-ascii?Q?zQuhK54CfP5YdA5uiDXsv9qiY8nOdxlUDzzSCrZ2Z9uZCnKuRpCbZ6z/8t6T?=
 =?us-ascii?Q?G1IKCM45TAMKq7Qvz0ul6bA1G+A5V67wyO0Tw2WSUIGqZCjr8qvhxEn0b69s?=
 =?us-ascii?Q?Sp2lq/QOjRWWRgjsNeg2rpNbtl8O/CJKdeVkTBJKvQSIVYunfRgYcGUTYxsc?=
 =?us-ascii?Q?ejD2XundUAaAiFnY31XHweJs6yd1kKc+MqJqcHKAfdKJw8MuOZlC9Yh3I8Gz?=
 =?us-ascii?Q?aIaY6LhTTZBbv2O1jh4KSNs4+1UYcb9LMFG+MfodUAT4CRUe72OBTEUN9tlI?=
 =?us-ascii?Q?yeQEmWSXf263yy8Az4tDdAAacwHcPIZkgFRZsBX0kj8tCVDm5ybjToIyql3i?=
 =?us-ascii?Q?iBsgfZYeZFGupAmR6WyaS1O0MaJJUD85nrVKsleQKxjcuUVbS1ceUGcbTQD0?=
 =?us-ascii?Q?SL7DF7nAHN+wdlw6oBOu0VuUcP/jKiJPXgYnfkFF1Mu0pY+hbEPDMoZFeQ8Y?=
 =?us-ascii?Q?q77FtjsSWPxbPhSMxqxNCQl3z5hMLTr5EIyZ/uHXOHS681mct4UnhlTsLukp?=
 =?us-ascii?Q?LaAtYVbhVJ0Hoj8FGkXxGiaWbcnPHrzjDIEDSh3h2sBeWaCettXLRM9eDLKF?=
 =?us-ascii?Q?aDJPipo1XqeX9n706nZ+EolJux7tSvBNyNQND+vp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64ce94c-f38d-4ded-fb14-08dc5a46ea88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:46:21.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi1ybZbh//lOL0sZX9HUsV/9B1EQ+Exz9d3YRFh0s+znvjJKJCAlW/IzA/7aT8wJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/arm64/include/asm/io.h | 132 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/io.c      |  42 ++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 8d825522c55c84..4ff0ae3f6d6690 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -139,6 +139,138 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
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
+		__raw_writeq(*from, to);
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


