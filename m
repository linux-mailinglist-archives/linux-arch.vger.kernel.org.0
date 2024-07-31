Return-Path: <linux-arch+bounces-5786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760769434AD
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 19:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11A11C215F0
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309DF1BD00E;
	Wed, 31 Jul 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URmAXo4v"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59C1AC443;
	Wed, 31 Jul 2024 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445534; cv=none; b=AaHX2c6RGvF7z8gBthZe+HdAOPzAowZjZFZE1urvuZwCnnMIwppT0JIBb8fiP9HLWmgpUDBhtj85OGTHRIahg//d2fnGYr6hYyDEKkLwj8qz/bmsJ3vcpgCgkDdUqhnu+xSKzYUgUIMlS7a2avn+XDlPZyb0zFwRzGnwBRJTXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445534; c=relaxed/simple;
	bh=Kvo+Qg69Lf9bUXUEg3NaEQbb4hHBPQA3suJvsVKDU/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNAb1jqmCFqkddOq555fxOExQGX7KlKDDh9ikzL3z5UOWcP6yM9UGCKG7SKhYpvf3r0YRoiQQCwUi3frzH6CvunxNIZBirRAgnWc7/QsV4CNOoffnsKwNOwQQHdPyhFIvHzIixRsdy2e2nVqz/FIZwp/jHPJ1EnG+muqMWzBfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=URmAXo4v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=loxjFiVI2FUEfLt+uJa/RoAUGOvN0EDyWPzOQRMKPYM=; b=URmAXo4vciLmD8RF26rtYBhhPA
	G31cEdVvEozLEj+TiA4d2wRtMbewzkqNphoc2s1IzH1fwbGdgUMbQNYsKuTX+GtkdZ8pEsRGMt9Wn
	tZQSzzAqb3x2Uk9yvAISY4PyRWfI4rIeUhfqY+XHg229yLUoAWWG6EtbDAEJOBSVAIZeFSjmu/2V8
	Pe2mEvZC+zNGXJ1eBrKKrLSpn1gYZQVD7rVJktSOYg7A9wFPxSPVGGsY8mXuYJcnjrATmgmr+YrWG
	DAC751NQGurBuTOXhxDSNHxQTCs/XNPevta1qUx7LxS11QH1clIvk+t7MXDQ5uCJXdDON6+G+Q0Gx
	vGpwi0oA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZClB-0000000GMnQ-09lX;
	Wed, 31 Jul 2024 17:05:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3BB5F300820; Wed, 31 Jul 2024 19:05:08 +0200 (CEST)
Date: Wed, 31 Jul 2024 19:05:08 +0200
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
	"Peter Zijlstra (Intel)" <peterz@infradaed.org>,
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
Subject: Re: [PATCH v4 1/2] rust: add static_key_false
Message-ID: <20240731170508.GJ33588@noisy.programming.kicks-ass.net>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
 <20240628-tracepoint-v4-1-353d523a9c15@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628-tracepoint-v4-1-353d523a9c15@google.com>

On Fri, Jun 28, 2024 at 01:23:31PM +0000, Alice Ryhl wrote:

>  rust/kernel/arch/arm64/jump_label.rs     | 34 ++++++++++++++++++++++++++++
>  rust/kernel/arch/loongarch/jump_label.rs | 35 +++++++++++++++++++++++++++++
>  rust/kernel/arch/mod.rs                  | 24 ++++++++++++++++++++
>  rust/kernel/arch/riscv/jump_label.rs     | 38 ++++++++++++++++++++++++++++++++
>  rust/kernel/arch/x86/jump_label.rs       | 35 +++++++++++++++++++++++++++++
>  rust/kernel/lib.rs                       |  2 ++
>  rust/kernel/static_key.rs                | 32 +++++++++++++++++++++++++++
>  scripts/Makefile.build                   |  2 +-
>  8 files changed, 201 insertions(+), 1 deletion(-)

So I really find the amount of duplicated asm offensive. Is is far too
easy for any of this to get out of sync.

> diff --git a/rust/kernel/arch/x86/jump_label.rs b/rust/kernel/arch/x86/jump_label.rs
> new file mode 100644
> index 000000000000..383bed273c50
> --- /dev/null
> +++ b/rust/kernel/arch/x86/jump_label.rs
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! X86 Rust implementation of jump_label.h
> +
> +/// x86 implementation of arch_static_branch
> +#[macro_export]
> +#[cfg(target_arch = "x86_64")]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
> +        core::arch::asm!(
> +            r#"
> +            1: .byte 0x0f,0x1f,0x44,0x00,0x00
> +
> +            .pushsection __jump_table,  "aw"
> +            .balign 8
> +            .long 1b - .
> +            .long {0} - .
> +            .quad {1} + {2} + {3} - .
> +            .popsection
> +            "#,
> +            label {
> +                break 'my_label true;
> +            },
> +            sym $key,
> +            const ::core::mem::offset_of!($keytyp, $field),
> +            const $crate::arch::bool_to_int($branch),
> +        );
> +
> +        break 'my_label false;
> +    }};
> +}

Note that this uses the forced 5 byte version, and not the dynamic sized
one. On top of that it hard-codes the nop5 string :/

Please work harder to not have to duplicate stuff like this.

NAK.


