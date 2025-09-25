Return-Path: <linux-arch+bounces-13767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D5B9EFE7
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 13:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401B42A18E5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23F1DC9B1;
	Thu, 25 Sep 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eK9xK0AY"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93867196C7C;
	Thu, 25 Sep 2025 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800959; cv=fail; b=WufQ+OfEV4LOLJzfa8YSzA8UixCOmeRzipfF/wM8JExU3S0otOz7UOHqJJa7G2BgPZvfI033mdAwodKtHJDL94fy98CHzGvWebce8I98I5OXTGEcsM2ZwjfBCCHJVKn7duakPos7CowcyNYb/lTG/HNm/1cTp/5ljDWB2H0SvoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800959; c=relaxed/simple;
	bh=/kLC3yVhjtmZ3kZWqnInMhT+4Tzlw3cqSFYphUHzsFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vDnxbnVkeg6zD1zEQ5i3/hbcbIZYEnUBawAf3TloRJZn1iUBQRYGcA5QlS2e3QOwxnq2sc9BqwRoMFyaqjc6wknogEcdni3nzk3gy7dAVl3ERRsv9dAUvqXyOyiQZu3XGmiK5hY/gLyMcXMPEoFFWhFBfVEc3gqW0c0MTT0LW6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eK9xK0AY; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHC9HhesbeywgAhXRnL+a1tGjPf4mII+ga6dTXtem8j6DLR07RtHsS4gNPGDA9cDyoN2nkJAp0xcctJh+77tl4ol/t6VWab7oGgHNE7d5HGx7zUm+NyDegcGZ2ZMeDJEpXY/lTVeFZ7bWnTu9x++3y5t8s89YKKe60n40fRlO8EvJ8rJaRvejLz/uucOYGMSrwtfdaZUUnnO+hm0bzIEu6SSHgyjp3n0P+z2EYhDyNyD3DI5ne9SRn3W9dPtGZk6XK0qmrBMab0Dr29kiWEHjJ1L0BB3ks6MWu/11rv6L8dSw9dn/x9AOfQ3ST636C5zwh1Ax/rMZ/nvk+U/9kEBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLUxv73iJZo8FT5b8dNeDuoaqjhLiJrQQLcKHiTh47k=;
 b=jb0xq9oRXWSAUavJCP11z/fpdQ7g8Mw4gDg5lrKpOTBYLCXmQLynJFtaPUCbF4WZpYPzplrcoZ13aRbUFNluKhKZ4Q2dhki8nOx3kffIl90K5sDne+tCMSSENmVZMcswvl5peco88v4v5CUGdh9MZZtqyzh4zhReZpY1986SGeShjzuZWLwSK7KZ/0t9JLLOZQTGNhEXBQTzrlXK3d0sQylpoxH7WTyhq3M57gmCMPlC6qCgpeUtpHWqGZC8Lr13KGjoyQ9m0icBUUklWh/C/d9KvZ80nEbMswfZ5Mw0M0dAK8hb5U4S3T5OddEmejIAudbzcsYxFu7c2Lpa3b44xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLUxv73iJZo8FT5b8dNeDuoaqjhLiJrQQLcKHiTh47k=;
 b=eK9xK0AY+8xvXmQOeGMWpxhk/IMq4V7kvh+WFFDBzl+6clWw1awE5TcEtTQIq/6c4wdvToQa4GEZFsHpcOJwa8dutQhrdpXTxzTp6TfhKtibk75aK0RBq3D717Ecc1y7ISNtuu5PkyUabf//m3GgnJUMWr7bWYOSIrVwLz0gJdiBUlNKtPISYEGkfmWg5goqxES7u2vx6hD/p3lWVFe8zlidqKbyXRGaBVSut7frkeiTMksoilXSnGpgZ1cqqxzP8oTXbGqzJKGJokDX6qm2jMiY6FLRS7kkKNSRx4HRKRCYh5cxNv7qq5u1SnbgKQ9UxCMtCHnqDYJyUo0V/BKkmQ==
Received: from CH2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:610:4f::22)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:49:13 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::4f) by CH2PR18CA0012.outlook.office365.com
 (2603:10b6:610:4f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Thu,
 25 Sep 2025 11:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 11:49:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 04:49:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 04:49:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 25
 Sep 2025 04:48:48 -0700
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
Subject: [PATCH net-next V5] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
Date: Thu, 25 Sep 2025 14:48:33 +0300
Message-ID: <1758800913-830383-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 425ff62d-3a05-4894-3b4b-08ddfc298c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z28YfANJKp8dU2Kt1UcTr0sXVmWDdqNp4wPDtkEDLzvMshWXh1PIRduHnRUg?=
 =?us-ascii?Q?ESwAN+VYnjQ5PruPav39BKDJEBBEOOkOjjNksW3k3Q4/ABIPIgAMXuggSWBA?=
 =?us-ascii?Q?nTjYzax4z7nUhqttgTeifn+n0Aq7yHvBxZFCjPEm/epT/Xdz0B9oAXLoUJnd?=
 =?us-ascii?Q?tBD1VEYfIgRx06wzKc/HAArjt2ZswYctGqKMW9S3SDJZbJ5J5Sy+F7cfONrf?=
 =?us-ascii?Q?3xikl3kuhQAznXw8rZ6BVcR/8/bOsu4QIl0wJwuPQ94EayW5J4pCsW3EPBZw?=
 =?us-ascii?Q?LsmZQM2vC00vZyN4S12eyc1+Jw16FyrihA3BJ/+Gw9LUb5jT3r4rjYzaDRxo?=
 =?us-ascii?Q?MhkDjklgVZI2xiOB+6uy3+gnAfOY7DV2oEfFCujKuOUJ7fbprkCSOENVZx5+?=
 =?us-ascii?Q?7lvCah7WMgrpoKKeQ63jDGMuudTioO5oUPvIOpOzlk/W5kvqmUL2nd73NwkK?=
 =?us-ascii?Q?9QVvKbC5QL8RykbgEmRQi9L2zV1938rO/OCWN5ULI41oTqYVVIL2sb6g47gs?=
 =?us-ascii?Q?lCHyLVnpww+JTSBSUUyoxS8VfWZ0Z3qLASF4zQP/LhGxdhQmV6CPYYsVLdce?=
 =?us-ascii?Q?XRirt+1510LK3m/iIvGnVg7dp3BaV+pNguxwSVXIgNjxrj5BPIVDbs/wBKSn?=
 =?us-ascii?Q?87IUt9WGnYxG5mhnm8Q6TUam2y0D/n/8D0IbeOTK840aQsWQDDlAT3vpnZui?=
 =?us-ascii?Q?nP4MnlYFr2AZTXxOzZUPFaKqilPj9NyjkYJaw7GzIrMRUfA1Lha1UPccJQXU?=
 =?us-ascii?Q?0gc0utrD4EKvfEkN+qkv+/B9doupcDIwpZHv/3R2XTjnRk5lYVib08q6qDds?=
 =?us-ascii?Q?aznG+H7ZaCQ5xOld4WUOCfYq2YOhOXMTmekAIbYPrH56t7V+GCd5NNOk9Fqk?=
 =?us-ascii?Q?KN41CjO26ZK8jJdaX/BLL9Xroo4s4ht5+9LOZzBqj64/Xtj5a1MLXco1ScPB?=
 =?us-ascii?Q?0xdhnpdpNcS7cV5W9ozMT8RwTJAuQiHsBnQIa6nvXwOJgk+Dm5epJEgRBQLK?=
 =?us-ascii?Q?SlqIOCFZH6N9a2XTUqgBe8N7S/G535CROJMaxYCxPdpua4boQPoV9ZPIzjjZ?=
 =?us-ascii?Q?RT5rHK6BomnYeBPLamAlUrOjht+R9G8s+gIxcB62nB0XmmYC+xHJw4i7g75S?=
 =?us-ascii?Q?BoAbIw6SinxzJfgszcHGQeb3EkSoQWOkXg4kcyJmuCruKvscpECAssOQvwh4?=
 =?us-ascii?Q?QRIwla1HlyoldpjA3tOmM/0uNLM+3D0fJmY2kWsP7VMNA4cphAg9RhnyHY2F?=
 =?us-ascii?Q?iYtw2kIYtnCkJC2Z0m1TJ+1jJG4hk6piGJeO14J+7nSSzRvCsVEjNgSi61O3?=
 =?us-ascii?Q?ekCRlwzrSv1D+ewVL+unlnPk/hOqMd2rEgijWNbMKADhsK0ZH9fd5zj0ZVaa?=
 =?us-ascii?Q?3Ec7C6ji05UKqxGx/akopFsvKvryHpYIdNmukWRySyjTdMEDAsPrXnxuEUCI?=
 =?us-ascii?Q?SCLYGSJjH9KyBsUWsQXl0CZuezaURKF5CyeVs5/lRf6M0AnZ1mnnpJRSW0Wa?=
 =?us-ascii?Q?l+526OH+MbehJX5mYoeCBFFQGM2KV1UlCA4ciz507OWgkI2vBulI/1JhbQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:49:12.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425ff62d-3a05-4894-3b4b-08ddfc298c1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305

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

Find V4 here:
https://lore.kernel.org/all/1758528951-817323-1-git-send-email-tariqt@nvidia.com/

V5:
- Force the usage of the new assembly code for ARM64 systems only to
  avoid compilation issues on other systems.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 999d6216648a..10d2685167bb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -7,6 +7,10 @@
 #include "mlx5_core.h"
 #include "wq.h"
 
+#if defined(CONFIG_KERNEL_MODE_NEON) && defined(CONFIG_ARM64)
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
+#if defined(CONFIG_KERNEL_MODE_NEON) && defined(CONFIG_ARM64)
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

base-commit: a1f1f2422e098485b09e55a492de05cf97f9954d
-- 
2.31.1


