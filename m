Return-Path: <linux-arch+bounces-467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F67F9FD4
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7FBB20D37
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1711CBC;
	Mon, 27 Nov 2023 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8643C8C4;
	Mon, 27 Nov 2023 12:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07870C433C9;
	Mon, 27 Nov 2023 12:42:43 +0000 (UTC)
Date: Mon, 27 Nov 2023 12:42:41 +0000
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
Message-ID: <ZWSOwT2OyMXD1lmo@arm.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124122352.GB436702@nvidia.com>

On Fri, Nov 24, 2023 at 08:23:52AM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 24, 2023 at 10:16:15AM +0000, Mark Rutland wrote:
> > On Thu, Nov 23, 2023 at 09:04:31PM +0200, Leon Romanovsky wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
[...]
> > > Provide a new generic function memcpy_toio_64() which should reliably
> > > generate the needed instructions for the architecture, assuming address
> > > alignment. As the usual need for this operation is performance sensitive a
> > > fast inline implementation is preferred.
> > 
> > There is *no* architectural sequence that is guaranteed to reliably generate a
> > 64-byte TLP, and this sequence won't guarnatee that (e.g. even if the CPU
> > *always* merged adjacent stores, we can take an interrupt mid-sequence that
> > would prevent that).
> 
> WC is not guaranteed on any arch, that is well known.
> 
> The HW has means to handle fragmented TLPs, it just hurts performance
> when it happens. "reliable" here means we'd like to see something like
> a > 90% chance of the large TLP instead of the < 1% chance with the C
> loop.
> 
> Future ARM CPUs have the ST64B instruction which does provide the
> architectural guarantee, and x86 has a similar guaranteed instruction
> now too. 
> 
> > What's the actual requirement here? Is this just for performance?
> 
> Yes, just performance.

Do you have any rough numbers (percentage)? It's highly
microarchitecture-dependent until we get the ST64B instruction.

More of a bike-shedding, I wonder whether the __iowrite*_copy()
semantics are better suited for what you need in terms of ordering (not
that mempcy_toio() to Normal NC memory gives us any ordering).

-- 
Catalin

