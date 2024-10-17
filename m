Return-Path: <linux-arch+bounces-8250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7259A24C3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 16:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7C31C223CB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A811DE3BC;
	Thu, 17 Oct 2024 14:16:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D91DE2B2;
	Thu, 17 Oct 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174617; cv=none; b=q3pR+DMNW4KBHwzDgcxnh8w/eZrac5sELevZFzGzSjB2acYbtBG59NsuRUMWG5sHnAoXxzgfyTCgZcqInSH14jtOYhuoLdatbE5mHv7s/SHJnHyZFFjJmKJ7ImESk068F/nNTSBOGN9J1UegNhYqxLERzFV+Ha6abAkRNVBNSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174617; c=relaxed/simple;
	bh=zxlBeAJp2bfYYqmWtSZQo9rE3eewc0ORywp0deKMTcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCobvcLSrWeYjRpkHPCNp4k30PlzU/UDWVfW/oXBDkeCMFhQN9DoDz+CZprC6DNxrVmWwpTR6MtAJhs3SDbIU8O9tW2rKJ2qeDNaaKfv2RmgUBkl9fHjLkNPiCw8cKYdH0tQY8Ei4w7z02NX6hYkQSkTaK+6eoSSQZz9gwFTia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E652CC4CEC3;
	Thu, 17 Oct 2024 14:16:49 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:17:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski
 <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph
 Hellwig <hch@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller
 <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov
 <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek
 <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, Richard
 Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu
 <song@kernel.org>, Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20241017101712.5a052712@gandalf.local.home>
In-Reply-To: <20241016170128.7afeb8b0@gandalf.local.home>
References: <20241016122424.1655560-1-rppt@kernel.org>
	<20241016122424.1655560-7-rppt@kernel.org>
	<20241016170128.7afeb8b0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 17:01:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> If this is only needed for module load, can we at least still use the
> text_poke_early() at boot up?
> 
>  	if (ftrace_poke_late) {
>  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> 	} else if (system_state == SYSTEM_BOOTING) {
> 		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
>  	} else {
>  		mutex_lock(&text_mutex);
>  		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
>  		mutex_unlock(&text_mutex);
>  	}
> 
> ?
> 
> The above if statement looks to slow things down just slightly, but only by
> 2ms, which is more reasonable.

I changed the above to this (yes it's a little hacky) and got my 2ms back!

-- Steve

DEFINE_STATIC_KEY_TRUE(ftrace_modify_boot);

static int __init ftrace_boot_init_done(void)
{
	static_branch_disable(&ftrace_modify_boot);
	return 0;
}
/* Ftrace updates happen before core init */
core_initcall(ftrace_boot_init_done);

/*
 * Marked __ref because it calls text_poke_early() which is .init.text. That is
 * ok because that call will happen early, during boot, when .init sections are
 * still present.
 */
static int __ref
ftrace_modify_code_direct(unsigned long ip, const char *old_code,
			  const char *new_code)
{
	int ret = ftrace_verify_code(ip, old_code);

	if (ret)
		return ret;

	/* replace the text with the new text */
	if (static_branch_unlikely(&ftrace_modify_boot)) {
		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
	} else if (ftrace_poke_late) {
		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
	} else {
		mutex_lock(&text_mutex);
		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
		mutex_unlock(&text_mutex);
	}
	return 0;
}

