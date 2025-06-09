Return-Path: <linux-arch+bounces-12307-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E495AD2A2A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448281631C6
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1ED225401;
	Mon,  9 Jun 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ2q/LWi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA061519BA;
	Mon,  9 Jun 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509989; cv=none; b=ZOPa2M06NoGk7s06kB8cZCvRq33J7SjKW4zuJ8o0BhVWQAx2ehJpfhfxd+6A7gokJvoOafdP9IWgYgDU+3gpXv55Ns99+nIfuKq/j1vhdOVJ2zRyVNuaKhuvrEZD6CmzuSZx6M4z7teVKtI7BuOfTtRTQu+z6qIMpeOw9vCWNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509989; c=relaxed/simple;
	bh=U4vhsJXM46e+0Mfc4PBs3bseTa3h9UosBlHtozqeIf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7JCme5vD0DNL+6n75FdM5qPiHxCgzKtZ/4pNt3j8hjwHqc1d2wsL3PoGSMdDsvfU0BFtxyQErKVNE9RQC2jNUkf54etvqASNiM+/Upd7+7TlZvYS57oDemdCNiCQLmE5vdGx7pVbf9ZV1qhUVIYc+YmYxu7Vc8u9U1z59GgC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ2q/LWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A46C4CEEB;
	Mon,  9 Jun 2025 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749509988;
	bh=U4vhsJXM46e+0Mfc4PBs3bseTa3h9UosBlHtozqeIf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZ2q/LWijEpaEq00igAvU15ZFA2btFmPEoPv0oTqawn+MjrxKEc4/OqXy2N38kxpV
	 AFvy2lrAzn2djDaUY1swfzB9EZ627MitJD6/avaXEMt58zpc+17thB5+o+L/NCFmXx
	 Bbahqr8beEaE9JLR92svUSP/oo9HcH3K/MV2jUx5drdibhmczFNStuOfZD9lCWMysz
	 P11+Cs72P7BkkpWfSW0Wc/UiWNcR1xk5ksNxTizKDn6BSr0mEtJF/ezlntceoWJxAz
	 yys2b1O4D36HQh8H0QW/vQ0doPIIwaleXhHsMUSvkGTKjPZAQluFZIrFMruyPgxt0i
	 IRxGum7RmzoYw==
Date: Mon, 9 Jun 2025 15:59:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Julian Calaby <julian.calaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <20250609225926.GE1255@sol>
References: <20250607200454.73587-1-ebiggers@kernel.org>
 <CAGRGNgV_4X3O-qo3XFGexi9_JqJXK9Mf82=p8CQ4BoD3o-Hypw@mail.gmail.com>
 <20250609194845.GC1255@sol>
 <CAGRGNgXw5LcykjiRS3yteb0K8FmYtb9wp1CJPM+GCKAw7j4ktQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGRGNgXw5LcykjiRS3yteb0K8FmYtb9wp1CJPM+GCKAw7j4ktQ@mail.gmail.com>

On Tue, Jun 10, 2025 at 08:36:39AM +1000, Julian Calaby wrote:
> Hi Eric,
> 
> On Tue, Jun 10, 2025 at 5:49 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Mon, Jun 09, 2025 at 06:15:24PM +1000, Julian Calaby wrote:
> > > Hi Eric,
> > >
> > > On Sun, Jun 8, 2025 at 6:07 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > This series is also available at:
> > > >
> > > >     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git lib-crc-arch-v2
> > > >
> > > > This series improves how lib/crc supports arch-optimized code.  First,
> > > > instead of the arch-optimized CRC code being in arch/$(SRCARCH)/lib/, it
> > > > will now be in lib/crc/$(SRCARCH)/.  Second, the API functions (e.g.
> > > > crc32c()), arch-optimized functions (e.g. crc32c_arch()), and generic
> > > > functions (e.g. crc32c_base()) will now be part of a single module for
> > > > each CRC type, allowing better inlining and dead code elimination.  The
> > > > second change is made possible by the first.
> > > >
> > > > As an example, consider CONFIG_CRC32=m on x86.  We'll now have just
> > > > crc32.ko instead of both crc32-x86.ko and crc32.ko.  The two modules
> > > > were already coupled together and always both got loaded together via
> > > > direct symbol dependency, so the separation provided no benefit.
> > > >
> > > > Note: later I'd like to apply the same design to lib/crypto/ too, where
> > > > often the API functions are out-of-line so this will work even better.
> > > > In those cases, for each algorithm we currently have 3 modules all
> > > > coupled together, e.g. libsha256.ko, libsha256-generic.ko, and
> > > > sha256-x86.ko.  We should have just one, inline things properly, and
> > > > rely on the compiler's dead code elimination to decide the inclusion of
> > > > the generic code instead of manually setting it via kconfig.
> > > >
> > > > Having arch-specific code outside arch/ was somewhat controversial when
> > > > Zinc proposed it back in 2018.  But I don't think the concerns are
> > > > warranted.  It's better from a technical perspective, as it enables the
> > > > improvements mentioned above.  This model is already successfully used
> > > > in other places in the kernel such as lib/raid6/.  The community of each
> > > > architecture still remains free to work on the code, even if it's not in
> > > > arch/.  At the time there was also a desire to put the library code in
> > > > the same files as the old-school crypto API, but that was a mistake; now
> > > > that the library is separate, that's no longer a constraint either.
> > >
> > > Quick question, and apologies if this has been covered elsewhere.
> > >
> > > Why not just use choice blocks in Kconfig to choose the compiled-in
> > > crc32 variant instead of this somewhat indirect scheme?
> > >
> > > This would keep the dependencies grouped by arch and provide a single place to
> > > choose whether the generic or arch-specific method is used.
> >
> > It's not clear exactly what you're suggesting, but it sounds like you're
> > complaining about this:
> >
> >     config CRC32_ARCH
> >             bool
> >             depends on CRC32 && CRC_OPTIMIZATIONS
> >             default y if ARM && KERNEL_MODE_NEON
> >             default y if ARM64
> >             default y if LOONGARCH
> >             default y if MIPS && CPU_MIPSR6
> >             default y if PPC64 && ALTIVEC
> >             default y if RISCV && RISCV_ISA_ZBC
> >             default y if S390
> >             default y if SPARC64
> >             default y if X86
> 
> I was suggesting something roughly like:
> 
> choice
>     prompt "CRC32 Variant"
>     depends on CRC32 && CRC_OPTIMIZATIONS
> 
> config CRC32_ARCH_ARM_NEON
>     bool "ARM NEON"
>     default y
>     depends ARM && KERNEL_MODE_NEON
> 
> ...
> 
> config CRC32_GENERIC
>     bool "Generic"
> 
> endchoice
> 
> > This patchset strikes a balance where the vast majority of the arch-specific CRC
> > code is isolated in lib/crc/$(SRCARCH), and the exceptions are just
> > lib/crc/Makefile and lib/crc/Kconfig.  I think these exceptions make sense,
> > given that we're building a single module per CRC variant.  We'd have to go
> > through some hoops to isolate the arch-specific Kconfig and Makefile snippets
> > into per-arch files, which don't seem worth it here IMO.
> 
> I was only really concerned with the Kconfig structure, I was
> expecting Kbuild to look roughly like this: (filenames are wrong)
> 
> crc32-y += crc32-base.o
> crc32-$(CRC32_ARCH_ARM_NEON) += arch/arm/crc32-neon.o
> ...
> crc32-$(CRC32_GENERIC) += crc32-generic.o
> 
> but yeah, your proposal here has grown on me now that I think about it
> and the only real "benefit" mine has is that architectures can display
> choices for variants that have Kconfig-visible requirements, which
> probably isn't that many so it wouldn't be useful in practice.
> 
> Thanks for answering my question,

The CRC32 implementation did used to be user-selectable, but that was already
removed in v6.14 (except for the coarse-grained knob CONFIG_CRC_OPTIMIZATIONS
that remains and can be disabled only when CONFIG_EXPERT=y) since the vast
majority of users simply want the optimized CRC32 code enabled.  The fact that
it wasn't just enabled by default was a longstanding bug.

- Eric

