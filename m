Return-Path: <linux-arch+bounces-6431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3613195A387
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0014281B70
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 17:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C51B2526;
	Wed, 21 Aug 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9r/ct1X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453016A95A;
	Wed, 21 Aug 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260110; cv=none; b=TIcvJ/uFeOVdKCcuG1IPidfhsrQBLEiUztnhPu5Z/oQ6EkyUSyP6nY9r7FP/e9ecB5NUaWYBg0xqJHcmb2zJWi1zPtSM4U9BAxAYQf4ZHEnOJIYe39Wg8QEs6Ht9ZKCzcRuRXT3PTCWuJjJSdoJ1Cb3dMoQXTKa7Q8doUkiZLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260110; c=relaxed/simple;
	bh=IuVDw/80YWYc4Tv7MyJ7dZ15Npf/cBodIg8N5LcldTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr1KW/6VY76EODzzshwLKZWSiuxWxjqbizcDhSYDBpQnYkaUFo0D9UGd6Kwj/dJVOlPsKTgCFeRbVV+2WPqMz/I5HrzDXouWKN8Ce3StvDJrRiYHq4rlBhi3tltJZWwhkry+qeV8xCBVSsorMN1KmTcI4C/IC3rUSQDXQvJYCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9r/ct1X; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d024f775so504969185a.2;
        Wed, 21 Aug 2024 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724260106; x=1724864906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WItMaeY5hi8+K3FTWN8onrZqOVRFgwo42FK4ki6Up7k=;
        b=Z9r/ct1XoOPToY5pXv4mygjRKkAx/rzW/tOhsVShwzg+AWkOJOJgVz5HEdGH4m03Kv
         a14Dbwjm78Pxyx4iwygligY0QxX3ahFEVaMempoRlDIQHaXOYqWKejUwGdkHpLKFDPae
         C2UKzdaOjXypNwuRLBvSxN2Te7fvhRx4dt9Jsr4geWPWazpcMOpusmJklCkWVkJeXnyL
         YjgA5Usf6Q+en3iD2KtQwHc9y0+6nsVh86o9jIOPn/gK9VjQ0I0j+1hE6DDsD5vb7nTx
         07dZTDVjYyq6fnsFE1HVzXlnji2vnoVAV8My8gC8fbY4V6AtGWsc29LVJD7PvzGnSFnC
         U/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260106; x=1724864906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WItMaeY5hi8+K3FTWN8onrZqOVRFgwo42FK4ki6Up7k=;
        b=QUeE3qs5rHG2o0tOC9TnwRxYiZf2ESEylewRpoPoks5pbIwHXpntPoXNcKxZz96L7f
         TDe/blvtKspbXYj26zGbOtbtRlB20EosSoqFPwrTYfO62PVPSIMdY4Aaw/BNGLQZfxzD
         drklOvSMqG3zYmW4CcPoRQDKav6Gt46Ajia/gdZPV0hIPpf+augKizkdxC7lwnEjjjlM
         hvO1mvbCjTq1OcY4fyn27QYjEPISXC/4oh74f8Hso7ttkIXEEo/Gc4GdIum5pLGiGai9
         +qgfKseQUXH5NIMQu29m6zc1tPXb1bSFGWmaEzHv7yA0Pm3Xdts5a5pSI6Bwj8qN2fRt
         wbRg==
X-Forwarded-Encrypted: i=1; AJvYcCU6j3YyksGiN/Q6jgqkgOUAU7ndP16Y79poWyymSuYudgNCfUmW+eeEh8J+XSdfKhiO/jnKSvx7IXkJz4bxnbSFoKrh@vger.kernel.org, AJvYcCX5EMd+hXUX3ywq6tVo/XTMxwp7PGyojdSzS/+Uf/CB4pIqgPHOS04iSNYRuNfOSXFizg717lDv2wYH@vger.kernel.org, AJvYcCXsXmimv5RIdNav0gyMTptU+Yf3H/5NK5hf3557Z2Ydsy5HbpT+8xc1mUkL6UGMOcTCtCpQ5OnUQp3VJmbo@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoXYSNts5xyfgWyYZTmUtUo02ThzCUYwzotOh6mz8gzz9oKt6
	AeWmPf5G0fAKMXf+3ivLBgCZQ5//2fuYCb7UfJ/zJh1DUuzvGBML
X-Google-Smtp-Source: AGHT+IHloTpPhwBJcAwCjVbulS24eS8+KaU3vw0LVPvn/6e7Y0C/8iW0lYK/XMYHaaRgSg14m0g3jA==
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr352917585a.32.1724260105540;
        Wed, 21 Aug 2024 10:08:25 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e0982sm641638485a.98.2024.08.21.10.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:08:24 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 662A01200043;
	Wed, 21 Aug 2024 13:08:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Aug 2024 13:08:23 -0400
X-ME-Sender: <xms:Bx_GZmzlhgzQJVimnzAq8DxkpCEEKpKZnGHwldoYfUXdg3qTwPgi8A>
    <xme:Bx_GZiTTFPe4MJvfGmjNx0AxL4-1ZD7TswYcaddbnjYZldyUG9Pt2OppqcYIOguY1
    JQGMFB0T-nQcxFySw>
X-ME-Received: <xmr:Bx_GZoWWIL7HXb49O-zcMWQoYmpV9g2_DBlD_yAMWBvba-oDlVDwgairALU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepjeelveeguddvheehvddvkeegvdehgfejhedu
    geejtedtheekleehieefvdeulefgnecuffhomhgrihhnpehrshdrshgsnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhn
    sggprhgtphhtthhopeehfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlih
    gtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhs
    rdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtohepjhhpohhimhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggr
    rhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Bx_GZsgAm5iZZrnJVUpKXpZr02SBSmpFjeWNFwzhlqgPdEzrefaVfA>
    <xmx:Bx_GZoDJVqHQjTYl6ZVUyugDuuzBW8gqsXd5uzJaI4CsR11L3Ba1CQ>
    <xmx:Bx_GZtJn4-2Fu9KRHH7nM-ozEKYWsqeAxcj9IWJ29R77P7_zxK83Vw>
    <xmx:Bx_GZvBxT92fkYDS8tuxiscs6WnAoGuTqsD2n-cO7I1ATfN7cRCR9A>
    <xmx:Bx_GZgzwIc3BoB_vKKok2EbMxkKW9NG_NhxnFRf9dZN79pUet8in8PZ5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 13:08:22 -0400 (EDT)
Date: Wed, 21 Aug 2024 10:08:16 -0700
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
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH v7 5/5] rust: add arch_static_branch
Message-ID: <ZsYfAFrBFVewchGM@boqun-archlinux>
References: <20240816-tracepoint-v7-0-d609b916b819@google.com>
 <20240816-tracepoint-v7-5-d609b916b819@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-tracepoint-v7-5-d609b916b819@google.com>

On Fri, Aug 16, 2024 at 11:07:42AM +0000, Alice Ryhl wrote:
> To allow the Rust implementation of static_key_false to use runtime code
> patching instead of the generic implementation, pull in the relevant
> inline assembly from the jump_label.h header by running the C
> preprocessor on a .rs.S file. Build rules are added for .rs.S files.
> 
> Since the relevant inline asm has been adjusted to export the inline asm
> via the ARCH_STATIC_BRANCH_ASM macro in a consistent way, the Rust side
> does not need architecture specific code to pull in the asm.
> 
> It is not possible to use the existing C implementation of
> arch_static_branch via a Rust helper because it passes the argument
> `key` to inline assembly as an 'i' parameter. Any attempt to add a C
> helper for this function will fail to compile because the value of `key`
> must be known at compile-time.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/Makefile                           |  5 ++-
>  rust/kernel/.gitignore                  |  3 ++
>  rust/kernel/arch_static_branch_asm.rs.S |  7 ++++
>  rust/kernel/jump_label.rs               | 64 ++++++++++++++++++++++++++++++++-
>  rust/kernel/lib.rs                      | 30 ++++++++++++++++
>  scripts/Makefile.build                  |  9 ++++-
>  6 files changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 199e0db67962..277fcef656b8 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -14,6 +14,8 @@ CFLAGS_REMOVE_helpers.o = -Wmissing-prototypes -Wmissing-declarations
>  always-$(CONFIG_RUST) += libmacros.so
>  no-clean-files += libmacros.so
>  
> +always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/arch_static_branch_asm.rs
> +
>  always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
>  obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
>  always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
> @@ -409,7 +411,8 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
>  $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
>      --extern build_error --extern macros --extern bindings --extern uapi
>  $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
> -    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
> +    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o \
> +	$(obj)/kernel/arch_static_branch_asm.rs FORCE
>  	+$(call if_changed_rule,rustc_library)
>  
>  endif # CONFIG_RUST
> diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
> new file mode 100644
> index 000000000000..d082731007c6
> --- /dev/null
> +++ b/rust/kernel/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +/arch_static_branch_asm.rs
> diff --git a/rust/kernel/arch_static_branch_asm.rs.S b/rust/kernel/arch_static_branch_asm.rs.S
> new file mode 100644
> index 000000000000..9e373d4f7567
> --- /dev/null
> +++ b/rust/kernel/arch_static_branch_asm.rs.S
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/jump_label.h>
> +
> +// Cut here.
> +
> +::kernel::concat_literals!(ARCH_STATIC_BRANCH_ASM("{symb} + {off} + {branch}", "{l_yes}"))
> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> index 011e1fc1d19a..7757e4f8e85e 100644
> --- a/rust/kernel/jump_label.rs
> +++ b/rust/kernel/jump_label.rs
> @@ -23,7 +23,69 @@ macro_rules! static_key_false {
>          let _key: *const $keytyp = ::core::ptr::addr_of!($key);
>          let _key: *const $crate::bindings::static_key = ::core::ptr::addr_of!((*_key).$field);
>  
> -        $crate::bindings::static_key_count(_key.cast_mut()) > 0
> +        #[cfg(not(CONFIG_JUMP_LABEL))]
> +        {
> +            $crate::bindings::static_key_count(_key.cast_mut()) > 0
> +        }
> +
> +        #[cfg(CONFIG_JUMP_LABEL)]
> +        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
>      }};
>  }
>  pub use static_key_false;
> +
> +/// Assert that the assembly block evaluates to a string literal.
> +#[cfg(CONFIG_JUMP_LABEL)]
> +const _: &str = include!("arch_static_branch_asm.rs");

Have you try this with "make O=<dir>"? I hit the following issue, but I
am rebasing on rust-dev, so I might miss something:

	error: couldn't read ../rust/kernel/arch_static_branch_asm.rs: No such file or directory (os error 2)
	  --> ../rust/kernel/jump_label.rs:39:17
	   |
	39 | const _: &str = include!("arch_static_branch_asm.rs");
	   |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	   |
	   = note: this error originates in the macro `include` (in Nightly builds, run with -Z macro-backtrace for more info)

	error: aborting due to 1 previous error	

Regards,
Boqun

> +
> +#[macro_export]
> +#[doc(hidden)]
> +#[cfg(CONFIG_JUMP_LABEL)]
> +#[cfg(not(CONFIG_HAVE_JUMP_LABEL_HACK))]
> +macro_rules! arch_static_branch {
> +    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
> +        $crate::asm!(
> +            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
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
> +            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
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
> +}
> +
> +#[cfg(CONFIG_JUMP_LABEL)]
> +pub use arch_static_branch;
> +
> +/// A helper used by inline assembly to pass a boolean to as a `const` parameter.
> +///
> +/// Using this function instead of a cast lets you assert that the input is a boolean, and not some
> +/// other type that can also be cast to an integer.
> +#[doc(hidden)]
> +pub const fn bool_to_int(b: bool) -> i32 {
> +    b as i32
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index d00a44b000b6..9e9b95ab6966 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -145,3 +145,33 @@ macro_rules! container_of {
>          ptr.sub(offset) as *const $type
>      }}
>  }
> +
> +/// Helper for `.rs.S` files.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! concat_literals {
> +    ($( $asm:literal )* ) => {
> +        ::core::concat!($($asm),*)
> +    };
> +}
> +
> +/// Wrapper around `asm!` that uses at&t syntax on x86.
> +// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
> +// syntax.
> +#[cfg(target_arch = "x86_64")]
> +#[macro_export]
> +macro_rules! asm {
> +    ($($asm:expr),* ; $($rest:tt)*) => {
> +        ::core::arch::asm!( $($asm)*, options(att_syntax), $($rest)* )
> +    };
> +}
> +
> +/// Wrapper around `asm!` that uses at&t syntax on x86.
> +// For non-x86 arches we just pass through to `asm!`.
> +#[cfg(not(target_arch = "x86_64"))]
> +#[macro_export]
> +macro_rules! asm {
> +    ($($asm:expr),* ; $($rest:tt)*) => {
> +        ::core::arch::asm!( $($asm)*, $($rest)* )
> +    };
> +}
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 72b1232b1f7d..59fe83fba647 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -263,12 +263,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
>  
> -rust_allowed_features := new_uninit
> +rust_allowed_features := asm_const,asm_goto,new_uninit
>  
>  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
>  # current working directory, which may be not accessible in the out-of-tree
>  # modules case.
>  rust_common_cmd = \
> +	SRCTREE=$(abspath $(srctree)) \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
>  	-Zallow-features=$(rust_allowed_features) \
>  	-Zcrate-attr=no_std \
> @@ -318,6 +319,12 @@ quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>  $(obj)/%.ll: $(obj)/%.rs FORCE
>  	+$(call if_changed_dep,rustc_ll_rs)
>  
> +quiet_cmd_rustc_rs_rs_S = RSCPP $(quiet_modtag) $@
> +      cmd_rustc_rs_rs_S = $(CPP) $(c_flags) -xc -C -P $< | sed '1,/^\/\/ Cut here.$$/d' >$@
> +
> +$(obj)/%.rs: $(obj)/%.rs.S FORCE
> +	+$(call if_changed_dep,rustc_rs_rs_S)
> +
>  # Compile assembler sources (.S)
>  # ---------------------------------------------------------------------------
>  
> 
> -- 
> 2.46.0.184.g6999bdac58-goog
> 

