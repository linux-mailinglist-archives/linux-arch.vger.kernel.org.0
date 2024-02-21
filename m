Return-Path: <linux-arch+bounces-2534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E285CD47
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 02:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC83F28484D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3306FCC;
	Wed, 21 Feb 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HbZcq4o9"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFB1FDD;
	Wed, 21 Feb 2024 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478255; cv=fail; b=KcTJu8s7rTOjRl/msP/F8cx8mxJ3lm5aSeG5JeN7pv74yOB7E3U9KIUVdupHsywRx05aOuN1Wmr0o96ZLRCMzqz9niV3cc/lW5ccHOpMlS2qdmrOIPuBsm6sE1uFZHmJCH8N214oLRM8aV62QcH0T8bxidAS4K4v7R8zMfyCUI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478255; c=relaxed/simple;
	bh=tsV8gCWR5LWzBTMNb04lZtui2QnvJXY6BoVwlI0294Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upmMHRCos90WDvBA0eybiYEDoxf/E/AmL3gcmoi33ccjeak9JJigupNg1uTqEHuYEeI/Wb2pOplAjg/kFx6LBvtmdPhH9Xr3MsxMzWujuNgONw5VNRJRBRxvuZX5pEwmUf6elFB5qw9463nVBWJmzkSEZnq1K/v7G8vYfd0Ov5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HbZcq4o9; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDB55eS+bouWFN+xyXFRhLARlZ4Fma8s3liDcpgHM+FZrfj3qP8EmjDsZeRZ8KzuuF3DEoAtgSn9aEHQL7rxTa8PvqYZgqDWX/YhGVleVakh9OOJP/uWpn6SUwRcpeNF9FX1NB7m+PHaQgggRbUcZRYJFmQ5UfCRPaaIQsk4/WXB22DnSFk797KUXgGClUqbZh0CwQgTC7QnYfEusYHtIgTbbbQGs0kmoxAYerUAsuAGGONTU9I6X1lXDR+/qlziK2FMRAif+U61aKNtpvsQfXoK5d1Nty8up6eM2nAkN4teJxW5xtNwLzexs9FpgCmHPoh8OSRqFygqUEQwtk06gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCBJ6dLMHu5mQWHFWQoqDEbAiF7nN/N1UtwVHyaeXCw=;
 b=XpCQx51J1YZGt4g2DQ0N8hW7RHp5UreK1PhtzcpHJCT4bMTpU8RRLJEMm06oc+KuHr+AN8AkzofH7MKIXoeGrukes63VCHLAWR2m1KXugLbfu/S9o7P2CJ93RY2bbYwfp2x1IgNJZ/BpNm3ZliX7C4K0+qHroaj+65SVOO9NqpeyN18Rs2VwP37YgTsVFheQEM1w42LzaxEiqINb2sFK8mnxDkSKnB0CfYrHJ1ceNmbAfpCMqmVbgwj0PNZEhVw/bfrjMYq0IHYG6XnW76Rm/OuhOUSZcmNRCmplm7Ep9n4lLOMo1qJdQTJxNAp4h8dAh1HKR10Q2qe44B+729X5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCBJ6dLMHu5mQWHFWQoqDEbAiF7nN/N1UtwVHyaeXCw=;
 b=HbZcq4o9kuGdg+hDYwdPbKTPnq4Zc8wBz0Y+ad4dRclXlvM8bF251R/wbZyAf8ouQ8lUva6hHe5s85ZFlENZPsJhUXXdHLXm13TmL1Agly2+i/32UH4FAd9Ot4j/8y2TIa2qjDwYPujdmktc0EU0w3aaBk0LfUF2OK5kWmtQbzq4tTJWwlfxDjThI1E0PPRWWbsESxAhnbbwxnfaq8TtPh7jB63x3c9ko/EnaS1cjI7v6eysimkVUbUKMS1Xeo+Hzx25hv5Sg595Bg9jkx/fOUn/mr9Oyr/obnCQQcIHZHAE2tihcS8oZkqA1OCqmfT7UuY+byv8VzrAnGNnD33IHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 01:17:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 01:17:13 +0000
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
Subject: [PATCH 6/6] IB/mlx5: Use __iowrite64_copy() for write combining stores
Date: Tue, 20 Feb 2024 21:17:10 -0400
Message-ID: <6-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 503a11ce-3472-4f39-23b3-08dc327ad479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZUsP4uuZRvvTyQEjP7oHdxAB1tkCb7TpqlW2j4G5uZlzlbhe4Q4NaVIZ7HlVICFi9LCImyQiikFEOJLPq1hzGFCurb503Z2uRL07JcROZSsmWXOxpCnEoGXui2IAZrY6aspiTckhaywZ/I5AQ2uLgjURThmUxhzashoA+wBwX+wQvgl9fgnqMd2GNEYT723i2+DclRsyYoTiVZVubfRBl16EQ27TaAwu2UXLIw4oF7rD0HxYo/+5bFWGD4GsLvuKCxIA5RmNiSdg1l9BG3ULR93xngb/s69jHXMGtEYdGW7WHHrRtSIyypIzclKPkOtxojbWVLFLvnfdSoGHWCAtCwumu3rdwhc1aQTeGppfbl8y+WCSatLvHezRTPsBLUe9kOfQeHV/ahagNzQ9HBonzap3PmGO86QWXUe9mWhoPICK6+HRpPgQhNnSqRrEPwS+egknvQBCFwK+Th9IQYl6FpDtFsg3AUJaWrv9OiI6Z9JLSPobGSFbIsz6XScqtZ4yreook+czjbKj00GVMySOBJPsScVZghD0wU3Ud8D2UEEuVNEPtH/RA/EOhDk49pvxiWfV0vDDBzBW+a9cPgu9f72IhaMBS/8xMLP4ur4mcac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vH3EaakA7dN2Nb9Ba3nth8A5rVVBLRhGUfmxVZy547Xt9fZHEwFhNxDNK6HR?=
 =?us-ascii?Q?j4tYW+tfpJ2fLQnYVoQ3s7A54392a4kWLJYbN/yS/fukmB14hJnNamnJIzeR?=
 =?us-ascii?Q?Ru3thkfInLPm9bPnEyOlidJd1NH9CiHwtfcjW6m8Z0KIiGSuf/JrbWlViI4L?=
 =?us-ascii?Q?yqqfEHz6rtcLWDsonF2QOgGZnkzkXkb3ZyE8e+lRrkrspENaDbEZ8ohl96EW?=
 =?us-ascii?Q?IUIbqO5rIO0NW4or0Zj4kV3jcVh3tbatXEBLKsN9hrvsh/v+0GsORBiVe8ly?=
 =?us-ascii?Q?sH7fVHB9Jf/wOQpjdOq+J8q2dvyDwRQ+Rkt/liFy/tU3qH9nKQ+hUzd7etUM?=
 =?us-ascii?Q?NqtvI9mctiOJyfltY188qQkp7dPnSZcIncpSkOJetUOeMsrkD+TvDASsFfjr?=
 =?us-ascii?Q?ufU+6En2yX2S5tj0T0ei4Cht9K4qJ5XP85x6fLDqAWqKFVpeyt6DYywBra3Z?=
 =?us-ascii?Q?4SNPDQ6o1OCYJZDJl7xp/0Tf2go8WV7xmjq4XQNSkF5zvMDnvJ8TWcdYWcNS?=
 =?us-ascii?Q?jLkqTElYmDhjSayJBp21LQBa40kWCI1vijGG70V3kxIfKAOACYNBCc1ikHqI?=
 =?us-ascii?Q?AqQuo/Epo2DT2Hex/QIYBZZUvIwmv4kZuAA9FYbNSKnyCsB+kDcre5ywxBhO?=
 =?us-ascii?Q?JpTX2V+4Qqx1hUT5ojbmi7xbplpRmV+RW8dcG3NKthxeSJoVFU3HzzW24hAK?=
 =?us-ascii?Q?eu3Gh4F1V07qjjD2/E6DUQwmGyE4vTWVr1+XrWy3uNK1VUH7A8WhwnlWVaAj?=
 =?us-ascii?Q?mxXdR4RwUyId/5ZWBjel7R6z/Z5hYABeSEQqje6CAkFAKrwOanTC378FuHXe?=
 =?us-ascii?Q?54NhRK02OLJjXLlzRIu4OGAViP+lh/0j6vUfe7bRkoHCSCZAcB4gDBhz+8I2?=
 =?us-ascii?Q?nF1j1vRj8Cezwi26eAV1VaLBDHPI7vchrSbWaQQn6GxC8CBqlYgEJO1vl/xE?=
 =?us-ascii?Q?0khS2+gCUiN/cZ5UHVB4B2DFehDVToqTZIfRz+lShBy7HqL4MdVsAFvyMOw1?=
 =?us-ascii?Q?dnq/72JL8ce69Bj9SCegtIZe5+LqIKcTQa8fbkt7v12yTVGDZZ5ZTthD5lvK?=
 =?us-ascii?Q?gwpYlR+c195g3qhtwgbrUGPd6b43D0ZFKYZVEBIdd3SLhFpwsSrph+WnMRGE?=
 =?us-ascii?Q?ex/z02SqMqUlnV4s71bZB/frLHqs3pNoqxkiOgI1bfgRR/a3k9r5ww4rjncM?=
 =?us-ascii?Q?3jLD6rWu5Tfwnd2A3NqfN0wCmlyB/GhHtf0iyd2Zfwh1eBYUYhkXPwQbfi9f?=
 =?us-ascii?Q?qQCfcWWQDuJnQGC0oOIP65yJuDH/b8VEEh6+LG97sUv7FX1B2/W/LSZ0GecG?=
 =?us-ascii?Q?7X/3LQnXbvLrAx9DxaBnbVE1Wn5NgmnqdjPlryVJ2KNSxmx3dh18IblpnLL7?=
 =?us-ascii?Q?UgZLK/K9zEbYGcR13NEElFNIWVx8XXXQVv+sI2envwI0p/Hd3Gum601jNdxa?=
 =?us-ascii?Q?OSyJ4HwWKBxwnooaA2n8yBd1jxjYoxbu7EQWoG5w53Q7rjlSfaVNxhPR9qMd?=
 =?us-ascii?Q?rOSw4kFvV6HZ4eqUrI33trRH+SXsN6vqWnRUGnTxB4yqRq/OeuF6T9yFiaxP?=
 =?us-ascii?Q?snW1oy90bpkqO89Vy70U+Qj7GCSE4THN34l3uOS8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503a11ce-3472-4f39-23b3-08dc327ad479
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:17:11.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvWSN6lmGu0W1uttJ3UWfg1mTQE9md1EXmngsOpBZVajtZBEe8Fe4AU4spOmCSOm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

mlx5 has a built in self-test at driver startup to evaluate if the
platform supports write combining to generate a 64 byte PCIe TLP or
not. This has proven necessary because a lot of common scenarios end up
with broken write combining (especially inside virtual machines) and there
is other way to learn this information.

This self test has been consistently failing on new ARM64 CPU
designs (specifically with NVIDIA Grace's implementation of Neoverse
V2). The C loop around writeq() generates some pretty terrible ARM64
assembly, but historically this has worked on a lot of existing ARM64 CPUs
till now.

We see it succeed about 1 time in 10,000 on the worst effected
systems. The CPU architects speculate that the load instructions
interspersed with the stores makes the WC buffers statistically flush too
often and thus the generation of large TLPs becomes infrequent. This makes
the boot up test unreliable in that it indicates no write-combining,
however userspace would be fine since it uses a ST4 instruction.

Further, S390 has similar issues where only the special zpci_memcpy_toio()
will actually generate large TLPs, and the open coded loop does not
trigger it at all.

Fix both ARM64 and S390 by switching to __iowrite64_copy() which now
provides architecture specific variants that have a high change of
generating a large TLP with write combining. x86 continues to use a
similar writeq loop in the generate __iowrite64_copy().

Fixes: 11f552e21755 ("IB/mlx5: Test write combining support")
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 96ffbbaf0a73d1..5a22be14d958f2 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/io.h>
 #include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
@@ -108,7 +109,6 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	__be32 mmio_wqe[16] = {};
 	unsigned long flags;
 	unsigned int idx;
-	int i;
 
 	if (unlikely(dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
 		return -EIO;
@@ -148,10 +148,8 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	 * we hit doorbell
 	 */
 	wmb();
-	for (i = 0; i < 8; i++)
-		mlx5_write64(&mmio_wqe[i * 2],
-			     bf->bfreg->map + bf->offset + i * 8);
-	io_stop_wc();
+	__iowrite64_copy(bf->bfreg->map + bf->offset, mmio_wqe,
+			 sizeof(mmio_wqe) / 8);
 
 	bf->offset ^= bf->buf_size;
 
-- 
2.43.2


