Return-Path: <linux-arch+bounces-5121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362C916DDE
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 18:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2671A1C20E4D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF56170837;
	Tue, 25 Jun 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk+BnFQ9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182416A945;
	Tue, 25 Jun 2024 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332323; cv=none; b=DC51PwXvQNugzOUHswzxuM0i5X2lnU6HJEQlCVQXgEauDCvX+GJ7TlRGqKYlXa0w8BmG9+OF65h3lGgqWi+/OfMVZoWPo8SKOimCZzgMT0Xnly8o9zMN3DghuJifkVdiXOpULFAWOoFVQnDMhgPjfC1WwRHXfYNL8vcXIDfaPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332323; c=relaxed/simple;
	bh=LIs4vK4bUzf89N/r9zzNId0+b4TR4KWaZxiHMNozK90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq1dshllfBAGG4evs1BhUOS/7cvf+hO/ncvOgh949q20XJ9NEK2eqONj384Dmc3qaQtYFwU+6qQy/AJytwAZHMqRl8dERDv493+VICEduJFWd+NHRAEeMALw2cCALBqzBQEI4rY7hLLEaGVUGc2BHbugBc+3l8eWqbHd21xN9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk+BnFQ9; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b4fec3a1a7so23846576d6.2;
        Tue, 25 Jun 2024 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719332321; x=1719937121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzV/v+3gA2B4KAmBgeJNV2RGM4iqu3a2XsO7XRn5nTQ=;
        b=Vk+BnFQ9KfKMb99bt5VogOb51vfXsnNi2f/ZyVzf7RNeg/x6p/POmKktP+d5i0dwt/
         mJ8kdjGCAFwGt9eel89P/L12uDeJ4t+wUHh85woXRmy42RB7ABmENPX179mEZnoZxlBJ
         ApXbWTymojpq7h8jzeaqPu7xuI7iEfGRvtqknWYoiCfVr2XSw3t1To2I1rVjD0bYA5BK
         72S38YYrRSq0qgqCEjC3VZvSmXQKau4X24CrgQo++wpTlQNPkG/bNjuW0XpL9KIQ00qi
         wxpP9gvbYTIlVV02sM+1bO3/MQ4tJ4b6THLtj+pRMRRNdkIuXq9b5sSS5uZ4u+4nMYC2
         7wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332321; x=1719937121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzV/v+3gA2B4KAmBgeJNV2RGM4iqu3a2XsO7XRn5nTQ=;
        b=uhAz7AjPT68rOZuAll7Dvqs1EChJZ/djc6XGK6rpXm59M1zF8QggiCwMti+WuWW7NF
         1zZ8m8674oC6UXRpbGD+KAV84yPBkT6oMjz472jP08/tFQJYlDjmyfrPG4xAyyJDEIIE
         ZGAi8pdM0eqL6YsumhCzwojB2RGl/+2SxqUcSWw+Lts7obowM0T8ojG3W3Yy03OPSoIa
         EsQsS03fOA1zqBkuiVp0H9EG/c9ShmOmWzpNtO74tnj5oZRCTMIhbdTohzTTSy0vcXQR
         KpFiGbtrhpKT7I9D3ZbhgxZRw+3qmAHE8gXLWoL1U8JgSj53+LauuztBLq2kJNLZA1EV
         mqTA==
X-Forwarded-Encrypted: i=1; AJvYcCU912p4cueBqCjBDvq9P4nvGgubVwe61sCU0VtJAXnipOQRKWsAVfh633fBYIcKvhpD5EJxCgQ2Bu+NutHYMLuvORc3eyF+cotsDZdJe14gtpczTYK85fZLLUu5IgUE7nE25IuGBD7BtQ==
X-Gm-Message-State: AOJu0Yw9+WhaqsIjdDchdwNuRxsAjtoZyOuXJ4WHJPPWeyMDnlYX93rk
	98c4wCZHZU1qpOBx4rn8AgBACGVWtaDDxTqlOgqlHYlCw/Eb3j02
X-Google-Smtp-Source: AGHT+IFp16ybZ3zN4/13OOxDnIrIaHAHRE80uezDo3NO5MXP+RGx1kp1ZnnfL052BTbPbgYmfd7OJg==
X-Received: by 2002:a05:6214:f64:b0:6b0:89ba:396a with SMTP id 6a1803df08f44-6b53bfdc14emr122051866d6.47.1719332320829;
        Tue, 25 Jun 2024 09:18:40 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed175fasm45632086d6.34.2024.06.25.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:18:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B21741200068;
	Tue, 25 Jun 2024 12:18:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 25 Jun 2024 12:18:38 -0400
X-ME-Sender: <xms:3u16Zs_BSxBTLen0HdT8P4JA-kxZW7auNThqakbpGn1AF0Ohg0n7oA>
    <xme:3u16ZkubK3VCHp3urVE5D8rh3vVgEFn5ItbyLqTG6oypkjFuMUbR-66xau3nXYse2
    IypIOSjEWjXStdlNQ>
X-ME-Received: <xmr:3u16ZiDZmjsJTjaLXcNMXZBb7QdlE6Fg-lcF3yzwG5W1fUBDr0KHioKqHkBsIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:3u16ZseeZK6SkF197gOnhCB2CJLXwjNJVYP76ut5b2f3Pa37JVp3mg>
    <xmx:3u16ZhMpNtWU-4dlK-Ea9hB27lKbOSkeDZ0XofJJzN8uoC2MsFC3yg>
    <xmx:3u16ZmkrYUmpQR2uEzfr3tE-JO4G9w8T5VW-0_V3sgVJhZgWakJXig>
    <xmx:3u16ZjtjyRBSRNrJ6L8COu96Y7yVyOMlWr0ZwmF5zSDsA_5d7w4_pQ>
    <xmx:3u16ZvsO-8FEkYzBu2K5pKYgTfNBj-ODhIhBCjoX2jWc7sAMIgPkuCST>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 12:18:37 -0400 (EDT)
Date: Tue, 25 Jun 2024 09:18:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Jason Baron <jbaron@akamai.com>,
 Ard Biesheuvel <ardb@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradaed.org>,
	Sean Christopherson <seanjc@google.com>,	Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>,	Oliver Upton <oliver.upton@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,	Ryan Roberts <ryan.roberts@arm.com>,
 Fuad Tabba <tabba@google.com>,	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/2] rust: add static_key_false
Message-ID: <ZnrtuaUByT70tJY5@boqun-archlinux>
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
 <20240621-tracepoint-v3-1-9e44eeea2b85@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-tracepoint-v3-1-9e44eeea2b85@google.com>

Hi Alice,

On Fri, Jun 21, 2024 at 10:35:26AM +0000, Alice Ryhl wrote:
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

[Add linux-arch, and related arch maintainers Cced]

Since inline asms are touched here, please consider copying linux-arch
and arch maintainers next time ;-)

> ---
>  rust/kernel/lib.rs        |   1 +
>  rust/kernel/static_key.rs | 143 ++++++++++++++++++++++++++++++++++++++++++++++
>  scripts/Makefile.build    |   2 +-
>  3 files changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fbd91a48ff8b..a0be9544996d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -38,6 +38,7 @@
>  pub mod prelude;
>  pub mod print;
>  mod static_assert;
> +pub mod static_key;
>  #[doc(hidden)]
>  pub mod std_vendor;
>  pub mod str;
> diff --git a/rust/kernel/static_key.rs b/rust/kernel/static_key.rs
> new file mode 100644
> index 000000000000..9c844fe3e3a3
> --- /dev/null
> +++ b/rust/kernel/static_key.rs
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Logic for static keys.
> +
> +use crate::bindings::*;
> +
> +#[doc(hidden)]
> +#[macro_export]
> +#[cfg(target_arch = "x86_64")]
> +macro_rules! _static_key_false {
> +    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
> +        core::arch::asm!(
> +            r#"
> +            1: .byte 0x0f,0x1f,0x44,0x00,0x00
> +
> +            .pushsection __jump_table,  "aw"
> +            .balign 8
> +            .long 1b - .
> +            .long {0} - .
> +            .quad {1} + {2} - .
> +            .popsection
> +            "#,
> +            label {
> +                break 'my_label true;
> +            },
> +            sym $key,
> +            const ::core::mem::offset_of!($keytyp, $field),
> +        );
> +
> +        break 'my_label false;
> +    }};
> +}
> +
> +#[doc(hidden)]
> +#[macro_export]
> +#[cfg(target_arch = "aarch64")]
> +macro_rules! _static_key_false {
> +    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
> +        core::arch::asm!(
> +            r#"
> +            1: nop
> +
> +            .pushsection __jump_table,  "aw"
> +            .align 3
> +            .long 1b - ., {0} - .
> +            .quad {1} + {2} - .
> +            .popsection
> +            "#,
> +            label {
> +                break 'my_label true;
> +            },
> +            sym $key,
> +            const ::core::mem::offset_of!($keytyp, $field),
> +        );
> +
> +        break 'my_label false;
> +    }};
> +}
> +

For x86_64 and arm64 bits:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

One thing though, we should split the arch-specific impls into different
files, for example: rust/kernel/arch/arm64.rs or rust/arch/arm64.rs.
That'll be easier for arch maintainers to watch the Rust changes related
to a particular architecture.

Another thought is that, could you implement an arch_static_branch!()
(instead of _static_key_false!()) and use it for static_key_false!()
similar to what we have in C? The benefit is that at least for myself
it'll be easier to compare the implementation between C and Rust.

Regards,
Boqun

> +#[doc(hidden)]
> +#[macro_export]
> +#[cfg(target_arch = "loongarch64")]
> +macro_rules! _static_key_false {
> +    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
> +        core::arch::asm!(
> +            r#"
> +            1: nop
> +
> +            .pushsection __jump_table,  "aw"
> +            .align 3
> +            .long 1b - ., {0} - .
> +            .quad {1} + {2} - .
> +            .popsection
> +            "#,
> +            label {
> +                break 'my_label true;
> +            },
> +            sym $key,
> +            const ::core::mem::offset_of!($keytyp, $field),
> +        );
> +
> +        break 'my_label false;
> +    }};
> +}
> +
> +#[doc(hidden)]
> +#[macro_export]
> +#[cfg(target_arch = "riscv64")]
> +macro_rules! _static_key_false {
> +    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
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
> +            .dword {1} + {2} - .
> +            .popsection
> +            "#,
> +            label {
> +                break 'my_label true;
> +            },
> +            sym $key,
> +            const ::core::mem::offset_of!($keytyp, $field),
> +        );
> +
> +        break 'my_label false;
> +    }};
> +}
> +
> +/// Branch based on a static key.
> +///
> +/// Takes three arguments:
> +///
> +/// * `key` - the path to the static variable containing the `static_key`.
> +/// * `keytyp` - the type of `key`.
> +/// * `field` - the name of the field of `key` that contains the `static_key`.
> +#[macro_export]
> +macro_rules! static_key_false {
> +    // Forward to the real implementation. Separated like this so that we don't have to duplicate
> +    // the documentation.
> +    ($key:path, $keytyp:ty, $field:ident) => {{
> +        // Assert that `$key` has type `$keytyp` and that `$key.$field` has type `static_key`.
> +        //
> +        // SAFETY: We know that `$key` is a static because otherwise the inline assembly will not
> +        // compile. The raw pointers created in this block are in-bounds of `$key`.
> +        static _TY_ASSERT: () = unsafe {
> +            let key: *const $keytyp = ::core::ptr::addr_of!($key);
> +            let _: *const $crate::bindings::static_key = ::core::ptr::addr_of!((*key).$field);
> +        };
> +
> +        $crate::_static_key_false! { $key, $keytyp, $field }
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
>  # ---------------------------------------------------------------------------
>  
> -rust_allowed_features := new_uninit
> +rust_allowed_features := asm_const,asm_goto,new_uninit
>  
>  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
>  # current working directory, which may be not accessible in the out-of-tree
> 
> -- 
> 2.45.2.741.gdbec12cfda-goog
> 

