Return-Path: <linux-arch+bounces-4459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7859F8C8991
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C442B22ADA
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AED12F5A9;
	Fri, 17 May 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPsMCEt7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FED12F5A3;
	Fri, 17 May 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960805; cv=none; b=gD8HYbVUMThpuyZ8qsBs01Umko4W99irkrqfgoYL5QZ31P+g+zVhyR+0DoDFCF15cmaqKMiv4xZEK2YF51cfOy9PBkzfZ8scdLOMPD6oeFmouXvGb9nr73C2QmWIR8xR/dti6z3AowYxTM9+o2qmF/aI56LCOCtd67Mc8lOVNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960805; c=relaxed/simple;
	bh=EpkhHazhMZ2fwuDobsplhqZvRLo+YDrsHfPiI4NpGv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKACy+u1+YztLmWQdjIiCnkGINYxyXb6Ut+09sAoH/qghxGCCU01rG3+LAFET8qc4JwFGgFIxIAxZryqeu80xnpu35x0RC0EodpbWWvApr86E2ooFn8RYqZM6vWE0/WPeIuRQiBUEqaKiBu+vmZWSXuzZ9HDN1J32+/geUD7pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPsMCEt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111FAC4AF67;
	Fri, 17 May 2024 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715960804;
	bh=EpkhHazhMZ2fwuDobsplhqZvRLo+YDrsHfPiI4NpGv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPsMCEt72a5yEc9EgEt6r+yjYEkV9BPAe1xRO8Mnx0FWUaiC9lvILRG04VRJZWw48
	 6oi3NhTWACIBMVCpaYFZBzGgjvog9Y2TBWGjwbtg4as/XPHXHwLo0KeYmlix1Tn8jJ
	 4VeuQ6blAMOigvYJG5R5zp9Slb7rxBGhcGmnSRhVLw3HY2TMrkHzFxNCfy5TM2KOl7
	 3goZJdJ9Tr8Zr9DvcjkvtgL8pUnnLDDUJrwFLygDVMOs6MaI5wNJFVtqt+sDPTLZKE
	 8D0fBgS7iYh917OFn63YR+c8+L84i4xjQMciA0V/P7pqzz6WoJLNRgmPCqv4y8iZTU
	 E4tvvudi2KGsA==
Date: Fri, 17 May 2024 16:46:32 +0100
From: Will Deacon <will@kernel.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
	Liviu Dudau <liviu@dudau.co.uk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RESEND v8 16/16] bpf: remove CONFIG_BPF_JIT dependency on
 CONFIG_MODULES of
Message-ID: <20240517154632.GA320@willie-the-truck>
References: <20240505160628.2323363-1-rppt@kernel.org>
 <20240505160628.2323363-17-rppt@kernel.org>
 <7983fbbf-0127-457c-9394-8d6e4299c685@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7983fbbf-0127-457c-9394-8d6e4299c685@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Klara,

On Fri, May 17, 2024 at 01:00:31AM +0200, Klara Modin wrote:
> On 2024-05-05 18:06, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > BPF just-in-time compiler depended on CONFIG_MODULES because it used
> > module_alloc() to allocate memory for the generated code.
> > 
> > Since code allocations are now implemented with execmem, drop dependency of
> > CONFIG_BPF_JIT on CONFIG_MODULES and make it select CONFIG_EXECMEM.
> > 
> > Suggested-by: Björn Töpel <bjorn@kernel.org>
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >   kernel/bpf/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index bc25f5098a25..f999e4e0b344 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -43,7 +43,7 @@ config BPF_JIT
> >   	bool "Enable BPF Just In Time compiler"
> >   	depends on BPF
> >   	depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
> > -	depends on MODULES
> > +	select EXECMEM
> >   	help
> >   	  BPF programs are normally handled by a BPF interpreter. This option
> >   	  allows the kernel to generate native code when a program is loaded
> 
> This does not seem to work entirely. If build with BPF_JIT without module
> support for my Raspberry Pi 3 B I get warnings in my kernel log (easiest way
> to trigger it seems to be trying to ssh into it, which fails).

Thanks for the report. I was able to reproduce this using QEMU and it
looks like the problem is because bpf_arch_text_copy() silently fails
to write to the read-only area as a result of patch_map() faulting and
the resulting -EFAULT being chucked away.

Please can you try the diff below?

Will

--->8

diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 255534930368..94b9fea65aca 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -36,7 +36,7 @@ static void __kprobes *patch_map(void *addr, int fixmap)
 
        if (image)
                page = phys_to_page(__pa_symbol(addr));
-       else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+       else if (IS_ENABLED(CONFIG_EXECMEM))
                page = vmalloc_to_page(addr);
        else
                return addr;


