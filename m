Return-Path: <linux-arch+bounces-8866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B705C9BD599
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 20:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441A5B21D31
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 19:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802D1E9096;
	Tue,  5 Nov 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndFUDxiZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775A1714B3;
	Tue,  5 Nov 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833473; cv=none; b=u/Z/dDTm+O0vTv/fJJQYJBau0/Y1uBrdhZ5M6JgGqAIw2jn76xCCSdJuAIeZg8bIZXbPp60ARfEC8T87lEw1PYnL3gqfS36D9qGoFBA6Aave62nBJjeWtMl1Kip2kZr5Uz6JCVbFdmjLNAglkWtwSHA/2eUMCzX2UDKP8M1G+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833473; c=relaxed/simple;
	bh=uoF4ZbISUkj3LBJVbm7mjK2pNt272UgYSEG9wAikNJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTVCpA/MsSM6wb7HDUNMjT5x8n3MYqO0MtF0nnI5zLkrRQVMyFYUbQNWjb0sv28srMgW5MwsGF/kODia9MQqFdyGoJnI5qwGKbFARum0JE6F6hzobyl/dq2boUlSIkSCtD7v2waf7gQ4ObMfEk63uJ70JTzmLAbYXqGs8mdnAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndFUDxiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14183C4CECF;
	Tue,  5 Nov 2024 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730833472;
	bh=uoF4ZbISUkj3LBJVbm7mjK2pNt272UgYSEG9wAikNJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndFUDxiZpHd3P71EA4Dtdpamj3S+pD0a2NSCYEIkT703any4R0lrK0H/JhQd4Hv2S
	 hAfH0p9N7ObDyDDis1fM3KZKbcT6xDBcyV1iwhCKpgr5eJTjsn996Jr680vAO44Otj
	 drCVf6YoRKOceIQN9knu/aAssyHKuocecyBZr/vNKZiP9PdCl8g8D3PbpLRYGfT7S3
	 8Jxa1hlnrGJeQdCliPqKl36JEkEIgDaJdtPl3tXojvE85kFpWmMnDAcr4PjH7oX62l
	 V8Za49Z9doiMVqhjlWd7GWzNdgnAXYy87njYhKhjV/rXdMfHzibVSbsFtDSY64+oSA
	 zKXctAOfMY/4A==
Date: Tue, 5 Nov 2024 12:04:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
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
	Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH v7 6/8] x86/module: prepare module loading for ROX
 allocations of text
Message-ID: <20241105190427.GA2903209@thelio-3990X>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-7-rppt@kernel.org>
 <20241104232741.GA3843610@thelio-3990X>
 <ZynDAhW0lKCfOqZl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZynDAhW0lKCfOqZl@kernel.org>

On Tue, Nov 05, 2024 at 09:02:26AM +0200, Mike Rapoport wrote:
> There's a silly mistake in cfi_rewrite_endbr() in that commit, the patch
> below should fix it. Can you please test?

Yup, that was it! All my machines boot with this diff applied on top of
next-20241105, so with that fixed, I think we are all good here.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 3407efc26528..243843e44e89 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1241,7 +1241,7 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end, struct module *mod)
>  		void *addr = (void *)s + *s;
>  		void *wr_addr = module_writable_address(mod, addr);
>  
> -		poison_endbr(addr+16, wr_addr, false);
> +		poison_endbr(addr + 16, wr_addr + 16, false);
>  	}
>  }

Cheers,
Nathan

