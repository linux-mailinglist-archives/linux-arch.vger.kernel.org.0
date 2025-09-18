Return-Path: <linux-arch+bounces-13670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B28B833EB
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0E3A6646
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 07:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6954764;
	Thu, 18 Sep 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fC8VxHFm"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5B14286;
	Thu, 18 Sep 2025 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178951; cv=fail; b=pHc/oT8cTYgVSAudIZ7vPTNuevV9FIbizaYTbBv2KjPbUxplozg1qIF5KyNigmtmZse1Olbno/VIhjXtyPi79dU63Etv71PMafuOT7pswDcFt6Itsvo6dLW6/CBEahssAWUkr1O2ITFGFN/aWG7dSK05QcwGWNJrohwcPOKLZdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178951; c=relaxed/simple;
	bh=2EllB9CNIhc3bD23zh9BK4AFVS36wNOqyoUt4Ib9AQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=trx/Ug4EMC8KU1KIFk2hMxCRCAcP0As7+YVjwhujaFeMaJGhn+TfJ2DWl9bAEIgROBkq2fQoUx6swKsJwMVGq1bPtkXr2qI53F6S5Nu2ibqUigGnXCvkCTeGEL9O7gK+2BuKg0adda5v6HmuFW/p90whdI/Ti1nCln0cKcBaOTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fC8VxHFm; arc=fail smtp.client-ip=52.101.57.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruHxuFkBEiJf7gK8mSDVdWwVCG0SCJ7UzNcnK/WB1QnPD7n/Ode1PsRuennsngYac8CRKjpKqbUEcV9MK+FvbAMe9W0QhOLL9b8GMaFsj36wGQ5LwjOorWSAGiti1mZ/F1ZCinHaTMWjDo6d9ZSp/OUlfVHqTPxNCjlsbIhuIOLK2yskiKCEZcVCkFkdA6yLwRVgHqY8Cf/1+HIKP3SCXa5dy2qnQrrLE+x8b7rRjXZAz2ucx0dfELIGgNM7pmx+/7HE5hwMuEgT5Lt00E3TWWuqIWrrj45e/QJvTl0ftHjeTo80cQFan9tp6izyxqbj9KZK/M7Urmd9yLCkMrfWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQKdAmIT8jebiv9cIXoFkcMJVmJUG9lmPpJDuWF+ito=;
 b=rkPPY1qGoudowAtw43RFMsb6nR46msCleWiASTU0YXByHmer61ULJA/8E7rygJ6UBm6zJ/2Z0NQwnVJ99cJQmOOI4Ts2tsr9JoQGQCZCr1oXvIcXYnZnDPTNeskv949N0tZeEPP6baGaN42ABSj+cjmks9wu7TXhkptH1tuG9M2VglYmA5WNjKov9iNeLWt+6205KZlTPzapUt80b8TtfeJPKbs0rJ3DbPsLXbZ4kN07sDw0RUis1mPnffPmI5SO0xWsjZbYngetqiqIzzay3Msci6VYsw4hWrE914Y7uRevjZsMFad8YWSP+3rQXbcXNV3/PLHqu/XxUjcLwpLyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQKdAmIT8jebiv9cIXoFkcMJVmJUG9lmPpJDuWF+ito=;
 b=fC8VxHFmO+uD9ymDpaM+vMzAeal3RjAUGnZIcTfWA3+CybjJFfxVjMohgRNnwXoJwNILXi7a5iTjxz2QR+fbqH+yIj9RfZuAT1stW/+1DFs072iYPnPTYPumIvysM7Tp/mLGIoc+l6o3p5gN19/9He1rHSQUqt/NkKAvuFUGNr5MJ+AocFeTe5L9DvJDiqfK5gej1BLFnWlMGyH72z0j1sR1Xuv8n0gYBEwuXcEw63PqzF0N7RUK7ELUYxFqI4JQgQOt8cxUcp+Z7Yms4CJsrUVdtQkPMN4/MpV84UuNCA4m0uJuC3jQioVxY9CPKrnkASxUC/YttQk0nOitOKQpQQ==
Received: from BY5PR17CA0033.namprd17.prod.outlook.com (2603:10b6:a03:1b8::46)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 07:02:23 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::b6) by BY5PR17CA0033.outlook.office365.com
 (2603:10b6:a03:1b8::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 07:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:02:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:02:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:02:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 00:01:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, "Will
 Deacon" <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
	"Andrew Morton" <akpm@linux-foundation.org>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Gerald Schaefer
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
Subject: [PATCH net-next V3] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
Date: Thu, 18 Sep 2025 10:01:23 +0300
Message-ID: <1758178883-648295-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9ac881-dcba-4fe8-11a4-08ddf6815187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mn8wfQwfaaX368R+Gm1qgeB7ESYPOAkcoAOtGKPUo5Wvs1q9hRmki/9US/q2?=
 =?us-ascii?Q?7ppvF4LFWrOqcRQ6uBYGsiM7iT/QU9V7FwhM+kdCUaaI4415jUjITcSmS/rV?=
 =?us-ascii?Q?etk4GdGkBNyaeGAG1cGLm1yZQT1QXkvUfMtMbkyMiAlawttWlXMsjaeNeK66?=
 =?us-ascii?Q?wAbJdSrXkOF170+r72Lj90MN74iSiDO+0yPo5Y8hYnPppMyBf+1AqU3Nbn2N?=
 =?us-ascii?Q?l1zeVepRayxbiHH+epINfW38YNyIeyYeGK4KnRa0U+gTewA9fUIfYc/afWfG?=
 =?us-ascii?Q?bL/1C4kD28gFsuueoBxeQMvAKAFrhZTQNTh6cwCnquaejRCOrv7oBGKN6Msl?=
 =?us-ascii?Q?BNr4poxA/HopYK6UKZdaqjp+dXyVI7NN2ANm4nj7xWgXy7xsfMOCKHSeFUFo?=
 =?us-ascii?Q?TTw8qnGvi+RdDJTgmpOaIdhdPylT8Ryjw57mevs2giR/cOzdhPb63haqnFlo?=
 =?us-ascii?Q?svNpAFm14xNScmdYPGBwJ39HyVDVcXaLgVVlOakthVdGMPnzGJ2LlXe9dJ3J?=
 =?us-ascii?Q?O8qwmxQh5n/KyBJr0RDUVTyhzXtiDy0OlIvfk4zJ9rNkUDIxDRnjLLlOnOox?=
 =?us-ascii?Q?Euvn4OrCFu7D4cx/r9zW+xBTneoUqqR8aB/6HtNn09TpBkbTn8XGdpNJCWd0?=
 =?us-ascii?Q?XiSGhAEXNL7jpxm95keT1T/od8bo0JHedNwneqgA2HwHRgRYoO8f8Y3u3rt+?=
 =?us-ascii?Q?dIbplmiXuJhrBvJ5OJBHaylzbCwuB6Rzb3pTzxZ8o2rszl5RosIMs+gUWKYX?=
 =?us-ascii?Q?gDo7h7moikdianZ0IjXg5wM4mBvIDQ0G+PU1EY9Gy4VXNv3KnUwRWRxCoe1d?=
 =?us-ascii?Q?xelY8JPsarJpd5cTNGxufKKXkxZYbD4RZICbNbliZgzp/oJ/D/W03Y/un1Yt?=
 =?us-ascii?Q?MJHD6e/cM9Xqd8gkCMoCGu8jWrdejzLRljyGaciClbULSwh/CQWcgfMLblpS?=
 =?us-ascii?Q?Ah0QfnZ+N2QgzFATaCykIS1etL9R+UN4jab6WXlhwEUE1I6THtgA1a3usNbt?=
 =?us-ascii?Q?rUl4h/2n4ThTt1p6LTNwhHvCisOp/DxaQoQIeYrMtBPv2vo3zFwB1jeRn5mB?=
 =?us-ascii?Q?7+JWlNJoql+BeSSG3W03HebSQxqfubQuRcHET+wUbP1qH3KDSFQGTgoVGwK/?=
 =?us-ascii?Q?N+VegG6uE7Y2GdzO1EWoZAUkiZVHSGm/BBuNvkcOxpSV6Ng5K3tE1pgiLjP1?=
 =?us-ascii?Q?Wmh0d8MlgyeR7bLBhieW/nvrw7yXWctPR9zDEYG+PatS+p1orGu7pQgb174y?=
 =?us-ascii?Q?LADZYRUjM0DYq9/WkhS7CpEb4S5I0w28jgfjaIS733HnSvhQ0OGkrjVaswZv?=
 =?us-ascii?Q?rWFEgl3D0wSFIJzjYdJMqSI6DnMmOUSaZyZmPgifG7B9EqyTGHLaqoz/4DGW?=
 =?us-ascii?Q?KapfYlCJ53j+A9eUXtEgGXj6Owm50wEcvLICDbD3CMLKcHwxMWtwruFBmw+Y?=
 =?us-ascii?Q?7jSOcQGSIOq5VTZ/4IsVWs582UBrJKWSNawv22gx/e59JPJnXPvDsj9J55aT?=
 =?us-ascii?Q?CJZLhq0SSRMyhw1OL8UjO0wp4oICqWzWuH0nWaryF632J0iCp/ReiR197Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:02:23.4452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9ac881-dcba-4fe8-11a4-08ddf6815187
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

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
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 28 ++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

Find V2 here:
https://lore.kernel.org/all/1757925308-614943-1-git-send-email-tariqt@nvidia.com/

V3:
- Move the new copy assembly code to be inline, within the same file it
  is used.
- Use ".arch_extension simd;\n\t" to avoid the need for separate file
  and special compilation flags.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 2f0316616fa4..d0518cabfd84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -7,6 +7,10 @@
 #include "mlx5_core.h"
 #include "wq.h"
 
+#ifdef CONFIG_KERNEL_MODE_NEON
+#include <asm/neon.h>
+#endif
+
 #define TEST_WC_NUM_WQES 255
 #define TEST_WC_LOG_CQ_SZ (order_base_2(TEST_WC_NUM_WQES))
 #define TEST_WC_SQ_LOG_WQ_SZ TEST_WC_LOG_CQ_SZ
@@ -255,6 +259,27 @@ static void mlx5_wc_destroy_sq(struct mlx5_wc_sq *sq)
 	mlx5_wq_destroy(&sq->wq_ctrl);
 }
 
+static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
+				size_t mmio_wqe_size)
+{
+#ifdef CONFIG_KERNEL_MODE_NEON
+	if (cpu_has_neon()) {
+		kernel_neon_begin();
+		asm volatile
+		(".arch_extension simd;\n\t"
+		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
+		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
+		:
+		: "r"(mmio_wqe), "r"(sq->bfreg.map + sq->bfreg.offset)
+		: "memory", "v0", "v1", "v2", "v3");
+		kernel_neon_end();
+		return;
+	}
+#endif
+	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
+			 mmio_wqe_size / 8);
+}
+
 static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, bool signaled)
 {
 	int buf_size = (1 << MLX5_CAP_GEN(sq->cq.mdev, log_bf_reg_size)) / 2;
@@ -288,8 +313,7 @@ static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, bool signaled)
 	 */
 	wmb();
 
-	__iowrite64_copy(sq->bfreg.map + sq->bfreg.offset, mmio_wqe,
-			 sizeof(mmio_wqe) / 8);
+	mlx5_iowrite64_copy(sq, mmio_wqe, sizeof(mmio_wqe));
 
 	sq->bfreg.offset ^= buf_size;
 }

base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
-- 
2.31.1


