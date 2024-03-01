Return-Path: <linux-arch+bounces-2784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48486E931
	for <lists+linux-arch@lfdr.de>; Fri,  1 Mar 2024 20:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842D1B2FF9C
	for <lists+linux-arch@lfdr.de>; Fri,  1 Mar 2024 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D839AEA;
	Fri,  1 Mar 2024 18:52:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB38C1B;
	Fri,  1 Mar 2024 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319162; cv=none; b=cheF4U6b+hRQQ2NiIR09czDVxD3LrZYDzQyVF9O4/T+xrKNHbZsEpKHAdFMhJv4x8pQ6sQSCXyKqIMbNmo6dTQ2v7cFAxOnRr3xdhMY6Ij8UAbmY8EnEsjaaGNCj6kdY/ZXUASELI4dEHRs0yDnVkvV9BTgAQ09i5viSrqNuv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319162; c=relaxed/simple;
	bh=44S/7fMa4t3C3sreMd4jk5F0uk+BmeF1MV2xSiGfrrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjwjDv1rQGT/oFdo6ZeSv9Aua86UiMp76PljyAdWAEo41kSiEKd+3HrOMOoI3hwxoXnqVPHdpQ4KUcM4xkx6uzHh9mb+zOnNpGyCTfv8NgEE7fVYurG9FQ/4B1bb91VnKlVgzNeNaaK9HwTs0Ox43iWqrzGP339drIvLebFhPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C1AC433F1;
	Fri,  1 Mar 2024 18:52:34 +0000 (UTC)
Date: Fri, 1 Mar 2024 18:52:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Message-ID: <ZeIj8HtdbKS3eqG6@arm.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>

On Tue, Feb 20, 2024 at 09:17:08PM -0400, Jason Gunthorpe wrote:
> The kernel provides driver support for using write combining IO memory
> through the __iowriteXX_copy() API which is commonly used as an optional
> optimization to generate 16/32/64 byte MemWr TLPs in a PCIe environment.
> 
> iomap_copy.c provides a generic implementation as a simple 4/8 byte at a
> time copy loop that has worked well with past ARM64 CPUs, giving a high
> frequency of large TLPs being successfully formed.
> 
> However modern ARM64 CPUs are quite sensitive to how the write combining
> CPU HW is operated and a compiler generated loop with intermixed
> load/store is not sufficient to frequently generate a large TLP. The CPUs
> would like to see the entire TLP generated by consecutive store
> instructions from registers. Compilers like gcc tend to intermix loads and
> stores and have poor code generation, in part, due to the ARM64 situation
> that writeq() does not codegen anything other than "[xN]". However even
> with that resolved compilers like clang still do not have good code
> generation.
> 
> This means on modern ARM64 CPUs the rate at which __iowriteXX_copy()
> successfully generates large TLPs is very small (less than 1 in 10,000)
> tries), to the point that the use of WC is pointless.
> 
> Implement __iowrite32/64_copy() specifically for ARM64 and use inline
> assembly to build consecutive blocks of STR instructions. Provide direct
> support for 64/32/16 large TLP generation in this manner. Optimize for
> common constant lengths so that the compiler can directly inline the store
> blocks.
> 
> This brings the frequency of large TLP generation up to a high level that
> is comparable with older CPU generations.
> 
> As the __iowriteXX_copy() family of APIs is intended for use with WC
> incorporate the DGH hint directly into the function.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Apart from the slightly more complicated code, I don't expect it to make
things worse on any of the existing hardware.

So, with the typo fix that Will mentioned:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

