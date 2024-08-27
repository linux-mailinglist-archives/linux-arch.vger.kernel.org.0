Return-Path: <linux-arch+bounces-6675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF9961322
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15D71C20E3F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7CC1C6F5E;
	Tue, 27 Aug 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJjeZGdR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3A1C5792;
	Tue, 27 Aug 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773409; cv=none; b=YZKizRVOkzZX5ds3msz1Z6gczEMA4tLMXkoZpKfXZQDPLCJnnkiHAuAetuszhW599cDH4z+B0bQqRJmtgqpiVm1fNEOBWfvpXF5rr4Rj8GF3XK+8a7Xh+LBl8AMz2aoif5kFr+YM+bcYYhSk6rkesG2IFQdv/m7jayKpd6BmP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773409; c=relaxed/simple;
	bh=gLN6XrXPe8lnOYBY+qE6Br7q9z15uQyViI2cYvrjDUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od33bOhcw1GpRXUEH88TvMilofZpTVAkWCKcAPdYK8wv/VqJrhchShe8pqCo19CVmveCY7goFnVNymTMihw6msAlyZXjuHiEkPIxR49duSk9PgU9+SnMPabgm7rfAluJtcVTXEYP2OGTAcEeJBmDDCEms8GXOA1tz4UayaH0Gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJjeZGdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C93C4DE0D;
	Tue, 27 Aug 2024 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724773408;
	bh=gLN6XrXPe8lnOYBY+qE6Br7q9z15uQyViI2cYvrjDUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJjeZGdRlRZciwiSds7ncOoFJeP+wPAbVUVeY1LlTa56La6oD/XycPb3ju2I/Si6N
	 bNsP9pfRPVziKGgn/Q7CZW62Bt7rl9iXHC+NkqAHxIdvlozlUPOn7DKQtQl24SAAKo
	 NVAJkyrxO3xLQShBOmpHzZcPcSpDnuVLQLFIjp6TCSAVJcQE/Q6oni4wO6fU4ZsrHD
	 4ovVIvkGw6loTWaFlHze4az9iCCc+TXdBuzKzGsuhZ4ATm4q785T8iPGoGLrAdyrZK
	 3tUYk2k2P5uZy+/qiIPItAj2gx6xlt89fXh5S1kblIuw6KS4FNa+7dzFK9H80hz+VW
	 wYQnWN9qfNMIA==
Date: Tue, 27 Aug 2024 18:40:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
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
Subject: Re: [PATCH v2 5/8] ftrace: Add swap_func to ftrace_process_locs()
Message-ID: <Zs3zcwyygUk4_X8y@kernel.org>
References: <20240826065532.2618273-1-rppt@kernel.org>
 <20240826065532.2618273-6-rppt@kernel.org>
 <20240826132909.306b08fc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826132909.306b08fc@gandalf.local.home>

On Mon, Aug 26, 2024 at 01:29:09PM -0400, Steven Rostedt wrote:
> On Mon, 26 Aug 2024 09:55:29 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Song Liu <song@kernel.org>
> > 
> > ftrace_process_locs sorts module mcount, which is inside RO memory. Add a
> > ftrace_swap_func so that archs can use RO-memory-poke function to do the
> > sorting.
> 
> Can you add the above as a comment above the ftrace_swap_func() function?

Sure.
 
> Thanks,
> 
> -- Steve
> 
> > 
> > Signed-off-by: Song Liu <song@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  include/linux/ftrace.h |  2 ++
> >  kernel/trace/ftrace.c  | 13 ++++++++++++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index fd5e84d0ec47..b794dcb7cae8 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1188,4 +1188,6 @@ unsigned long arch_syscall_addr(int nr);
> >  
> >  #endif /* CONFIG_FTRACE_SYSCALLS */
> >  
> > +void ftrace_swap_func(void *a, void *b, int n);
> > +
> >  #endif /* _LINUX_FTRACE_H */
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 4c28dd177ca6..9829979f3a46 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6989,6 +6989,17 @@ static void test_is_sorted(unsigned long *start,
> > unsigned long count) }
> >  #endif
> >  
> > +void __weak ftrace_swap_func(void *a, void *b, int n)
> > +{
> > +	unsigned long t;
> > +
> > +	WARN_ON_ONCE(n != sizeof(t));
> > +
> > +	t = *((unsigned long *)a);
> > +	*(unsigned long *)a = *(unsigned long *)b;
> > +	*(unsigned long *)b = t;
> > +}
> > +
> >  static int ftrace_process_locs(struct module *mod,
> >  			       unsigned long *start,
> >  			       unsigned long *end)
> > @@ -7016,7 +7027,7 @@ static int ftrace_process_locs(struct module *mod,
> >  	 */
> >  	if (!IS_ENABLED(CONFIG_BUILDTIME_MCOUNT_SORT) || mod) {
> >  		sort(start, count, sizeof(*start),
> > -		     ftrace_cmp_ips, NULL);
> > +		     ftrace_cmp_ips, ftrace_swap_func);
> >  	} else {
> >  		test_is_sorted(start, count);
> >  	}
> 

-- 
Sincerely yours,
Mike.

