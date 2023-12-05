Return-Path: <linux-arch+bounces-705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5AB805B0D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA01A1F2128E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FCF692BD;
	Tue,  5 Dec 2023 17:21:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CC692B9;
	Tue,  5 Dec 2023 17:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E461C433C8;
	Tue,  5 Dec 2023 17:21:29 +0000 (UTC)
Date: Tue, 5 Dec 2023 17:21:27 +0000
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
Message-ID: <ZW9cF0ALVwgvcQMy@arm.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204182330.GK1493156@nvidia.com>

On Mon, Dec 04, 2023 at 02:23:30PM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 04, 2023 at 05:31:47PM +0000, Catalin Marinas wrote:
> > Personally I'd optimise the mempcy_toio() arm64 implementation to do
> > STPs if the alignment is right (like we do for classic memcpy()).
> > There's a slight overhead for alignment checking but I suspect it would
> > be lost as long as you can get the write-combining. Not sure whether the
> > interspersed reads in memcpy_toio() would somehow prevent the
> > write-combining.
> 
> I understand on these new CPUs anything other than a block of
> contiguous STPs is risky to break the WC. I was told we should not
> have any loads between them.

Classic memcpy does similar tricks with four LDPs in a row before
starting to issue the STPs (though there are new LDPs for the next
data in-between). But that was tuned for cacheable memory, not sure
if something similar would behave well on Normal-NC memory.

> So we can't just update memcpy_toio to optimize a 128 bit store
> variant like memcpy might. We actually need a special case just for 64
> byte.
> 
> IMHO it does not look good as the chance any existing callers can use
> this optmized 64B path is probably small, but everyone has to pay the
> costs to check for it.

I don't think the cost of the check is noticeable and there are several
places where the copy goes beyond 64 bytes. It may be worth a try.

> I also would not do this on x86 - Pathscale apparently decided the
> needed special __iowrite*_copy() things to actually make this work on
> xome x86 systems - I'm very leary to change x86 stuff away from the 64
> bit copy loopw we know works already on x86.
> 
> IMHO encoding the alignment expectation in the API is best, especially
> since this is typically a performance path.

The slight downside of a __iowrite512_copy() API is that, if we follow
the 32/64 semantics, it would need the source buffer aligned. Maybe we
can document it to 64-bit alignment only rather than 512.

> > A memcpy_toio_64() can use the new ST64B instruction if available or
> > fall back to memcpy_toio() on arm64. It should also have the DGH
> > instruction (io_stop_wc()) but only if falling back to classic
> > memcpy_toio(). We don't need DGH with ST64B.
> 
> I'm told it is problematic, something about ST64B not working with
> NORMAL_NC.

Last time I checked it was meant to work on Normal-NC (not cacheable
though). That's on page 285 of the Arm ARM J.a.

> Also in a future ST64B world we are going to see HW start relying on
> large TLPs, not just being an optional performance win. To my mind it
> makes more sense that there is an API that guarantees a large TLP or
> oops. We really don't want an automatic fallback to memcpy.

We can't guarantee those large TLPs without the ST64B instructions, so
it needs to be more of a QoS aspect than correctness.

-- 
Catalin

