Return-Path: <linux-arch+bounces-3598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700278A1D09
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856F11C22727
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE11C8206;
	Thu, 11 Apr 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCkKbeAI"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888671C8209;
	Thu, 11 Apr 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854001; cv=fail; b=ngeGIyy/eEflgEV0m0a/UjArXpMIV+kKwaxuAPibhhmAadKfuValQMOea+YU8e+kM5ET0yHYijvyDoX/UMQWI+rc96yfhqPc/XYDtQmSNE7+CU4pTvZta2Ednpxpj2Ss4ClxHWcKgARnQlRQHecUwys59As5ILM0aTiQQB2TRJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854001; c=relaxed/simple;
	bh=UvNRReKimtoocRwemASlh7LTpPqVmyVN8CX+j4Q3nG0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tUtSdBAKNUHwQ1Wyq/UlevkCrUgEgbxvO/C2cUyeouEuXa+WnPzba2SFg8BV7YzNzO27VA6fOKmxTfEO10JCr0u+O838N1qTCPmokPiXdrLvKDdQ1/347vY7tpnVdkl9zmXzlsIs2r71sh/dWL4FArk4ddXhqGu3PeNNG4+tYP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GCkKbeAI; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbABDfPcvoBQcaIZMLVAluH8LT5prIo6dFqA2JAaMsBFf2mY3T8HLo3xG8oGzSCmmjC7PBESq7p9djXqyd68+1TIELh6m7egsvOZCf1GAEe9ELLR088O9194CIKuCHKuOpOx/1LiQAtILQ6l50LmChlqooIQdYcNKr6UwOG+xICek0K9FSC0ydeX41nRpCorzFFAEHkT1DOFC2OTnArh+5xK/kqihfd8y9i7+5sfPSR3vskGcKFj1qi/LcBvYt2oQ2jS1evO1SJftHHfoKVJ3c6QB2Ev+iKqXdMZQ61uhomihmBxz0GFQt/RfTT0yeo7RITWyrqAyb3aP8cZ0BrU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TSfpHJuRZgnnF4JHPfetCgyobUxlxswrERmKm2ZCKk=;
 b=hZhCeDgHMQi53CjhbAwuwIoJ3WYjxbVxyxPdjdOlmo1Z7VCVUQL+9RSk4SAtIw1e+9ZP0V4Txc7Ce8ZM/X2OJBmyoD1QX/4+M8+lE9ajP9981Hh1g5CHVq4F1bxLJx+MVraDylJzC909oYsqRPfbqGMWX3JBgPAL+DwAmGd4Ky+JWHxWUpqhGJ+jFuzTguepBM3Hjfi0nZtEIN2PevLJsHcMNntil7j6ttF94Qf2x5m+OV8TSLsQycbQqrdfTCzpGeQa3Ses2hE/vAoUD2LtwOrW/kNf5mmqOYchATnu4lZdSFOTHqdI9sKdzlVx86GH81UpOBMUfObOUl3/96IuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TSfpHJuRZgnnF4JHPfetCgyobUxlxswrERmKm2ZCKk=;
 b=GCkKbeAIEXnt21pK4Re1vy1IkGgwr9B7O/zdcWAVHABILAI0Cz+zd1amGvZDnDG8wvhINqyEvAanquK5/Z4iL3FEWeGxBO990/DNe0MAoIqjO3VI/AQwFL8RGxXFXtqUiK7eRHvw1t2js93WVIOxNxfXjYLKdBMGfRW2iyUJQW6jdvcERpLTPa7lhxL51eX0SiKLdLjx43EWMrPdFw5lzehKjHezA4twv8zk0RL46xEVT0JmIyrPs0g4uyQgR8PJBHRuhWqxByjc44ojIOfpPfsGyAMypN9QKSu28ZeosEki6pasnlXLAj1NK586LP8aiKy3HZzU/O74ZC11DKYZhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:46:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:46:29 +0000
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
Subject: [PATCH v3 0/6] Fix mlx5 write combining support on new ARM64 cores
Date: Thu, 11 Apr 2024 13:46:13 -0300
Message-ID: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 265e108c-8a7c-49ac-5c50-08dc5a46eb56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JA8EFwCK/RO2ujwGJEToskV/XqLTM90iGcNkOTWMp+kmwQhjpuJxGUjAoF54WAGTLBin3QCVN2yf2VGlR/eTaBEJ/qtIwkyWrWeRJ9ac4h07oMKgwYjWrGDLUlO8W5E/M76keBDjOViDvlMs+QE7Cd7CRBks67UNI8yWtwHvBz6xGq3HiiGFpdEX4dDZwawRqsFMG1BD5wlGMU1NdwA2nHNruPdyF2O0oqRucG4xcDppNQKEmRDjsWNE/2b07jcrbpgWPyJrxFXLxXwuGQk6JNspR3M3F8GEy7IH7cflG0f3l8qL8P2ORAaD1F+bLVJWlBtAO0Mmn7r2BRJY3wuN3CUcskU1i2rLyoZ3waQwlqgpk8VzWCNSgNbq+B4A5Agxx+6LoEcRdiLL7/OFx4Huh7nsUVl7qjthVfu5Zl6NVNhiZQziQnkBLLGn5OQTi9vlBRvItE3/OinOhYzCCZTEoj4DSWPtjVW6ViZpdDXvQcfTrCUvTwAuYX69z4SoEMWCpSPjSpfqmRcvsNHKOz789LaIGW31Jkcg8D92jDJHUPL/8jgrt8upX7PdjPP+Mn3FHFT1iKgLR7VRYXepcGm8k48cgniZg4K1Ba4ihnSH5xSqiBWVK9gxEKdS4vkp9sw5h3AFLxS/vDlAXBwQ7PZBHj+xPKjvNPF9mevu5P9cQQlXnzTMmy0x3PRXGhsFvfoUe++mZrtzBQRXlcVOfHC5qA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5aVM9tk0wMqiDLfCCnBpXqnLfCIJx/VaYqd0yyi9z/7JnW9I4EtLda8qAYUe?=
 =?us-ascii?Q?ptHoLrwDXzQRf4VdnTuE2/dY2hO+iI/X8bymNOZiZX3icgqPhOtUxojs8SlG?=
 =?us-ascii?Q?/ltEwkUTpBmUR5Z77UTX2vQnytidz5C/rCU8jbT4qGR9nkGEIAtPcCbsYJ0c?=
 =?us-ascii?Q?L4VOY0MELDd0Vvhx+4bkNML0fAnapZPSTK61UyEPnHH+zILstGERSCKUUf/P?=
 =?us-ascii?Q?epQ5PA6o4q0YuTPWAO/TUFcs5p0py7xgngfeidTaiBrMyZLiEiOaVKF6ipgi?=
 =?us-ascii?Q?/timq1FIazDNrIAAwFBpNG8CXSThN0zq6jTxhQRRUsK2jSlbnG0TnxF3EgNW?=
 =?us-ascii?Q?546XuF8ORBarYkiMKlkn7dleKbchOoHrIKOar868t1Nis6LPF3mBpuYFRir+?=
 =?us-ascii?Q?iEaxlDF/I4ag3UXQSXT0adfzuAMQ8lteBQ/AXE8nLdRGLyy6kBpyf8Uy/XI7?=
 =?us-ascii?Q?NUyOpuBPhxSHFE5yq4Z0yiQhyM1AqaQ4or8oFim0TfD5NjnTK0/Urvznpng3?=
 =?us-ascii?Q?0CV9kanAysk0rPBf/nKJIkHLj4Iy3iZHbqFvw23hlchjMDFORPlPCInmsNta?=
 =?us-ascii?Q?dOp4gBww8eAX5hfcPcr50kjBNMn1UwzvOqMSfMKYUVnK3BV081jTXUbbmv3v?=
 =?us-ascii?Q?degWwKI9y+79MoafBdp3U5Dvh1iRnRs4qmxdp8KJc63boX+C8Iw2JosW/GzE?=
 =?us-ascii?Q?VM5SoAL/7AH1JwAyikMOCJWyikJHysd6Eeqwze09bHanwAxFdw4jaYPYBdgT?=
 =?us-ascii?Q?SQ5EKj/mT3SY0EzUVuDXBuuwDCH7u5ovzsV3XebMvTIsD+gSXXKUkhIITxU/?=
 =?us-ascii?Q?bzVLxWwXdboT2nUjDenXW49L6yl8UsiM4IAr64O9+tlsCTIBOeFqMDTlb4qp?=
 =?us-ascii?Q?OYsBN63nccdIjdLJEsjxPwPNh8pN2FYvG/17Pj0ux10lwm3OSbsV8mYrndUo?=
 =?us-ascii?Q?MlEoqkzswaI4TYDGRdj/mxO9lsk/rHQnwiTMLW/jkOMvaZnPCh/u+qN1ZTMj?=
 =?us-ascii?Q?0PktYzMZwF9w1Vqd9HCwSIF9qYKpl9ITVrquSZtC7+85Snopi/PmBt+PC/BH?=
 =?us-ascii?Q?lpD6J72y4WKMmWFpkSDYY7JRmlC77nE0pjVIgRzesoMJhLXFM0YVlF2JT5uw?=
 =?us-ascii?Q?tdzf89CpHhQPojsH1TIxeU3Has17xhPjrH1gwcXQuu1OKKg5Q/WMyNh0TufH?=
 =?us-ascii?Q?BzQrVVkZBQ15KlHexYqh+yZ40kxEYAPa8I8W8+Bkxt54uq1mG4bMn3nxqDCI?=
 =?us-ascii?Q?s/LHEWHLzILoFlCgPmKihs0Fc4CgpeKuCb1ZT8/Py/rSYloQxtMuN7gd1Twf?=
 =?us-ascii?Q?SbujY1SxdA78JTt2KpViu003CH6uFPFpQpWapOqxULuYWYWdhJvKPn9mLnmS?=
 =?us-ascii?Q?ihR+IaFLuP1PSlUIrSt9yGr1JKQy7cuKKzuYGfy4C+3v1JWNvZ4bljKiUuJb?=
 =?us-ascii?Q?HP4zEO2skZw2ewx5q0+gl/MhZt2rapMTPVTH/cRvtDKytDTS37gr49JbNZQp?=
 =?us-ascii?Q?lzLKjFqIHkssr9Qvcd85IHAYd3hfv1f/1ni0mEpyi4Qy5POf6htrzRPpPvaT?=
 =?us-ascii?Q?rSucd/cU8pMDwzut3WUlkzvYGMxNETQ/4DeovgFJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265e108c-8a7c-49ac-5c50-08dc5a46eb56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:46:22.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8915375WsAel0lUb1WRehXKGKkoos4XM1pJyEhFqMm88ZXRdGreWm2xCWtCFlWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

mlx5 has a built in self-test at driver startup to evaluate if the
platform supports write combining to generate a 64 byte PCIe TLP or
not. This has proven necessary because a lot of common scenarios end up
with broken write combining (especially inside virtual machines) and there
is no other way to learn this information.

This self test has been consistently failing on new ARM64 CPU
designs (specifically with NVIDIA Grace's implementation of Neoverse
V2). The C loop around writeq() generates some pretty terrible ARM64
assembly, but historically this has worked on alot of existing ARM64 CPUs
till now.

We see it succeed about 1 time in 10,000 on the worst affected
systems. The CPU architects speculate that the load instructions
interspersed with the stores make the test unreliable.

Arrange things so that the ARM64 uses a predictable inline assembly block
of 8 STR instructions.

Catalin suggested implementing this in terms of the obscure
__iowrite64_copy() interface which was long ago added to optimize write
combining stores on Pathscale RDMA HW for x86. These copy routines have
the advantage of requiring the caller to supply alignment which allows an
optimal assembly implementation.

This is a good suggestion because it turns out that S390 has much the same
problem and already uses the __iowrite64_copy() to try to make its WC
operations work.

The first several patches modernize and improve the performance of
__iowriteXX_copy() so that an ARM64 implementation can be provided which
relies on __builtin_constant_p to generate fast inlined assembly code in a
few common cases.

It looks ack'd enough now so I plan to take this through the RDMA tree.

v3:
 - Rebase to 6.9-rc3
 - Fix copy&pasteo in __const_memcpy_toio_aligned64() to use__raw_writeq()
v2: https://lore.kernel.org/r/0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com
 - Rework everything to use __iowrite64_copy().
 - Don't use STP since that is not reliably supported in ARM VMs
 - New patches to tidy up __iowriteXX_copy() on x86 and s390
v1: https://lore.kernel.org/r/cover.1700766072.git.leon@kernel.org

Jason Gunthorpe (6):
  x86: Stop using weak symbols for __iowrite32_copy()
  s390: Implement __iowrite32_copy()
  s390: Stop using weak symbols for __iowrite64_copy()
  arm64/io: Provide a WC friendly __iowriteXX_copy()
  net: hns3: Remove io_stop_wc() calls after __iowrite64_copy()
  IB/mlx5: Use __iowrite64_copy() for write combining stores

 arch/arm64/include/asm/io.h                   | 132 ++++++++++++++++++
 arch/arm64/kernel/io.c                        |  42 ++++++
 arch/s390/include/asm/io.h                    |  15 ++
 arch/s390/pci/pci.c                           |   6 -
 arch/x86/include/asm/io.h                     |  17 +++
 arch/x86/lib/Makefile                         |   1 -
 arch/x86/lib/iomap_copy_64.S                  |  15 --
 drivers/infiniband/hw/mlx5/mem.c              |   8 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   4 -
 include/linux/io.h                            |   8 +-
 lib/iomap_copy.c                              |  13 +-
 11 files changed, 222 insertions(+), 39 deletions(-)
 delete mode 100644 arch/x86/lib/iomap_copy_64.S


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.43.2


