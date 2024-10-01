Return-Path: <linux-arch+bounces-7520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D153A98BF6B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4D1F21994
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051641C8FC5;
	Tue,  1 Oct 2024 14:11:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BF1C6F53;
	Tue,  1 Oct 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791878; cv=none; b=Y7RHFOA+7q6bXb+oFiCl6//Qj6N/C2a27FKhhZh1opo0pEc7czgW4Q5bADwhk0ls40w6jttNSPsaWRZto+GUUa9Q191/eefzE+lTImV4iqbaRX+W16YR5wKPAm+gMgNA6E5Uj8k/nz/Vv7/dOuQieqK5HIcvr5mL/WfkM1t3nmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791878; c=relaxed/simple;
	bh=XLnLMLvJXoviHxYWl7YAmckLFdggOgG+MZ4GrqQT5P4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7kywNc97Flqe9j7LXgkyg06hbLCWo/LXNsM634uOsxLVdg4Cob6jcr0fmCNKAR1psLsnq7yGivFzESFfzTP0e0B/mu6u+3BlWSgHWU3GdmFWrx0MS62t6NKhQeuPLJtmxj9iaIODI3Orqz/zOgkJwkgrDuFpkPqc9j/cb3i45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C885C4CEC6;
	Tue,  1 Oct 2024 14:11:12 +0000 (UTC)
Date: Tue, 1 Oct 2024 10:12:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard
 Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak
 <ubizjak@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-arm-kernel@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Conor
 Dooley <conor.dooley@microchip.com>, Samuel Holland
 <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao
 <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v9 1/5] rust: add generic static_key_false
Message-ID: <20241001101201.7a43726d@gandalf.local.home>
In-Reply-To: <20241001-tracepoint-v9-1-1ad3b7d78acb@google.com>
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
	<20241001-tracepoint-v9-1-1ad3b7d78acb@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Oct 2024 13:29:58 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
> 
> This patch only provides a generic implementation without code patching
> (matching the one used when CONFIG_JUMP_LABEL is disabled). Later
> patches add support for inline asm implementations that use runtime
> patching.
> 
> When CONFIG_JUMP_LABEL is unset, `static_key_count` is a static inline
> function, so a Rust helper is defined for `static_key_count` in this
> case. If Rust is compiled with LTO, this call should get inlined. The
> helper can be eliminated once we have the necessary inline asm to make
> atomic operations from Rust.
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/helpers.c          |  1 +
>  rust/helpers/jump_label.c       | 15 +++++++++++++++
>  rust/kernel/jump_label.rs       | 29 +++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +
>  5 files changed, 47 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..e0846e7e93e6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -14,6 +14,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/firmware.h>
>  #include <linux/jiffies.h>
> +#include <linux/jump_label.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
>  #include <linux/refcount.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..17e1b60d178f 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -12,6 +12,7 @@
>  #include "build_assert.c"
>  #include "build_bug.c"
>  #include "err.c"
> +#include "jump_label.c"
>  #include "kunit.c"
>  #include "mutex.c"
>  #include "page.c"
> diff --git a/rust/helpers/jump_label.c b/rust/helpers/jump_label.c
> new file mode 100644
> index 000000000000..0e9ed15903f6
> --- /dev/null
> +++ b/rust/helpers/jump_label.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2024 Google LLC.
> + */
> +
> +#include <linux/jump_label.h>
> + 

Nit, the above line has a spurious space.

-- Steve


> +#ifndef CONFIG_JUMP_LABEL
> +int rust_helper_static_key_count(struct static_key *key)
> +{
> +       return static_key_count(key);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_static_key_count);
> +#endif
> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> new file mode 100644

