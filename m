Return-Path: <linux-arch+bounces-7558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08798C334
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D0C1C231EC
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC91CB514;
	Tue,  1 Oct 2024 16:16:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435F2A1D2;
	Tue,  1 Oct 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799419; cv=none; b=EjC1/DclyLhSzBjzdDQosFGbWwqNWF1gPcs9QcpJE/ySy3fJH+Nol6mzaIFBTz4hqQI6wFQHaUro+xVqmResh5byOn2NB+IycnXH5xa+ZtjPRz8sRCrRlb+g8nReFd3Zln0QAcJi2iphe6dL0iuJ96x/4iZUJu7Uo5GUOWiAPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799419; c=relaxed/simple;
	bh=+xOBbJqEQIRC0gl2frSEEZG/U6gjZcSnXTHQoY+QbGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7G9ONds6SizHRNMDx2TKbuN2Vy7oCw00JDepRz+75jJFCSrbjhc/YXhzvjfryAsXlzKu6DkXx4EUeJiqje+XI5I0Ylg5M4jyfl97TGcdbe2uk+FKw8xsj6F0vVJWG4PNedPrgqU806Chnan2gbDJ2EP1MH4vX/2Mmye2dcoUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BF7C4CEC6;
	Tue,  1 Oct 2024 16:16:50 +0000 (UTC)
Date: Tue, 1 Oct 2024 17:16:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Uros Bizjak <ubizjak@gmail.com>, Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
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
Subject: Re: [PATCH v9 4/5] jump_label: adjust inline asm to be consistent
Message-ID: <ZvwgcBzLwYkgsJ2u@arm.com>
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
 <20241001-tracepoint-v9-4-1ad3b7d78acb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-tracepoint-v9-4-1ad3b7d78acb@google.com>

On Tue, Oct 01, 2024 at 01:30:01PM +0000, Alice Ryhl wrote:
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

For the arm64 changes:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

