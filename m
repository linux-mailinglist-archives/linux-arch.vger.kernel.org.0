Return-Path: <linux-arch+bounces-9136-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 939029D1847
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 19:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6EFB219C9
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E11E0E19;
	Mon, 18 Nov 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeOY29sz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1811DFD90;
	Mon, 18 Nov 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955230; cv=none; b=C65iEmiUVNqCwMaoI0xEolVaaDqIyPk+QR/WbrMk2gxMvPF1NsvExIAEOKa25Bkenyqnc0u+JwtDI56pzF6fQF4fxUEMdPpKR9GP6sx8bLEHjI5oVgQYOs4/6Z2OnpXFrzS/A2Dk7piVDjvhotJBUPuMcSKMnUOmkcgTmEI2W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955230; c=relaxed/simple;
	bh=PgWfk6zhBX25rXxPAwmwUJeghk+GajLkQHlk+OfGUQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUl06Od+kI3Nql2XFM4vsiJo7mK/t6pCi3zKmH/5DldJo9ZraThxrfbpDIvVtVlgZhhXsbn9AS6MLXdjGkmGPVJli7kgfLza/gkK9cBktTW4FYe9EBidYJiAGHvbmSy//lz+zv7VthyoC2689Pzlf/7FSmly5M+R+KDM4FEUzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeOY29sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5AEC4CECC;
	Mon, 18 Nov 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731955229;
	bh=PgWfk6zhBX25rXxPAwmwUJeghk+GajLkQHlk+OfGUQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GeOY29szPjdxa0xm+vV9DTg2e5TPlxk7huuBMuJbtT+hTn5kPCdRWZ2oKgkC8UpSt
	 VKEpF1/SK1ceIDW9rYbK4e2lrKnmmaewrajrem/5hOE+eL2aJiJwe2Mq1uUh3lhZ50
	 bF8KJonZOhyM89MpbuLHVivYouTUSuZbDmGNuIIUU6Sz4PBRF7AffgUgRIMQ22WWof
	 8/hSFdkboAANibLeqfLmV82IhRXIdNitXrU+lzbag6jN3GbbRMHw4voatyzJmOaEVn
	 LYCc2cjDCBvkB/fCKjeR1Y3G/eBzyCxZ8foJEVKOfJ+JG689X8AaWtSJSKfiAkucWY
	 LfgB8UgFNVmrQ==
Date: Mon, 18 Nov 2024 10:40:26 -0800
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v7 0/8] x86/module: use large ROX pages for text
 allocations
Message-ID: <ZzuKGoj99rIuMaBE@kernel.org>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241118132501.4eddb46c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118132501.4eddb46c@gandalf.local.home>

On Mon, Nov 18, 2024 at 01:25:01PM -0500, Steven Rostedt wrote:
> On Wed, 23 Oct 2024 19:27:03 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Hi,
> > 
> > This is an updated version of execmem ROX caches.
> > 
> 
> FYI, I booted a kernel before and after applying these patches with my
> change:
> 
>   https://lore.kernel.org/20241017113105.1edfa943@gandalf.local.home
> 
> Before these patches:
> 
>  # cat /sys/kernel/tracing/dyn_ftrace_total_info
> 57695 pages:231 groups: 9
> ftrace boot update time = 14733459 (ns)
> ftrace module total update time = 449016 (ns)
> 
> After:
> 
>  # cat /sys/kernel/tracing/dyn_ftrace_total_info
> 57708 pages:231 groups: 9
> ftrace boot update time = 47195374 (ns)
> ftrace module total update time = 592080 (ns)
> 
> Which caused boot time to slowdown by over 30ms. That may not seem like
> much, but we are very concerned about boot time and are fighting every ms
> we can get.

Hmm, looks like this change was lost in rebase :/

@Andrew, should I send it as a patch on top of mm-stable?

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8da0e66ca22d..859902dd06fc 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -111,17 +111,22 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
  */
 static int __ref
 ftrace_modify_code_direct(unsigned long ip, const char *old_code,
-			  const char *new_code)
+			  const char *new_code, struct module *mod)
 {
 	int ret = ftrace_verify_code(ip, old_code);
 	if (ret)
 		return ret;
 
 	/* replace the text with the new text */
-	if (ftrace_poke_late)
+	if (ftrace_poke_late) {
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
-	else
+	} else if (!mod) {
 		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
+	} else {
+		mutex_lock(&text_mutex);
+		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
+		mutex_unlock(&text_mutex);
+	}
 	return 0;
 }
 
@@ -142,7 +147,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(ip, old, new);
+		return ftrace_modify_code_direct(ip, old, new, mod);
 
 	/*
 	 * x86 overrides ftrace_replace_code -- this function will never be used
@@ -161,7 +166,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	new = ftrace_call_replace(ip, addr);
 
 	/* Should only be called when module is loaded */
-	return ftrace_modify_code_direct(rec->ip, old, new);
+	return ftrace_modify_code_direct(rec->ip, old, new, NULL);
 }
 
 /*


> -- Steve

-- 
Sincerely yours,
Mike.

