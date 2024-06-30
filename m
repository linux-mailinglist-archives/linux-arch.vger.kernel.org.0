Return-Path: <linux-arch+bounces-5207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0391D01F
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2024 08:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B770EB213D7
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2024 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD37376EC;
	Sun, 30 Jun 2024 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="ilvdZp3h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFD2B9A2
	for <linux-arch@vger.kernel.org>; Sun, 30 Jun 2024 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719727223; cv=none; b=dCeM2AsOn3kVf3PVLlu6PPZdngwvD1f94aXt9t9NcebvTJEa0i87x6hrgqOkKstmDJmYvKf24CwwHEKJJ1MZVfytmy3MLMB5joZiTD4bW3U45IPNwOI1U1APKvoUg8/swPFqvDLc7jUuzM3yzGOXU98SAEYS5p7zmb8yMELl0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719727223; c=relaxed/simple;
	bh=tQkrBNfZsOwLqSWgWSlipr86F48Z0svj3Vr5OZUb7y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD/S/vVt3lzcjV25DB5W4VrboIUm2h9n8/4a33cVHl62etJWOQzVQqkbve3hsXXhU1JPy5m9f+B6SMyNtusP6tiQMUOm/5wDJzsPTVYvXOpH9OeL8DGGdG6QQ/jFYqM7mXFmjgoHT2zkiMzslqXDT1jh5BznypS4jxoPnWJjSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=ilvdZp3h; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e035dc23a21so1708771276.0
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2024 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1719727220; x=1720332020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z+HcQF7Z+hkJPUz7jNlFlAo56pnj1GWbfXdC8hq/RY=;
        b=ilvdZp3h3HcW9NZGDwQ9UxVB1FvggDeml5PLE4NKg/oLagONSarxbXeDupRzV01IK9
         Y9ztu2CaDuGJT6/G0uzfijq7lhzLt1hCe5oc8K+OhOyVxeuMp6EgTD3IKLZbDzdIvwUd
         /0Qa2gxVpi1lnju7ptpF/1vIcHLaQ4zKoi4Jo1opjvbVBoLRyMzsDxq1g36qCDAhpl1j
         8DaFdXaWtZg2Bj6PR7pyDq2Ktfn2EjwRoyP51dTAt5Yj9uvT+v2BOx5YxNkZMyOghhG8
         PnreAWG77kJiVnQZ/t3Cx7j/s9sUO0XS/I5fOpnqYmJHID5yITCPmZIQsa1bcoB4eADX
         XD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719727220; x=1720332020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z+HcQF7Z+hkJPUz7jNlFlAo56pnj1GWbfXdC8hq/RY=;
        b=utw1h7M7/Jk7U/KinvQ0UZd4vTZYRocxgvjxe2di14b8dBgvyncXTVvq1WD/oVPOYA
         J5MdEbzg6CxWHpgCUXcoLqSQqhjCLXhSaj0yBs2yogX7O6NCJSlbyHeu/rH3d8bWVng4
         EBHDp//VM6EVB7cIliwiAwLjtM+K5b5LWfR+hgljYX/FXUTCjoxfTHj3UMrgSa6SOapu
         G3kzquCHZgXh/05FTa3rayrmmK28RLHnbDkLDFzf8wN2YSifChCTCr7+sUA8LQpefyqs
         cGwrTY11bCwF50lNtNz7nX1ek58fQeOgryQbrZDVQuG7nUgif6NneXKlffOJL1yBgMwW
         hF+A==
X-Forwarded-Encrypted: i=1; AJvYcCVXV68HtVBwSQfTe1A/UXjJUisja8E35KTPtskhqj8VFkZ05ABZ3l27N/7r/Y27XuaPOJG7LgxJ+Lrokq0wpKict6NeN7jSsiGvmA==
X-Gm-Message-State: AOJu0YwYEYlb0e/v+1afU4EfkM29cxrQZnIFIueaPwXPKvW3UHR2N7a8
	AOgaYIOSBagCaTuGcrQUfPUZn3e1Hd7xDA/9prN1r3839nJX5Y35XXFPmz49V80pkVicYN5c/P6
	SgiY7KQurqucHmJNmdRL7urHwqtHjLvzVGP6zXg==
X-Google-Smtp-Source: AGHT+IGa/J8SobAVMgZOGPow3jjMohMft7k0t0CJ7I1qGMmuVdGvPtInQVQQZhlJQRKSx2WFdG8uA8+wzb8seMm1cE8=
X-Received: by 2002:a25:860e:0:b0:e02:6fe6:ec55 with SMTP id
 3f1490d57ef6-e036eb27eebmr2255709276.17.1719727219444; Sat, 29 Jun 2024
 23:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-tracepoint-v4-0-353d523a9c15@google.com> <20240628-tracepoint-v4-1-353d523a9c15@google.com>
In-Reply-To: <20240628-tracepoint-v4-1-353d523a9c15@google.com>
From: hev <r@hev.cc>
Date: Sun, 30 Jun 2024 14:00:08 +0800
Message-ID: <CAHirt9iXiQHT-WsKVamyNY8-nw-Xddrc3xO05k6mM-9xtjSgPw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: add static_key_false
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

Hi Alice

On Fri, Jun 28, 2024 at 9:24=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
>
> It is not possible to use the existing C implementation of
> arch_static_branch because it passes the argument `key` to inline
> assembly as an 'i' parameter, so any attempt to add a C helper for this
> function will fail to compile because the value of `key` must be known
> at compile-time.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/arch/arm64/jump_label.rs     | 34 ++++++++++++++++++++++++++=
++
>  rust/kernel/arch/loongarch/jump_label.rs | 35 ++++++++++++++++++++++++++=
+++
>  rust/kernel/arch/mod.rs                  | 24 ++++++++++++++++++++
>  rust/kernel/arch/riscv/jump_label.rs     | 38 ++++++++++++++++++++++++++=
++++++
>  rust/kernel/arch/x86/jump_label.rs       | 35 ++++++++++++++++++++++++++=
+++
>  rust/kernel/lib.rs                       |  2 ++
>  rust/kernel/static_key.rs                | 32 ++++++++++++++++++++++++++=
+
>  scripts/Makefile.build                   |  2 +-
>  8 files changed, 201 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/arch/arm64/jump_label.rs b/rust/kernel/arch/arm6=
4/jump_label.rs
> new file mode 100644
> index 000000000000..5eede2245718
> --- /dev/null
> +++ b/rust/kernel/arch/arm64/jump_label.rs
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Arm64 Rust implementation of jump_label.h
> +
> +/// arm64 implementation of arch_static_branch
> +#[macro_export]
> +#[cfg(target_arch =3D "aarch64")]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) =3D> {'my_label:=
 {
> +        core::arch::asm!(
> +            r#"
> +            1: nop
> +
> +            .pushsection __jump_table,  "aw"
> +            .align 3
> +            .long 1b - ., {0} - .
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
> +
> +pub use arch_static_branch;
> diff --git a/rust/kernel/arch/loongarch/jump_label.rs b/rust/kernel/arch/=
loongarch/jump_label.rs
> new file mode 100644
> index 000000000000..8d31318aeb11
> --- /dev/null
> +++ b/rust/kernel/arch/loongarch/jump_label.rs
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Loongarch Rust implementation of jump_label.h
> +
> +/// loongarch implementation of arch_static_branch
> +#[doc(hidden)]
> +#[macro_export]
> +#[cfg(target_arch =3D "loongarch64")]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) =3D> {'my_label:=
 {
> +        core::arch::asm!(
> +            r#"
> +            1: nop
> +
> +            .pushsection __jump_table,  "aw"
> +            .align 3
> +            .long 1b - ., {0} - .
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

I have tested these patches on LoongArch and it works as expected.

Tested-by: WANG Rui <wangrui@loongson.cn>

Thanks,
-Rui

> +
> +pub use arch_static_branch;
> diff --git a/rust/kernel/arch/mod.rs b/rust/kernel/arch/mod.rs
> new file mode 100644
> index 000000000000..14271d2530e9
> --- /dev/null
> +++ b/rust/kernel/arch/mod.rs
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Architecture specific code.
> +
> +#[cfg_attr(target_arch =3D "aarch64", path =3D "arm64")]
> +#[cfg_attr(target_arch =3D "x86_64", path =3D "x86")]
> +#[cfg_attr(target_arch =3D "loongarch64", path =3D "loongarch")]
> +#[cfg_attr(target_arch =3D "riscv64", path =3D "riscv")]
> +mod inner {
> +    pub mod jump_label;
> +}
> +
> +pub use self::inner::*;
> +
> +/// A helper used by inline assembly to pass a boolean to as a `const` p=
arameter.
> +///
> +/// Using this function instead of a cast lets you assert that the input=
 is a boolean, rather than
> +/// some other type that can be cast to an integer.
> +#[doc(hidden)]
> +pub const fn bool_to_int(b: bool) -> i32 {
> +    b as i32
> +}
> diff --git a/rust/kernel/arch/riscv/jump_label.rs b/rust/kernel/arch/risc=
v/jump_label.rs
> new file mode 100644
> index 000000000000..2672e0c6f033
> --- /dev/null
> +++ b/rust/kernel/arch/riscv/jump_label.rs
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! RiscV Rust implementation of jump_label.h
> +
> +/// riscv implementation of arch_static_branch
> +#[macro_export]
> +#[cfg(target_arch =3D "riscv64")]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) =3D> {'my_label:=
 {
> +        core::arch::asm!(
> +            r#"
> +            .align  2
> +            .option push
> +            .option norelax
> +            .option norvc
> +            1: nop
> +            .option pop
> +            .pushsection __jump_table,  "aw"
> +            .align 3
> +            .long 1b - ., {0} - .
> +            .dword {1} + {2} + {3} - .
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
> +
> +pub use arch_static_branch;
> diff --git a/rust/kernel/arch/x86/jump_label.rs b/rust/kernel/arch/x86/ju=
mp_label.rs
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
> +#[cfg(target_arch =3D "x86_64")]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) =3D> {'my_label:=
 {
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
> +
> +pub use arch_static_branch;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fbd91a48ff8b..fffd4e1dd1c1 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -27,6 +27,7 @@
>  extern crate self as kernel;
>
>  pub mod alloc;
> +pub mod arch;
>  mod build_assert;
>  pub mod error;
>  pub mod init;
> @@ -38,6 +39,7 @@
>  pub mod prelude;
>  pub mod print;
>  mod static_assert;
> +pub mod static_key;
>  #[doc(hidden)]
>  pub mod std_vendor;
>  pub mod str;
> diff --git a/rust/kernel/static_key.rs b/rust/kernel/static_key.rs
> new file mode 100644
> index 000000000000..32cf027ef091
> --- /dev/null
> +++ b/rust/kernel/static_key.rs
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Logic for static keys.
> +
> +use crate::bindings::*;
> +
> +/// Branch based on a static key.
> +///
> +/// Takes three arguments:
> +///
> +/// * `key` - the path to the static variable containing the `static_key=
`.
> +/// * `keytyp` - the type of `key`.
> +/// * `field` - the name of the field of `key` that contains the `static=
_key`.
> +#[macro_export]
> +macro_rules! static_key_false {
> +    ($key:path, $keytyp:ty, $field:ident) =3D> {{
> +        // Assert that `$key` has type `$keytyp` and that `$key.$field` =
has type `static_key`.
> +        //
> +        // SAFETY: We know that `$key` is a static because otherwise the=
 inline assembly will not
> +        // compile. The raw pointers created in this block are in-bounds=
 of `$key`.
> +        static _TY_ASSERT: () =3D unsafe {
> +            let key: *const $keytyp =3D ::core::ptr::addr_of!($key);
> +            let _: *const $crate::bindings::static_key =3D ::core::ptr::=
addr_of!((*key).$field);
> +        };
> +
> +        $crate::arch::jump_label::arch_static_branch! { $key, $keytyp, $=
field, false }
> +    }};
> +}
> +
> +pub use static_key_false;
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index efacca63c897..60197c1c063f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -263,7 +263,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ----------------------------------------------------------------------=
-----
>
> -rust_allowed_features :=3D new_uninit
> +rust_allowed_features :=3D asm_const,asm_goto,new_uninit
>
>  # `--out-dir` is required to avoid temporaries being created by `rustc` =
in the
>  # current working directory, which may be not accessible in the out-of-t=
ree
>
> --
> 2.45.2.803.g4e1b14247a-goog
>
>

