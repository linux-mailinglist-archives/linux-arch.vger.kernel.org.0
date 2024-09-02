Return-Path: <linux-arch+bounces-6915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F59688CE
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C2B1C229AD
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766A20FA9E;
	Mon,  2 Sep 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iuNrutOX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627620FA81;
	Mon,  2 Sep 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283540; cv=none; b=WG+gXN9K8lxnGxbDORaYnFTizfEn6qn18Od8D6zse+D7P0IHeP2j7jb0UT2aDJZ6gDMy8v06gWr1daTHE2qdkpTljoAGE0aFyTFGemtDl2vGgCptPA1Qjeh0aY7J6EOGtEj+3/il9STyTdC9juO/VzbEUAOC1zqOy3PrG1G8KIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283540; c=relaxed/simple;
	bh=fUSd9HPyLWKRmcuFVw1YoefIwPoFNB5OAn+c3unkmPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMNddmfPv1XpvqQXMydrlkpE+DfzDA7kkGl8+xs9cvd2fltYRG2cjMbO+qRQ8WNyV3rRJkOelulb3NQyiGKODyncO8ead3lr30KGSwSCxOpuAHjUWjeYd6juvmYc2j1kdfWjhc1gLxQHiwY/UVsyp/0f34aLwAvevThsAc3RpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=iuNrutOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DC7C4CEC2;
	Mon,  2 Sep 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iuNrutOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725283536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6jSH04ylCfCnC9fARLpwRNnQ3m5UGs97reDSV69vpg=;
	b=iuNrutOXX3CqU+J1BZxzwrNyjslGjTny3QmMKKXSomAE2CIiydXfypJ1MfWaL8mkUagLFN
	orHmTQ7PSSuDwRPMcfwFvKl2XGvXueL05hGkVUUA92GHFLQaaJrJm6Y40xoaSZFe0n3plE
	eCNa4RHgAojXV1XWFsNLVU042Q6PQOg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a75bf891 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:25:36 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:25:34 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>, ardb@kernel.org
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtW8zh8ED-oePxnw@zx2c4.com>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <20240830114645.GA8219@willie-the-truck>
 <963afe11-fd48-4fe9-be70-2e202f836e34@linaro.org>
 <ZtW5meR5iLrkKErJ@zx2c4.com>
 <8390ac81-7774-4e67-9739-c2b98813d6da@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8390ac81-7774-4e67-9739-c2b98813d6da@csgroup.eu>

On Mon, Sep 02, 2024 at 03:19:56PM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/09/2024 à 15:11, Jason A. Donenfeld a écrit :
> > Hey Christophe (for header logic) & Will (for arm64 stuff),
> > 
> > On Fri, Aug 30, 2024 at 09:28:29AM -0300, Adhemerval Zanella Netto wrote:
> >>>> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> >>>> index 938ca539aaa6..7c9711248d9b 100644
> >>>> --- a/lib/vdso/getrandom.c
> >>>> +++ b/lib/vdso/getrandom.c
> >>>> @@ -5,6 +5,7 @@
> >>>>   
> >>>>   #include <linux/array_size.h>
> >>>>   #include <linux/minmax.h>
> >>>> +#include <linux/mm.h>
> >>>>   #include <vdso/datapage.h>
> >>>>   #include <vdso/getrandom.h>
> >>>>   #include <vdso/unaligned.h>
> >>>
> >>> Looks like this should be a separate change?
> >>
> >>
> >> It is required so arm64 can use  c-getrandom-y, otherwise vgetrandom.o build
> >> fails:
> >>
> >> CC      arch/arm64/kernel/vdso/vgetrandom.o
> >> In file included from ./include/uapi/linux/mman.h:5,
> >>                   from /mnt/projects/linux/linux-git/lib/vdso/getrandom.c:13,
> >>                   from <command-line>:
> >> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_prot_bits’:
> >> ./arch/arm64/include/asm/mman.h:14:13: error: implicit declaration of function ‘system_supports_bti’ [-Werror=implicit-function-declaration]
> >>     14 |         if (system_supports_bti() && (prot & PROT_BTI))
> >>        |             ^~~~~~~~~~~~~~~~~~~
> >> ./arch/arm64/include/asm/mman.h:15:24: error: ‘VM_ARM64_BTI’ undeclared (first use in this function); did you mean ‘ARM64_BTI’?
> >>     15 |                 ret |= VM_ARM64_BTI;
> >>        |                        ^~~~~~~~~~~~
> >>        |                        ARM64_BTI
> >> ./arch/arm64/include/asm/mman.h:15:24: note: each undeclared identifier is reported only once for each function it appears in
> >> ./arch/arm64/include/asm/mman.h:17:13: error: implicit declaration of function ‘system_supports_mte’ [-Werror=implicit-function-declaration]
> >>     17 |         if (system_supports_mte() && (prot & PROT_MTE))
> >>        |             ^~~~~~~~~~~~~~~~~~~
> >> ./arch/arm64/include/asm/mman.h:18:24: error: ‘VM_MTE’ undeclared (first use in this function)
> >>     18 |                 ret |= VM_MTE;
> >>        |                        ^~~~~~
> >> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_flag_bits’:
> >> ./arch/arm64/include/asm/mman.h:32:24: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
> >>     32 |                 return VM_MTE_ALLOWED;
> >>        |                        ^~~~~~~~~~~~~~
> >> ./arch/arm64/include/asm/mman.h: In function ‘arch_validate_flags’:
> >> ./arch/arm64/include/asm/mman.h:59:29: error: ‘VM_MTE’ undeclared (first use in this function)
> >>     59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
> >>        |                             ^~~~~~
> >> ./arch/arm64/include/asm/mman.h:59:52: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
> >>     59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
> >>        |                                                    ^~~~~~~~~~~~~~
> >> arch/arm64/kernel/vdso/vgetrandom.c: In function ‘__kernel_getrandom’:
> >> arch/arm64/kernel/vdso/vgetrandom.c:18:25: error: ‘ENOSYS’ undeclared (first use in this function); did you mean ‘ENOSPC’?
> >>     18 |                 return -ENOSYS;
> >>        |                         ^~~~~~
> >>        |                         ENOSPC
> >> cc1: some warnings being treated as errors
> >>
> >> I can move to a different patch, but this is really tied to this patch.
> > 
> > Adhemerval kept this change in this patch for v3, which, if it's
> > necessary, is fine with me. But I was looking to see if there was
> > another way of doing it, because including linux/mm.h inside of vdso
> > code is kind of contrary to your project with e379299fe0b3 ("random:
> > vDSO: minimize and simplify header includes").
> > 
> > getrandom.c includes uapi/linux/mman.h for the mmap constants. That
> > seems fine; it's userspace code after all. But then uapi/linux/mman.h
> > has this:
> > 
> >     #include <asm/mman.h>
> >     #include <asm-generic/hugetlb_encode.h>
> >     #include <linux/types.h>
> > 
> > The asm-generic/ one resolves to uapi/asm-generic. But the asm/ one
> > resolves to arch code, which is where we then get in trouble on ARM,
> > where arch/arm64/include/asm/mman.h has all sorts of kernel code in it.
> > 
> > Maybe, instead, it should resolve to arch/arm64/include/uapi/asm/mman.h,
> > which is the header that userspace actually uses in normal user code?
> > 
> > Is this a makefile problem? What's going on here? Seems like this is
> > something worth sorting out. Or I can take Adhemerval's v3 as-is and
> > we'll grit our teeth and work it out later, as you prefer. But I thought
> > I should mention it.
> 
> That's a tricky problem, I also have it on powerpc, see patch 5, I 
> solved it that way:
> 
> In the Makefile:
> -ccflags-y := -fno-common -fno-builtin
> +ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
> 
> In arch/powerpc/include/asm/mman.h:
> 
> diff --git a/arch/powerpc/include/asm/mman.h 
> b/arch/powerpc/include/asm/mman.h
> index 17a77d47ed6d..42a51a993d94 100644
> --- a/arch/powerpc/include/asm/mman.h
> +++ b/arch/powerpc/include/asm/mman.h
> @@ -6,7 +6,7 @@
> 
>   #include <uapi/asm/mman.h>
> 
> -#ifdef CONFIG_PPC64
> +#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)
> 
>   #include <asm/cputable.h>
>   #include <linux/mm.h>
> 
> So that the only thing that remains in arch/powerpc/include/asm/mman.h 
> when building a VDSO is #include <uapi/asm/mman.h>
> 
> I got the idea from ARM64, they use something similar in their 
> arch/arm64/include/asm/rwonce.h

That seems reasonable enough. Adhemerval - do you want to incorporate
this solution for your v+1? And Will, is it okay to keep that as one
patch, as Christophe has done, rather than splitting it, so the whole
change is hermetic?

Jason

