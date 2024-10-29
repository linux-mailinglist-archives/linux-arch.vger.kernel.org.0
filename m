Return-Path: <linux-arch+bounces-8688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C959B5151
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C70281A9E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6261DB349;
	Tue, 29 Oct 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/iLY1sG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDDBE49;
	Tue, 29 Oct 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224245; cv=none; b=jSoJPxvHQSoX9dHvPVmEm1m/4Je2frbk4pKP3bY4s85qFdcDbeFmUrUvXpQPZpAfTycTKBtrb2E8gX41vaOOyCVWZ1MMv0kGuuNQkkG5Y6vOZSu1F4U6GCaThIA1n7bWExWXkP6qd5ka39QDBNGYhEcnilyJY5gFVlSA1TN7x8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224245; c=relaxed/simple;
	bh=3Ya/vna/josXfaP08+rZliV3Vbn6Ymxerk6FxliU00o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5fmA/vivV5OJR/WTodPId3ngn1XnZSDK2qNicjDwqsSs6SBjNEjOVun9JsN9MjXOVIZ/NRIr+UlBSaMtMUe38AS8y7ulkT02SRn2ER79pxzet1hmInfq88I8auGCGI6AKjSdK7Vcce5AjlbIkK3nsl/kMSNEvQyd3HQZQVxI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/iLY1sG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b14554468fso426553885a.1;
        Tue, 29 Oct 2024 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730224242; x=1730829042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK/pLK7S1V1t6tuat6FFIn60WJ4TxvUKBBBCYp6IBH8=;
        b=H/iLY1sGVq7BXbsUAQJa18NOoGtNgNev2tReGwqbyxPwInfb7s7Nh2cZS2DtJDcuiJ
         lLAuEpArxeJe9H5Q2+liC5kfVNzgbh8NadT2AjCAQ+qqCFOpvRTB5044E8skqez2B3Rw
         mxRLwces4rcHkbDy86QCEfCZivFLAwsO12EO0VXMLGyMmVdT4AJCWh0zj5P56r+Rm4xA
         hKCOYPhBF9TNBbcJnGGP1+C1XX/nggQy0qVcb8nL884Zpyfq7YDB6Dbdnt3Kc8mYzGG4
         gOvPXTDsw1o2zjmXEyhQKpVs2Vrtu8bXAacoX6+yz2u6ywlYnAofRJ/KECVjTNoc8SAh
         GWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224242; x=1730829042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK/pLK7S1V1t6tuat6FFIn60WJ4TxvUKBBBCYp6IBH8=;
        b=lScCZv5D7dRE0prJlvZGflz6sMMbe345AlzYSk8pDf5vJR2qUC11fOHaABt/UE8v3M
         LkTOrRIyEhamk3D+RDo2FJEP6qQVwL/MtJXyPv2CT9K9Za1MjmHRqUTf56FBhM8o4HXw
         JQPEHxFO5cln33kCEMTDGjL6U5BxyXpSkrizHf7Vk3Ijqsmye33jpKf7OlKy1/e/8JKA
         cPEudGuLvGB6FvoNlDWv3jBizCgy0NKjlsetpT2zuwaj0/Gc1b/lXp7RfJBYU5hgwoia
         ttkU6h1KpCl3GuEh/GM76PI6p4lmrZ2wdvb3CyrYAgI8SXC+ZY3kyZlftjTAm3aynZz/
         lqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk+tk6EhoLw837DWzQrzIcaN32J6WaHJrZhk2M3qjU9XIcosDWVf4UBGOMan6Tr/9aLoPvRSBR1YGXSCIc/MpH4ZVK@vger.kernel.org, AJvYcCXSRAbNakUSq7WcbZIiXsL4oN8AmlQw/AZ79oWZRlU8mTewGHtO7o84dROVkFtrot+OG8FR35fBXMl7@vger.kernel.org, AJvYcCXTHBe7XMi6ucYaGlB9/1oPddRwzVuBOLdu2h7W1+1YYuXb4vqDsPlE5EH8FX6veLQFmBwjUR9x7LgZxbFI@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3qxlDo89tFHa0ABZ+ZRhk7kbMsDdXVM+je4VFkTj/hLPYfpL
	j2T5Rk5LnBU2hqbUhiQzso3XceDoA698s7fMx7D2mo+QGjTCDUMC
X-Google-Smtp-Source: AGHT+IFGMVOBqxcUtZ7Un1nNcyqmn8u2lqCn/vEwPQlMDhoDECiVmLIANcB5IXjL+WWmWp1X0e6goQ==
X-Received: by 2002:a05:6214:4603:b0:6cd:6ad4:1fc9 with SMTP id 6a1803df08f44-6d18585e11emr174482126d6.44.1730224242073;
        Tue, 29 Oct 2024 10:50:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a565f4sm43845056d6.138.2024.10.29.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:50:41 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id AE8D6120006A;
	Tue, 29 Oct 2024 13:50:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 29 Oct 2024 13:50:40 -0400
X-ME-Sender: <xms:cCAhZ5TRRj75IS2Tzjtu63aZzV9zDi1UeLbOZ6_hFfDk7T8qW6AVhg>
    <xme:cCAhZyxQ2PjsZEtNAV0l77rOvuexoFa8akCFADoXqh3RrCMgjGsi0uyAC3xsAL-fn
    RK0gk0-jNsrBOCM1w>
X-ME-Received: <xmr:cCAhZ-0CElQ-ri8IF4FVpuuH9UQmaVHSKBH2w8fJa68UhMEBscThH-OD4OE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeelgeffvdelgedtgeetfeejvdeiueetueev
    gffghfejieeuhfefvedtgffgfeeunecuffhomhgrihhnpehrshdrshgsnecuvehluhhsth
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
X-ME-Proxy: <xmx:cCAhZxCZq3d0UKYNwzqPWrFaA9y-XTAHxm_9BJmjE_XYMRQTg1ygdQ>
    <xmx:cCAhZyhQmFYGDivfUtONNKb8UmOZ0MNrQs5cpxin0J_THuilmJtVpQ>
    <xmx:cCAhZ1qtpMwug643Rt8r_Lup_7vByNKCy-1SOxkaayjBBdtdsyEm6w>
    <xmx:cCAhZ9g8cmPze38Y9VJbL-e8QyQcfXE1cHAdxasFa5rjtWUp949vpQ>
    <xmx:cCAhZ9TEHmr0HPX_vPEOyHq3JSpvWEm8sDab7uXAAslSI5xYvxNgHwSP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 13:50:39 -0400 (EDT)
Date: Tue, 29 Oct 2024 10:50:38 -0700
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
	Andreas Hindborg <a.hindborg@kernel.org>,
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
Subject: Re: [PATCH v11 5/5] rust: add arch_static_branch
Message-ID: <ZyEgbhWdFa66p-G3@Boquns-Mac-mini.local>
References: <20241015-tracepoint-v11-0-cceb65820089@google.com>
 <20241015-tracepoint-v11-5-cceb65820089@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-tracepoint-v11-5-cceb65820089@google.com>

On Tue, Oct 15, 2024 at 01:14:59PM +0000, Alice Ryhl wrote:
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
>  rust/Makefile                           |  6 +++++
>  rust/kernel/.gitignore                  |  3 +++
>  rust/kernel/arch_static_branch_asm.rs.S |  7 +++++
>  rust/kernel/jump_label.rs               | 46 ++++++++++++++++++++++++++++++++-
>  rust/kernel/lib.rs                      | 35 +++++++++++++++++++++++++
>  scripts/Makefile.build                  |  9 ++++++-
>  6 files changed, 104 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index b5e0a73b78f3..c532f48b79de 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -36,6 +36,8 @@ always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
>  obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.o
>  obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
>  
> +always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/arch_static_branch_asm.rs
> +
>  # Avoids running `$(RUSTC)` for the sysroot when it may not be available.
>  ifdef CONFIG_RUST
>  
> @@ -424,4 +426,8 @@ $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
>      $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
>  	+$(call if_changed_rule,rustc_library)
>  
> +ifneq ($(CONFIG_JUMP_LABEL),)
> +$(obj)/kernel.o: $(obj)/kernel/arch_static_branch_asm.rs
> +endif
> +
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
> index 000000000000..2afb638708db
> --- /dev/null
> +++ b/rust/kernel/arch_static_branch_asm.rs.S
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/jump_label.h>
> +
> +// Cut here.
> +
> +::kernel::concat_literals!(ARCH_STATIC_BRANCH_ASM("{symb} + {off} + {branch}", "{l_yes}"))
> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> index 4b7655b2a022..2f2df03a3275 100644
> --- a/rust/kernel/jump_label.rs
> +++ b/rust/kernel/jump_label.rs
> @@ -24,7 +24,51 @@ macro_rules! static_branch_unlikely {
>          let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
>          let _key: *const $crate::bindings::static_key = _key.cast();
>  
> -        $crate::bindings::static_key_count(_key.cast_mut()) > 0
> +        #[cfg(not(CONFIG_JUMP_LABEL))]
> +        {
> +            $crate::bindings::static_key_count(_key) > 0
> +        }
> +
> +        #[cfg(CONFIG_JUMP_LABEL)]
> +        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
>      }};
>  }
>  pub use static_branch_unlikely;
> +
> +/// Assert that the assembly block evaluates to a string literal.
> +#[cfg(CONFIG_JUMP_LABEL)]
> +const _: &str = include!(concat!(
> +    env!("OBJTREE"),
> +    "/rust/kernel/arch_static_branch_asm.rs"
> +));
> +
> +#[macro_export]
> +#[doc(hidden)]
> +#[cfg(CONFIG_JUMP_LABEL)]
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
> index 55f81f49024e..c0ae9ddd9468 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -148,3 +148,38 @@ macro_rules! container_of {
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
> +/// Wrapper around `asm!` configured for use in the kernel.
> +///
> +/// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
> +/// syntax.
> +// For x86, `asm!` uses intel syntax by default, but we want to use at&t syntax in the kernel.
> +#[cfg(target_arch = "x86_64")]

This should be:

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]

for future proofing and um (usermode linux) support.

> +#[macro_export]
> +macro_rules! asm {
> +    ($($asm:expr),* ; $($rest:tt)*) => {
> +        ::core::arch::asm!( $($asm)*, options(att_syntax), $($rest)* )
> +    };
> +}
> +
> +/// Wrapper around `asm!` configured for use in the kernel.
> +///
> +/// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
> +/// syntax.
> +// For non-x86 arches we just pass through to `asm!`.
> +#[cfg(not(target_arch = "x86_64"))]

Ditto.

With these fixed, feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +#[macro_export]
> +macro_rules! asm {
> +    ($($asm:expr),* ; $($rest:tt)*) => {
> +        ::core::arch::asm!( $($asm)*, $($rest)* )
> +    };
> +}
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 8f423a1faf50..03ee558fcd4d 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -248,12 +248,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
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
> +	OBJTREE=$(abspath $(objtree)) \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
>  	-Zallow-features=$(rust_allowed_features) \
>  	-Zcrate-attr=no_std \
> @@ -303,6 +304,12 @@ quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
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
> 2.47.0.rc1.288.g06298d1525-goog
> 

