Return-Path: <linux-arch+bounces-8044-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A856E99A778
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F801F24E0F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F0194A4C;
	Fri, 11 Oct 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJy54j3r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68EC1946DF;
	Fri, 11 Oct 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660251; cv=none; b=LY1Oygv4qSJwh7w4deh77MAIgmFTHtLcwg6KVxWtBVw+HT2HfKx9dVePkKEsapslwvco2hWhH/rwDRCPtuOPskE2WDvPAujUv8xBpA1Agsl388+KLWelW6TjMjSNI3tdYcPsHK+YnGvevP2BJBiYYL9Tukbw5vSlAeEoWbgliDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660251; c=relaxed/simple;
	bh=A3N9Mkq30GPl1hwp0+TVudApr5l241CnTDu+mkjDc68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXoUR+2lEo7g5wSd5l5SfaHtLTuNpz0ZUfbt/7+HDoyitY4OrPcX+828pY7Oz/KqNxKHrVOOi4O6a0JvMdpMppcnoTqRWdX10cb6Y36XFQwSoeoE1XNyhOO4x3IRqFtFdg5nnaxpglY9o8NgKxd6LOyBUEsHPBfuxwldw1QLfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJy54j3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39333C4CEC3;
	Fri, 11 Oct 2024 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728660250;
	bh=A3N9Mkq30GPl1hwp0+TVudApr5l241CnTDu+mkjDc68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJy54j3rdRFfLY2A7N5cYYGCebcq3yQ7Nn3YpXPetQdckOI3xObxbldIKT/3sa4pY
	 P0pMjlETYXgk5U9otowTN0tcgGSiHOnEA+T7brocFPuL7mxw8+lWpBc3d1IZg7QrTi
	 yxcm1ahYN+C3XxkjCb7gQhnOAJW0mQ24ywsBTW+bD59i1djn7RcWzLwmMWi7FhGtRa
	 f/Wlzo2/2dx4/+fXDKYXgOsTbpGfv868g7eBHtYCnd3ZTbC8zDts+Bjo0zvfstARrm
	 Wu1+LOPZIdHy3rx7zi4/v+iynpsH50cr29F6HhEPLYf51ySyV+L1zOfHn1gFLPgizY
	 WdZnrav+mlECA==
Date: Fri, 11 Oct 2024 08:23:12 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
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
Subject: Re: [PATCH v10 5/5] rust: add arch_static_branch
Message-ID: <20241011152312.r5sy7k7hsunmmbfo@treble>
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
 <20241011-tracepoint-v10-5-7fbde4d6b525@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011-tracepoint-v10-5-7fbde4d6b525@google.com>

On Fri, Oct 11, 2024 at 10:13:38AM +0000, Alice Ryhl wrote:
> +#[cfg(CONFIG_JUMP_LABEL)]
> +#[cfg(not(CONFIG_HAVE_JUMP_LABEL_HACK))]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
> +        $crate::asm!(
> +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> +            l_yes = label {
> +                break 'my_label true;
> +            },
> +            symb = sym $key,
> +            off = const ::core::mem::offset_of!($keytyp, $field),
> +            branch = const $crate::jump_label::bool_to_int($branch),
> +        );
> +
> +        break 'my_label false;
> +    }};
> +}
> +
> +#[macro_export]
> +#[doc(hidden)]
> +#[cfg(CONFIG_JUMP_LABEL)]
> +#[cfg(CONFIG_HAVE_JUMP_LABEL_HACK)]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
> +        $crate::asm!(
> +            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
> +            l_yes = label {
> +                break 'my_label true;
> +            },
> +            symb = sym $key,
> +            off = const ::core::mem::offset_of!($keytyp, $field),
> +            branch = const 2 | $crate::jump_label::bool_to_int($branch),
> +        );
> +
> +        break 'my_label false;
> +    }};

Ouch... could we get rid of all this duplication by containing the hack
bit to ARCH_STATIC_BRANCH_ASM() like so?

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index ffd0d1a1a4af..3f1c1d6c0da1 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -24,7 +24,7 @@
 #ifdef CONFIG_HAVE_JUMP_LABEL_HACK
 #define ARCH_STATIC_BRANCH_ASM(key, label)		\
 	"1: jmp " label " # objtool NOPs this \n\t"	\
-	JUMP_TABLE_ENTRY(key, label)
+	JUMP_TABLE_ENTRY(key " + 2", label)
 #else /* !CONFIG_HAVE_JUMP_LABEL_HACK */
 #define ARCH_STATIC_BRANCH_ASM(key, label)		\
 	"1: .byte " __stringify(BYTES_NOP5) "\n\t"	\
@@ -33,10 +33,8 @@
 
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
-	int hack_bit = IS_ENABLED(CONFIG_HAVE_JUMP_LABEL_HACK) ? 2 : 0;
-
 	asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
-		: :  "i" (key), "i" (hack_bit | branch) : : l_yes);
+		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
 l_yes:

