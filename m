Return-Path: <linux-arch+bounces-646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A254D803B8F
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C497A1C20A8B
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA4D2E83C;
	Mon,  4 Dec 2023 17:31:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3E2E41A;
	Mon,  4 Dec 2023 17:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D900C433C7;
	Mon,  4 Dec 2023 17:31:50 +0000 (UTC)
Date: Mon, 4 Dec 2023 17:31:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev, Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZW4NAzI_jvwoq8dL@arm.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127134505.GI436702@nvidia.com>

On Mon, Nov 27, 2023 at 09:45:05AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 27, 2023 at 12:42:41PM +0000, Catalin Marinas wrote:
> > > > What's the actual requirement here? Is this just for performance?
> > > 
> > > Yes, just performance.
> > 
> > Do you have any rough numbers (percentage)? It's highly
> > microarchitecture-dependent until we get the ST64B instruction.
> 
> The current C code is an open coded store loop. The kernel does 250
> tries and measures if any one of them succeeds to combine.
> 
> On x86, and older ARM cores we see that 100% of the time at least 1 in
> 250 tries succeeds.
> 
> With the new CPU cores we see more like 9 out of 10 time there are 0
> in 250 tries that succeed. Ie we can go thousands of times without
> seeing any successful WC combine.
> 
> The STP block brings it back to 100% of the time 1 in 250 succeed.

That's a bit confusing to me: 1 in 250 succeeding is still pretty rare.
But I guess what your benchmark says is that at least 1 succeeded to
write-combine and it might as well be all 250 tries. It's more
interesting to see if there's actual performance gain in real-world
traffic, not just some artificial benchmark (I may have misunderstood
your numbers above).

> However, in userspace we have long been using ST4 to create a
> single-instruction 64 byte store on ARM64. As far as I know this is
> highly reliable. I don't have direct data on the STP configuration.

Personally I'd optimise the mempcy_toio() arm64 implementation to do
STPs if the alignment is right (like we do for classic memcpy()).
There's a slight overhead for alignment checking but I suspect it would
be lost as long as you can get the write-combining. Not sure whether the
interspersed reads in memcpy_toio() would somehow prevent the
write-combining.

A memcpy_toio_64() can use the new ST64B instruction if available or
fall back to memcpy_toio() on arm64. It should also have the DGH
instruction (io_stop_wc()) but only if falling back to classic
memcpy_toio(). We don't need DGH with ST64B.

> > More of a bike-shedding, I wonder whether the __iowrite*_copy()
> > semantics are better suited for what you need in terms of ordering (not
> > that mempcy_toio() to Normal NC memory gives us any ordering).
> 
> I have the same remark I gave to Niklas, this does not require
> alignment or an exact 64 byte size. It was clearly made to support WC
> stores since Pathscale did it, but I don't see this mapping nicely to
> the future 64 byte store instructions are we getting.

As above, I'd suggest just using memcpy_toio() as a fallback if ST64B is
not available.

> We could name it __iowrite512_copy() if that makes more sense?

I've been thinking at the __iowrite*_copy() and these also take a
'count' argument. I assume in this instance we don't really need one, so
it's just additional overhead (more like API clutter, I doubt it makes
much difference for performance). I'd say just stick to the
mempcy_toio_64() but have the io_stop_wc() inside this function as we
won't need it with ST64B.

Well, unless someone has a better name for this function.

-- 
Catalin

