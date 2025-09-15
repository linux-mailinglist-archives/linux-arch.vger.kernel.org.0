Return-Path: <linux-arch+bounces-13641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DEAB58810
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 01:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5434E1C16
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 23:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C842F2D8783;
	Mon, 15 Sep 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsM2bbYr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36128CF5D;
	Mon, 15 Sep 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978119; cv=none; b=CNndiZM/CMFhL3D4ge1TCUSWFIumYgpJoWc1OyfYRP74okBQZUc/WmcpcxjwseXSmIqt2bu+IBreV8axjOtA4pz+yzqbBhMfGjJpjiTzngcgrJv8DxWKhvkDIFBehp5Hl1EqjaHMr8Tt1jVD+x2oBiLxfCDIjk+7Kc0BXf2jVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978119; c=relaxed/simple;
	bh=NZVjwENaK3+moDPtvfhqs0yvrJHkbbnLBuuY1y0SxaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZQ756F9B6ZUpfKiiO6NVEHsOjtZ4GJ7XQxq1pwOwniLrzJRHfxadQraG2daI64RsqO7+UJ0VpR+1wuO9fYrWX4t5AMub/6li4hZ1DNtGMymo1m9e1J75wmG4dJ+S36EvpbT/NwPZu/3QY07B02BhbkLhai7PSRP3dr2fYuxYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsM2bbYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1499C4CEF1;
	Mon, 15 Sep 2025 23:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757978119;
	bh=NZVjwENaK3+moDPtvfhqs0yvrJHkbbnLBuuY1y0SxaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsM2bbYr6kONzJgx6IaM9qmXwh6IylLUWOIv8KL1Gd/47LIsx5/9FMH00QAGj+85f
	 YOQlOzogYKlYvY08pRk1hFWCcqEA0xIW+xm+F5XFc+3D58mpVjA+WUIsJXmL91YBfj
	 /GqbFG1oD6o7jYCPsmcGnZ8Z3XqRx38OlzOMGdG5NqFc3YX3BbNG/sXZbdJRVBqtBV
	 x9wDkKV2eotAJlDKHyES+owYkLDkcy+cXeAALdxt8fv+1FyrS7S6XbhHL6rMIhcJiC
	 jkTzj8sjH1a8MYC7h56umQ9SoDv7Y4JFTFxNufV+YN1UUglimXMuMyI7YBDS4lW9Eq
	 cut8a2by1XQVg==
Date: Mon, 15 Sep 2025 16:15:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
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
Message-ID: <20250915231506.GA973819@ax162>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
 <20250915221859.GB925462@ax162>
 <20250915222758.GC925462@ax162>
 <20250915224810.GM1024672@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915224810.GM1024672@nvidia.com>

On Mon, Sep 15, 2025 at 07:48:10PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 03:27:58PM -0700, Nathan Chancellor wrote:
> > On Mon, Sep 15, 2025 at 03:18:59PM -0700, Nathan Chancellor wrote:
> > > On Mon, Sep 15, 2025 at 11:35:08AM +0300, Tariq Toukan wrote:
> > > ...
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > > index d77696f46eb5..06d0eb190816 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > > @@ -176,3 +176,9 @@ mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
> > > >  
> > > >  obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
> > > >  mlx5_dpll-y :=	dpll.o
> > > > +
> > > > +#
> > > > +# NEON WC specific for mlx5
> > > > +#
> > > > +mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
> > > > +FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
> > > 
> > > Does this work as is? I think this needs to be CFLAGS instead of FLAGS
> > > but I did not test to verify.
> > 
> > Also, Documentation/core-api/floating-point.rst states that code should
> > also use CFLAGS_REMOVE_ for CC_FLAGS_NO_FPU as well as adding
> > CC_FLAGS_FPU.
> > 
> >   CFLAGS_REMOVE_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_NO_FPU)
> 
> I wondered if you needed the seperate compilation unit at all since it
> it all done with inline assembly.. Since the makefile seems to have a
> typo, it suggests you don't need the compilation unit and it could
> just be a little inline protected by CONFIG_KERNEL_MODE_NEON.

Hmmm, clang rejects the current patch

  drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c:9:3: error: instruction requires: neon
      9 |         ("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
        |          ^
  <inline asm>:1:2: note: instantiated into assembly here
      1 |         ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x19]
        |         ^
  drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c:9:48: error: instruction requires: neon
      9 |         ("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
        |                                                       ^
  <inline asm>:2:2: note: instantiated into assembly here
      2 |         st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x20]
        |         ^

while GCC accepts it... It looks like GCC's -mgeneral-regs-only only
impacts the compiler using floating-point and SIMD registers after [1]
in GCC 6.x, whereas clang's restriction is on both the compiler and
assembler. Perhaps clang should be adjusted to match but its behavior
seems more desirable for the kernel to ensure floating-point code is
properly separated and called between kernel_fpu_{begin,end}(). This
error is resolved with the following diff.

[1]: https://gcc.gnu.org/cgit/gcc/commit/?id=7d9425d46b58e69667300331aa55ebddddcceaeb

Cheers,
Nathan

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 06d0eb190816..a85fc21419d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -181,4 +181,5 @@ mlx5_dpll-y :=	dpll.o
 # NEON WC specific for mlx5
 #
 mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
-FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
+CFLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_NO_FPU)

