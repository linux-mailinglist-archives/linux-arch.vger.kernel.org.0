Return-Path: <linux-arch+bounces-8161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61599E106
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 10:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64381C218A8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2147D1CACEE;
	Tue, 15 Oct 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egqvVNG6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACF17335E;
	Tue, 15 Oct 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980951; cv=none; b=BpGslpAjb/SScjF6F21OPKp+TH/nP5BXNhVm3OJC5e3DzloFNGYTrPaIPnn0Dk7o7T9A2nycDD/vwTKmZSI2CKBmmH6b/kkhIH1D6IN8DAE4N+qJwXMHLdhVE1es9xCY1Ve2RQwxYhxEKgbdSQecTTMFHsgdsr6ArDr2XY2z9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980951; c=relaxed/simple;
	bh=DsgcZIwzu+lcz+sCcqq5yd6bbrmg5UWNN75kmiN7u1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXgvpzrUod20Noaa/8bLii5yxXW7uUaTmt925QivCJv8uQa6AikUCy3ZpfBJTKGT101k50Ih3SSxzVl5Hyzzprfk5FOq4MYDpyqpSLeM8erfL/Ek5qxul1RTIPsZUkbrF0f0xwW7lF6b937+FxTcq83N2lZgk/fmnsEzCciKrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egqvVNG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFDFC4CEC7;
	Tue, 15 Oct 2024 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728980950;
	bh=DsgcZIwzu+lcz+sCcqq5yd6bbrmg5UWNN75kmiN7u1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egqvVNG6q9wlgpkO2ihI5nbC6bmr+MKMXS2UkyLdtZUnRa2mJjPhb/GoHeE8B3JIV
	 VDOtfy1iCH02B47+vC2mLdYrhXPmRCcdJ1+Qf6WXe8/wfp0qMu9/oa8S2JtMyqJO/O
	 ZmBQkqH3b1vcstwGj/aIQZ/QJ/x/VWHD7oxFh+9oQa2EPZRfC0PAr1bUMSRbgTw0WX
	 C7Lug7jeKA6ulz3nyHPgkg0UGzQL6Atd/tuR2Y2ST5aOa7GcMnBjH9MVS3YMhP6L1x
	 3BVwGozDPiF2n6afO7840UO9nN2SDmvcqv5gq/FNe0QhCmwM6wOayqIt/j1N459swo
	 /mUI7oPo31iJQ==
Date: Tue, 15 Oct 2024 01:29:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH v5 6/8] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <20241015082905.GA1235948@thelio-3990X>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-7-rppt@kernel.org>
 <20241010225411.GA922684@thelio-3990X>
 <Zwkg3LwlNJOwNWZh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwkg3LwlNJOwNWZh@kernel.org>

On Fri, Oct 11, 2024 at 03:58:04PM +0300, Mike Rapoport wrote:
> I overlooked how cfi_*_callers routines update addr.
> This patch should fix it:

Thanks, can confirm. My boot is working again and LKDTM's
CFI_FORWARD_PROTO test properly fails.

> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 3b3fa93af3b1..cf782f431110 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1148,11 +1148,13 @@ static int cfi_disable_callers(s32 *start, s32 *end, struct module *mod)
>  
>  	for (s = start; s < end; s++) {
>  		void *addr = (void *)s + *s;
> -		void *wr_addr = module_writable_address(mod, addr);
> +		void *wr_addr;
>  		u32 hash;
>  
>  		addr -= fineibt_caller_size;
> -		hash = decode_caller_hash(addr);
> +		wr_addr = module_writable_address(mod, addr);
> +		hash = decode_caller_hash(wr_addr);
> +
>  		if (!hash) /* nocfi callers */
>  			continue;
>  
> @@ -1172,11 +1174,12 @@ static int cfi_enable_callers(s32 *start, s32 *end, struct module *mod)
>  
>  	for (s = start; s < end; s++) {
>  		void *addr = (void *)s + *s;
> -		void *wr_addr = module_writable_address(mod, addr);
> +		void *wr_addr;
>  		u32 hash;
>  
>  		addr -= fineibt_caller_size;
> -		hash = decode_caller_hash(addr);
> +		wr_addr = module_writable_address(mod, addr);
> +		hash = decode_caller_hash(wr_addr);
>  		if (!hash) /* nocfi callers */
>  			continue;
>  
> @@ -1249,11 +1252,12 @@ static int cfi_rand_callers(s32 *start, s32 *end, struct module *mod)
>  
>  	for (s = start; s < end; s++) {
>  		void *addr = (void *)s + *s;
> -		void *wr_addr = module_writable_address(mod, addr);
> +		void *wr_addr;
>  		u32 hash;
>  
>  		addr -= fineibt_caller_size;
> -		hash = decode_caller_hash(addr);
> +		wr_addr = module_writable_address(mod, addr);
> +		hash = decode_caller_hash(wr_addr);
>  		if (hash) {
>  			hash = -cfi_rehash(hash);
>  			text_poke_early(wr_addr + 2, &hash, 4);
> @@ -1269,14 +1273,15 @@ static int cfi_rewrite_callers(s32 *start, s32 *end, struct module *mod)
>  
>  	for (s = start; s < end; s++) {
>  		void *addr = (void *)s + *s;
> -		void *wr_addr = module_writable_address(mod, addr);
> +		void *wr_addr;
>  		u32 hash;
>  
>  		addr -= fineibt_caller_size;
> -		hash = decode_caller_hash(addr);
> +		wr_addr = module_writable_address(mod, addr);
> +		hash = decode_caller_hash(wr_addr);
>  		if (hash) {
>  			text_poke_early(wr_addr, fineibt_caller_start, fineibt_caller_size);
> -			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
> +			WARN_ON(*(u32 *)(wr_addr + fineibt_caller_hash) != 0x12345678);
>  			text_poke_early(wr_addr + fineibt_caller_hash, &hash, 4);
>  		}
>  		/* rely on apply_retpolines() */
>  
> > Cheers,
> > Nathan
> 
> -- 
> Sincerely yours,
> Mike.

