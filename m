Return-Path: <linux-arch+bounces-3594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170D8A1CFC
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9656287A8E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D511C6884;
	Thu, 11 Apr 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WltAjyD4"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D11C6614;
	Thu, 11 Apr 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853992; cv=fail; b=WGlroHRqQwECawDUZq9TWRp5dkUfzMVclguFPbuv83YjSywxfRUI3PxKnUstj6rcxIIjbzSUDXU4ZNoLDpE4FL5mqyLjEYog46ZzSLrghXmijwW7HAcm120H4PM0RVZqD5xt+EZDEQWVqYTIWHJCFJJwHv1t3BawpVBcAMyHKSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853992; c=relaxed/simple;
	bh=8X0JGd6PYwFznOK/k+8Q/tJawDZXr5NfPUgiV3pVVTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLCwu2mrOdaypCRW5udxzPqooNv5KRt3QaaNTWKs9A8alDKCAqCwe2QrrXnZzX64/cqQRYR6KYxNjUT3IhHmxO6AuZj1AQevak5ec+EoR2v/d0G+eOFmykv0de7NOLTje9jNIXqAE9FZDaJv2jWcGLo/TijOWNlGJLZbFmtR5N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WltAjyD4; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfetvjP0bRsA7pApjR90PEzjVf5iqzjj4EwUMwx1GS0WYSxbAQIcMzvy1lG3hSBkCKsASjNCVfDwg4Hazwgvxlp7vzkemALmMOJILISl6F/czFDSqk6es0MGP2ohDSzVlVz7ELm0xJY++fz8wpYtLlQtOiB4/aPuRHa9kOkZTN8X/Z1zbkU3I/K2Vh5+MmUZM2r/MDXzdTRK49WHtHSyAvYb4nfv4NLgaJMegPbASkVqZ6QPVp4Ske7iPCQC+zS+mIk2LIeu1KARWBlLouQit0HVQysaWRjFSVqkFhzb/yVnG6rJ+WosRe5Bv9qS6xyexXJu7qTBWi7kEV3SY//KaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL/+1Ovzzk5ip+yquiKZoDvD1L09FZj6JaZuh5HD2sM=;
 b=W56kkzgzr9xa90yAWcPTo4mDU5iV9gRBqTDmYgJVQArgWFddISXXwKw7E9vrBIoddEI2IFaqEGkWGQTSzsx4E4PqbgheUZO6q+cTP2OHrZR/bqLlDcqmNyFWXxQwe4EoZ1uncYLDuQcLAWqV+0c8J6qTAZTy5gnJzLjRX2WlS0vQ17hXM2FAHRIn9berYAJiIsIFlTHP2nDBRDdxoMXSBZi9KYLMDA8BKUxalMrTtdZ174ftYhgoqRdLyxEpdQ6SvzsgxeGfAwTkLIZ9knedWdN0epMGlT5Qon+iGHkh6gel+bUHoUn7tK/KUVLTHuNGwzc0CJV5zeaxQiZ6dFYEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL/+1Ovzzk5ip+yquiKZoDvD1L09FZj6JaZuh5HD2sM=;
 b=WltAjyD4WBz27CJmwOp742fSbs8E3sJikV40Ffa0MXy1S+DP6iuKIByZ5I95ps4eJ0eCyEpIeXb3JEHDfDBKfsVevsEPnKQlcBpFTS0Gm+XTDWw1EBq4bEV+WaryC8atHfSlymMuycaekcC/Ar+d9v+AzPjobHMe8G7kTAcsySdAtSNvx74pm94Iy3+9cMZMkDtQZZEwskuB5vLYEBbaz81pL0SMYJTZMe9uY/UNO7KCG4KMmqIEmHaDz4Euotl/weUdBDIP6ZJQQwWgMKRfHZQ5BA4bL9ToyPbOCTKw7mfrPZf+hy1+o4ue4bQfZI4j919RdztTxznFYa2BWu9Skg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:46:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:46:22 +0000
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
Subject: [PATCH v3 5/6] net: hns3: Remove io_stop_wc() calls after __iowrite64_copy()
Date: Thu, 11 Apr 2024 13:46:18 -0300
Message-ID: <5-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:208:329::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 162f02e4-4c68-4f16-202b-08dc5a46eac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7JAzZB7dIhZczOp87EmeQ3lo4R0RBRwn9quRWo3Az8U065VXuJTfjNHCCWWt/2Kh0T9JPZNqMYTCbxmZi3cXDDuKr+jqIkJooQ9aJM7xzy8yts26tHkXzPU7xHzhWS89dZ66HeqcU5Z+OokWjnbuk4Beo4fvPAVfnKphT0qVQEiSa0S83gATAVlIoPeyzBfFrEXZdfczbbtpnuu68C2wmncUxuefAdK/J0R/XvJvVk+lGtqc0Xi4bssFDvLxKBEv1IeegF2n6fzsQ5OoVTlY+dPBJPbyzOV4v7KOn4EV0Lj4gkc+eg3nsq+VtL8O82gBF76eeoMjuz3tJ9GFTstYygc/4QnIQSqm80hZtRzIbwmSUaa0qN9jZKO0mv4XXqTSurfvYhhzdwaidzU1d3FCwfkN/ZelAY6I2rt6kmZIkeN9VkiQrNvFoCL35fp/YvIimn+YqATQOt7mU60ZIeEt1V+4RRMB6OZlBuRATGs9ychXd5yzUha5xWojWMH85A+RVX3SvoJbBzH1K5lj60ImuyDAb/R+H1Ag5d0UomlosmXBH7puyJzpjfVM1ft2zoEc3X3viXKP0vGj4OcOKheCvQHr9JKOyLBJJXiA6s4KSbPJHNJmxP7PCK9G2aGNDSus52jC0kkHrgAzFliiAAiRHf2Inh4wgfeaIU+wHFBzeFcNWOst0mvb0OqmbS/4x4ZU4Ph2uQ4gyjD3mi6Z4/Xt2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X6SvtBQW9hfgnqqofhbe4drSqngbPmUuplwZIDmBET/aj3Tdq3L8tT0gafPb?=
 =?us-ascii?Q?Dj91vcTOdzyFtdEonsJT9Q056tJWieVbV/JJOVWGKSSVlDvD+xliMeL7fhFa?=
 =?us-ascii?Q?veEfiR0RjpBJ1Y3VxL8K+HqeejjsTEPgjOp2HtCIsnm2qbTiaaOxWqDfGaVI?=
 =?us-ascii?Q?lnjwRMZlzVyGIRrgCDA5GhZccvjBUFimCKO72C4SuviLffJs2MIjAtsD749S?=
 =?us-ascii?Q?4w0qT70vGqidR13rZ68rwi1ef90NRGAE10kD2SpsW/NIqx6tiQeGr1Li0GYQ?=
 =?us-ascii?Q?90nPwxPFS4bAr724bt9v/e/4Q0rcxoSfR/HGb87f4Ap3Yly3SHPAqsHEYcX8?=
 =?us-ascii?Q?jGFRFMzGug5VFs2JAMTpVYXPqSisq8rj62Vlvez/Mjnuop4WxnoGXDgneYtN?=
 =?us-ascii?Q?buDj68s4kB8L4ZDf9vBaMLGGXqFzW0GjTLtlbFKdM7gxlHBLuxSLhNzRvEDx?=
 =?us-ascii?Q?FeWm3qpWfArRm79GNGdMJIiPZFXnK/xCraATVbtpBWWYNn5zJzw6uUUBS5M4?=
 =?us-ascii?Q?BSZIsHMcVr0CVDBHju+CgrCDesc4f/lGuLaDoUHwu+skR8hTMs8PXT2hvs+K?=
 =?us-ascii?Q?xpIq0CLaFodyciYRfHRVUPBQh2S0iJsAaNxX7LN/rR6BmQL9uDzyiP6vq9bO?=
 =?us-ascii?Q?CPjUYAiokyjsDt8riyaRdQbhe9l5uIyatWS9FmlyJw96y79uBIiZ4+STBxZv?=
 =?us-ascii?Q?qARu5kjfBIuheIUS7Xp1fDLjYC/qdTdLZ252IPVZ7APwYp3342ZcYxUhTIaR?=
 =?us-ascii?Q?wKODbE9MuYduzWjWrGgnseGi6wvkIPuNbI782LbSgBPrALbzUFvacuP6Hg0c?=
 =?us-ascii?Q?On47qkusCFCob7dl3sSFC/+oCkPkyOH24ipj6JZrszG4id6r4y+jpneFN4rG?=
 =?us-ascii?Q?5JOsOErapLclINz87WubDL4WjoQ6vkChlbDEdnMf5WrTCFrRlx4fT71ORB7f?=
 =?us-ascii?Q?AXPZLyty4Qc0kWs6lGWtSKtvzu0FSc1+Jpsut65he+Hhw3OWEJENDGQQxWdZ?=
 =?us-ascii?Q?pM+zu7FSjBWCb3uJ08FR0Viyt8OC605gXRkfzHv3tRaoKSNv6IV80LJAwc7S?=
 =?us-ascii?Q?fYJxfNnA/P0cee8voVu/UUMZuhiAOjy0r4CEh0Q21AQuYDtTvSDncwLtGauD?=
 =?us-ascii?Q?lLggBD9vL5vCdxibkQiRwcebSZFB77QMcQircK46RfUgyjKfY+mWRNHLymva?=
 =?us-ascii?Q?/CrZLlOURV5rxKj7T1hgKi34ciEpNBVV2SDecUZUZMPhI1Qgn5w+LbB26TTS?=
 =?us-ascii?Q?b6MBs/+4FhfUqbZ7NUX+HdeWlA7SSk22KwdzFt6IWRBMKN0UtmamDeyZ864u?=
 =?us-ascii?Q?sH8qiLBLe3ZB/a5HvuXphWmMGE+CyJCkc82A7d4124yn7l1nrfc8fBkGUrZ1?=
 =?us-ascii?Q?1WHv1f85gT0ITbVhhDdUSATNhkp8AabJkn0azJIsl7LAAJyF310Dz03Pgnx3?=
 =?us-ascii?Q?9m4F1LoeV7sqKfmUCEXV4MwDYzcEcdiSiBOSBHeb6KE6d0WNIxxVew57KEmH?=
 =?us-ascii?Q?UN4XIeGnhbKKPiSDlyEjcMd7rJMocHC3ZrLyG3c5EkjXTH4oevGHza3iKLvZ?=
 =?us-ascii?Q?Fg3KQ8XkcNcNgJyvGq+QulfjojqsVbEUw63PSbaf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162f02e4-4c68-4f16-202b-08dc5a46eac6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:46:21.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4Vw9au7lLe47jv4H7gUn9+gsAiz82wDhVtCX7hsISQylfWL9cWHdbq4E0Y3Nkqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

Now that the ARM64 arch implementation does the DGH as part of
__iowrite64_copy() there is no reason to open code this in drivers.

Reviewed-by: Jijie Shao<shaojijie@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 19668a8d22f76a..04b9e86363f8fc 100644
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


