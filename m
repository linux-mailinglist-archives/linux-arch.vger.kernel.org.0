Return-Path: <linux-arch+bounces-6531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668895B8BE
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2250B25EE9
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490031CC15B;
	Thu, 22 Aug 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS2b8Fii"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD61C9DFF;
	Thu, 22 Aug 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337505; cv=none; b=EmoyN/ltQ013JnWgr4srITZYqqSIxFbCIWDjI/ENUwJtn/9kgK//10XeG0TOjytz0Hr5oTLRPUIMZSBatQJe4LLAlsnWJg632uDPf4oBABPQvl20DyokaKd9/R/BAazGJ7fh5dhoetJmTC6gVr/SKjT89WgmMJbaqbY8f2farfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337505; c=relaxed/simple;
	bh=9gore8kOVGgYcBY8Kxe0Jf4tMk0BkXzHpIkh18lmmLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U210RSgWUlYbcNl/QlbCAXg+iU+3lt713A6UQQ8sJswd3jkt3tJ8bVlBMSNpalrb3oKuvCjd2NF50rgYlU0yCK9rU822ZdHD9MGigs20655+VR+7DthNAxeMs5fC2TzIG3qB7OdsDWKPKPXGdbQ0/WUXoMeKX8/872xyJhY8c5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS2b8Fii; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a4df9dc840so52155085a.2;
        Thu, 22 Aug 2024 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724337502; x=1724942302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as3zLpP+ypLOVnuaFbYC0lf0eOdREEs1DY49MjXOZrs=;
        b=aS2b8FiiwG0g36FFo1974xAhhAHqAQQesgA6PQDDM92Ro0bedGfeqHW2R5zKQoWIHn
         j4XTAUu77xFPAKvDn8KkPyyFIcM1081yt8niEq/cW+jbCdnpYNcsytJ4xKcPaE8/97x6
         7A/MzqNv0d03/GPUauIdQiWDqA5uM6cOY+KsNcH/ltOp0WzuIDYsViQtE5SC/Dm1AhD0
         Y5Csq4CoAXrUvZ2YtGnfwExgL4A2fc+pMtuQZJsCqkQpunSBlNx60br4vHJlVV7WSNKZ
         GYBp3F5JIi388l0I1rPZ3Q/zZh5O34QYAj3Jw83pGzzBpP++O160Ke11LkR2M6gpCCyq
         P4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337502; x=1724942302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as3zLpP+ypLOVnuaFbYC0lf0eOdREEs1DY49MjXOZrs=;
        b=oGksGDOwV1PsAjuIGcS6J/7VPBXrFz2gQMXXNiwqEi1JBSe3NgTPBpnSEowr+MIhrq
         b/JP22HpFyK/41PuFPWeVvZkaA8J9bDJhy9QBtFjey028pyfVXIOmGAdjiNkMP4PG2xf
         sstULuaM1zB290JtAaA9Fxbt/WBt8XdZeoxeF7toWfdNv5db4AicodbH7WthQ9qcNB2N
         qgFpMdTi2G2Fhbd2kVM7mvQcH8tKMKG4SZtz0BwrbpWlF7QMMeQhv2juPWv5lbT8acPO
         3v8f3StA4BTfjnbpmHk6ah3FkDMgUGGxYZ+hCsEoiriOq0CrR9hu2Z1O7wxB3uViTa7o
         u+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWem5wUOTKNdG8kJfcRUrk69vAHs/19glr9R0wSY8ExFwoNRApoghp69LOyw1ie03JGNyIYRfs913wFbbvn@vger.kernel.org, AJvYcCXVtMCULZYEeucznMPbGAbVaDju0G0Va/908U03Zq0tRpgkVfrByo+cX9IWnhaih4nosn5If/FpSAb7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpnii3ZnAPMUoRd6P74I+jeBKKnwfvYOCT3RNtwHa8eLbdkYxO
	5VBX06LJX20IlhGZeQjRXN+VMaY5aPFPzSL2eTjI1O0wWN58GZ+O
X-Google-Smtp-Source: AGHT+IGHKAz0cDx9YYukajphluySKz9oqfl1AgEwpqBpNV/QBSal2NixrEBUNudaTlOlqfVhKnGlGA==
X-Received: by 2002:a05:620a:2403:b0:7a3:5004:43dc with SMTP id af79cd13be357-7a67490c94dmr644776585a.40.1724337502335;
        Thu, 22 Aug 2024 07:38:22 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb1a9sm74722285a.75.2024.08.22.07.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:38:22 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1E339120006A;
	Thu, 22 Aug 2024 10:38:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 10:38:20 -0400
X-ME-Sender: <xms:W03HZgAVqETYrm2sklYPOy12UyZ3-XdbZ22P7ahQeBxX18CA8L7iAA>
    <xme:W03HZigNZeIrlbZnJab5BlEscW6EfQGry1sN8Z09GvcSzRIQhKJpWH2eg6wr8i6Xo
    CVniNOTQOr74whZ8Q>
X-ME-Received: <xmr:W03HZjniGPf4oZLxzv1hUuuDXc25Ecp6zCNFGVt-7eUyaGV_aCY-88jICeHMzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthht
    ohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivg
    hurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehpvght
    vghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjphhoihhmsghovgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdp
    rhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W03HZmz0RtCHvRdvvXhdHK6CiBfNaoKMqVWSyXRGzdy2hGudUXwXoA>
    <xmx:XE3HZlTeoqW4ASRM93Fuf6EcaxoPJZDQw4l0yazWG2D0fH-CwPClkg>
    <xmx:XE3HZha-bijkYnGhZ4anF7oaQnj_Yj5ncHajXmz-kW6koLOc61Bm0w>
    <xmx:XE3HZuRE1Hh1EnpcXCfQ5Zdts5zpUvsDto-1ZyijvD61Fs_FwBwGWw>
    <xmx:XE3HZvD5JmuiBQRsCOSO6nYxi0ejgFjW5kNdsVSKH6_WoBFSLWJDzeHx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 10:38:19 -0400 (EDT)
Date: Thu, 22 Aug 2024 07:38:10 -0700
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
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev,
	Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH v8 2/5] rust: add tracepoint support
Message-ID: <ZsdNUofUSSNv9jTR@boqun-archlinux>
References: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
 <20240822-tracepoint-v8-2-f0c5899e6fd3@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-tracepoint-v8-2-f0c5899e6fd3@google.com>

On Thu, Aug 22, 2024 at 12:04:14PM +0000, Alice Ryhl wrote:
> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
> 
> Instead of calling __DO_TRACE directly, the exported rust_do_trace_
> function calls an inline helper function. This is because the `cond`
> argument does not exist at the callsite of DEFINE_RUST_DO_TRACE.
> 
> __DECLARE_TRACE always emits an inline static and an extern declaration
> that is only used when CREATE_RUST_TRACE_POINTS is set. These should not
> end up in the final binary so it is not a problem that they sometimes
> are emitted without a user.
> 
> Reviewed-by: Carlos Llamas <cmllamas@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  include/linux/tracepoint.h      | 22 +++++++++++++++++-
>  include/trace/define_trace.h    | 12 ++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 49 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 6be396bb4297..5042ca588e41 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -237,6 +237,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)
>  #endif
>  
> +/*
> + * Declare an exported function that Rust code can call to trigger this
> + * tracepoint. This function does not include the static branch; that is done
> + * in Rust to avoid a function call when the tracepoint is disabled.
> + */
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#define __DEFINE_RUST_DO_TRACE(name, proto, args)			\
> +	notrace void rust_do_trace_##name(proto)			\
> +	{								\
> +		__rust_do_trace_##name(args);				\
> +	}
> +
>  /*
>   * Make sure the alignment of the structure in the __tracepoints section will
>   * not add unwanted padding between the beginning of the section and the
> @@ -252,6 +264,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	extern int __traceiter_##name(data_proto);			\
>  	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
>  	extern struct tracepoint __tracepoint_##name;			\
> +	extern void rust_do_trace_##name(proto);			\
> +	static inline void __rust_do_trace_##name(proto)		\
> +	{								\
> +		__DO_TRACE(name,					\
> +			TP_ARGS(args),					\
> +			TP_CONDITION(cond), 0);				\
> +	}								\
>  	static inline void trace_##name(proto)				\
>  	{								\
>  		if (static_key_false(&__tracepoint_##name.key))		\
> @@ -336,7 +355,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	void __probestub_##_name(void *__data, proto)			\
>  	{								\
>  	}								\
> -	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> +	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
> +	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
>  
>  #define DEFINE_TRACE(name, proto, args)		\
>  	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index 00723935dcc7..8159294c2041 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -72,6 +72,13 @@
>  #define DECLARE_TRACE(name, proto, args)	\
>  	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>  
> +/* If requested, create helpers for calling these tracepoints from Rust. */
> +#ifdef CREATE_RUST_TRACE_POINTS
> +#undef DEFINE_RUST_DO_TRACE
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)	\
> +	__DEFINE_RUST_DO_TRACE(name, PARAMS(proto), PARAMS(args))
> +#endif
> +
>  #undef TRACE_INCLUDE
>  #undef __TRACE_INCLUDE
>  
> @@ -129,6 +136,11 @@
>  # undef UNDEF_TRACE_INCLUDE_PATH
>  #endif
>  
> +#ifdef CREATE_RUST_TRACE_POINTS
> +# undef DEFINE_RUST_DO_TRACE
> +# define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#endif
> +
>  /* We may be processing more files */
>  #define CREATE_TRACE_POINTS
>  
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 8fd092e1b809..fc6f94729789 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -20,6 +20,7 @@
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> +#include <linux/tracepoint.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 91af9f75d121..d00a44b000b6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -51,6 +51,7 @@
>  pub mod sync;
>  pub mod task;
>  pub mod time;
> +pub mod tracepoint;
>  pub mod types;
>  pub mod uaccess;
>  pub mod workqueue;
> diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
> new file mode 100644
> index 000000000000..cf2d9ad15912
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
> +/// This macro generates an unsafe function that calls into C, and its safety requirements will be
> +/// whatever the relevant C code requires. To document these safety requirements, you may add
> +/// doc-comments when invoking the macro.
> +#[macro_export]
> +macro_rules! declare_trace {
> +    ($($(#[$attr:meta])* $pub:vis unsafe fn $name:ident($($argname:ident : $argtyp:ty),* $(,)?);)*) => {$(
> +        $( #[$attr] )*
> +        #[inline(always)]
> +        $pub unsafe fn $name($($argname : $argtyp),*) {
> +            #[cfg(CONFIG_TRACEPOINTS)]
> +            {
> +                // SAFETY: It's always okay to query the static key for a tracepoint.
> +                let should_trace = unsafe {
> +                    $crate::macros::paste! {
> +                        $crate::jump_label::static_key_false!(
> +                            $crate::bindings::[< __tracepoint_ $name >],
> +                            $crate::bindings::tracepoint,
> +                            key
> +                        )
> +                    }
> +                };
> +
> +                if should_trace {
> +                    $crate::macros::paste! {
> +                        // SAFETY: The caller guarantees that it is okay to call this tracepoint.
> +                        unsafe { $crate::bindings::[< rust_do_trace_ $name >]($($argname),*) };
> +                    }
> +                }
> +            }
> +
> +            #[cfg(not(CONFIG_TRACEPOINTS))]
> +            {
> +                // If tracepoints are disabled, insert a trivial use of each argument
> +                // to avoid unused argument warnings.
> +                $( let _unused = $argname; )*
> +            }
> +        }
> +    )*}
> +}
> +
> +pub use declare_trace;
> 
> -- 
> 2.46.0.184.g6999bdac58-goog
> 

