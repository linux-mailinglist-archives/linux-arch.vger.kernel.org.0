Return-Path: <linux-arch+bounces-5793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398994380E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 23:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CF71F2291E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 21:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277916C861;
	Wed, 31 Jul 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQu1F0BL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A42166308
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461668; cv=none; b=WBWxbz5qOSqdJf5nByZdKOoldHL6qlpzn8bWbHisvJ385XPgkuOw29qLohtzWCmgRFWQEVFVKr2TIe2iCU71l4CfZi8eAcfIfQRH23Lye0Eb5yrLNmbwSUvFZAYfg1ga3cYYumuRzdPxfGiko1iY2uEXR6aT2CZ673OQsS754c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461668; c=relaxed/simple;
	bh=7409YPGD84DSohjrVEJAwG5xvR83yL1kGxaxMdosLHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOOImTO7K6nw+gdAFtZUi8x23wY8FQtfaLZb0cJfu/F5dvVFDp6xU2mixa6uQBPtsTElLjcyWgjNZIlYhRFNDUAqhTZ4mlp/+0rVFFaB/3G2WvRDR4qCxWDcOq/jhVLhrAbGigB3cRFzn2HJxZ84OnGlOCn5dzpdY1vyHwxqQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQu1F0BL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42809d6e719so41581075e9.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722461665; x=1723066465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bli9lhI61IaRjVxZ6El/2TlE2JOrlJn5Lbi96Tzc1cY=;
        b=GQu1F0BLQxTE5HrRAYdznGPthK87JO7jzNA+e0LtPBS1Xeb7WCoXTu2o2+hnzBzEUl
         buBKc8MLsCIEA0Bjx1nzCTqT1i+hXRpUbn5iBBD2SbfwEsIe35BUVWVchgQPPD+DFajC
         lgje4uUGsgJyywhKyYgL3ztHIrUUCdz3okoNP58tNgHhPgWtwYf9i8AxVGsRIaJgg9X8
         CKcJQ2zOdQWlDWO3kjiYGEMSBdXzPvWGQVqYoBqIqg7REf/xE5sFBvxtZ1ndtnA7kFmX
         qadHFbyDM1p2Ld/bexaE0vVnZucLwHYBDMHOjdX234OwQF4buenYjN+cAaHLeLST4GQT
         nxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461665; x=1723066465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bli9lhI61IaRjVxZ6El/2TlE2JOrlJn5Lbi96Tzc1cY=;
        b=WVnj0j1Na4+29KxoMnSzp0UmLkmHj+t/OOLM5iX9zCKZK4M3VcEEoSg+R/QJ2DG4Me
         8Tt/Dfkh3bXxhxnUEOsb9XjdQQepcXYRCwh9DWJcxoC6GvsLSQBrzdcZJexdT3y1Q9AS
         BYxrHVLbcTQSYmqAAdRnZ0fSaci+ciO82H35r+nd9WUjHSp3QE/jG4Rhsjb6soLhykZ1
         Zyhd3Xnmck2hNdO4lRbr6XlraHxXpiFbGWPf293wbIuXKigffPdRVGjplCQp55uAOAJT
         QCkQUYiKxS5synz8NpqngGFJidpEa1lV2ONvOmHyR1Emcxm/V8gq0CPNWx1K/h7w3Mem
         6G7w==
X-Forwarded-Encrypted: i=1; AJvYcCVb1ADMFK9b7dnduGJisS3b8AiKgOxkiX5arIGz0H3vV5iwudwVwbp3NQT+4VVVJqEsBy24tNcp4kmr3RbtH6cs/o3E+Z3mK56waw==
X-Gm-Message-State: AOJu0Yx7bfnXUDewrtzkBYo3jxa2VdGoRXH04ND+OINElM81Zm9PaHw5
	W0iljF5UuPkRyRezWWdQ/A9aHbIXNV/6NoyuoYLMVOPf6ZUYClLah/CN1geUdfLOQ3TcHwUTkTi
	zqzs2OM/9OBTPGUNQ3A31C+AJ/JzW+hEJsROa
X-Google-Smtp-Source: AGHT+IEnnH7Vl1oPP/7poRoKnYi3pQkDBFhO+xnBb/MH3dLIwjkKyZ7/ziEU66uYwoK2Ox4X3gDKYbUA6wyDWgsUmeg=
X-Received: by 2002:a05:600c:3543:b0:426:6ee7:c05a with SMTP id
 5b1f17b1804b1-428a9bdcd50mr4067365e9.15.1722461664765; Wed, 31 Jul 2024
 14:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
 <20240628-tracepoint-v4-1-353d523a9c15@google.com> <20240731170508.GJ33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240731170508.GJ33588@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 31 Jul 2024 23:34:13 +0200
Message-ID: <CAH5fLghYodekhH-1A0BWZVwgbqkWbP3WP70-us2FtHqvOqD_Hw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: add static_key_false
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradaed.org>, 
	Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:05=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jun 28, 2024 at 01:23:31PM +0000, Alice Ryhl wrote:
>
> >  rust/kernel/arch/arm64/jump_label.rs     | 34 ++++++++++++++++++++++++=
++++
> >  rust/kernel/arch/loongarch/jump_label.rs | 35 ++++++++++++++++++++++++=
+++++
> >  rust/kernel/arch/mod.rs                  | 24 ++++++++++++++++++++
> >  rust/kernel/arch/riscv/jump_label.rs     | 38 ++++++++++++++++++++++++=
++++++++
> >  rust/kernel/arch/x86/jump_label.rs       | 35 ++++++++++++++++++++++++=
+++++
> >  rust/kernel/lib.rs                       |  2 ++
> >  rust/kernel/static_key.rs                | 32 ++++++++++++++++++++++++=
+++
> >  scripts/Makefile.build                   |  2 +-
> >  8 files changed, 201 insertions(+), 1 deletion(-)
>
> So I really find the amount of duplicated asm offensive. Is is far too
> easy for any of this to get out of sync.
>
> > diff --git a/rust/kernel/arch/x86/jump_label.rs b/rust/kernel/arch/x86/=
jump_label.rs
> > new file mode 100644
> > index 000000000000..383bed273c50
> > --- /dev/null
> > +++ b/rust/kernel/arch/x86/jump_label.rs
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! X86 Rust implementation of jump_label.h
> > +
> > +/// x86 implementation of arch_static_branch
> > +#[macro_export]
> > +#[cfg(target_arch =3D "x86_64")]
> > +macro_rules! arch_static_branch {
> > +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) =3D> {'my_labe=
l: {
> > +        core::arch::asm!(
> > +            r#"
> > +            1: .byte 0x0f,0x1f,0x44,0x00,0x00
> > +
> > +            .pushsection __jump_table,  "aw"
> > +            .balign 8
> > +            .long 1b - .
> > +            .long {0} - .
> > +            .quad {1} + {2} + {3} - .
> > +            .popsection
> > +            "#,
> > +            label {
> > +                break 'my_label true;
> > +            },
> > +            sym $key,
> > +            const ::core::mem::offset_of!($keytyp, $field),
> > +            const $crate::arch::bool_to_int($branch),
> > +        );
> > +
> > +        break 'my_label false;
> > +    }};
> > +}
>
> Note that this uses the forced 5 byte version, and not the dynamic sized
> one. On top of that it hard-codes the nop5 string :/
>
> Please work harder to not have to duplicate stuff like this.

I really didn't want to duplicate it, but it's very hard to find a
performant alternative. Is there any way we could accept duplication
only in the cases where an 'i' parameter is used? I don't have the
choice of using a Rust helper for 'i' parameters.

Perhaps one option could be to put the Rust code inside jump_label.h
and have the header file evaluate to either C or Rust depending on the
value of some #ifdefs?

#ifndef RUST_ASM
/* existing C code goes here */
#endif
#ifdef RUST_ASM
// rust code goes here
#endif

That way the duplication is all in a single file. It would also avoid
the need for duplicating the nop5 string, as the Rust case is still
going through the C preprocessor and can use the existing #define.

I'm also open to other alternatives. But I don't have infinite
resources to drive major language changes.

Alice

