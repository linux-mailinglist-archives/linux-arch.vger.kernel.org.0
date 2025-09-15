Return-Path: <linux-arch+bounces-13610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762FFB57319
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1953189E520
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF82EAD05;
	Mon, 15 Sep 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOvI2GGV"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CF2E9EC6;
	Mon, 15 Sep 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925365; cv=fail; b=iybtzht6dmxhhM4J6iNLlP2vXakzruc7TA0itspfUAO8XT+X6ainjXHUCekT797MIX/ZenbM1hN4jSZ2AUkFRUwv0kqR+5qfF4vXij97rLMxdUUeF8trR+uUDlnOC+kuSnEfJqwH7okXMj8zBJEiMkBIyxcb/qPzpU+6FUNIyE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925365; c=relaxed/simple;
	bh=wQrPULds2DfYAzaQ1mim3Ph1BcPl8J0kauRnkv+WmEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hTsITSefhsCZS8xDWanpQgam9iMPx0T04GmhJPvJNs+yUYHNt7zIqaTHWZS1xvh5T/EXGqQ/QwqfTpUltRzN/b1njysKeOJaC5pw1IuVUqUy9X3eqrCCr7/jIUzArUMH3CUCYTRRk5angJCI0S5safcpom0LtciKFDhzytTkGJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOvI2GGV; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdLcvYr77D3V1GFpQ/BYBbouSR9UxZqkmMHyWKOSqXWyt780S8Th1rALEBMDL0377v7dE/hQsFSivZSIh6R88M9gSceP2LT4kyLhzX+e1GgkBvY6c01rnu7QfnlXIUPFJBPgibezUL5mhkIw2OeCh450HKFoqrDv9jLAVJtfqlA+XKxJqTtyuvq48NiFZVMQLHiaCa7P7LUvhYIVYYGIDFgGlnO5c5EnFWCF0wwfWbewZU5smGA3qxFH5ktFAslXQrtfzp+Huiy0TVCYXbfSfgX4sQZqA91jeJxSRsZ1yMNvW0zA2UllrSj7zoV0sQD6WhrNxFU9DnEl4+P1O6e5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+7xzu2TqCSZQdzPiepLQxO3vbI6eorOZ/UIvlG774E=;
 b=iLCRo8GwZMoLtQAvxgaj7+eDCgkB5BBtdYFry3DSgIBjD+Dw+SVpOrzr8fnqdar03Fz7ySnUKQUiSD+QEuhfKSRch4Mt1A9n39t9y0TQEb9z6ALacOoJzAVWZzdkbUUC42NV3u2zOnbWa2QXFUg35gynkb2+y8YngeFZSEm+7UQYKWA5zjYF9MdJrjdW80N/NLqqyL2Ev3xuAhhs3Zb2ZIKevYsp1go+twV3a/K1fV6WlGMxR3u+qL8xm9d1XRQPgrbNNirZ7aFn80dxTNCmV2573oz3u0ElT3Yx3hxGBbPbZo9SMcxyrgzPxyTN23vlr5VmgCB4Yl+WYIQHg4RhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+7xzu2TqCSZQdzPiepLQxO3vbI6eorOZ/UIvlG774E=;
 b=rOvI2GGVztuV+IEMl4H/5JGONZhCh87Wztge2OfeHUy+83E3DVgHAyG5symgkC7Ti5I2bJuxaqQH9fqA1dfV92wMq2LHbKcQQmqFuT+epPNpjWxhIpxskkrR0AhAHnrJKurjDDLGsZtk2JSw2+Em89FCVFqVkjgmc43h241NV8XD69mlCJ4HVA+zlZ+Lvk7K8/vZxjZURb/mR51oXKFZtzv8XtL9e1hUiURE5qVn1BjDrs3TQeR8nDH3UTgAMUr9X67oTw38rElRTAiwFpE4DQYmWn4gH8rbnfxPndfbzY8oSxSmIM2lNstW1WDiCf3gARpEAclvBQ54YP/GycZ1rQ==
Received: from MN2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:208:178::16)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 08:35:57 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:178:cafe::3f) by MN2PR19CA0003.outlook.office365.com
 (2603:10b6:208:178::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 08:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Mon, 15 Sep 2025 08:35:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 01:35:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 01:35:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 15 Sep 2025 01:35:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Will Deacon <will@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt
	<justinstitt@google.com>, <linux-s390@vger.kernel.org>,
	<llvm@lists.linux.dev>, Ingo Molnar <mingo@redhat.com>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Salil Mehta <salil.mehta@huawei.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
	<x86@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann
	<arnd@arndb.de>, Leon Romanovsky <leonro@mellanox.com>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Michael Guralnik <michaelgur@mellanox.com>,
	<patches@lists.linux.dev>, Niklas Schnelle <schnelle@linux.ibm.com>, "Jijie
 Shao" <shaojijie@huawei.com>, Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH net-next V2] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
Date: Mon, 15 Sep 2025 11:35:08 +0300
Message-ID: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5d6194-1796-458e-7336-08ddf432e49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ngA+L5vR3nH1N/kUn3TJKv+d0r020PiOuxS1BwhNayP29zzJAcE4nTvkVC8y?=
 =?us-ascii?Q?uR5ELW9phd7TbqwnNiv2w4VeC/iQgIxtE+hViPHGCIrbkE3zNR4cCYAvX79D?=
 =?us-ascii?Q?1kHR8ny3xyM1p9a/OFIu/UXqnTTOg5HNm4HiRNwVCZjrqKHbrHWg38CHkokK?=
 =?us-ascii?Q?QrAvMpTYoSLnrJ6PvSB5bXAWe1pGqt1vAYc3R/g0Yi6+wW/G46FKimtT5WE6?=
 =?us-ascii?Q?mPFA8vxUb7FAcTAIOZ0d38uTYannqLECYB5CKtL8u/8WMdUZ8C+WCKErOelp?=
 =?us-ascii?Q?S+MIGvXJWqQ/s/f0PE8Z01cuT0lVYQZr3Yrn9sPktoBTwNyGFS0ttdGXEcnI?=
 =?us-ascii?Q?lE2ufpd71Tx25uLVRwDsKtpTD+pQXTcvJElq82go+ID/uUQtjx2LrK3/s/g1?=
 =?us-ascii?Q?ujKhohOL7wd77lgB/qCJjFzFpwZsZIIHm/2t3eFlm9opqwFXkot2tsOzwKUq?=
 =?us-ascii?Q?qaNrDbny6d/ijKfUJ2X1jD+RjQUl+Gm+5X9sReb2HSflq5WFZuJm/I82XhC+?=
 =?us-ascii?Q?U7/71sOkMLiVkd5LPelXFWebGQwyvZcu4INASm2OMt3G4vpv4d2h44XvdVZ+?=
 =?us-ascii?Q?+RHYSyFJ6e7xSVrdWgfRP4Aa7BSxAKBOGVLQfTG/1ambrJVaAtg5Gjbzhtrg?=
 =?us-ascii?Q?9q26WRc2P18l3Jj9nXrgcwgT9QdYjaHGXy8lWuqPqDAzTqIA8ehUKCCX0ILc?=
 =?us-ascii?Q?cOTN/ZQNtrmxgOWkrxYx2iqra9MKfnCa2JGLKx0MWd51WlDzqiMWdUfYg+wC?=
 =?us-ascii?Q?dLoR3KJP3p8FEZKyNo/A73Ed5uFb8JEsY2UrcVN87KITui6E19e5O/cxZTDb?=
 =?us-ascii?Q?ZyK0rjI2hs1CXh8is8HJLjfli9wXrP5sqRW+KbDdKxkbQVmK8aBqLJRQlzFc?=
 =?us-ascii?Q?L5Or1vViSrxKJgLH6tHFLkCaHYLHs5vDHFUmrM1U4JEXF7jtkWnDi6Q/1Rs1?=
 =?us-ascii?Q?lXvr+OW221Jyg4WIDGI576416sW4xONDglVXT0RzOkiSKDcWfkVN0xW97ypw?=
 =?us-ascii?Q?7ttT6Seys6KAeheS0rQXaZJdwY0Ffrqgy1u0DJw936UBI2Tu+yudqeCK2hJ3?=
 =?us-ascii?Q?BEUePrh7bAnEKjBU7Rsm/oacSzP5xc45vnhzZ1D0AAGDBpuMCejZ5a02a7Yk?=
 =?us-ascii?Q?dhRAEJFnlLi8Bpj9qtiYwW9iqhNsmvF+Wa56EIBdNdZrM9XjjMgmdZhxb2rp?=
 =?us-ascii?Q?IaDYU9wExfWrHvImS2x6VkHuNZQIFxyIqePu6P97uKTmVS6R8SrqF4Umr0+S?=
 =?us-ascii?Q?3UUhPmzRe/UNRpAPx3FEjOydXeI70OhlLwWVBlXtK0VOlB6gOaP8caP3RQFo?=
 =?us-ascii?Q?aV/CXKJxQhxa2z0H/mhdbid+rVYYGB7PUrNl+2uYoUZkohRxbGyd52eQzvbC?=
 =?us-ascii?Q?nFYuMacAGI/jJPM980uQPaDwdvptZXBwRGNegHx1nb6Z3uWvvHIu6mptllD3?=
 =?us-ascii?Q?XgmaSlHuoDJM/WQzfpWu8AXpM2+arNtbaXazAeXH7SdN6K+AMwscYLc44YFD?=
 =?us-ascii?Q?/DeE2UL/8Rza22fntL5dW6ydxHrWqXk/W01Q8K8pfxRplN5HPspZYs4XdQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:35:57.5997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5d6194-1796-458e-7336-08ddf432e49c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

From: Patrisious Haddad <phaddad@nvidia.com>

Write combining is an optimization feature in CPUs that is frequently
used by modern devices to generate 32 or 64 byte TLPs at the PCIe level.
These large TLPs allow certain optimizations in the driver to HW
communication that improve performance. As WC is unpredictable and
optional the HW designs all tolerate cases where combining doesn't
happen and simply experience a performance degradation.

Unfortunately many virtualization environments on all architectures have
done things that completely disable WC inside the VM with no generic way
to detect this. For example WC was fully blocked in ARM64 KVM until
commit 8c47ce3e1d2c ("KVM: arm64: Set io memory s2 pte as normalnc for
vfio pci device").

Trying to use WC when it is known not to work has a measurable
performance cost (~5%). Long ago mlx5 developed an boot time algorithm
to test if WC is available or not by using unique mlx5 HW features to
measure how many large TLPs the device is receiving. The SW generates a
large number of combining opportunities and if any succeed then WC is
declared working.

In mlx5 the WC optimization feature is never used by the kernel except
for the boot time test. The WC is only used by userspace in rdma-core.

Sadly modern ARM CPUs, especially NVIDIA Grace, have a combining
implementation that is very unreliable compared to pretty much
everything prior. This is being fixed architecturally in new CPUs with a
new ST64B instruction, but current shipping devices suffer this problem.

Unreliable means the SW can present thousands of combining opportunities
and the HW will not combine for any of them, which creates a performance
degradation, and critically fails the mlx5 boot test. However, the CPU
is very sensitive to the instruction sequence used, with the better
options being sufficiently good that the performance loss from the
unreliable CPU is not measurable.

Broadly there are several options, from worst to best:
1) A C loop doing a u64 memcpy.
   This was used prior to commit ef302283ddfc
   ("IB/mlx5: Use __iowrite64_copy() for write combining stores")
   and failed almost all the time on Grace CPUs.

2) ARM64 assembly with consecutive 8 byte stores. This was implemented
   as an arch-generic __iowriteXX_copy() family of functions suitable
   for performance use in drivers for WC. commit ead79118dae6
   ("arm64/io: Provide a WC friendly __iowriteXX_copy()") provided the
   ARM implementation.

3) ARM64 assembly with consecutive 16 byte stores. This was rejected
   from kernel use over fears of virtualization failures. Common ARM
   VMMs will crash if STP is used against emulated memory.

4) A single NEON store instruction. Userspace has used this option for a
   very long time, it performs well.

5) For future silicon the new ST64B instruction is guaranteed to
   generate a 64 byte TLP 100% of the time

The past upgrade from #1 to #2 was thought to be sufficient to solve
this problem. However, more testing on more systems shows that #3 is
still problematic at a low frequency and the kernel test fails.

Thus, make the mlx5 use the same instructions as userspace during the
boot time WC self test. This way the WC test matches the userspace and
will properly detect the ability of HW to support the WC workload that
userspace will generate. While #4 still has imperfect combining
performance, it is substantially better than #2, and does actually give
a performance win to applications. Self-test failures with #2 are like
3/10 boots, on some systems, #4 has never seen a boot failure.

There is no real general use case for a NEON based WC flow in the
kernel. This is not suitable for any performance path work as getting
into/out of a NEON context is fairly expensive compared to the gain of
WC. Future CPUs are going to fix this issue by using an new ARM
instruction and __iowriteXX_copy() will be updated to use that
automatically, probably using the ALTERNATES mechanism.

Since this problem is constrained to mlx5's unique situation of needing
a non-performance code path to duplicate what mlx5 userspace is doing as
a matter of self-testing, implement it as a one line inline assembly in
the driver directly.

Lastly, this was concluded from the discussion with ARM maintainers
which confirms that this is the best approach for the solution:
https://lore.kernel.org/r/aHqN_hpJl84T1Usi@arm.com

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  6 +++++
 .../mlx5/core/lib/wc_neon_iowrite64_copy.c    | 14 +++++++++++
 .../mlx5/core/lib/wc_neon_iowrite64_copy.h    | 12 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 24 +++++++++++++++++--
 4 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h

Find V1 here:
https://lore.kernel.org/all/1757572873-602396-1-git-send-email-tariqt@nvidia.com/

V2: no changes, extended the CC list.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d77696f46eb5..06d0eb190816 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -176,3 +176,9 @@ mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
 
 obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
 mlx5_dpll-y :=	dpll.o
+
+#
+# NEON WC specific for mlx5
+#
+mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
+FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
new file mode 100644
index 000000000000..8c07d2040607
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "lib/wc_neon_iowrite64_copy.h"
+
+void mlx5_wc_neon_iowrite64_copy(void __iomem *to, const void *from)
+{
+	asm volatile
+	("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
+	"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
+	:
+	: "r"(from), "r"(to)
+	: "memory", "v0", "v1", "v2", "v3");
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h
new file mode 100644
index 000000000000..ff2a2e263190
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_LIB_WC_NEON_H__
+#define __MLX5_LIB_WC_NEON_H__
+
+/* Executes a 64 byte copy between the two provided pointers via ARM neon
+ * instruction.
+ */
+void mlx5_wc_neon_iowrite64_copy(void __iomem *to, const void *from);
+
+#endif /* __MLX5_LIB_WC_NEON_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 2f0316616fa4..44c2ac953ea2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -7,6 +7,11 @@
 #include "mlx5_core.h"
 #include "wq.h"
 
+#ifdef CONFIG_KERNEL_MODE_NEON
+#include "lib/wc_neon_iowrite64_copy.h"
+#include <asm/neon.h>
+#endif
+
 #define TEST_WC_NUM_WQES 255
 #define TEST_WC_LOG_CQ_SZ (order_base_2(TEST_WC_NUM_WQES))
 #define TEST_WC_SQ_LOG_WQ_SZ TEST_WC_LOG_CQ_SZ
@@ -249,6 +254,22 @@ static int mlx5_wc_create_sq(struct mlx5_core_dev *mdev, struct mlx5_wc_sq *sq)
 	return err;
 }
 
+static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
+				size_t mmio_wqe_size)
+{
+#ifdef CONFIG_KERNEL_MODE_NEON
+	if (cpu_has_neon()) {
+		kernel_neon_begin();
+		mlx5_wc_neon_iowrite64_copy(sq->bfreg.map + sq->bfreg.offset,
+					    mmio_wqe);
+		kernel_neon_end();
+		return;
+	}
+#endif
+	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
+			 mmio_wqe_size / 8);
+}
+
 static void mlx5_wc_destroy_sq(struct mlx5_wc_sq *sq)
 {
 	mlx5_core_destroy_sq(sq->cq.mdev, sq->sqn);
@@ -288,8 +309,7 @@ static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, bool signaled)
 	 */
 	wmb();
 
-	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
-			 sizeof(mmio_wqe) / 8);
+	mlx5_iowrite64_copy(sq, mmio_wqe, sizeof(mmio_wqe));
 
 	sq->bfreg.offset ^= buf_size;
 }

base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
-- 
2.31.1


