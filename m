Return-Path: <linux-arch+bounces-2533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9D85CD45
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 02:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B957A1C228DA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 01:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6536FB2;
	Wed, 21 Feb 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTda1vpT"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90542CA2;
	Wed, 21 Feb 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478255; cv=fail; b=XfIXa2oWbjkG2dcLfD3RYWXKg3a20LJ9MukJuxhbJdhdSOaNa8iRrrwNYBn7Et772/wOrwuYTWs8/N+gpxEHlIO50fA5Ijs0lREiXiQJR48qN2tUI09j2nTuXaNcCK/RrBDI/nlNAyf133RR88VvvgbjpAi0MfhSrqddx9/cJPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478255; c=relaxed/simple;
	bh=fk7fcECrybDUha7s5MgcA7pG+5Gh1uF3c7JF3N/ubWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYS+j8/POnSexoyd3ViRiSUz1BCEgbhNyjN7lclCylgZCR7jKzfQwHybxoyLh34bXIhkG8Zs1ZEny7a/PjtnyDOY83bDnpJsZSl1FG3H2c1nWOpzUuKrIqDCyKlkguTKoDJQ/NfdVyPWYFi2Bq12T2QnQ8L0KDugQPL8R97CyxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTda1vpT; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM8NrTQ66jERFiZtDH7XbAj9uBemMPkdD5wWN+9tHvyzPUe/pwJuIEkXFo3ZuF9NtLzmzdk+1IVotk8eORNS7XVrKEghzl9wymqI125fKJ2zL0pmmD1jKz/k3e8toVrn/EySPdpA+fXy5KsSteZ4/6Hey1w7TF+fUpNA9/vorT5q0vYyAEVbQzoTg8RaDgujRD/zIw8ppvWbMwKqktxGTpUzjSCzWKKDYWB5aD9ugM0EaWC8wDnJKBd0iiNCFtSrX8a0bFEGHhNRwzUjaPTAf1a4CEfKM17Q0YJB/yWM9V3SovzGatqaHPxw20PKl51Y2PZI8O/A5HPvEP59N3Iavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVx8ZHtyQ2mJAYsBPQbCm/vB3XwsGVOaRto1ttd02Po=;
 b=Q//ztglfRh4J7l/K53kbH3KIjWUldAQbaKUf/nELDuyBLn4LJrQbgdAIcjnH698DkfRudSf+GDJp6awoXrgV8m8QkHfQxd27FxA288feMlgLmfEJ+aZKyccBiIaZsjUAXdq7Vf1abi7jM+/s2T20MCdSq397ml6Q0uxbjx4kn/1ygsYARFcgAqstBomrvd59eD9jnN614T0ANUj9xr/Hit8kanejPwgBy6n8FHzK6A0BMHSnhWUNraAxZw1Br/qoptD64czAGO/faQ8YJNRyU7mCJNRHjtdRfFxH4TXn10+IOFe5+wjUmgWNrcntaHTNg1eJoxj1IvgKPONIt7ql7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVx8ZHtyQ2mJAYsBPQbCm/vB3XwsGVOaRto1ttd02Po=;
 b=GTda1vpTZB1x5UgizbvA7xRJbbb8Ls5VC8kTqObIg8zs19GdBs4fOIn98JkgwJpfAPDw/e2Q7H6V6VY412AZpuq/yUnJWUuJmp+Cl9cAxOTsD/jZ2+eHpJVz3kaehCTojUsx9PgF3mfVDhjlirRMJoCbRxmv2zY+yrILt4lLV1tv/uJ8cchMmYeo7i46coXe6/vCmUHcnUlfNnVo34l47TwkJFjsXpc9cp1waOsBfN3s4vv1tXMlMf5x6K0h+udnkOINXdncjmpbhp4SbfKvrlP2cFaZNWmIVIO6uFzx4f3PFeRvfk1Q13LTmsJ13TaOthz0PG4eTc5CfxDLhpuAug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 01:17:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 01:17:11 +0000
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
Subject: [PATCH 5/6] net: hns3: Remove io_stop_wc() calls after __iowrite64_copy()
Date: Tue, 20 Feb 2024 21:17:09 -0400
Message-ID: <5-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: dff2ebf8-f514-48e1-b9df-08dc327ad476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SUYm0LcrRTVi6ZmbVICMh1j3dXQOcxtnwMHx2eueW0Neva5BTpE++HHvmY6Egm6G9rnlKrqL4MGhGFKitiSMACdqX51idLjsAxiCnVNUyyGiMLdsicNljXE9P1TyzCxaf5YM+BRB0pI+ORxTmShFPRMj3MfKoUD0mvCASrjJJCQhvX7SiiYwAL0SknzRynMflYV6XKlymdeXYZC+wrLjD9i5JLrGeTY7ZIZTb9nqmXGC8ExeckUsxXqHeC5wHY3LN5iotKSk/93qNlwMOeIzUBTKZs+V9KItRYToObQwrZ11ceKS4+3GrZXmsB+zpLjGXnVaI68mjoZzdeQjjfxswfxDT22ATk9k2CvLMHyg2EideKssQwgsTeUdNLgtLOplpVzJ9ehlGRjihlv8mfVV9ZGraSWW3/ztV5z1XCU/scmLdAtz6b0itDw1sQ2v8PHyKSTIf/3/rKqdwMNVqvR9tv1i8Ub6DlUlqLHbrfYaAp6mEhWTzZWZqcC7M5pNb/gHVeVTfffgvBpCoOPBAzp6VXp6iXu57LdkoyWIV/UlM2gR3rX7kFyp/n2l2Lb0vdUn0KGNEhPxLrqldSJMIQkbdSc3w/vKtlbM94cdBgy/ef0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wIpvvUj6hi97HpuRveI83cGVfJZu8lYkjGWsdJPN70+6UlGAMUcGaGhX35X?=
 =?us-ascii?Q?QMSPvxzW6LXKpHMYITvhxGYakTRpdv8dTfXW+u5zbjqTJAStu/xNaCxL2VnD?=
 =?us-ascii?Q?3fDf5ecVwarYThu8uNvS4CEaXTZLIV9cDqlyfB/3yjM1uyAxms/tY9PxKgza?=
 =?us-ascii?Q?asyeoje/VSB3+x67ZnxmputXwK8mi3v5CDNmdxohGIKzxogf4dukz7N+Lklh?=
 =?us-ascii?Q?0yNvfCOACZpNZ8mqwbIyS3r40pQQC+RaYn7RpHL7qyHydxxZqnDgW13o//aP?=
 =?us-ascii?Q?d92qTQyzv95qo+HVnmPi0qbd7yVgfJA5k7yp9tVK35PpkREjRUq+lhZccxZQ?=
 =?us-ascii?Q?mQkojO4Q2ca9xuKoxXKivHjNv2Fnsi4uw9M1JCUD+aBKRfVUJITwuGr8JXPW?=
 =?us-ascii?Q?oiyU4C6k+KdwgX7J+McJQR+XIv75+OE8Hagfg4RgqavBORUDVG27Lcryb0X/?=
 =?us-ascii?Q?hp4HLUlTYrTKpgyHwrLXICfdbwVHfkUskQcaeVmfOwrGmcd6vTS/oUaHMFBW?=
 =?us-ascii?Q?CbV8DPZbqiQc5bItoYpNLKYMOyXCuWOB1D1nnd1RmJr11FYlPq4XgVP2RzOv?=
 =?us-ascii?Q?VAZ3s9cd/gdYcKhFRjD9YZ/Oa5tBbrBXDdOuyOq4EZaSJZJRP7iEAVH7XHie?=
 =?us-ascii?Q?+4IoHeP0WkbgwpMuWJXM9pEdtqtLXlOOJhf4MFpBC09ehE6ZbGTfc5J3LE26?=
 =?us-ascii?Q?S1awAgRhJ3TAESIVNO1oqh7dW6FAcWVWqxSDOHyRfcd4Rz7zwu7gGkRQe94v?=
 =?us-ascii?Q?zg8+HFP0dprQTnV2OoOJTa3pphZn69HwISrEbVxadNGNWw4ZvxP49KUSND/H?=
 =?us-ascii?Q?wsau7H+gP1ZnUGaDuoleXQtOftlSyDqoBXm76kSbj4GhMUplJKYu/MzjtY7Y?=
 =?us-ascii?Q?u7d809g4HzRHBRio72DWRQ1yc8ucMTgRkmMV7R8kt1e04enGi85oy8MyWb2l?=
 =?us-ascii?Q?L4dhE1jyMz+hjBXeiP7yIexwbDIjtyZcCE6Nq+uN9B9NCRSSYbom+FdTAOYh?=
 =?us-ascii?Q?8PSy2A5Bv0wgyDMimAcmhBKef5EZfRru5PWQPDxAW2Zic+pO+kKPXIZSEhGs?=
 =?us-ascii?Q?48z+NjwOFvtUBRVtEKS55+5qqiwXqbFBsnv+x4jayh22P2EW++mMiCNPS6dT?=
 =?us-ascii?Q?mAm3sKA+lGlwi48JljzdV6KBChsUPjJ7tftrV9X1BMatp6aJG+wIMt6vdsuu?=
 =?us-ascii?Q?lS08Vv5LJgeJ6NaEcBCt1615bTzQ94j9KKpBzYRlZSvBWh9Msc0KLPwLsMom?=
 =?us-ascii?Q?ovCBUPPWtgGPZGXPCxoYOVHHe22uBY8QqrtcwFLUrlVeXv7mF/rM1+jxSW0D?=
 =?us-ascii?Q?5GeU1+hoc9o3ddYtLy4GASwaRzPCdmXD0wlxmGXs2/j/T390gQEZactOlbsc?=
 =?us-ascii?Q?F//2B9vI0L3vWl8Um3mYxfPS+oP6vr/z/6pe6tBMXlFglFv3tJkz/CTnLfw9?=
 =?us-ascii?Q?1gisci48Ds1KpPPdDnP/bDKrLDi0ccmZ1AS9qRgB1SMZ87K6shg9Sp26jS0w?=
 =?us-ascii?Q?GiuslQuw/09mpfx1G2txAvNWp+s8VfL23jloRIZLDaWlirRLK+mfk2whtt7p?=
 =?us-ascii?Q?yN+1nC8EHuNg4OvABxV2F2ehbNj1kIF9iKk5nPeU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff2ebf8-f514-48e1-b9df-08dc327ad476
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:17:11.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5LgyTOVv825kQghPkcnCtymbkdgi2WgvQTEqFJhv6pL8ulD/iTEOXT9wFWQB7k0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

Now that the ARM64 arch implementation does the DGH as part of
__iowrite64_copy() there is no reason to open code this in drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index f1695c889d3a07..ff556c2b5bacb4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2068,8 +2068,6 @@ static void hns3_tx_push_bd(struct hns3_enet_ring *ring, int num)
 	__iowrite64_copy(ring->tqp->mem_base, desc,
 			 (sizeof(struct hns3_desc) * HNS3_MAX_PUSH_BD_NUM) /
 			 HNS3_BYTES_PER_64BIT);
-
-	io_stop_wc();
 }
 
 static void hns3_tx_mem_doorbell(struct hns3_enet_ring *ring)
@@ -2088,8 +2086,6 @@ static void hns3_tx_mem_doorbell(struct hns3_enet_ring *ring)
 	u64_stats_update_begin(&ring->syncp);
 	ring->stats.tx_mem_doorbell += ring->pending_buf;
 	u64_stats_update_end(&ring->syncp);
-
-	io_stop_wc();
 }
 
 static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
-- 
2.43.2


