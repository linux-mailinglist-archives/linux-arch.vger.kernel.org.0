Return-Path: <linux-arch+bounces-5789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3359435F9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C221F221FF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F743EA7B;
	Wed, 31 Jul 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b1nTHKn2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5112EBD7;
	Wed, 31 Jul 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452319; cv=none; b=knbq8FUcDuEz3cuIfRQIhM13xZ/Pz2qRNz2B8l3AJTCUXl/iFIPBZIRZKlo08t1fU7LXBBQ72oyCzbVurK4/R3fUThNCI/kNOytupZ2D8a1uCq9BRj4V9FCjjg9cjBP3O21dBCM11mz9/yqsJHFIZSUfMqQOHigCMpi1uEPnKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452319; c=relaxed/simple;
	bh=Os8qowKsxDSRcPHPF/e1AaWARnryjEqWztOmIrjOGZI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lM/tfIkPJTWxP9Z8QB+bGPBGHkxxEbfLj8c8xJ2dnCsTuTARr0wmSCFIi1pycm7mvn1P2sXFsc13Zvt9+/A4Is3i4vYH9lyPw+R5byWEMVw3Kpa+Wwk/ZM9ucPbrTXJETSk8NLHJZAnDpD0Ukjowdm+kYqB3P90EfiRvjwOOfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b1nTHKn2; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722452314; x=1722711514;
	bh=Ok2jcwhhpJcH2GHlECFhqT7lAO056VLfnNsP0CYcDJg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b1nTHKn2T1dmR8vteP/M2sWrDZnltmVMV+WeJpQaWHdshFgouh8mtm6NWkSOyvsxv
	 zbvWJCt5CARyolCYp8jYPTiMMC2/kamd6t1bN+hVlgjMjCiCQAFbJEnz1IMoa3ET7b
	 dv/+gkT8NoDZWbongMdRmVuvEm5gxl2UjI9LZZyU/hVmY7z8FZclgaMloojKNlSXGl
	 3JDlf6u0EO7lKkTxR5KncuBvKc2QYLLC9GUUqnUn8OIok9sbIj5OjDnyv1rHUrCrft
	 30wBI2Y8WrNCEUZoxCwk/KYw5Ic9fuzfIcT71pq+GI6qDGIg08sGLP7pGBPC44S4xU
	 28vEKBj2xRsUw==
Date: Wed, 31 Jul 2024 18:58:28 +0000
To: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradaed.org>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti
	<alexghiti@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] rust: add tracepoint support
Message-ID: <b675e620-6a20-496a-8d23-8e184d7bde6b@proton.me>
In-Reply-To: <20240628-tracepoint-v4-2-353d523a9c15@google.com>
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com> <20240628-tracepoint-v4-2-353d523a9c15@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8ba1730ad398f749464698fd1f1be0f27b26c0d0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.06.24 15:23, Alice Ryhl wrote:
> diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
> new file mode 100644
> index 000000000000..1005f09e0330
> --- /dev/null
> +++ b/rust/kernel/tracepoint.rs
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Logic for tracepoints.
> +
> +/// Declare the Rust entry point for a tracepoint.
> +#[macro_export]
> +macro_rules! declare_trace {
> +    ($($(#[$attr:meta])* $pub:vis fn $name:ident($($argname:ident : $arg=
typ:ty),* $(,)?);)*) =3D> {$(
> +        $( #[$attr] )*
> +        #[inline(always)]
> +        $pub unsafe fn $name($($argname : $argtyp),*) {
> +            #[cfg(CONFIG_TRACEPOINTS)]
> +            {
> +                use $crate::bindings::*;

Why is this needed, can't you put this into the invocation of `paste!`?
ie `[< $crate::bindings::__tracepoint_ $name >]`?

> +
> +                // SAFETY: It's always okay to query the static key for =
a tracepoint.
> +                let should_trace =3D unsafe {
> +                    $crate::macros::paste! {
> +                        $crate::static_key::static_key_false!(
> +                            [< __tracepoint_ $name >],
> +                            $crate::bindings::tracepoint,
> +                            key
> +                        )
> +                    }
> +                };
> +
> +                if should_trace {
> +                    $crate::macros::paste! {
> +                        // SAFETY: The caller guarantees that it is okay=
 to call this tracepoint.

Can you add this on the docs of `$name`? ie add a Safety section.
The docs should still appear when creating them/when LSPs show them to
you.

---
Cheers,
Benno

> +                        unsafe { [< rust_do_trace_ $name >]($($argname),=
*) };
> +                    }
> +                }
> +            }
> +
> +            #[cfg(not(CONFIG_TRACEPOINTS))]
> +            {
> +                // If tracepoints are disabled, insert a trivial use of =
each argument
> +                // to avoid unused argument warnings.
> +                $( let _unused =3D $argname; )*
> +            }
> +        }
> +    )*}
> +}
> +
> +pub use declare_trace;
>=20
> --
> 2.45.2.803.g4e1b14247a-goog
>=20


