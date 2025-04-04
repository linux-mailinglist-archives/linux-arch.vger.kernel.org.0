Return-Path: <linux-arch+bounces-11290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24999A7C3C2
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 21:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20F3189F776
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DB219A68;
	Fri,  4 Apr 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIZiimYd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AD145B25;
	Fri,  4 Apr 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743794920; cv=none; b=TvB+tvCAQs/a+csDiIVzRGaxptJl8HuFxE0Z24ejWQXd0+4f5F9lHtX4jy7pABq9wJEDS/hNNmkq04/bqAjjCiAnCUzLC/D5qXmIAk68TOUlyIohxaxfHapU2eT9eyNYTCinVVNwIduKyNYx8wHZEiginbMGPBgk4J2jVZHWs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743794920; c=relaxed/simple;
	bh=8ON196eganUBVW2Uw3mgBt0Ay+BgxYwGYYvK3t0u8LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAIca3mWIxGeFaCZ4Op2ZMmKSakcxHDiXSrJ9JIlv/xCyMEPvm5kBDSlAossdP3U443o4MpCSKXGme2xwfbRn4zm5KAlmrqfTyioP2nNvGDyvyeLNx32eINioGURylcGsiRxcJCZA6dYU7yCZH+pCXQ+4bTnwbMk0mOMUWS1q/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIZiimYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3764BC4CEDD;
	Fri,  4 Apr 2025 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743794919;
	bh=8ON196eganUBVW2Uw3mgBt0Ay+BgxYwGYYvK3t0u8LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIZiimYduGQlYd2eRXB0bT5WZbNtqoQs2X2vWnGNkb2RfYrSSYo+3b6Ksd92L9QkU
	 3jTvER9D2qhCfD9RD9u/HIRwBDb2e0HR7zlu61b9pTLeOexX0PTE7wJ3bxWUgk4Jcy
	 zkMeQ3h7tMs9VzyZ+QHUKlI5yRqZuBQeMHQ/zFynTEaUp1PEMNUH+UCgw6lXpws8m7
	 2cCkadlCNXtEL3GiPvoFWON3JPIq2P1cviH3f4bkUyEGRAxW29fZhUZ3xN+mvx3Ons
	 /zRuTDVoMUKMBP7EsS5b/ybQq7GLbbEKO80kjE9FspuudRcr3yy4rA0jgqHMvbbCRR
	 jPcbU/YWFP0+g==
Date: Fri, 4 Apr 2025 12:28:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Ignacio Encinas <ignacio@iencinas.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
Message-ID: <20250404192832.GC1622@sol.localdomain>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
 <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
 <aa29e983-78b9-430b-b8a6-e64de5f4ca12@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa29e983-78b9-430b-b8a6-e64de5f4ca12@codethink.co.uk>

On Fri, Apr 04, 2025 at 04:47:52PM +0100, Ben Dooks wrote:
> On 03/04/2025 21:34, Ignacio Encinas wrote:
> > Implement endianness swap macros for RISC-V.
> > 
> > Use the rev8 instruction when Zbb is available. Otherwise, rely on the
> > default mask-and-shift implementation.
> > 
> > Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> > ---
> >   arch/riscv/include/asm/swab.h | 43 +++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 43 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
> > new file mode 100644
> > index 000000000000..7352e8405a99
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/swab.h
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef _ASM_RISCV_SWAB_H
> > +#define _ASM_RISCV_SWAB_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/compiler.h>
> > +#include <asm/cpufeature-macros.h>
> > +#include <asm/hwcap.h>
> > +#include <asm-generic/swab.h>
> > +
> > +#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
> > +
> > +#define ARCH_SWAB(size) \
> > +static __always_inline unsigned long __arch_swab##size(__u##size value) \
> > +{									\
> > +	unsigned long x = value;					\
> > +									\
> > +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
> > +		asm volatile (".option push\n"				\
> > +			      ".option arch,+zbb\n"			\
> > +			      "rev8 %0, %1\n"				\
> > +			      ".option pop\n"				\
> > +			      : "=r" (x) : "r" (x));			\
> > +		return x >> (BITS_PER_LONG - size);			\
> > +	}                                                               \
> > +	return  ___constant_swab##size(value);				\
> > +}
> > +
> > +#ifdef CONFIG_64BIT
> > +ARCH_SWAB(64)
> > +#define __arch_swab64 __arch_swab64
> > +#endif
> > +
> > +ARCH_SWAB(32)
> > +#define __arch_swab32 __arch_swab32
> > +
> > +ARCH_SWAB(16)
> > +#define __arch_swab16 __arch_swab16
> > +
> > +#undef ARCH_SWAB
> > +
> > +#endif /* defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE) */
> > +#endif /* _ASM_RISCV_SWAB_H */
> > 
> 
> I was having a look at this as well, using the alternatives macros.
> 
> It would be nice to have a __zbb_swab defined so that you could do some
> time checks with this, because it would be interesting to see the
> benchmark of how much these improve byteswapping.

FYI if you missed the previous discussion
(https://lore.kernel.org/linux-riscv/20250302220426.GC2079@quark.localdomain/),
currently the overhead caused by the slow generic byte-swapping on RISC-V is
easily visible in the CRC benchmark.  For example compare:

    crc32_le_benchmark: len=16384: 2440 MB/s

to
    
    crc32_be_benchmark: len=16384: 674 MB/s

But the main loops of crc32_le and crc32_be are basically the same, except
crc32_le does le64_to_cpu() (or le32_to_cpu()) on the data whereas crc32_be does
be64_to_cpu() (or be32_to_cpu()).  The above numbers came from a little-endian
CPU, where le*_to_cpu() is a no-op and be*_to_cpu() is a byte-swap.

To reproduce this, build a kernel from the latest upstream with
CONFIG_CRC_KUNIT_TEST=y and CONFIG_CRC_BENCHMARK=y, boot it on a CPU that has
the Zbc extension, and check dmesg for the benchmark results.

This patch should mostly close the difference, though I don't currently have
hardware to confirm that myself.

- Eric

