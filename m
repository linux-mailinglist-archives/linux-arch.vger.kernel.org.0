Return-Path: <linux-arch+bounces-3595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988F8A1CFF
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CCA1C23BE9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BC1C6898;
	Thu, 11 Apr 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RODdimYo"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B41C6889;
	Thu, 11 Apr 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853993; cv=fail; b=WsIcEEccxUbGOtMDawlkgBi9Za0Vvp7dPSS+9VTfOJvQdA94iPqnLBrYB/hjdFOSYWwnFk/q/aw9umQQxF1ofGIrV9gnoPTti2ebFmR0segIIF7w5efW0vWWF+miVgwKS7z8lsHbf3CAjRxEu/RwbDRvQqv4l93Q4Hsx3Pe4XVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853993; c=relaxed/simple;
	bh=tsV8gCWR5LWzBTMNb04lZtui2QnvJXY6BoVwlI0294Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEaF1l+NQEy3P/7uV6vk1guQu5MiAkI3V5og5KjEgfoT9PB0eVM4Q+crk8pOuAlRdF4MnCYCiWovca2wZ2zPXJbqJwlWciIq3TFRYOqV6ZuEWUHUbJ5E95pc3IkdnDIHFqQNlM4wXqjJGYwdcH5wml/Ag44R4m3n9aLMoVrp7r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RODdimYo; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANyvqUK2sHBM55LTyq27gnMhGkTm7PIQGxUKbypxeyNdgpElh3Exw1Qii55G9peCwncz/vJqzZuhVEW+s/21mJlFb2bs8oW29cgdYPphM5Bv930x3NxT0GPq13oAW5dXklVO6M4LTDs0qrvKCTo6cOp/G/yrMsrHxfDOWFeepSX7okxR/as5fuhTnhipYrRceB95gtwsLGIXdmR/fUstBHGIRy/U/osvdsVUPf0G4Pvn5GOgEOUnB94gW8CTZjzokxfnIEBkj3MjvDtlKju58zZfwn7mteMqD4hwW99WggQCqN0WVFYrbKAOrXlGHkt8uPa2GdHbwghFfG1Z9CoHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCBJ6dLMHu5mQWHFWQoqDEbAiF7nN/N1UtwVHyaeXCw=;
 b=ZUhb8p8yYy8H1w0NC6iTkobJhiRurMgINoIQJSYSd039tIlFYaa+rhpNd2QF20kQzliVU4NUFF3WBUzbTtNrtLjip4IjIfia4o10XkPI4EclYAAC2RNui4a2r6txyvokekTdSgwlihiTcbWOFd2RS8DnJihpY8xKWlmn7uEpIvxBEGeA6L4QIwWu01Pw/mQ3dMTAzHRUEtt6K4zZqJNhzsz3Cmk96N2YrRKekh0uxAiQmOkrJVYIHjZpG7uxtHy/o62uO2Ux3lADOBSWSPZ9rdIU6zq6x4kAH9LLmeBwGLl5ECHhyeU/M44sO58DwZEGPcii0VBu3GR68i06Isi91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCBJ6dLMHu5mQWHFWQoqDEbAiF7nN/N1UtwVHyaeXCw=;
 b=RODdimYot7SvWfBj8A9+tRc2B6LuoqiMGSEtOqf+gjUUPMCb9dE3LH+G63yCynqMP7PEmY4ALZ6muoUNHM9Rb9uuz0IIzEqXonfe+AvTvFYwszCbSdnwSiO+GVr8kuYGWCicarmfXbabFntCK3WPMGDYIxKxdz5/Xe0QkSi59NOdeNyIZu5SR5N+NS/p0FEqSWvR88DaZKNYRlMfTuYf3Zq6tCSWW4hOzpg+WPTQy3tgeoh6z3G2Y/uTrnEo9Fz+VwimwiJHOdMIYEsjDtl9VA1m/O4Wl+whY4eij0e0ae6J4D9reBMi/JGQpXsAaC0cgO+hjzZ7TudPi5iTxqxbRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:46:21 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:46:21 +0000
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
Subject: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write combining stores
Date: Thu, 11 Apr 2024 13:46:19 -0300
Message-ID: <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0360.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d37bec-dfc8-4ea9-b9c5-08dc5a46ea89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bAbZtqgSLYoBHuexDrOmcxhNdNitRnYM5AsP/TQ/uHr681wIIQRskhYweCJLioORQmxze6aI5vesNYadFZ3MM+VDL2P/ZSZl9IYWcKhLQOq7z+VLc9gU4aL33pk5DdkpWdm6bMnp+oJPFCcs2n5eMmMZul0b4llYYggYTVrkPMuVGVrXZ0WUBoHF0jzv9So8ZyEWEmwolWe4bG0ePZ9tEGp/DPO7XIXSv9rn4hns1D5Y7wfz5yf0AdL9YveF4I1zA/qHhor0tqqiAH7p/eWQl+xzC5KwJhKIEd5V2SCqKte0M3BRNrhFJsIaOtYZPSJ946+2B8H7TrC8se09v2e3/Q9VXo+/3cZrsJr2h/SPQcZo27qIFEqhX6diNhuNNylpMhg2uytg6LtyOu3ZAlpjE3GE8ekydnaYCVCRbT3tDmSJR+oAbOpLUBZ/40zoqwfUBSikfZ7fMubWnJ2m+i3mX4cC9Dx5frriWsFBQs0LAfTAmPiYncBQpuKbTZDI+O7VEhQqfhIhMd+NHuqk2bhVwxCYBhQ1HlvtW9hNNK0o2hgpraHflobJdq5FXf4cfYYT19XE3K4lX/y2fS1oJiLXvqFmv+v9tA583Dago9NuDfd+aFBIXsk8EyL5SpLRX5mnQ9c17Hxgg7HmFB6ofSmRHHv+x532HQSaL8qiIpeByRDI6WwEtcu4ky/C2xDfZE0Dav2v9LS39HFP7RYrGrIxjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2mJ8dZJrhO1gnl+3xL0a5jYH7+vnn6zd2w1S3bqFK6RkSLm5am+GYCJh8L2F?=
 =?us-ascii?Q?w1QWLHZcWT2Zudt57JwA1rzms8VxVCe50JlX/RORDovLZEQ9SOEzwS0lBgFT?=
 =?us-ascii?Q?mcUcNf4xZVcn/cQ6TpnoTHuTN/z6/xW7F3PymJuqaKbI0PlPBamlKUhrcAWO?=
 =?us-ascii?Q?+5pNX90M4pMe2jDx1Fr6DdaYDn2sSvfZUouaiYBl/uKngPWBm4ofRVdK51cT?=
 =?us-ascii?Q?/hZsP8STtH+Xr/KhWi5FFyhrMYwvrbRnIzZt8ijMH+7KaGE4Gq9vvfp8dikT?=
 =?us-ascii?Q?cGmLuxswVK3DkSiKen3xchOFn+/f7KCz3oVILCbwnp+9c3e/PeR95rHWFF+p?=
 =?us-ascii?Q?JF+DwajfkbKm3cBBzu9lXIE7JSni7sF95a2AMPtiGwoZm/mmJdQCp4pZlk59?=
 =?us-ascii?Q?2GGlZ8b+LUkuwdZLRxYsyELDJ/ntbEOjZMWgqLKNpteao4A4yWXjhUBy2MOP?=
 =?us-ascii?Q?N5MejwyN5wHs+DYVeRexbCPkJLA942kBpCzVW5wpiI5EfnF4w5jY/EPT7N0l?=
 =?us-ascii?Q?KGIyVtg9V70sHyFop0HgpnX12fMJJEorBIw33exceiWh4UKn8s5itXE6OP01?=
 =?us-ascii?Q?oYJEIUa32pxPXadEI0+008rgN6eFl0gNu+bWCqE6h2jYlUJdt59wPtV/rIW5?=
 =?us-ascii?Q?MdWv4KgIIFzJKkhDq8qnV8Rp2py4b2Vv4/9X0BOYvTt6sT9Bqz7DjpePgBxQ?=
 =?us-ascii?Q?szi1OXxkgswntMKP9eFxCQ0MUOpN9oYiJLJp3ilc5y3/kyt91gDnexg0mOZI?=
 =?us-ascii?Q?1Z/FCpC1prhtNgnrKa9R5R+LckAnQ+YmeaJc87cbSikGqgNKR63v8uoxndqe?=
 =?us-ascii?Q?ioQqe0SsRGcQjt7DP3I1mxvOMgpz2AKeKQD88nrn3LaVBx6rBbg0Q332pa5i?=
 =?us-ascii?Q?i1PieWAztToObdwjnDQVPOoqIYBpLvyLxVusAf6GM/lcIDTWdwMwYAPBn2PQ?=
 =?us-ascii?Q?Fe8xX9Lf7Qe4D3dUj4i8hV54VDcqA2zlOx0aEhCFzns0xpLkEooqHuFkIVc5?=
 =?us-ascii?Q?1kvzdPiFxdDrJthAfR1RhCcA4E1tNG3pAmwCZ1m9bzEWpX+G9WcrUg4ZZryN?=
 =?us-ascii?Q?16mPztFT517eJeOD5j2Gjxl0htGe/WpE7FOT220MTJqUw2QoiDyHf0Jjkwzj?=
 =?us-ascii?Q?4qvef8b5Ggfh3WOMCHe7gs8nWd7n+LUgksCLzcWpZ8kH3mPdMJE8FlCM2mP8?=
 =?us-ascii?Q?Pa9VbASreJFl/T20iSndV1TGvED8fjFBAOaBoIKpB5tS8+dbYYcwGyF5a/NY?=
 =?us-ascii?Q?pumVcPLgvw8F2fc/a+fHLzC2pgwkPtqV0jA8ZyLh8pIgqmnzRHpi4SSs8gIb?=
 =?us-ascii?Q?U66FSoqDjeVhbWU+vYSorkwLTv9UasZrCkqaawBe/nNEd5buUyI7dx2Vzasc?=
 =?us-ascii?Q?xlqNQlngazAam09cFxZ94cTbtQDqMEe/7n/B+yZ6IJrB5AJVQh4rM2hmnMpb?=
 =?us-ascii?Q?hAJzs0KWNSBYHFPzZSYMin3Z0nwSrax1FpIqdynsEwPlw+eRtRgNjIskvFnf?=
 =?us-ascii?Q?I9T05og8oWLNXm3ci5uuwg9SlwefC3TN0vdWfuEY/pg14hhN51440dMhwJWP?=
 =?us-ascii?Q?vbzdrbqsqaTCk7208sgab7fPAhpSFCiq4OSziA7z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d37bec-dfc8-4ea9-b9c5-08dc5a46ea89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:46:21.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfYX9S0grWr1lnmTmc8Lwrv4DMnlxUBjZCJlwsgl7GiBwUWRL2qE0Yx3c29brbA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

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


