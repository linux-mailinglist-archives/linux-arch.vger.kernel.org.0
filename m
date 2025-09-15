Return-Path: <linux-arch+bounces-13638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44840B58756
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 00:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083F1166E68
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 22:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497792C027A;
	Mon, 15 Sep 2025 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGT6EmnQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AD29E114;
	Mon, 15 Sep 2025 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974752; cv=none; b=LPH2znTb2tOhZvs5WQPeSQxv5M+IMYQLc/rf/1UWPzX52I3dqoz+AeHadUqOFhzogt7/FC1KkFacm4KVaMohqdiD/kf7n2SPmcO8YWhKP0AWxtDMPnE3pMiWP8OUU+ecj4MPxqT3aHLDKZ6Jo3Us+GlFvr8AI/KTewjbVz4iUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974752; c=relaxed/simple;
	bh=b/KAMT/vU3fpIChuCZ8uax4id1ddqwonwf8AV/cakto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2U0buxusUzkJR/mgwCfcWv/x01Mg5aCeq1SjGR2vTYPUg8y93wc9t+mpDqBMEbyZRhgSJJCqS4ULenjJ5/aZul+aUg2W0OHE0qz2/pcB+CwI/JTzscmVVdHAdV6HJNraEqbMfQPpSY4cAm7trYxcJp5wjGCyaQEwb5uUzXE6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGT6EmnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C50C4CEF1;
	Mon, 15 Sep 2025 22:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757974751;
	bh=b/KAMT/vU3fpIChuCZ8uax4id1ddqwonwf8AV/cakto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGT6EmnQvukqFMqMtqlepbmHr2WQI1aQineneVKQQSGzOY1R6Q+XDnwa3NsHXFQOV
	 hmI40g/TeZ7O/rX9/+oJl1mrj/tdRdV5JiW6497YhnCgSztVVbei6nPKjfkGcS0eVG
	 6J/oVwgHOtWRKx2Q2bxpv/YuoGK0hmyIOFQ01bKfzCSnazZXtKE5x6b/Rz39elUVTF
	 dJmk2wUg4D3bzoi7AqfyRJi1PJTa7b2g2oomBqh773Qjhba70EW1sj2NgI9EPVxqON
	 x2hGtjFgJvhONx5/L8mpl0ia6De74xa66l+Y6mAi5ahONM7ADPHt9qw/alKSWsd0Qs
	 d1D0WOSovq6ZA==
Date: Mon, 15 Sep 2025 15:18:59 -0700
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
Message-ID: <20250915221859.GB925462@ax162>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>

On Mon, Sep 15, 2025 at 11:35:08AM +0300, Tariq Toukan wrote:
...
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index d77696f46eb5..06d0eb190816 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -176,3 +176,9 @@ mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
>  
>  obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
>  mlx5_dpll-y :=	dpll.o
> +
> +#
> +# NEON WC specific for mlx5
> +#
> +mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
> +FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)

Does this work as is? I think this needs to be CFLAGS instead of FLAGS
but I did not test to verify.

Cheers,
Nathan

