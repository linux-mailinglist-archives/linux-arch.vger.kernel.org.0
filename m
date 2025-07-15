Return-Path: <linux-arch+bounces-12773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D762B0515C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 07:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21037B1AE9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 05:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1354A2D29CA;
	Tue, 15 Jul 2025 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ0kddfR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0135255F24;
	Tue, 15 Jul 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559032; cv=none; b=H/oRjwtXmXAJvia2cdLs9Ogn9n7mnBOXx/hLTkV5e5KArztjHqE9nqBF40C1pfw9xS6tS7BalVsXh2uWoG9bJCul/VkPC3tWL/dAaExUMSZPe9EfBSAl/0A3JtakHhPndiB+PWiteG9TSGVIvLCKADOin+Gd8jj0ghB6fmRbm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559032; c=relaxed/simple;
	bh=wmvN79kkI2uY89k/rrcdVS6059/8dQL8TezMZWnf+rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuwIH4MM45hCUNMHgWeG49I8VJJPNO+tDblhdMsyAS6SLXsvums274nez4bdkmBpRHmgcQVvy+dcvx/U8TpauUDIrGNZH5I666NUa6m4PMYmWs+EuE6gjCwhU9KOTjL1dqgjLfgt2v/lRyFze5eGQvRWAwEOexHm9oLHVTKbEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ0kddfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8964C4CEE3;
	Tue, 15 Jul 2025 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752559031;
	bh=wmvN79kkI2uY89k/rrcdVS6059/8dQL8TezMZWnf+rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ0kddfRq/wi2cczPvscCBtaQBOvPPubaZPv3FhypEw+5UKK0WhctGzJqakUE47mj
	 0hgvMUtevpezIfVJrccsqdtSYPd2sjN0nRb9tN0vghFJ+c05Vt5+gWGqNDdNJk7p6H
	 Sh8oWOAYHvlvgAcM5ZwOV2KbvC/4LCYKyIt/WgUJb5b0ER0EaKLDgyQwMcQxcdZpWG
	 yRZoRdLWkXFBN0aAu91ZYkfbMxd4cRB9BrlHetz/bw9JgY4rGuKT9x+znMMEXCi7ry
	 xSs/2RLQ/Ed9IUoMZM+nwW7VQ7Wh00EVvhINdsIUSq31XrazAB7+UGLadWmjzYO5wH
	 BcbPsbS4HX8Vw==
Date: Tue, 15 Jul 2025 08:57:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, llvm@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jijie Shao <shaojijie@huawei.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 6/6] IB/mlx5: Use __iowrite64_copy() for write
 combining stores
Message-ID: <20250715055707.GC5882@unreal>
References: <0-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <6-v3-1893cd8b9369+1925-mlx5_arm_wc_jgg@nvidia.com>
 <20250714215504.GA2083014@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714215504.GA2083014@nvidia.com>

On Mon, Jul 14, 2025 at 06:55:04PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 11, 2024 at 01:46:19PM -0300, Jason Gunthorpe wrote:
> > mlx5 has a built in self-test at driver startup to evaluate if the
> > platform supports write combining to generate a 64 byte PCIe TLP or
> > not. This has proven necessary because a lot of common scenarios end up
> > with broken write combining (especially inside virtual machines) and there
> > is other way to learn this information.
> > 
> > This self test has been consistently failing on new ARM64 CPU
> > designs (specifically with NVIDIA Grace's implementation of Neoverse
> > V2). The C loop around writeq() generates some pretty terrible ARM64
> > assembly, but historically this has worked on a lot of existing ARM64 CPUs
> > till now.
> > 
> > We see it succeed about 1 time in 10,000 on the worst effected
> > systems. The CPU architects speculate that the load instructions
> > interspersed with the stores makes the WC buffers statistically flush too
> > often and thus the generation of large TLPs becomes infrequent. This makes
> > the boot up test unreliable in that it indicates no write-combining,
> > however userspace would be fine since it uses a ST4 instruction.
> 
> Hi Catalin,
> 
> After a year of testing this in real systems it turns out that still
> some systems are not good enough with the unrolled 8 byte store loop.
> In my view the CPUs are quite bad here and this WC performance
> optimization is not working very well.
> 
> There are only two more options to work around this issue, use the
> unrolled 16 byte STP or the single Neon instruction 64 byte store.
> 
> Since STP was rejected alread we've only tested the Neon version. It
> does make a huge improvement, but it still somehow fails to combine
> rarely sometimes. The CPU is really bad at this :(
> 
> So we want to make mlx5 use the single 64 byte neon store instruction
> like userspace has been using for a long time for this testing
> algorithm.
> 
> It is simple enough, but the question has come up where to put the
> code.  Do you want to somehow see the neon option to be in the
> arch/arm64 code or should we stick it in the driver under a #ifdef?
> 
> The entry/exit from neon is slow enough I don't think any driver doing
> performance work would want to use neon instead of __iowrite64_copy(),
> so I do not think it should be hidden inside __iowrite64_copy(). Nor
> have I thought of a name for an arch generic function..

__iowrite64_slow_copy() ????

> 
> Thanks,
> Jason

