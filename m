Return-Path: <linux-arch+bounces-13707-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B191B8F73C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 10:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83A0173DD8
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86A277CBF;
	Mon, 22 Sep 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hI3LTHdQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359973208;
	Mon, 22 Sep 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529014; cv=fail; b=LKFh1+63gNsuEa0iEr75q01eNIBC1ql4QZDRapzN9OM97UXr9AFKTuL8RxY+Ma/QuVHRkDwkeVUWV53rCa1WaprG8ZQwo1tQSzYO+uYBUnv5v9zUIXqskOlqDxpu4PMb7X8eE3hLWX233UcrRHElHJYvbDUhP93E17YLPkXwOZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529014; c=relaxed/simple;
	bh=mVXOCyaEz8cjc0WIhn6EfOYdxRj2c/DetPo4OC/IL78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S83znVjur8iiP4zz3lgE6s74tJJmAnrXMSkvQ/OxGRsrxuguuk9TKzolD76OPHc8rJia4d2UiU1GVoEt+17mZu+tAvsRuJ5FolWk1nTmxD1vQY9OtqFtBNRoZuquSNs40eBoVZ9zrkiI4ESMCAubAaxO9D6Sj8pWthlvT/HCg8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hI3LTHdQ; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyXkGAOfezuNaZw/O7sBSpFQIuvG/IDjVz8nm04ZMZ64SkWfYMD7/wd5SOxJfzOdfFmY6UM4E03y1SzxbX+sMhnqfjG/VaxTBc81/hiqPibF04uZCBF7KhjgSbI/2e0QhbtFHoPhlhgXBJ5FywIHWR7kKCOWHP1iTNhagfCQM9H6ktt8xqyAuKNLmToHGAMHiH1rOYNXMal7CqUNygmvVVNTZ66K3Spn5iN26ZV3KdrNHgqQ6D5VbsY3DIjLuvUfyyCxp9RHcAokAZbu/dUkTPXIclhu+k3IgAgzrWFZSmeGao6xWx6Cp27txQOYaYoTOvMHvgmRmHRk8owNb4IBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck8wkHTqUm4dA07JLsfGtWJwNUYmpYOpgty2xl+OMk4=;
 b=m//WWn/f4LCZShOaJilJe+q0hZo8ZRtNmVhUkl0QTu15/vmW1jDsoZtBg8g33DEnDThH2/vY9kpeqq4IyzbiLmex3B7qrOahgoMI45bLAZGYMu/J/wLxQbtG466vRxGJNFshkC44GWiMDa6Cm+fKe/xrzOZcR24E+WUmvozxavl5i0V8BRN72nXfjzFk+TEphIU9T7sVhtfl1Tp9LUTW2jwYS7/ghGJYuLqeoQlm916zjagso8YJbwfQtqnZ7QI7CfXrmogdJn3kUQgI44u2oTGukRIZyanyhwQ/kjC0jNRQIpGOoZ2HXtXY5WV2M8ArsoXabW43VWS8uQdkypAlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck8wkHTqUm4dA07JLsfGtWJwNUYmpYOpgty2xl+OMk4=;
 b=hI3LTHdQI+DBC4PY/2YXo1tjPb8KSGtpLZF2zDm98U+1BJLRO/2x+xeWqPqRaniYLGTUKHedCpCPnsnStyhFzkUDNFp4tyEjPLPTHh9aQJG2ZqUSV0PimGRJJ2F9+JqNRtMtWT10tVX9Klh+7ZR03LoXNSWaSkm1G+HdVGzrbYY+URkfWeQIsjwp65b5ts1o3KWwOviD4hc0qK/QmUnyHBmM9BKKN0TpoO3SsjjCNg3/rP5PxBgn9tmdn7ZfbYZSqp6FgVjZzCQbChtvZ1pPTlFZOC64weTZLnsdRq+HkITaBK+qeH8jp/pQE9+Tv2HBk6WNHIr4TEmuVWAiRAlKEA==
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 08:16:45 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::c0) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 08:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 08:16:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 01:16:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Sep 2025 01:16:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 01:16:21 -0700
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
 Shao" <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>, "Patrisious
 Haddad" <phaddad@nvidia.com>
Subject: [PATCH net-next V4] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
Date: Mon, 22 Sep 2025 11:15:51 +0300
Message-ID: <1758528951-817323-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 637fd0b1-da60-44d0-50ff-08ddf9b05e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alMzRIBYv+/KiugOtKc5g0T/Z/yT4NQc1yVBVZHs8nyuLoDjqCmqfZ1q2/6l?=
 =?us-ascii?Q?ywXbyF8Hwex6K+le5cOt/9kjCDhWnb1vZEdirJlHF67BzqrifnkVx5a0NUrK?=
 =?us-ascii?Q?n56XNeK/tBT6ARwzDS9VBl1erZATFEPMsdHGbTPA9aELIFxP1xuXib5ogKHo?=
 =?us-ascii?Q?EymvuOP2FQ1LvVGUujWotkRIxdwitmBrfo0oYR+Oe0UDYSZCtJdWJaAr6FkN?=
 =?us-ascii?Q?FwBDReneI/jIdA6DGbR+Gv/6azq7vhWTPcjByDIjcDZvZfj5yJCdkZWh+78y?=
 =?us-ascii?Q?I0BQMmgj/kpOQclsCH9ps+369bXGoUKaI7b0h65wQo5w7uLNIPydRswEL5b/?=
 =?us-ascii?Q?xwvl0f4oQ7roc/s2gbtv4TjJFyW7dR6D9VcxqnsvDC+L9I+z7ea8vwqrcINL?=
 =?us-ascii?Q?SNkVc7xE2s8YdFmuMIVOd/PAXXEulMu7CUdQ+cobfQI01faNOpNPC3gFqcUV?=
 =?us-ascii?Q?+Ucbiq2+NmGWCq8+EO8VXegAcZQhm52Taqx8DOGQyZTPTxzIIbF2snz2rMT7?=
 =?us-ascii?Q?7VvJfOfi7jRbkufi7Q5+fj1wFd4a2reT85ny7UnSsn8m2Xn8h9333VHVtaTO?=
 =?us-ascii?Q?2SYYrA71qLd4sc1sghCek7YtPnGCqW8FV9S3Zi6IHZJieHpxD7LHLo8Nukv1?=
 =?us-ascii?Q?DoaYFq9+hUStfpgCqFB3Dj9EM/YWoXr81E4D/FMHfDuvtMmQQ7OFImqMVZwn?=
 =?us-ascii?Q?oDhC8KaoeDyGPwI30sIBSKzMkzKYSoIwXgeUPYdRa06h1SBGJL5zRN81wM6T?=
 =?us-ascii?Q?3yPGYIkNwkKMB8KWSL6RPPG50CJsWjDtWXY4vzZ0Z7LLGLAvM4ql2CLtxU7i?=
 =?us-ascii?Q?1ILQp9QDAeMFjX11/71HU/RrLpP4i4564Ec1LeolrK5Woy73MmScs6g8kiHF?=
 =?us-ascii?Q?0f9x5KgXTZz/f8AuartxflO2o6ZZPNdZ5zy7AOEk+I6xXzaAWfl643RU/mgK?=
 =?us-ascii?Q?i2T1D9GF5pH72G/kMd7BCkketx3Cna9qyfleoVmlzMXvB78gaktB9ln6q0iz?=
 =?us-ascii?Q?N1Y3mhxRu7Mw6um8Kcp2WwBm3wKp3PYEkbwbEL2lWAFVbncfKr2JsFyqyLI1?=
 =?us-ascii?Q?pmfZ5TgAibZS+M7RVTlct0imUonjE+slJu6i9cU6Nl8GAe811VxvJi6y0XEO?=
 =?us-ascii?Q?BW4cJMT/mhEHoEvES6y7WLABxz6aqfVGC/bCPlWqMia2oX2P3xwpLEbLCdb+?=
 =?us-ascii?Q?wZi09GRlYDrSpUw0ETyRLOLfdibqNY9Nt4xJWqD+LyXnKHzaaL7cOSYdS+OV?=
 =?us-ascii?Q?Hr3X80hmyY8ZPy+ScllJH1RHBCu6w7woNPmTFSfby1NUaS+2kswvYNplFgVF?=
 =?us-ascii?Q?YzBTa4BjtFhO4gfFdn3w1q0UIOykjCBEGrBXjUXFAx6t6vcc7Ib17Hc4NvAY?=
 =?us-ascii?Q?DJvY5O5sUQP0I8WarQ8eDlkv1hythKa6AumGiRAIvNyfF9TwYae08sewrI6m?=
 =?us-ascii?Q?rPURSHpB6p7zcJxM8wWNxt6qXiTO90wprkPOQcBRPep5hmFVhvBoK97+xLX2?=
 =?us-ascii?Q?XKTHrtcRze08uBXjbHwJJD4aIuh+h0H0nqMxOo7RIWSqPBJVilNRG2D+fQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:16:44.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637fd0b1-da60-44d0-50ff-08ddf9b05e38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738

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

Find V3 here:
https://lore.kernel.org/all/1758178883-648295-1-git-send-email-tariqt@nvidia.com/

V4:
- Rebased.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 999d6216648a..9f988344d9c8 100644
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
+				size_t mmio_wqe_size, unsigned int offset)
+{
+#ifdef CONFIG_KERNEL_MODE_NEON
+	if (cpu_has_neon()) {
+		kernel_neon_begin();
+		asm volatile
+		(".arch_extension simd;\n\t"
+		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
+		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
+		:
+		: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
+		: "memory", "v0", "v1", "v2", "v3");
+		kernel_neon_end();
+		return;
+	}
+#endif
+	__iowrite64_copy(sq->bfreg.map + offset, mmio_wqe,
+			 mmio_wqe_size / 8);
+}
+
 static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, unsigned int *offset,
 			     bool signaled)
 {
@@ -289,8 +314,7 @@ static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, unsigned int *offset,
 	 */
 	wmb();
 
-	__iowrite64_copy(sq->bfreg.map + *offset, mmio_wqe,
-			 sizeof(mmio_wqe) / 8);
+	mlx5_iowrite64_copy(sq, mmio_wqe, sizeof(mmio_wqe), *offset);
 
 	*offset ^= buf_size;
 }

base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
2.31.1


