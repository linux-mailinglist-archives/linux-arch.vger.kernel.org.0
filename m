Return-Path: <linux-arch+bounces-5944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79E946262
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44558B21DD8
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBF1537DF;
	Fri,  2 Aug 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NvaGzkys"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F661537A0;
	Fri,  2 Aug 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619450; cv=none; b=TA7DlaeOy2zHmtJOBmuefSenD9P37r2JwJ5zWh01erAifXo+uWASfCdV6y+xFb+M/tAT57+vEIRVt/6AAu6/8mSqMZevp3i+DTmytPzFdKeeKwoi3Pbo9Qj9A93dCOa3ABKWruo0MrBgnKvw2MPa12vTVnDSZVDd+Pmh5Ldq9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619450; c=relaxed/simple;
	bh=WFAHa2ete4Xb+JbywsGV+pLk9gCOl+vYhLmCllbETPw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRMSxlC+UBENbYmTNjSFv2V4jOPB7SmXCrPRNylip1LQQXAnQDwU6iHbtjcrNC4hwbhulAQbTWlBnwOCweFmrI4OxDWSnzmwb8VG3UDH3OLDvtWwsSj1bgYC243HaSWxh6nKZMECFIb7ZLIMdYPdfGUNRRPHokzkUsZOCoT/UZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NvaGzkys; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722619446; x=1722878646;
	bh=KYJ880DzvybbissblwMCNzUlLxxe1Ktl0TOAACRRXAQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NvaGzkysirXcjizn6Jo4e4bFXgCgbyugGW/9RojsJdsReD3ddkqxDsLLila/aLRf6
	 zAbt4EB/1Gu795L1QQ/3CavkmtMHt7uIFQq8t2ItVC3iOl9fwTeC1AthRSX4z+8iNe
	 oTr8wCRurge3wMmBL2CzZSMR6HFHR48iZ/RMDQcD0zhPEJL/htJer4r63YJ548B1tb
	 J6FK0Z9l/PtQc892UbtZkC+5Plst5EtSJMIYvNubk7qKCDAz8J/AnUw2YqS/s397gC
	 G+gnJ0EzhLYfOWcLjc7ypKcE9FOL5T0G59OgxWS4zTsdbw3CdY61bx6jAIVXRefpsV
	 feUbG72Eojoow==
Date: Fri, 02 Aug 2024 17:23:59 +0000
To: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH v5 2/2] rust: add tracepoint support
Message-ID: <a381ef22-96f4-4a72-8e3a-cc023dee111a@proton.me>
In-Reply-To: <20240802-tracepoint-v5-2-faa164494dcb@google.com>
References: <20240802-tracepoint-v5-0-faa164494dcb@google.com> <20240802-tracepoint-v5-2-faa164494dcb@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d47c8e3b3391333c5a5926396deb7ee3ad135f33
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.08.24 11:31, Alice Ryhl wrote:
> diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
> new file mode 100644
> index 000000000000..69dafdb8bfe8
> --- /dev/null
> +++ b/rust/kernel/tracepoint.rs
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Logic for tracepoints.
> +
> +/// Declare the Rust entry point for a tracepoint.
> +///
> +/// This macro generates an unsafe function that calls into C, and its s=
afety requirements will be
> +/// whatever the relevant C code requires. To document these safety requ=
irements, you may add
> +/// doc-comments when invoking the macro.

I think we should mandate safety documentation for the function.

> +#[macro_export]
> +macro_rules! declare_trace {
> +    ($($(#[$attr:meta])* $pub:vis fn $name:ident($($argname:ident : $arg=
typ:ty),* $(,)?);)*) =3D> {$(

Can you add an `unsafe` in front of `fn`, since this macro generates an
`unsafe` function? Otherwise I don't see how the SAFETY comment below is
correct.

---
Cheers,
Benno

> +        $( #[$attr] )*
> +        #[inline(always)]
> +        $pub unsafe fn $name($($argname : $argtyp),*) {
> +            #[cfg(CONFIG_TRACEPOINTS)]
> +            {
> +                // SAFETY: It's always okay to query the static key for =
a tracepoint.
> +                let should_trace =3D unsafe {
> +                    $crate::macros::paste! {
> +                        $crate::static_key::static_key_false!(
> +                            $crate::bindings::[< __tracepoint_ $name >],
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
> +                        unsafe { $crate::bindings::[< rust_do_trace_ $na=
me >]($($argname),*) };
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
> 2.46.0.rc2.264.g509ed76dc8-goog
>=20


