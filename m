Return-Path: <linux-arch+bounces-6544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20395BCFD
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8ED1C230B4
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD01CEABD;
	Thu, 22 Aug 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzRsAv4S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACCD1CEAB6;
	Thu, 22 Aug 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347205; cv=none; b=baB8sWBF0DpXvDgbFiFCoGE3w4XrcMo8GFhqoFgR8KIi4Ly6VbYcxwtOlIg1IV8COogPi3uDFvQ7fqODiVKqQNrlnNSVxHDKg0Zo8jnH7dq6VL0XGFM62Md16pHoxBXWp1J+qRNx+dLFtT3HijOnEatj3GVL3prm/kgvTVg09nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347205; c=relaxed/simple;
	bh=W7laqQR01J0+tCeAIN5VCv+rD6TbdvCUIGpT5IBSgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap1pVb0XtmAj6VNihoAUISgYlE3Aov7fNzq69UH12uSYPe8gNKdxDOaTQtGKmvl7WwDySPg1iMtBennvqWkoEDYS9MvjYkUphYqauu9eyR0uRST6GNJCB9JA8NNSRW1u73V1J9Djbv8YzcxXUCTZnDAgjvbz0CDctE+W6xj1/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzRsAv4S; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d436c95fso66224085a.3;
        Thu, 22 Aug 2024 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724347202; x=1724952002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWNnN5Rt2dG30RvqrIIBZJm8x7pgPszO2KiXLf2qQpQ=;
        b=LzRsAv4SCaNjjmKSFbn7FgtXB5Q2vF9oVvSVzLsot2GENwzaphyM2opdYSDLt4UNph
         /igdhcV+fyRs3gyuNzWeh/pciQrEhb3L+X8Mdt4WNzCaSW+dDUbzI2bIx+ywuOYt8MJt
         oU4yJqJGCAqjf+88V/PMpU44RIRjNVjzcob1PTOEttYtjWSdIybzHoaRIxd2bkkyp6wM
         /unMCSYb41KtsYuZL9EKidlPkltyYxOHVS2FwsOYZc76KQRpQKE1idDBlN1KAJAlyxLm
         J0MY1P4jx8879dyKPIVpdgmk8/iUOh96pWaymzsRBl+Z5FYB2I6TUrRtkMKnyw3T5yvC
         iIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347202; x=1724952002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWNnN5Rt2dG30RvqrIIBZJm8x7pgPszO2KiXLf2qQpQ=;
        b=Coo7E3oAMyhRBzHwInxNDiaMkZrXhZ1Ce4CQYOxZmRTQUNwb2ofVl77KHnzNDNYto3
         kZ2nPXA625tLcnU8x1TqI8faTDUughz772ULcxSJwC3U49lkxBtE+MPJSLicswHsAe1e
         BqOiiuVAAN4FjwTbwgb+HL3Pprc499wzk0htuWzEsdtEzmaVg54I3L9gLBxx0XBKDR3N
         INnwatOU9qZ1XbPN8Idq7Dp99AVHUIun3yXAFkl9XnLrUMQrW6F35o2MzPuj5P/DxXV1
         8x/L1JmSNvaFGkTFMhy2sIV6Ey6sOzEoILZReqioM+389CXsra5lDfmWK0Ebhhxt4ZTE
         Vlwg==
X-Forwarded-Encrypted: i=1; AJvYcCUTDUorg7KrRE6cxduTM9np1r7g/t1d0HsvOcjxJE8c4a0IO1It6Mn4Ud/7FeACWoqTg4fdrsT66bTw490Z@vger.kernel.org, AJvYcCUeOLzPTXtnKXXlEoDaBSagiS+fSdwzLxIIoWC9HOWc7YzhrPVVoPhBVyj/SOJs/41X07VXpWSS9yHEpEwX1/ExHi9F@vger.kernel.org, AJvYcCWHufwHq7WzQTzNav1h/jxHoE/fPGTs73L5w/7Y60tUcoBMNoxAbessiJzobEU0oQZbPRk8PJIxAFIs@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnpR5OULHKdfWj4uR8KzzWMMNB4FhbOsc8Lo8dVOmTxQ02Ej4
	9S6UFlQ570YbklW5RZKWVgHYdASBjTAvNGSOfBXyvokVcSgXiQ+W
X-Google-Smtp-Source: AGHT+IG9h/7jpcanS4G8XArqKa6Zl87YJlLIIMDAoPD4/35CCz7tXpAyXVq1cMFdE9i97+v0hgP2wA==
X-Received: by 2002:a05:620a:2950:b0:7a1:c426:d875 with SMTP id af79cd13be357-7a680a852cbmr324679185a.39.1724347202022;
        Thu, 22 Aug 2024 10:20:02 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f343d3asm90720685a.48.2024.08.22.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:20:01 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A5462120006D;
	Thu, 22 Aug 2024 13:20:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 13:20:00 -0400
X-ME-Sender: <xms:QHPHZuvdcZkOuMuVQcWLJanx2eIOUancEWByPxv9_4dtKJOrkEUrdA>
    <xme:QHPHZje7dknB2f5NA7EaRg-qfduRUBifRgbvU321a8_Vq3MmiZngInru7wY5x5D9K
    XhAfsnqttUhyoBmwA>
X-ME-Received: <xmr:QHPHZpx41TMUNPUdwHiuRIPj3DUd9_tvcLu2xwRGsl3Q-YXJPrdpMcp2TqSzyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepueefleeufeefhfeljeejvdeuvdduhfdvhfdv
    teeludehteeghfdtieefudegjeefnecuffhomhgrihhnpeiiuhhlihhptghhrghtrdgtoh
    hmpdhruhhsthdqfhhorhdqlhhinhhugidrtghomhdpghhithhhuhgsrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeeh
    heehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmh
    gvpdhnsggprhgtphhtthhopeehfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhoshhtvgguth
    esghhoohgumhhishdrohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitg
    hiohhsrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepjhhpohhimhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QHPHZpPu85gNx2cWy4ND3x_J-by9eb6cniWBdJ9fgQT4QgA74oZMaQ>
    <xmx:QHPHZu9q_O0f6R9LIKNwIDhnLiWahJroKdp53DpW9ouVAMkfeMbGow>
    <xmx:QHPHZhXexnOd5t-CBGQ--_usreFIoCaZXFxnR_gx9xWUqdDIGrWSlA>
    <xmx:QHPHZnf-LFuNNC38Ac3SZlyHefUKGYnwzTUJlsQ_5sxQEOYyfVIIOA>
    <xmx:QHPHZocPLA_DqYk7kMsOhYYoqNJfRDurSDuMaQcktN-TX_6nzKT3dyEJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 13:19:59 -0400 (EDT)
Date: Thu, 22 Aug 2024 10:19:50 -0700
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
Subject: Re: [PATCH v8 3/5] rust: samples: add tracepoint to Rust sample
Message-ID: <ZsdzNqUuXSXaGZqt@boqun-archlinux>
References: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
 <20240822-tracepoint-v8-3-f0c5899e6fd3@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-tracepoint-v8-3-f0c5899e6fd3@google.com>

On Thu, Aug 22, 2024 at 12:04:15PM +0000, Alice Ryhl wrote:
> This updates the Rust printing sample to invoke a tracepoint. This
> ensures that we have a user in-tree from the get-go even though the
> patch is being merged before its real user.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  MAINTAINERS                        |  1 +
>  include/trace/events/rust_sample.h | 31 +++++++++++++++++++++++++++++++
>  rust/bindings/bindings_helper.h    |  1 +
>  samples/rust/Makefile              |  3 ++-
>  samples/rust/rust_print.rs         | 18 ++++++++++++++++++
>  samples/rust/rust_print_events.c   |  8 ++++++++
>  6 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f328373463b0..1acf5bfddfc4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19922,6 +19922,7 @@ C:	zulip://rust-for-linux.zulipchat.com
>  P:	https://rust-for-linux.com/contributing
>  T:	git https://github.com/Rust-for-Linux/linux.git rust-next
>  F:	Documentation/rust/
> +F:	include/trace/events/rust_sample.h
>  F:	rust/
>  F:	samples/rust/
>  F:	scripts/*rust*
> diff --git a/include/trace/events/rust_sample.h b/include/trace/events/rust_sample.h
> new file mode 100644
> index 000000000000..dbc80ca2e465
> --- /dev/null
> +++ b/include/trace/events/rust_sample.h

Is it possible to make this a header file inside sample/rust/? Given
this is just an example, I feel it's better if we could avoid making
this "public", but maybe I'm missing some constraints of tracepoints.

(Oh, I just remember the problem while I was writting this: we need the
header file here because this is now how bindgen generates bindings, so
moving it to sample/rust/ requires we have "per-module" or
"per-subsystem" bindgen feature)

Anyway this is not a big deal to me. We can move it later if possible.
So:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Tracepoints for `samples/rust/rust_print.rs`.
> + *
> + * Copyright (C) 2024 Google, Inc.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rust_sample
> +
> +#if !defined(_RUST_SAMPLE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _RUST_SAMPLE_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(rust_sample_loaded,
> +	TP_PROTO(int magic_number),
> +	TP_ARGS(magic_number),
> +	TP_STRUCT__entry(
> +		__field(int, magic_number)
> +	),
> +	TP_fast_assign(
> +		__entry->magic_number = magic_number;
> +	),
> +	TP_printk("magic=%d", __entry->magic_number)
> +);
> +
> +#endif /* _RUST_SAMPLE_TRACE_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index fc6f94729789..fe97256afe65 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -23,6 +23,7 @@
>  #include <linux/tracepoint.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> +#include <trace/events/rust_sample.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 03086dabbea4..f29280ec4820 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +ccflags-y += -I$(src)				# needed for trace events
>  
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> -obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> +obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o rust_print_events.o
>  
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> index 6eabb0d79ea3..6d14b08cac1c 100644
> --- a/samples/rust/rust_print.rs
> +++ b/samples/rust/rust_print.rs
> @@ -69,6 +69,8 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
>  
>          arc_print()?;
>  
> +        trace::trace_rust_sample_loaded(42);
> +
>          Ok(RustPrint)
>      }
>  }
> @@ -78,3 +80,19 @@ fn drop(&mut self) {
>          pr_info!("Rust printing macros sample (exit)\n");
>      }
>  }
> +
> +mod trace {
> +    use core::ffi::c_int;
> +
> +    kernel::declare_trace! {
> +        /// # Safety
> +        ///
> +        /// Always safe to call.
> +        unsafe fn rust_sample_loaded(magic: c_int);
> +    }
> +
> +    pub(crate) fn trace_rust_sample_loaded(magic: i32) {
> +        // SAFETY: Always safe to call.
> +        unsafe { rust_sample_loaded(magic as c_int) }
> +    }
> +}
> diff --git a/samples/rust/rust_print_events.c b/samples/rust/rust_print_events.c
> new file mode 100644
> index 000000000000..a9169ff0edf1
> --- /dev/null
> +++ b/samples/rust/rust_print_events.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Google LLC
> + */
> +
> +#define CREATE_TRACE_POINTS
> +#define CREATE_RUST_TRACE_POINTS
> +#include <trace/events/rust_sample.h>
> 
> -- 
> 2.46.0.184.g6999bdac58-goog
> 

