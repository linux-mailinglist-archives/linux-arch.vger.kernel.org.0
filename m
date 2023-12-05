Return-Path: <linux-arch+bounces-707-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C8805EB0
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 20:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6CEB21071
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF36AB8A;
	Tue,  5 Dec 2023 19:34:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9F6AB84;
	Tue,  5 Dec 2023 19:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0F5C433C7;
	Tue,  5 Dec 2023 19:34:47 +0000 (UTC)
Date: Tue, 5 Dec 2023 19:34:45 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZW97VdHYH3HYVyd5@arm.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205175127.GJ2692119@nvidia.com>

On Tue, Dec 05, 2023 at 01:51:27PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 05:21:27PM +0000, Catalin Marinas wrote:
> > On Mon, Dec 04, 2023 at 02:23:30PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Dec 04, 2023 at 05:31:47PM +0000, Catalin Marinas wrote:
> > > > Personally I'd optimise the mempcy_toio() arm64 implementation to do
> > > > STPs if the alignment is right (like we do for classic memcpy()).
> > > > There's a slight overhead for alignment checking but I suspect it would
> > > > be lost as long as you can get the write-combining. Not sure whether the
> > > > interspersed reads in memcpy_toio() would somehow prevent the
> > > > write-combining.
> > > 
> > > I understand on these new CPUs anything other than a block of
> > > contiguous STPs is risky to break the WC. I was told we should not
> > > have any loads between them.
> > 
> > Classic memcpy does similar tricks with four LDPs in a row before
> > starting to issue the STPs (though there are new LDPs for the next
> > data in-between). But that was tuned for cacheable memory, not sure
> > if something similar would behave well on Normal-NC memory.
> 
> Can we conclude a direction here?
> 
> 1) I don't want to mess with x86 so we keep a dedicated API
>    Are we agreed to call it __iowrite512_copy() and note its special
>    alignment limitation?

Sounds fine to me.

> 2) You want to #define __iowrite512_copy() to memcpy_toio() on ARM and
>    implement some quad STP optimization for this case?

We can have the generic __iowrite512_copy() do memcpy_toio() and have
the arm64 implement an optimised version.

What I'm not entirely sure of is the DGH (whatever the io_* barrier name
is). I'd put it in the same __iowrite512_copy() function and remove it
from the driver code. Otherwise when ST64B is added, we have an
unnecessary DGH in the driver. If this does not match the other
__iowrite*_copy() semantics, we can come up with another name. But start
with this for now and document the function.

> 3) A future ST64B and the x86 version would be put under
>    __iowrite512_copy()?

Yes, arch-specific override.

> 4) A future ST64B would come with some kind of 'must do 64b copy or
>    oops' to support the future HW that must have this instruction? eg
>    we already see on Intel that HW must use ENQCMD and nothing else.

I don't agree with the oops part. We can't guarantee it on arm64, ST64B
I think is optional in the architecture. If you do need such guarantees,
we'd need the driver to probe for the feature (e.g. arch_has_...()) and
invoke a new macro. You can't have the __iowrite512_copy() that worked
fine suddenly giving an error just because some driver wants a
guaranteed atomic 64 byte write.

-- 
Catalin

