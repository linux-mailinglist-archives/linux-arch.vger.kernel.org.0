Return-Path: <linux-arch+bounces-3652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654F8A40B5
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 08:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB63D1F214AB
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 06:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A81C6A3;
	Sun, 14 Apr 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExCk/4I4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E2208A4;
	Sun, 14 Apr 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713077714; cv=none; b=sNgAbe44+8KCXVOMWnMyi3DTHTI2GzrsliFL/yMDRAQman10MDCOo+8UyosQECDl15n3W42EL1MubMaZWfWAvmNw69CRTvr0KKPrDgHD7jdgqCMb0jZusTw7o1TyqVYG0CdSmXsL40esGjbtG5sJAsPZx42TwTvEy/MpG6axTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713077714; c=relaxed/simple;
	bh=yXFVMzCDhJLeup5ZM/cl95e9uW89yN9aiaOn424Za9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfoccgObn9EnkjBv9/uDVMKczF511MmardP1KOfr21WJgoPvmo8sVA34vRS8OMzYum+fhe6jGjiSTws1TwWKbRgww6+PFulfm8skHJk3rhZ/zFjYIHCKpWfGMtMSC2JRE+h/KCm4r53wL/+QJbJSwRjVrAGaJRfGBJ0ut2PPIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExCk/4I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6995FC072AA;
	Sun, 14 Apr 2024 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713077713;
	bh=yXFVMzCDhJLeup5ZM/cl95e9uW89yN9aiaOn424Za9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExCk/4I4W5Phef5aKaCHl7yCjGPCdhEDo2t4j5gOOcRyNoNKAWaoFjcjUPNV/ZDjL
	 NgPGAZFKEHXGgq8aJVi8Z2vvDSoVvCAV16D5jLcPzItS86EojO+p5yw5DDCakIbCdC
	 uDA7f0oS8i29LKJV724dmx85sHqKA14tjFqITDp8vRb8dfZu8WBgwU1FYXq0TYmRGR
	 7tSa/jZjNfXa/T7/J/CXr2wjq9OOfmF2PhtvRmpH6VXO/pNGCEo0ysFPCgbJcswH3+
	 8pSQxW9Jh3lYLdHalhcMBeJUrFP7jE5aNtiOQBUuA7scvpAOHZqdofUGHWY2VvqQnF
	 hEcRjO6WYTf+Q==
Date: Sun, 14 Apr 2024 09:53:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
Message-ID: <Zht9hw_DhDsaTuEP@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-6-rppt@kernel.org>
 <Zhg9DXzagPbpNGH1@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhg9DXzagPbpNGH1@bombadil.infradead.org>

On Thu, Apr 11, 2024 at 12:42:05PM -0700, Luis Chamberlain wrote:
> On Thu, Apr 11, 2024 at 07:00:41PM +0300, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > module_alloc() is used everywhere as a mean to allocate memory for code.
> > 
> > Beside being semantically wrong, this unnecessarily ties all subsystems
> > that need to allocate code, such as ftrace, kprobes and BPF to modules and
> > puts the burden of code allocation to the modules code.
> > 
> > Several architectures override module_alloc() because of various
> > constraints where the executable memory can be located and this causes
> > additional obstacles for improvements of code allocation.
> > 
> > Start splitting code allocation from modules by introducing execmem_alloc()
> > and execmem_free() APIs.
> > 
> > Initially, execmem_alloc() is a wrapper for module_alloc() and
> > execmem_free() is a replacement of module_memfree() to allow updating all
> > call sites to use the new APIs.
> > 
> > Since architectures define different restrictions on placement,
> > permissions, alignment and other parameters for memory that can be used by
> > different subsystems that allocate executable memory, execmem_alloc() takes
> > a type argument, that will be used to identify the calling subsystem and to
> > allow architectures define parameters for ranges suitable for that
> > subsystem.
> 
> It would be good to describe this is a non-fuctional change.

Ok.
 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> 
> > diff --git a/mm/execmem.c b/mm/execmem.c
> > new file mode 100644
> > index 000000000000..ed2ea41a2543
> > --- /dev/null
> > +++ b/mm/execmem.c
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> And this just needs to copy over the copyright notices from the main.c file.

Will do.
 
>   Luis

-- 
Sincerely yours,
Mike.

