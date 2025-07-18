Return-Path: <linux-arch+bounces-12857-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14428B0A9FC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 20:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C216C3B20BF
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E093F2E764E;
	Fri, 18 Jul 2025 18:10:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86880C1C;
	Fri, 18 Jul 2025 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862215; cv=none; b=Ilv2rSSg4FEjYZ9LEuBLF/CQKizIrFz09aavJiZ3DLJ76CJ8OiX0pW2mNfOljh8tYhSveitu9Gbilrw9WmRhyle5x6I8J8Tpp8DJCXboThLZCJh2BEEBWnEFK8S02d86OHODTv0cZv9PPreIMmBlHQtIbqKqzQKYPx49c8HaYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862215; c=relaxed/simple;
	bh=WgxSzovmY/3HN+EA7KrCAS/u+NXYud7/dmBnI4yWUAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgl0V3YWtA2LIs5L9aJr0yVfvOHwNkzkuK1gTcE/8T2X5HX7c2R2AzmuO+PAhTaNT69g/laofiovUvh0wY9W4DrMNh7uVesPqX0yoOK1chgtzfCsysQhNVlFEVdAiEVxOaMGnclQGwyd/sRO2lnh4DVfazEWPOa6J7hMZlPzy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA27C4CEEB;
	Fri, 18 Jul 2025 18:10:09 +0000 (UTC)
Date: Fri, 18 Jul 2025 19:10:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write
 combining stores
Message-ID: <aHqN_hpJl84T1Usi@arm.com>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <20250714215504.GA2083014@nvidia.com>
 <aHYqPRqgcl5DQOpq@willie-the-truck>
 <20250715115200.GJ2067380@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715115200.GJ2067380@nvidia.com>

On Tue, Jul 15, 2025 at 08:52:00AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 15, 2025 at 11:15:25AM +0100, Will Deacon wrote:
> > > Since STP was rejected alread we've only tested the Neon version. It
> > > does make a huge improvement, but it still somehow fails to combine
> > > rarely sometimes. The CPU is really bad at this :(
> > 
> > I think the thread was from last year so I've forgotten most of the
> > details, but wasn't STP rejected because it wasn't virtualisable? 
> 
> Yes, that was the claim.
> 
> > In which case, doesn't NEON suffer from exactly the same (or possibly
> > worse) problem?
> 
> In general yes, in specific no.

For a generic iowrite function, I wouldn't use STP or Neon since it may
end up being used on emulated MMIO.

BTW, for Neon, don't you need kernel_neon_begin/end()? This may have its
own overhead and also BUG_ON for different contexts. Again, not suitable
for a generic function.

Unfortunately, there's no way to know what this function is called on.
We might try to infer that the kernel started at EL2 but even that is
not entirely correct with nested virt. Or the OS may start at EL1 but
have direct access to mlx5 where we'd want the faster option.

> mlx5 (and other RDMA devices) have long used Neon for MMIO in
> userspace, so any VMM assigning mlx5 devices simply must make this
> work - it is already not optional. So we know that all VMs out there
> with mlx5 support neon for mlx5, and it is safe for mlx5 to use.

I can't think of any generic solution here, it may have to be a hack
specific to mlx5. We can also add add support for ST64B and have some
condition on system_supports_st64b() for future systems.

Even if we could handle virtualisation, I wonder whether
__iowrite64_copy() is the right function to implement 128-bit stores or
the larger 64-byte atomic stores. At least the comment for the generic
function suggests that it writes in 64-bit quantities. Some MMIO may
only handle such writes. A function like memcpy_toio() is more generic,
it doesn't imply any restrictions on the size of the writes (though I
think it guarantees natural alignment for the stores).

-- 
Catalin

