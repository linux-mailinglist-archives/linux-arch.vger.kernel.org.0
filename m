Return-Path: <linux-arch+bounces-13801-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E1BA7816
	for <lists+linux-arch@lfdr.de>; Sun, 28 Sep 2025 23:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2633B71B5
	for <lists+linux-arch@lfdr.de>; Sun, 28 Sep 2025 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B329B783;
	Sun, 28 Sep 2025 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8WoeX1M"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF126CE22;
	Sun, 28 Sep 2025 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093725; cv=fail; b=ZXd0HE2vYMlAIHlpg7Fj2INJXzqB02PoPipSXfkhL6rkQBh3ETWqstDuLvbuOqfvdT8szKOVQrXQa1wM+Lex/d0Kpd8e5bp5sZf1+UKQDl8Pg7a6AkQxjlDpIqfiP+Bo0STglbNj+Nxg8RILUNplTI2EMvo5Aq3s8nV5wZnlIvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093725; c=relaxed/simple;
	bh=p7HxxOS6xud3Pz4C9Ybb6rapbt1+Lf99pV5wHrLwNEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cj7DmBM0CU621sxMewZZg/xMyXG3WtF2za5fole1vj2CbX0OXC3Bw1MZt/QbmyMM/PlR6ChoR/gqj2qplq8+ayJRdM94aixpxPFcIeORxSO1Y6203wPFs1gS/qvwuEshlfeEoVx3P8Ad3f0oZczcwe8vcAEeXkwkEqjCuoCjj2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8WoeX1M; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePvNmEANb/RAseR/9fasgfpumNR27tXYwCJsZgdUbFKKRxI9mXvBH26G1T0AGp+YK4mZKDjN/08dqKkHRYr9MKH5xfZmVCsIvaG9UFXEeE+/gR1r6lo3GPekyRKhsWb8PnLUm1fss3pfPsVLlhmZRTLlQMTv2fCaXkQ2KFADJnpV4pIVhhH4Q2BvXETRjrpW8us4Tx7Xe1BgFtFGNhLPV5k0R6MOiOSDDBf3+NOkB0SUsVTXJWkg/KcrMXR6TcrZwtS1ZRW2HrsgEmUu0AJJyJ4ehq/kjqyM1DNlgZ6XZAS7mzIADfe+M51G5dWeY9VViHb+pKXTHHKPWQRo2fMGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERQOZ5U4lQR29ppwd7X+N9EhMaaqC0fe+ildgMl1tUU=;
 b=tYt6pqVfjS39wb/C9qlhjeF0z2lFrFy46LESiYBIkN79N7TTApBAeii1i7KAq3+lR2uyax093QlBni9rR4asb65AB6h6NNYhFf7EcuqcvyemZKt3WA2Q+gQ8P+HRHMUEHQobisYnLRd2PnyECiEZ+zqaIdz+u6yn/dsdc2n9Fswmbpe7LhU6IGPT90RwqMqxZkf6aMXYEoT4W2kLQtGH2MQ12tPcP4Bbqs0P+aAT7gaL2B8Hmg6dOFxuZqyhoZiNSUwcxVvJlzMJcg5KS/JvodyG4dW22BscnfJvv7rhhBUKfvHPXsYraNi80wsalz43ONSynD86HDd9oF06DuV8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERQOZ5U4lQR29ppwd7X+N9EhMaaqC0fe+ildgMl1tUU=;
 b=C8WoeX1M2o1FKZkPnck5TPYJoKAxj1MQIL2LOZ6hm0WmzzD+rV+2MM/xCL6PvpoJoz6QSwHZVgFzohxHZsEbwDgZYfM/tUXkoV6UBzIurHMFrsFiIYn+iGjb18Xjr40xrbuCtv5zAH3kE4nhK28LLxeyXdgKn/iJDfaqa9hTVSKSk+GqdHUbfwxmme0zB+R272Jpj6yhBXlBeHOrWGkfQfLJfNnAvZx7Lb3uEZjYbMsdX3mw81hB89NHIztXCgx4giXyLSrrk31O7re3AzVIuoO1ATJPb1j9FPuJqPKimYolx+JV+2bhiexb6bjDgpPnlET2ynZUzbvW0PLunVgJYQ==
Received: from CH5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610:1f0::20)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Sun, 28 Sep
 2025 21:08:35 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::5a) by CH5PR05CA0015.outlook.office365.com
 (2603:10b6:610:1f0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.11 via Frontend Transport; Sun,
 28 Sep 2025 21:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 28 Sep 2025 21:08:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 28 Sep
 2025 14:08:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 28 Sep
 2025 14:08:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 28
 Sep 2025 14:08:16 -0700
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
Subject: [PATCH net-next V6] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
Date: Mon, 29 Sep 2025 00:08:08 +0300
Message-ID: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 597ba744-f635-4e02-6d72-08ddfed32f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kx1sOzyZlTZ5VOPaOQgVPQa3ntYclUaKRdIx7ChoDCAQ0PO7Tv2N9UVgivQb?=
 =?us-ascii?Q?ZMXZo6a8Is9xta6H08qXd9WYMMBixWHwmZN/zMI698EgY6to6sFvkbNVcVGD?=
 =?us-ascii?Q?fsUDGvKvbKO9tKvBL+9HXkwG3Zslf1iNZGpJH0owfzVmAT+5WRrmmiVUS5hx?=
 =?us-ascii?Q?FX6YZZKpXq2sSnAoYeu0FAapZEFPATZ9dCrEEWEpIk322EokphjaqYj4si0m?=
 =?us-ascii?Q?vN4pGWFnEiQ4yFzjg3qSdUjgFu5kqT+pnKnFhBSuQjyvDxu7MccXThacBxF2?=
 =?us-ascii?Q?jzcL5KlPZwRUuRft6SFjdFDyshTgG98ETnkwl+nPE4MsPa5d2khI/xVOKStL?=
 =?us-ascii?Q?DMesprl/Q+13OiPK6T1xN+WIczajeSLkr4K3Y7evYFPdnErS3THtD8WURvwD?=
 =?us-ascii?Q?o91zqz9QxOB5mmZ7Jw4iZRpzmKAHCwrvn5myeMvtE5crlnaypqZK0vTW5KbC?=
 =?us-ascii?Q?MxkSmf/ox8s84ndEJ/qayEyjZGVwut3eqveDY3CXnnsHaFVEInuZwp5W1FQh?=
 =?us-ascii?Q?0dZX0UkJc5iYtl1V1/hRFcXWxkIJsJQWbUf5WZ0AHCLN9HO5bgaaIQ12KSXG?=
 =?us-ascii?Q?Aux582/HMqhcCo4Nr1uj8sEJnXStVw+avXrcP8IhVHgx213hdQdLguiqmVD6?=
 =?us-ascii?Q?fjyzHLgXdu6gWuwMivHE6uSnYomDWKFW4emX7ieZTOuiNsA3qEsao1OrIfws?=
 =?us-ascii?Q?zdDsmCuJuQj+IJlbYXtP89iAMa1FUfxKqveKte25OWq14lrU37c1BweENIVc?=
 =?us-ascii?Q?vSEPCtehBIImCwB/qSsMqT45ytwZegkXCt1RpeVFLqPuBRvd1s3+GQ2fCS13?=
 =?us-ascii?Q?JHdcmudf2lbWWGS+9w8l9uSZRFdemWVXq3uuvFeXVbzlmiMob0VwM91a1LdP?=
 =?us-ascii?Q?u7S4i0O4FnZLmLgwjSN/Cag9oSHnn6G+deMDHn4p+TxWZ9AqmeV1cItLrMLU?=
 =?us-ascii?Q?bKGJsp4f8k1oS5iBk5HCCHL/k2eqmNX1l1e62Pbof/3RkeBFfo85oPbZojPa?=
 =?us-ascii?Q?KQ6yJCJvmwyfgvLFzIV83HTgooBuuhLJ1s/LIqW2tahM+/3cD53v53yqnJIB?=
 =?us-ascii?Q?hQCgbiApsZT0aKlvo0bBCXkpgpjL2xHZ2ix3OLMJVPJDnxFQCVI5ooKl5rAg?=
 =?us-ascii?Q?jesWC7+qvGUMTTxboMXEPNnwMeBsKhbkTpn8CgV5YK8oKruwdHMq8FaJ0ECc?=
 =?us-ascii?Q?vMO7IZ4a8wMQCnKX2S5RH5imS9VnVGZaO77cF4CIlDe7ezHOcwwDzFSdMxs5?=
 =?us-ascii?Q?TP3eQKKCChGINFCLnMwxGUEmLUtgaNoUmrTywtY5CcH0Ijvf6c+slVmVSItd?=
 =?us-ascii?Q?7zvOQnsZoS6Z8L8VSXw7Pe4jjYRzoMXR85mdsNnDbCbLJQ0ahp9TqPPaKF6X?=
 =?us-ascii?Q?sNTro3qJr4KaoyYeLd2/XLme5jtnst9jCaba3jWcG8apcA9Hu/iGPAzNmiye?=
 =?us-ascii?Q?ke4FvmyWEzQJ0dRbQQlUwVSth6c+iNB7DKoatHIQdOGPMI6EcxPUIzBvHuyz?=
 =?us-ascii?Q?Zc+3d49XaaLMRVhEV4U5DvyRJ4xqK6+3p8AmahgDE+YUyG7EuQct0voSnELk?=
 =?us-ascii?Q?9K4k7I5+mRhLgojVjfqS7BLFdZ+jp/IjVA7OUjJV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:08:34.1097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597ba744-f635-4e02-6d72-08ddfed32f5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

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

Find V5 here:
https://lore.kernel.org/all/1758800913-830383-1-git-send-email-tariqt@nvidia.com/

V6:
- Replace defined() usages with IS_ENABLED() (Jason).

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 999d6216648a..c281153bd411 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -7,6 +7,10 @@
 #include "mlx5_core.h"
 #include "wq.h"
 
+#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
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
+#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
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

base-commit: e835faaed2f80ee8652f59a54703edceab04f0d9
-- 
2.31.1


