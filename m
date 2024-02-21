Return-Path: <linux-arch+bounces-2539-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A785CD5E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 02:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3640284974
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A148C15;
	Wed, 21 Feb 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmS9LIEf"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B345748E;
	Wed, 21 Feb 2024 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478266; cv=fail; b=FOsqxmEGx2ijI7KPeLMgAa8+ngyWx7G2dd+O1bDr/uCW5ygy6dgVu33uvCq1BNx02TKFMI5blcWHBGocKMgoDfQAoThJBEhOYPhb6QvVj4oXQTIdY6oCqWNM5OuPuZZgPKPEw5Crlxo/cpXUW2AjfBRmD7eOUu8HWsmXdHVEIQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478266; c=relaxed/simple;
	bh=VIHA3Mvya4c85Qxw3FIBjS4O9w2g7AZKsgoVcGD7yfo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HPJOnGr/QFTidQkdyU2wxaUvgMogkM8b8U/Eg6Dbp1al0B+gEp8qDqfW7luY+LAaDm3lmNXRh5i/P+kChtPKcyJMCbvoamalAxGIbJkV6HmtnnNjc1izTE5QJPZGkEMSfltIkF9KjzM6XTtKP4TIkfzgbd1FryNJWwDa7bD5svk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmS9LIEf; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au17HivPtKgwTUwsIsVe4w8acB/YnaJca9l6bdKojKgPnF0o5wZ4l2LNTLQKkcw7WOdnLtlRV6VZ9IfraVzuLtp3NlxN44kZVCgwJHZt0Ze0HmygRF0O9UI4QP7EjiZHKKTnJbZcN3ZFL6r2rhjmT6BdSyc8bEsG7JfNElL9MsIs3D6SdSLWx9Bo5WrWsW2DxNPEjqk+t+QsHo0Dt1s0sSyLAV7LkLpqnYW3bMjjj7bssffUQfJWaPAuEw8Lt5IeP2zbz25Zdr4PJFRMecntAhpUUzX7kF5ymyUbE7Fdo9+4I35i02tmaGwk3vd/yTkoSwZ9zm14y8Cx6IdVZ4k7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW7ie0e+X6dYg50MFn//UM2JmFfloVFyb957RHrxNqs=;
 b=UlS0uZydyrkl7NrkdT2M+kG0FODgi8Sup073BddrRw00eMMSynlPplpzMeW3vDQiIaaPpV9z27Ki4yubxYbpgPa8wZioYh4OTbNELyV2AtOffB5fug90xrZzir4wAUUDGA0CwsO8yx51E4EOyMwYb+BCmGeHh1mTPFPsBZmTOYD5+qfg+8mhrhhmYSTAFr33co28VNnaofRvlwhyAtzQrasq9atpo4otRP/ZssRsTbgh71pE6Msrm2HX9iK+Fuuw8tsZ1ZODbxkeheA3x9PKCoJfisxkiUc9X6WFsKX6bjQ+O7x4JHpUgRFL4cu36+xw9MpIM9qDeP/RLuAFuP/33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW7ie0e+X6dYg50MFn//UM2JmFfloVFyb957RHrxNqs=;
 b=jmS9LIEfF1yLbZ2MGkg5tNLrblHgHHUbR9Xs/1wUITnOWgN9OiKW1ZAhC409weS4TGkB+Wfj0yCejuLi6L0ZQuvNCo3nm43msTr3xVuHYOFnSd3zs+rVdEYwQl3sC8JNDfsQtrmL2q5UnAgeuR8q5jLiGutW62RaroHM2votXhbwoAKvGnhkcCXjK/Xo1nbM96MpwinwJDwNlDxOORwZkfD5aBCsXdhGNHHdBycW09xVwZtx6F2K3zPie0hfpOPT3JXcprWImb4pfLGQ7w86Jr4/aziWoNZ0GT2LFavNh5Ut7RH8Exgwp7ZcEBEwqC2J/tgli2rUB2TMfAfC3z6CEw==
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
Subject: [PATCH 0/6] Fix mlx5 write combining support on new ARM64 cores
Date: Tue, 20 Feb 2024 21:17:04 -0400
Message-ID: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1cb82c-6cf2-45eb-b721-08dc327ad4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mjzQ4IR33Aude1JpvBAEco7oIX0GN+ux2Sb3IvDNnJ5ttnC95n0+XpbQ+nso4xAtMhwVuwF5Mmp+yvgi5s19PmGG1eyNf3GsFzVURHyWuE0jiDpBGgvEpHD8fV2ySJvnjKv1ovtlOCF/Z76R0I3F0Qrso+36UdxPnlKo0f9KrNXq24ZTMZFMSco98piUOoUPlNtgx0hTOCcEDhPZX0/mf8wbG+PxyK+/jiDHWgtIOyWlCu1+Kyzpwh/lhSvgJQAuQ6sRBh0iEBBQT8XZRI5kVQCBBDUeos39R/lZFLXtv5zWe8mtL2acdO+4bLSINa0vHngaOlTKUcJBk1BlAr4yBSMR0PzwWI1iVY0yUkY1kRPTog5pX560523TisnBVjbyAB+YwSS1m0bl23Xm0v4u6U1e6URYQkgQjbftyzRkMi/2eAPl2E+j7kV3TQMYpxu5is0jG5RafIMyxWHeeY1YfBM3qCLXjDbRutjS/TloBG9N88FtnxyRijIjtrLsaaoBH743Ko0ttwhNJRzPxgMnWDvHC6BlR3l091b6L9B0DYe+Kww4bO636lgQ3Pi601ADMBxblA5EfL7VRhRuNFn73I2FnONg2AlFSJJ3GxE9HgURlvituQF9rYn2KhNguzB2jPh3erhgdijac3f+iEARhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mySvtt5aiSypU+XvFca+es8y6V5upmdpaiDMpHgApiTVpldIPRG45s4a9/uG?=
 =?us-ascii?Q?WlF6ExFkNEg75xPJlzG3nauYIiGGP5it1y4V7SaaCqmK6wgMJnnGhCo+Mtni?=
 =?us-ascii?Q?tQAJjxRw7NLwkeY1iuicL3EYTYcmmfQVFjalYx3z/QCn9XBB7UBosjNJ1+vV?=
 =?us-ascii?Q?HH4gGx4+LsaHtPB+MD3P4I8/h9rPNF0Jr9jvtb1GamOVGdeYobaDXDqZB9iw?=
 =?us-ascii?Q?QOdMOqd3z08jepAg6zs/HJoqXg7nReBXPfdrAoNkOW7E+Mom4nflEwGqTOhJ?=
 =?us-ascii?Q?NlB8J7zryzs2N5cXN1BsPLOy0bAs/kjNey1T6C8HDsIppzlMwr+J/CGjTrpx?=
 =?us-ascii?Q?8vX4hxcH8vE3Io5YPBWmqNwl70pq1ZqT8/BoUuNJS3Aexmrc0vRpz+JeEdOO?=
 =?us-ascii?Q?D28VJ1boIEz4wiJqiu9r33oWtxm2YI5V9IWtXoN3ifAOYGT9YPp81nlqxhyc?=
 =?us-ascii?Q?nXa2mWMYZaOtmI4mw2ExazQeXqdlv3NYPfc06B4F82lkh/fNgkqOMbPagk5j?=
 =?us-ascii?Q?tmjaJwLzgJEwkSl3MPc1hj9OKxLqGQjXTWIA0q4Y+IRiQBcL5jlYTofZzZPQ?=
 =?us-ascii?Q?qrMJn1erYFJYeC2PV6YFBt/dpVAjo6BfNvE7qjkIUmlEDJvy9iJnEbhlRulj?=
 =?us-ascii?Q?UyzR8dqPltsZSUd6OZOXeuszqjfFF2krYU5bUr8a5gEzg1oxIDjFQ/ES+aik?=
 =?us-ascii?Q?sbqGqhGy6CN58p0uCzQl+YeIiWYW1SfX7htQVro8DfM4R+UkC7PLa4bk0t/L?=
 =?us-ascii?Q?xDmfv3Aelk9APbGXNshL461NBdXI97zV1YrY9vdgIK9SY0UpXg2pf68PMMDv?=
 =?us-ascii?Q?KXmAYjkDSun1rRmYl+sVgCJRdeSmUJSSFVKEyfOJRxtx7Iv5hw1CdQJJpHt9?=
 =?us-ascii?Q?uracNcyjVJGboZI7+CxL9cwcaFfOjkFVQDcdHwutvOVJHKk6/yoIliEpIf2v?=
 =?us-ascii?Q?ZyeV1UeoEvrBT6+Kddf5/228sTeZPFxDuunQLfeaI282vQ4vZ7m9SFR/675b?=
 =?us-ascii?Q?bfwA7c7gbOTZZqz6/T0+KJHY15iGSi/YUFskW6SM/BIUvSs6EJjUptPOnc2w?=
 =?us-ascii?Q?MESOvyp2NawMky15MjErkynEeaZv1H6NBUHbjLbi+gpfC8LlRvJPf2bHARJy?=
 =?us-ascii?Q?oRNkJ0L2nWR4VFg0aLQY7S1TQtpo9rDSoTHCLBJj2n9SXkejqKkIzW1M2yUj?=
 =?us-ascii?Q?2jFo8ZvwITCEJcHzWBxDnbPJC6PMrna50Tb7KrqDeNva1L56xmwEjnKUBe0C?=
 =?us-ascii?Q?i1a5WihZ0psNc70yGW9YWnQk8E9ipzDKJry/6FSeXxpfmiUIAcKVXhfuIq6R?=
 =?us-ascii?Q?hGIZXBpVrYr7a5A599u3SeWckyVfrcaw2P1nq291yquQvZ/IDrq69bjPb5Qi?=
 =?us-ascii?Q?AnHXB4B68EmJ3spbBusOcFAVeAo5y0xItGs0v3LzOR+z2CQ737IQMQQHF3BJ?=
 =?us-ascii?Q?piNQiNtCCwu6Hw1OauzyakFkG6j8yqdmtQDfUvuoZHdZq5mwPGgL/dmk3JST?=
 =?us-ascii?Q?i/24AewbzXu7Xx9YIf0c1WDAAo4g6yVVOWiP6MHSw7shhtulg1Nww7/nUH8O?=
 =?us-ascii?Q?lhowgESgyrUmnMfvMJjSlbakoclB/fAgi3ueb84p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1cb82c-6cf2-45eb-b721-08dc327ad4f7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:17:12.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZm+1tAjwY54wFxKXYiS6iZn4stQtGF7V8WW8nnqoo6vipvYFAiQ/b1Gb72blQZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

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

It should come after the S390 fix:

https://lore.kernel.org/r/0-v1-9b1ea6869554+110c60-iommufd_ck_data_type_jgg@nvidia.com

With acks, I'd like to take this through the RDMA tree.

v2:
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


base-commit: 3856559a378586366dc602f93febe1c57cdc366c
-- 
2.43.2


