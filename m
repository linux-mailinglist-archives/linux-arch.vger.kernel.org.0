Return-Path: <linux-arch+bounces-710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F855806D76
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 12:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09226281AF5
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7B631597;
	Wed,  6 Dec 2023 11:09:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC622069;
	Wed,  6 Dec 2023 11:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5016FC433C7;
	Wed,  6 Dec 2023 11:09:21 +0000 (UTC)
Date: Wed, 6 Dec 2023 11:09:18 +0000
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
Message-ID: <ZXBWXodu2rxQ7Szz@arm.com>
References: <ZWB373y5XuZDultf@FVFF77S0Q05N>
 <20231124122352.GB436702@nvidia.com>
 <ZWSOwT2OyMXD1lmo@arm.com>
 <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205195130.GM2692119@nvidia.com>

On Tue, Dec 05, 2023 at 03:51:30PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 07:34:45PM +0000, Catalin Marinas wrote:
> > > 2) You want to #define __iowrite512_copy() to memcpy_toio() on ARM and
> > >    implement some quad STP optimization for this case?
> > 
> > We can have the generic __iowrite512_copy() do memcpy_toio() and have
> > the arm64 implement an optimised version.
> > 
> > What I'm not entirely sure of is the DGH (whatever the io_* barrier name
> > is). I'd put it in the same __iowrite512_copy() function and remove it
> > from the driver code. Otherwise when ST64B is added, we have an
> > unnecessary DGH in the driver. If this does not match the other
> > __iowrite*_copy() semantics, we can come up with another name. But start
> > with this for now and document the function.
> 
> I think the iowrite is only used for WC and the DGH is functionally
> harmless for non-WC, so it makes sense.
> 
> In this case we should just remove the DGH macro from the generic
> architecture code and tell people to use iowrite - since we now
> understand that callers basically have to in order to use DGH on new
> ARM CPUs.

That works for me but what would the semantics be for __iowrite64_copy()
for example? Is there a DGH at the end of the whole write or after each
iteration? I'd go with the former since e.g. hns3_tx_push_bd() does
that (and doesn't seem to be a 64 byte copy). Similarly for
__iowrite512_copy(), if you want the DGH after each iteration you should
only pass a count of 1.

-- 
Catalin

