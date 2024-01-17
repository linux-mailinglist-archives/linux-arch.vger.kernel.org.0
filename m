Return-Path: <linux-arch+bounces-1385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63083054A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 13:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F126E281744
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jan 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F817FD;
	Wed, 17 Jan 2024 12:30:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C82F30;
	Wed, 17 Jan 2024 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494608; cv=none; b=XEKh6MEERtG+2/jZPLB6j/jhyqR5cAaOCaqucrXOQAzr6aXXJ0DQ+08szyVgL8gmW8EMsisQ80bH8uIeukfS+a77FV1C7GY9A7t2sg30IniSrtnU0vMJBU66lbVwcYKZH0ptX2gzhFz6wsAnGx6RdxWf3j3PiHiIakHb2ZpMJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494608; c=relaxed/simple;
	bh=vfpWLFzxvHh1WPoKbrU7KkeTlkCsXClFVEql7NOpBFo=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=bOjOjO7BdbbBKXZC8e3GdKl5qI1SfaEllISyBbLAA17BuDaPgVrRG06PLwbgn9C3h+aEMY+6LlK3Ya59RQssLte7pEANmDlGwMGGCv/n8dN7QImwhCYly8tIedbeiOC7znJC8qC7u3lV2Cuz53OMuGeI72jB+l/NG2fZ5lG5JvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 688B211FB;
	Wed, 17 Jan 2024 04:30:51 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.37.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86E8B3F766;
	Wed, 17 Jan 2024 04:30:03 -0800 (PST)
Date: Wed, 17 Jan 2024 12:30:00 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <ZafISDVeAA1swx2I@FVFF77S0Q05N.cambridge.arm.com>
References: <20231127134505.GI436702@nvidia.com>
 <ZW4NAzI_jvwoq8dL@arm.com>
 <20231204182330.GK1493156@nvidia.com>
 <ZW9cF0ALVwgvcQMy@arm.com>
 <20231205175127.GJ2692119@nvidia.com>
 <ZW97VdHYH3HYVyd5@arm.com>
 <20231205195130.GM2692119@nvidia.com>
 <ZXBWXodu2rxQ7Szz@arm.com>
 <20231206125919.GP2692119@nvidia.com>
 <20240116185121.GB980613@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116185121.GB980613@nvidia.com>

On Tue, Jan 16, 2024 at 02:51:21PM -0400, Jason Gunthorpe wrote:
> Hey Catalin,
> 
> I'm just revising this and I'm wondering if you know why ARM64 has this:
> 
> #define __raw_writeq __raw_writeq
> static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> {
> 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> }
> 
> Instead of
> 
> #define __raw_writeq __raw_writeq
> static __always_inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> {
> 	asm volatile("str %x0, %1" : : "rZ" (val), "m" (*(volatile u64 *)addr));
> }
> 
> ?? Like x86 has.

I believe this is for the same reason as doing so in all of our other IO
accessors.

We've deliberately ensured that our IO accessors use a single base register
with no offset as this is the only form that HW can represent in ESR_ELx.ISS.SRT
when reporting a stage-2 abort, which a hypervisor may use for emulating IO.

Mark.

> 
> The codegen for a 64 byte unrolled copy loop is way better with "m" on gcc:
> 
> "r" constraint (gcc 13.2.0):
> 
> .L3:
>         ldr     x3, [x1]
>         str x3, [x0]
>         ldr     x3, [x1, 8]
>         add     x4, x0, 8
>         str x3, [x4]
>         ldr     x3, [x1, 16]
>         add     x4, x0, 16
>         str x3, [x4]
>         ldr     x3, [x1, 24]
>         add     x4, x0, 24
>         str x3, [x4]
>         ldr     x3, [x1, 32]
>         add     x4, x0, 32
>         str x3, [x4]
>         ldr     x3, [x1, 40]
>         add     x4, x0, 40
>         str x3, [x4]
>         ldr     x3, [x1, 48]
>         add     x4, x0, 48
>         str x3, [x4]
>         ldr     x3, [x1, 56]
>         add     x4, x0, 56
>         str x3, [x4]
>         add     x1, x1, 64
>         add     x0, x0, 64
>         cmp     x2, x1
>         bhi     .L3
> 
> "m" constraint:
> 
> .L3:
>         ldp     x10, x9, [x1]
>         ldp     x8, x7, [x1, 16]
>         ldp     x6, x5, [x1, 32]
>         ldp     x4, x3, [x1, 48]
>         str x10, [x0]
>         str x9, [x0, 8]
>         str x8, [x0, 16]
>         str x7, [x0, 24]
>         str x6, [x0, 32]
>         str x5, [x0, 40]
>         str x4, [x0, 48]
>         str x3, [x0, 56]
>         add     x1, x1, 64
>         add     x0, x0, 64
>         cmp     x2, x1
>         bhi     .L3
> 
> clang 17 doesn't do any better either way, it doesn't seem to do
> anything with 'm', but I guess it could..
> 
> clang 17 (either):
> 
> .LBB0_2:                                // =>This Inner Loop Header: Depth=1
>         ldp     x9, x10, [x1]
>         add     x14, x0, #8
>         add     x18, x0, #40
>         ldp     x11, x12, [x1, #16]
>         add     x2, x0, #48
>         add     x3, x0, #56
>         ldp     x13, x15, [x1, #32]
>         ldp     x16, x17, [x1, #48]
>         str     x9, [x0]
>         str     x10, [x14]
>         add     x9, x0, #16
>         add     x10, x0, #24
>         add     x14, x0, #32
>         str     x11, [x9]
>         str     x12, [x10]
>         str     x13, [x14]
>         str     x15, [x18]
>         str     x16, [x2]
>         str     x17, [x3]
>         add     x1, x1, #64
>         add     x0, x0, #64
>         cmp     x1, x8
>         b.lo    .LBB0_2
> 
> It doesn't matter for this series, but it seems like something ARM64
> might want to look at to improve..
> 
> Jason
> 

