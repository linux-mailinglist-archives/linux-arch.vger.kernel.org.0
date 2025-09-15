Return-Path: <linux-arch+bounces-13639-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC0AB5877E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 00:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EB017088C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23182C0F9A;
	Mon, 15 Sep 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btiFbV66"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61851280A5A;
	Mon, 15 Sep 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975290; cv=none; b=qZZCDAJCB7RbnumFG6BRxlRT2jvgO7BBcVAHwvW1oCnZRtF/GEPJrHsfweOewzrTfEvlsM/PRkc6kxvPZCVajTbCabcK/PAC1xmK0DCnvhf2RQrUuBVyVgCRfqHo0Vd5SswRyTeS81R0s8CCv6a2QNEJTNFld8ex6FjFknCkX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975290; c=relaxed/simple;
	bh=Wcpg6tFqbeXrFoRBlvkg7Sf+BtHE6/mi4vJgwFoUZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAL6e8EpyXPJgBKPZ1TXHPF4pj5VD7BG9YenEa0Ar1/lRoFRMGil5uukQ/PVyXEo43p4iRWsjs0eybSuVy4Nukk2Syrdcpswp5ikeq8s3STS/BoXIb+60d1/HxJq31C5x8JyLJf/oFvYPRzT0CaPQDVyfPBTuKGoQkYxTRp+L30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btiFbV66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE259C4CEF1;
	Mon, 15 Sep 2025 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975290;
	bh=Wcpg6tFqbeXrFoRBlvkg7Sf+BtHE6/mi4vJgwFoUZ7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btiFbV66ndT5PiIZKyhZnWESs8zz13HkVRGGazrbMKTT4i+wheS/50P4tznON9TyA
	 a58Hw/PgCuOAvxPnuSLa/Sl0Cr4WPrfPd5Aae+v1MEk7ZhupfTtxeqdXD49BcpCmjR
	 j04dEBmtBubaNUzCl/IOXOUzUcuSaywrmwoE/r31Ded7UHFyuLbQGcmyBSHG5iy1Ay
	 dnZDqqyZ0L2NHVjXaNZsZzyLlpsoNEk736iFJTsw059hVGtLtLEl5gJRickoHqnJr+
	 UMwJRFPkvIVIM725yAa3peQjy4+9NywQ/bqbohEuAm/i9n+0WhUTjicS5UtSncs+Ux
	 gd2aTTgxJ1EQw==
Date: Mon, 15 Sep 2025 15:27:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
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
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20250915222758.GC925462@ax162>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
 <20250915221859.GB925462@ax162>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915221859.GB925462@ax162>

On Mon, Sep 15, 2025 at 03:18:59PM -0700, Nathan Chancellor wrote:
> On Mon, Sep 15, 2025 at 11:35:08AM +0300, Tariq Toukan wrote:
> ...
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > index d77696f46eb5..06d0eb190816 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > @@ -176,3 +176,9 @@ mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
> >  
> >  obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
> >  mlx5_dpll-y :=	dpll.o
> > +
> > +#
> > +# NEON WC specific for mlx5
> > +#
> > +mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
> > +FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
> 
> Does this work as is? I think this needs to be CFLAGS instead of FLAGS
> but I did not test to verify.

Also, Documentation/core-api/floating-point.rst states that code should
also use CFLAGS_REMOVE_ for CC_FLAGS_NO_FPU as well as adding
CC_FLAGS_FPU.

  CFLAGS_REMOVE_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_NO_FPU)

Cheers,
Nathan

