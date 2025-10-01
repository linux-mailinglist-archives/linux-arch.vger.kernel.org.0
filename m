Return-Path: <linux-arch+bounces-13824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48ABB1426
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF823C783E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43EA286D44;
	Wed,  1 Oct 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdEs2skq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E927F749;
	Wed,  1 Oct 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336627; cv=none; b=JNZA5LDER2muScGdIHqpatJJ7llqmlplpmdcZxa17KeBwb8wRGm/y/i7v6wgaeQJXbpoyPzvRR39LsM14ZOphWnja7BTMEApU14XbCk2i/en+BrGIM4Dlb2gUaXW3Ldme1PJ1S9a/rhAFLNPVHYpEtjBEasKfMt8aIXIPC8DRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336627; c=relaxed/simple;
	bh=Z2NyxMKwcPeMXXKKAv2xDnR4oJ5LczuNNOFthCmdrr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnPoc+ZHdVQFLGw+uuzWvO5dIkIkSasT1rrn2YdUUkY/pNhY0uwuJ06hG7zbGPmxjTWwv/Wfcm8BVUJLTYoC6WNmOIEbntRKxdx30Kt8OgU9kZ7gw5EDIBo/s9LBLUArpZiVROmo1+JCU+x0zS5/LK+4BwzTFhc8FZfoajWMkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdEs2skq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9119C4CEF1;
	Wed,  1 Oct 2025 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759336627;
	bh=Z2NyxMKwcPeMXXKKAv2xDnR4oJ5LczuNNOFthCmdrr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdEs2skqGh70Zo1YI7DOoy0aHJ4HyFogdGtdCIGleVtLKrtCn2RVAk0weWaPfpVaR
	 QsjhbNwWzsEPIy3c6ubYWjwAvf+W12ZWE0sj4KXEuAj/6x+hItzGtqAzrsg6HH9uh1
	 tpwtJLVaLW9Gf3jMWeI1mgiOvjvntUQIlshpktbKoefzm2aDnjPWnR+1t/36brucD+
	 kJlZ7n6esgshltyonSUnbDHGsLosx1fPpraYDnKjRb8+thXVO+HWaKoFbcOCUjKHt/
	 KvDNqiz28a8Etu79fFmX+l8kL9EE39VtJvMA8AJXVBNg4dqMumlorzFCtiRqAirXW5
	 OlOUSv2m92lnA==
Date: Wed, 1 Oct 2025 09:36:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
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
	Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
Message-ID: <20251001163655.GA370262@ax162>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
 <651ee9fe-706e-4471-a71b-e7a12b42cc3e@redhat.com>
 <20251001145514.GC3024065@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001145514.GC3024065@nvidia.com>

On Wed, Oct 01, 2025 at 11:55:14AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 01, 2025 at 11:28:09AM +0200, Paolo Abeni wrote:
> 
> > > +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> > > +				size_t mmio_wqe_size, unsigned int offset)
> > > +{
> > > +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> > > +	if (cpu_has_neon()) {
> > > +		kernel_neon_begin();
> > > +		asm volatile
> > > +		(".arch_extension simd;\n\t"
> > 
> > Here I'm observing build errors with aarch64-linux-gnu-gcc 12.1.1
> > 20220507 (Red Hat Cross 12.1.1-1):
> 
> > /tmp/cchqHdeI.s: Assembler messages:
> > /tmp/cchqHdeI.s:746: Error: unknown architectural extension `simd;'
> 
> This is a binutils error not gcc.. What is the binutils version?

I can reproduce this with at least binutils 2.36.1, which is in the
kernel.org GCC 8.5.0 toolchain.

Removing the semicolon resolves the issue for me and matches the format
of .arch_extension in the rest of the kernel. I am guessing binutils
became less strict with parsing at some point.

Cheers,
Nathan

