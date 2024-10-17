Return-Path: <linux-arch+bounces-8247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C99A1E82
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9659F281DD7
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC21D8E01;
	Thu, 17 Oct 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XiFI8B0o"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117B12DD8A;
	Thu, 17 Oct 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157722; cv=none; b=UpUiOJbtw8iZ3OKHSVxebF+uGWLS8vNm2NCm+hvjhRvzS2cSuF5i2BybNOXgS1e/q+R9OGC+eO0ah6MfCRnpLzk/zuGv45PoEU/Zp1N9Jc0xyA48Ep4am3M+4T/Hg5H16vBQPCu6DnlPnCIg/EOdSROTCR9MDx3Ji3ywBIqg9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157722; c=relaxed/simple;
	bh=ped3950d54S9hAnLeEAj3X1RF7de8yQC2eJe9g2KexQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sv8MyB8pyytV987E6kqqqbg5g6m9STWTSaQnrT5pgPr5TxCrkicKeIMX69tWBC7ej3UzeOdtxQQw+sespwseuMEdqKv9krABRrG1s6oIFQEi8RksbUHoPXDRQHjNM4Grc+2QyIkS9yxMiEEipChXZtYelJcxlisohlhB27DhJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XiFI8B0o; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VVu7cX1SI2+XfnYlKmwbrDG3+CJWOAmt2jAl9wbUo9k=; b=XiFI8B0ovduSIe40JjuY242meO
	1tWdoXPB8Y4u6FvdJlkOh0pr/b+ptTLEARYM4Fz0YcPpgeZ6S8vIFL3pv7C67je495kkW38x9jgPx
	kZcvMosNEICP21MaeTfL4OcNrqj3D/g6hBzGdP9sE2b36zBWvYJp4QWDybwMxKdlcL3ZpeYi7ki7+
	suQtk2YIywEtSE8+GUQPkWxddDo9J2uY+LZoII7Oa4V1WDt8U55u9QC4d2zaOtcNPZVh6JsT6n2VV
	yz3mabQVBKOF3bVpb3D/1s3d5tFfjBLa1mZAU7RdfOnmovvB/POi51RCfYsgOa7ik7FCs2q+EK5D6
	fjlJqizw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Mua-000000075pF-1RkI;
	Thu, 17 Oct 2024 09:35:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF73A3005AF; Thu, 17 Oct 2024 11:35:15 +0200 (CEST)
Date: Thu, 17 Oct 2024 11:35:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <20241017093515.GU16066@noisy.programming.kicks-ass.net>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-7-rppt@kernel.org>
 <20241016170128.7afeb8b0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016170128.7afeb8b0@gandalf.local.home>

On Wed, Oct 16, 2024 at 05:01:28PM -0400, Steven Rostedt wrote:
> On Wed, 16 Oct 2024 15:24:22 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > index 8da0e66ca22d..b498897b213c 100644
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -118,10 +118,13 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
> >  		return ret;
> >  
> >  	/* replace the text with the new text */
> > -	if (ftrace_poke_late)
> > +	if (ftrace_poke_late) {
> >  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> > -	else
> > -		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > +	} else {
> > +		mutex_lock(&text_mutex);
> > +		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > +		mutex_unlock(&text_mutex);
> > +	}
> >  	return 0;
> >  }
> 
> So this slows down the boot by over 30ms. That may not sound like much, but
> we care very much about boot times. This code is serialized with boot and
> runs whenever ftrace is configured in the kernel. The way I measured this,
> was that I added:
> 

> If this is only needed for module load, can we at least still use the
> text_poke_early() at boot up?

Right, so I don't understand why this is needed at all.
ftrace_module_init() runs before complete_formation() which normally
switches to ROX, as such ftrace should be able to continue to do direct
modifications here.

Which reminds me, at some point I did patches adding a
MODULE_STATE_UNFORMED callback in order for static_call / jump_label to
be able to avoid the expensive patching on module load as well (arguably
ftrace should be using that too, instead of a custom callback).

