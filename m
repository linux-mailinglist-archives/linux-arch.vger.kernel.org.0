Return-Path: <linux-arch+bounces-2668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB15385EE55
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 01:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C6F1F22554
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 00:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF510A16;
	Thu, 22 Feb 2024 00:57:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2EF10F1;
	Thu, 22 Feb 2024 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563446; cv=none; b=MlgcdaYSOtXIk6P+WPJLKcbZwMy13+rA/o/8aOOlJpXUyCrEnAZKbnZAgNjFnlX2gAX6KDvUZ/ieraJsqy1LPM3Gsk81Jx9IlQCzJC9CYm+GZgZ88zzb4hyC1F4hnZSZaL6xoM7SCD2/3TLyBcLYkqk7xscKZlbD2RNfz1JmNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563446; c=relaxed/simple;
	bh=TpNLIT6IBsmqizqpSoGO/6QU3PYKUcfmgj/xzzcRj2E=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H3aUBe/Nw+U8Cb5vYCbTAA+RGDzRfNhXpkaiIc/e3nzOct2CrKSOA1W9mbjpxEiBLDNBWgbsgnF4PJg0VfcOaPG7LKs8dA+TEqcvfheBkNJ5O3GTS6z2+Yq/CzRf7oN+NHxWtbHGslBGXp/f60W6nCG6sDmhCvfO1Jy5azB4mSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TgF6d26ZSz2Bd3b;
	Thu, 22 Feb 2024 08:55:05 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id A555D140383;
	Thu, 22 Feb 2024 08:57:14 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 08:57:13 +0800
Message-ID: <45ac5429-df48-489e-928f-8444aea127cd@huawei.com>
Date: Thu, 22 Feb 2024 08:57:12 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Leon Romanovsky <leonro@mellanox.com>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Mark
 Rutland <mark.rutland@arm.com>, Michael Guralnik <michaelgur@mellanox.com>,
	<patches@lists.linux.dev>, Niklas Schnelle <schnelle@linux.ibm.com>, Will
 Deacon <will@kernel.org>
Subject: Re: [PATCH 5/6] net: hns3: Remove io_stop_wc() calls after
 __iowrite64_copy()
To: Jason Gunthorpe <jgg@nvidia.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt
	<justinstitt@google.com>, Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <llvm@lists.linux.dev>, Ingo Molnar
	<mingo@redhat.com>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Salil Mehta
	<salil.mehta@huawei.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, <x86@kernel.org>, Yisen Zhuang
	<yisen.zhuang@huawei.com>
References: <5-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <5-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Reviewed-by: Jijie Shao<shaojijie@huawei.com>

on 2024/2/21 9:17, Jason Gunthorpe wrote:
> Now that the ARM64 arch implementation does the DGH as part of
> __iowrite64_copy() there is no reason to open code this in drivers.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index f1695c889d3a07..ff556c2b5bacb4 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -2068,8 +2068,6 @@ static void hns3_tx_push_bd(struct hns3_enet_ring *ring, int num)
>   	__iowrite64_copy(ring->tqp->mem_base, desc,
>   			 (sizeof(struct hns3_desc) * HNS3_MAX_PUSH_BD_NUM) /
>   			 HNS3_BYTES_PER_64BIT);
> -
> -	io_stop_wc();
>   }
>   
>   static void hns3_tx_mem_doorbell(struct hns3_enet_ring *ring)
> @@ -2088,8 +2086,6 @@ static void hns3_tx_mem_doorbell(struct hns3_enet_ring *ring)
>   	u64_stats_update_begin(&ring->syncp);
>   	ring->stats.tx_mem_doorbell += ring->pending_buf;
>   	u64_stats_update_end(&ring->syncp);
> -
> -	io_stop_wc();
>   }
>   
>   static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,

