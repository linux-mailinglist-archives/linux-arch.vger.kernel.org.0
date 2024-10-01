Return-Path: <linux-arch+bounces-7521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7098BF88
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1927BB239A9
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815851CC88A;
	Tue,  1 Oct 2024 14:13:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526371C6F67;
	Tue,  1 Oct 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792001; cv=none; b=WyMXZNPM72KVQ8y3YqqW3gu3R0SS/pkDFtD3B9c7EOCMXPSzVgPbzHX9eRt6ZcADwDQ3eRH9ykZK3+J0G8uXq44QZy/CM+KlF4GRSgheNALH/vUjwxwjVcvW1v3tvM1V/YH+sfA7WC3ZqGTp4LpR9yxW7qrPP8P7JCg+TZQnJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792001; c=relaxed/simple;
	bh=3igbjCvuJ0YDGAR0DQ9ZtPlULJXsd8VFMK0uyZUChfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ5jTugGZD4gL1GJ3BmLy450hKeG3zEAOsx5NJ8cyLJMJplif7z9CrW3mdYMMwx+jNoFzOQ9G0FJqAFqAi4nHk9AwvP188IRSubHjErNAlqk+5LCU4NwFfM0m1RSCpLGi0E52w52W2KdvvC7szQgQS0BEa2y+XsCFZsf/YvwbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6668DC4CECD;
	Tue,  1 Oct 2024 14:13:15 +0000 (UTC)
Date: Tue, 1 Oct 2024 10:14:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard
 Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak
 <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-arm-kernel@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Conor
 Dooley <conor.dooley@microchip.com>, Samuel Holland
 <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao
 <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v9 4/5] jump_label: adjust inline asm to be consistent
Message-ID: <20241001101404.29388dd0@gandalf.local.home>
In-Reply-To: <20241001-tracepoint-v9-4-1ad3b7d78acb@google.com>
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
	<20241001-tracepoint-v9-4-1ad3b7d78acb@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Can I get some more acks from the arch maintainers? So far there's only one
ack from Peter Zijlstra for x86. But this touches arm, arm64, loongarch and
riscv too.

-- Steve


On Tue, 01 Oct 2024 13:30:01 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> To avoid duplication of inline asm between C and Rust, we need to
> import the inline asm from the relevant `jump_label.h` header into Rust.
> To make that easier, this patch updates the header files to expose the
> inline asm via a new ARCH_STATIC_BRANCH_ASM macro.
> 
> The header files are all updated to define a ARCH_STATIC_BRANCH_ASM that
> takes the same arguments in a consistent order so that Rust can use the
> same logic for every architecture.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
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
> index 1c768d02bd0c..87a71cc6d146 100644
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
> +	"1:	nop				\n\t"	\
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
> +	"1:	j	" label "		\n\t" \
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
> index cbbef32517f0..fb79fa1cf70a 100644
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
> +	".long " label " - . \n\t"			\
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


