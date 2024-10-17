Return-Path: <linux-arch+bounces-8249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2179A20F1
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 13:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DD5B20E6D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3491DBB3A;
	Thu, 17 Oct 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot+aEOLg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115811DAC86;
	Thu, 17 Oct 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164542; cv=none; b=jWcw6PfYoSDRIP1R2WwQRasmqv7xDS6dVFMsZXeQW412EuBar+UGIpG934Uraipe0RIqIUVmCNAC3Um5FF2nBCsYSpsvBm/4gNlBS3obd4YkMr9eUkLVIR+krbKCK7Rav82OC26hrADwh58beUY4XGM1IkCT7f09emaFaaGDLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164542; c=relaxed/simple;
	bh=rt80HNwYvry4F4GclVQlY1veJ+krWpXQVKReUpcl890=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvSqamfqiXnn9xRBzSs/+y+27ipmtsgY3LqQRfpskcXziMiKqve8k+gGC6BUN0U1gTPpzFqlekUrFtPPqahPUQ00NZ8aJDnOLqsZTXLefpgbe11WjH2KpJbGypQoKOOmBEvTi2UdDcU9+gKYQaYo8TdMdLuZH86pt5O5jDTxqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot+aEOLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51E6C4CEC3;
	Thu, 17 Oct 2024 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729164541;
	bh=rt80HNwYvry4F4GclVQlY1veJ+krWpXQVKReUpcl890=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ot+aEOLgX5JjytFWTSP6bvwXMFkowa3+f8eQ2nWquiQ2RAv0bCvly8HaX5AltuwSG
	 MSL87zIBHWGLQnCmCdiEfFC7X5ejkFjDqsJRxmUPBDOphZUPBuoh9vgoceix8Psav5
	 Yvn0UgFKrQvx/wSoy69QgTtp5NCCSdTL6QB1vx3PWWPTlokB4+yqFBJYWypC9U2bHQ
	 nQtmXd5x7H21VQL4AHHLnM8nJNg1uOm2mWoaE2bjtRwnQ1e9g0HZLSZljRpX0WRG/I
	 j7Jg7Czseip6435Tp950cr2IcSkIthwfZaEljLp7+y1XWJYi+AU0xcha6M5b6FnQGJ
	 4UYbNkR0gIbzA==
Date: Thu, 17 Oct 2024 14:25:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 6/8] x86/module: prepare module loading for ROX
 allocations of text
Message-ID: <ZxD0EVBoO-jcxEGE@kernel.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-7-rppt@kernel.org>
 <20241016170128.7afeb8b0@gandalf.local.home>
 <20241017093515.GU16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017093515.GU16066@noisy.programming.kicks-ass.net>

On Thu, Oct 17, 2024 at 11:35:15AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 16, 2024 at 05:01:28PM -0400, Steven Rostedt wrote:
> > On Wed, 16 Oct 2024 15:24:22 +0300
> > Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > > index 8da0e66ca22d..b498897b213c 100644
> > > --- a/arch/x86/kernel/ftrace.c
> > > +++ b/arch/x86/kernel/ftrace.c
> > > @@ -118,10 +118,13 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
> > >  		return ret;
> > >  
> > >  	/* replace the text with the new text */
> > > -	if (ftrace_poke_late)
> > > +	if (ftrace_poke_late) {
> > >  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> > > -	else
> > > -		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > > +	} else {
> > > +		mutex_lock(&text_mutex);
> > > +		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > > +		mutex_unlock(&text_mutex);
> > > +	}
> > >  	return 0;
> > >  }
> > 
> > So this slows down the boot by over 30ms. That may not sound like much, but
> > we care very much about boot times. This code is serialized with boot and
> > runs whenever ftrace is configured in the kernel. The way I measured this,
> > was that I added:
> > 
> 
> > If this is only needed for module load, can we at least still use the
> > text_poke_early() at boot up?
> 
> Right, so I don't understand why this is needed at all.
> ftrace_module_init() runs before complete_formation() which normally
> switches to ROX, as such ftrace should be able to continue to do direct
> modifications here.

With this series the module text is allocated as ROX at the first place, so
the modifications ftrace does to module text have to either use text poking
even before complete_formation() or deal with a writable copy like I did
for relocations and alternatives.

I've been carrying the ftrace changes from a very old prototype and
didn't pay enough attention to them them until Steve's complaint.

I'll look into it.
 
> Which reminds me, at some point I did patches adding a
> MODULE_STATE_UNFORMED callback in order for static_call / jump_label to
> be able to avoid the expensive patching on module load as well (arguably
> ftrace should be using that too, instead of a custom callback).
> 

-- 
Sincerely yours,
Mike.

