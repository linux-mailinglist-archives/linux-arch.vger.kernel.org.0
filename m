Return-Path: <linux-arch+bounces-13677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B3B857A3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34AA7C5D8B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B1306B28;
	Thu, 18 Sep 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwZnl0bg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089E1607AC;
	Thu, 18 Sep 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208058; cv=none; b=vC/fq12ScbsdzSJ9sLs0vIzguqZsjsZ8jJERLzhV+uP3I950VSWRLkfq90kjAtO2IbcEq3u+JTP8ZxwIo/2D/iaxJLyswab9mFoFfYgDQdfjgviVKXe+jq/LdZEGP/mllUoyxMjNT8bR7T/skq9jMAoG06WW6Km4Ldm7AwGHC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208058; c=relaxed/simple;
	bh=sW/npsoqVvH2jZ1iYFeywDG41QnbgIzfrJf90iHIx94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYNuEjCN9+jJskTHbs4XDGmPeKXXXaiW5hh2KJ8LgwellK4VtkyC+P96X+4e8gA4bH0Dja1NqyfhvBApY4kvVMCw69FXZ9n/BP3//g0EPlBvILyyQ8lkp/bnQY+AI1FmOJ3YxlZ0gwRTeAHecT4o1J1HNjqSdz+7Qkn/ktQ0z08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwZnl0bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD3CC4CEEB;
	Thu, 18 Sep 2025 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208057;
	bh=sW/npsoqVvH2jZ1iYFeywDG41QnbgIzfrJf90iHIx94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwZnl0bgzIv5G9GpaNIDQbuvO9HddfBAxifrvDjM5Ugs42X76RrBv51TpbdZm5Y1L
	 mHQv8IAwm4Xd7QqDtWeChSyd0hXizLPuB2fIG09/9z0/ttqtVToJnG0xDvM7xZQN0y
	 m2pRwIJx1HdEaHaPQRUPdlZi+AeKJfLhgt5uRqabPJ95o3Ib7FYa3KR/mz++sX1Lka
	 ouGGsFcEH95nRzAxLtCilfOwp6ls1KG4xphq5ucvhDweyDOeUjwEszovJaqSF1pTVe
	 1JVb1CKf7Cti5yxGTvJENeZRlV2K3Kjermk5ncw0x/qepBF3oLDwfHUQsk+YORmcjv
	 fkxEbB7s/6Ojg==
Date: Thu, 18 Sep 2025 16:07:27 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Justin Stitt <justinstitt@google.com>, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next V3] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250918150727.GX394836@horms.kernel.org>
References: <1758178883-648295-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758178883-648295-1-git-send-email-tariqt@nvidia.com>

On Thu, Sep 18, 2025 at 10:01:23AM +0300, Tariq Toukan wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Write combining is an optimization feature in CPUs that is frequently
> used by modern devices to generate 32 or 64 byte TLPs at the PCIe level.
> These large TLPs allow certain optimizations in the driver to HW
> communication that improve performance. As WC is unpredictable and
> optional the HW designs all tolerate cases where combining doesn't
> happen and simply experience a performance degradation.

...

> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/wc.c | 28 ++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> Find V2 here:
> https://lore.kernel.org/all/1757925308-614943-1-git-send-email-tariqt@nvidia.com/
> 
> V3:
> - Move the new copy assembly code to be inline, within the same file it
>   is used.
> - Use ".arch_extension simd;\n\t" to avoid the need for separate file
>   and special compilation flags.

Hi Tariq, Patrisious, all,

This is not a full review - although I've been following this patch with
much interest, I don't feel qualified to provide one.

But what I can do is be the poor soul to report that unfortunately
the patch doesn't compile against net-next. So at some point it will
need to be rebased and reposted.

Thanks for your persistence on working on this, it is indeed a nettlesome issue.

-- 
pw-bot: changes-requested

