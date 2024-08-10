Return-Path: <linux-arch+bounces-6147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446594DEC7
	for <lists+linux-arch@lfdr.de>; Sat, 10 Aug 2024 23:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E13B20F6C
	for <lists+linux-arch@lfdr.de>; Sat, 10 Aug 2024 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312D313D89A;
	Sat, 10 Aug 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SlodpyVH"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F913D8A6;
	Sat, 10 Aug 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723325242; cv=none; b=EfRFKRh3jvdv2K27xXFhjaWQvsIgX9XMV32WW05XNpdDI9c/IaienNjf4RIPuSZNa14tm0D0mRlb624tRXLN4yq5kycEjRmJ1hC+UWVrxBsrnqofzPJw3LrHCRpiUWGOaG49HitHo4b2ssbjR3K1NDXWB/X6IKcpXB/0tmjv6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723325242; c=relaxed/simple;
	bh=UFw18Biowc+RS3ZsThhCPHGYPTxWeuACsU0OGuHWq/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOrdtH+Xz24W+V0D94pvyER72g+b6Mq+CKow0EJ4oiQAdrIS9zFEmBoTcEbPJ0EGXB9L0EQq/GOwTGagBAM2Q+BoAYD1W7GCldcmgSV8gfnMn0HgPtbO5HQGPXqd0hE1vhb6Ipk/TlRUNXzuh11wSPLB9lHzR7d/gzkL26RhVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SlodpyVH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QS4maoDE9j0FPQOAXgzzsa6/fUJQHH67QENNS+2ljQI=; b=SlodpyVHbHOHc5JsqYBNEK43LL
	xWYoqz26t8JR2c+GPCw5A3SN/gWdzaf9NYgioguHIg8/Ppvyj603Ac8juUxZo2TFtxlGC+GXUq/v/
	AvmyS9U25DC+acTebH9fSQIAhq28P7tudVeZu/8+pfKCTZtUdfn29A/vlGks5kVY/A+64Otsp/J5F
	BQ1viAkQnQrBxjJhgcEczOTZY8T8w1SCs1E2D4yCr/RMADTmF+a9Y1yPlh8fXZWyzEx29ceU6m+lK
	eziSg60W10jAC+fiWNbEtYlOMHfdJEbSMjq2vPgLRbu965BE+0Aw/Jm5A6oyOvU6F94pfgTz2mlmG
	S9UHZ2fg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sctbx-00000007Fnm-43XW;
	Sat, 10 Aug 2024 21:26:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 041B7300729; Sat, 10 Aug 2024 23:26:53 +0200 (CEST)
Date: Sat, 10 Aug 2024 23:26:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 4/5] jump_label: adjust inline asm to be consistent
Message-ID: <20240810212652.GE11646@noisy.programming.kicks-ass.net>
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
 <20240808-tracepoint-v6-4-a23f800f1189@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-tracepoint-v6-4-a23f800f1189@google.com>

On Thu, Aug 08, 2024 at 05:23:40PM +0000, Alice Ryhl wrote:
> To avoid duplication of inline asm between C and Rust, we need to
> import the inline asm from the relevant `jump_label.h` header into Rust.
> To make that easier, this patch updates the header files to expose the
> inline asm via a new ARCH_STATIC_BRANCH_ASM macro.
> 
> The header files are all updated to define a ARCH_STATIC_BRANCH_ASM that
> takes the same arguments in a consistent order so that Rust can use the
> same logic for every architecture.
> 
> Link: https://lore.kernel.org/r/20240725183325.122827-7-ojeda@kernel.org [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I can't help but notice your risc-v conversion is much nicer than the
one you did for ARM. But I'm not going to complain too loudly about
that.

It's a shame about that 2 for JUMP_LABEL_HACK, having to lift that
nonsense all the way to Rust, but alas.

This will do, thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/arm/include/asm/jump_label.h       | 14 +++++----
>  arch/arm64/include/asm/jump_label.h     | 20 ++++++++-----
>  arch/loongarch/include/asm/jump_label.h | 16 +++++++----
>  arch/riscv/include/asm/jump_label.h     | 50 ++++++++++++++++++---------------
>  arch/x86/include/asm/jump_label.h       | 38 ++++++++++---------------
>  5 files changed, 75 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
> index e4eb54f6cd9f..a35aba7f548c 100644
> --- a/arch/arm/include/asm/jump_label.h
> +++ b/arch/arm/include/asm/jump_label.h
> @@ -9,13 +9,17 @@
>  
>  #define JUMP_LABEL_NOP_SIZE 4
>  
> +/* This macro is also expanded on the Rust side. */
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"1:\n\t"					\
> +	WASM(nop) "\n\t"				\
> +	".pushsection __jump_table,  \"aw\"\n\t"	\
> +	".word 1b, " label ", " key "\n\t"		\
> +	".popsection\n\t"				\
> +
>  static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
>  {
> -	asm goto("1:\n\t"
> -		 WASM(nop) "\n\t"
> -		 ".pushsection __jump_table,  \"aw\"\n\t"
> -		 ".word 1b, %l[l_yes], %c0\n\t"
> -		 ".popsection\n\t"
> +	asm goto(ARCH_STATIC_BRANCH_ASM("%c0", "%l[l_yes]")
>  		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
>  
>  	return false;
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index a0a5bbae7229..424ed421cd97 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -19,10 +19,14 @@
>  #define JUMP_TABLE_ENTRY(key, label)			\
>  	".pushsection	__jump_table, \"aw\"\n\t"	\
>  	".align		3\n\t"				\
> -	".long		1b - ., %l["#label"] - .\n\t"	\
> -	".quad		%c0 - .\n\t"			\
> -	".popsection\n\t"				\
> -	:  :  "i"(key) :  : label
> +	".long		1b - ., " label " - .\n\t"	\
> +	".quad		" key " - .\n\t"		\
> +	".popsection\n\t"
> +
> +/* This macro is also expanded on the Rust side. */
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"1:	nop\n\t"				\
> +	JUMP_TABLE_ENTRY(key, label)
>  
>  static __always_inline bool arch_static_branch(struct static_key * const key,
>  					       const bool branch)
> @@ -30,8 +34,8 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>  	char *k = &((char *)key)[branch];
>  
>  	asm goto(
> -		"1:	nop					\n\t"
> -		JUMP_TABLE_ENTRY(k, l_yes)
> +		ARCH_STATIC_BRANCH_ASM("%c0", "%l[l_yes]")
> +		:  :  "i"(k) :  : l_yes
>  		);
>  
>  	return false;
> @@ -43,9 +47,11 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
>  						    const bool branch)
>  {
>  	char *k = &((char *)key)[branch];
> +
>  	asm goto(
>  		"1:	b		%l[l_yes]		\n\t"
> -		JUMP_TABLE_ENTRY(k, l_yes)
> +		JUMP_TABLE_ENTRY("%c0", "%l[l_yes]")
> +		:  :  "i"(k) :  : l_yes
>  		);
>  	return false;
>  l_yes:
> diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
> index 29acfe3de3fa..8a924bd69d19 100644
> --- a/arch/loongarch/include/asm/jump_label.h
> +++ b/arch/loongarch/include/asm/jump_label.h
> @@ -13,18 +13,22 @@
>  
>  #define JUMP_LABEL_NOP_SIZE	4
>  
> -#define JUMP_TABLE_ENTRY				\
> +/* This macro is also expanded on the Rust side. */
> +#define JUMP_TABLE_ENTRY(key, label)			\
>  	 ".pushsection	__jump_table, \"aw\"	\n\t"	\
>  	 ".align	3			\n\t"	\
> -	 ".long		1b - ., %l[l_yes] - .	\n\t"	\
> -	 ".quad		%0 - .			\n\t"	\
> +	 ".long		1b - ., " label " - .	\n\t"	\
> +	 ".quad		" key " - .		\n\t"	\
>  	 ".popsection				\n\t"
>  
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"1:	nop				\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +
>  static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
>  {
>  	asm goto(
> -		"1:	nop			\n\t"
> -		JUMP_TABLE_ENTRY
> +		ARCH_STATIC_BRANCH_ASM("%0", "%l[l_yes]")
>  		:  :  "i"(&((char *)key)[branch]) :  : l_yes);
>  
>  	return false;
> @@ -37,7 +41,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
>  {
>  	asm goto(
>  		"1:	b	%l[l_yes]	\n\t"
> -		JUMP_TABLE_ENTRY
> +		JUMP_TABLE_ENTRY("%0", "%l[l_yes]")
>  		:  :  "i"(&((char *)key)[branch]) :  : l_yes);
>  
>  	return false;
> diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
> index 1c768d02bd0c..f6342d456372 100644
> --- a/arch/riscv/include/asm/jump_label.h
> +++ b/arch/riscv/include/asm/jump_label.h
> @@ -16,21 +16,28 @@
>  
>  #define JUMP_LABEL_NOP_SIZE 4
>  
> +#define JUMP_TABLE_ENTRY(key, label)			\
> +	".pushsection	__jump_table, \"aw\"	\n\t"	\
> +	".align		" RISCV_LGPTR "		\n\t"	\
> +	".long		1b - ., " label " - .	\n\t"	\
> +	"" RISCV_PTR "	" key " - .		\n\t"	\
> +	".popsection				\n\t"
> +
> +/* This macro is also expanded on the Rust side. */
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"	.align		2		\n\t"	\
> +	"	.option push			\n\t"	\
> +	"	.option norelax			\n\t"	\
> +	"	.option norvc			\n\t"	\
> +	"1:	j	" label "		\n\t" \
> +	"	.option pop			\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +
>  static __always_inline bool arch_static_branch(struct static_key * const key,
>  					       const bool branch)
>  {
>  	asm goto(
> -		"	.align		2			\n\t"
> -		"	.option push				\n\t"
> -		"	.option norelax				\n\t"
> -		"	.option norvc				\n\t"
> -		"1:	nop					\n\t"
> -		"	.option pop				\n\t"
> -		"	.pushsection	__jump_table, \"aw\"	\n\t"
> -		"	.align		" RISCV_LGPTR "		\n\t"
> -		"	.long		1b - ., %l[label] - .	\n\t"
> -		"	" RISCV_PTR "	%0 - .			\n\t"
> -		"	.popsection				\n\t"
> +		ARCH_STATIC_BRANCH_ASM("%0", "%l[label]")
>  		:  :  "i"(&((char *)key)[branch]) :  : label);
>  
>  	return false;
> @@ -38,21 +45,20 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>  	return true;
>  }
>  
> +#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)		\
> +	"	.align		2		\n\t"	\
> +	"	.option push			\n\t"	\
> +	"	.option norelax			\n\t"	\
> +	"	.option norvc			\n\t"	\
> +	"1:	nop				\n\t"	\
> +	"	.option pop			\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +
>  static __always_inline bool arch_static_branch_jump(struct static_key * const key,
>  						    const bool branch)
>  {
>  	asm goto(
> -		"	.align		2			\n\t"
> -		"	.option push				\n\t"
> -		"	.option norelax				\n\t"
> -		"	.option norvc				\n\t"
> -		"1:	j		%l[label]		\n\t"
> -		"	.option pop				\n\t"
> -		"	.pushsection	__jump_table, \"aw\"	\n\t"
> -		"	.align		" RISCV_LGPTR "		\n\t"
> -		"	.long		1b - ., %l[label] - .	\n\t"
> -		"	" RISCV_PTR "	%0 - .			\n\t"
> -		"	.popsection				\n\t"
> +		ARCH_STATIC_BRANCH_JUMP_ASM("%0", "%l[label]")
>  		:  :  "i"(&((char *)key)[branch]) :  : label);
>  
>  	return false;
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index cbbef32517f0..87a3a0f5bd22 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -12,49 +12,41 @@
>  #include <linux/stringify.h>
>  #include <linux/types.h>
>  
> -#define JUMP_TABLE_ENTRY				\
> +#define JUMP_TABLE_ENTRY(key, label)			\
>  	".pushsection __jump_table,  \"aw\" \n\t"	\
>  	_ASM_ALIGN "\n\t"				\
>  	".long 1b - . \n\t"				\
> -	".long %l[l_yes] - . \n\t"			\
> -	_ASM_PTR "%c0 + %c1 - .\n\t"			\
> +	".long " label "- . \n\t"			\
> +	_ASM_PTR " " key " - . \n\t"			\
>  	".popsection \n\t"
>  
> +/* This macro is also expanded on the Rust side. */
>  #ifdef CONFIG_HAVE_JUMP_LABEL_HACK
> -
> -static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
> -{
> -	asm goto("1:"
> -		"jmp %l[l_yes] # objtool NOPs this \n\t"
> -		JUMP_TABLE_ENTRY
> -		: :  "i" (key), "i" (2 | branch) : : l_yes);
> -
> -	return false;
> -l_yes:
> -	return true;
> -}
> -
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"1: jmp " label " # objtool NOPs this \n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
>  #else /* !CONFIG_HAVE_JUMP_LABEL_HACK */
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"1: .byte " __stringify(BYTES_NOP5) "\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +#endif /* CONFIG_HAVE_JUMP_LABEL_HACK */
>  
>  static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
>  {
> -	asm goto("1:"
> -		".byte " __stringify(BYTES_NOP5) "\n\t"
> -		JUMP_TABLE_ENTRY
> -		: :  "i" (key), "i" (branch) : : l_yes);
> +	int hack_bit = IS_ENABLED(CONFIG_HAVE_JUMP_LABEL_HACK) ? 2 : 0;
> +	asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
> +		: :  "i" (key), "i" (hack_bit | branch) : : l_yes);
>  
>  	return false;
>  l_yes:
>  	return true;
>  }
>  
> -#endif /* CONFIG_HAVE_JUMP_LABEL_HACK */
> -
>  static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
>  {
>  	asm goto("1:"
>  		"jmp %l[l_yes]\n\t"
> -		JUMP_TABLE_ENTRY
> +		JUMP_TABLE_ENTRY("%c0 + %c1", "%l[l_yes]")
>  		: :  "i" (key), "i" (branch) : : l_yes);
>  
>  	return false;
> 
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 

