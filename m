Return-Path: <linux-arch+bounces-7512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773098BD29
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75518B230E1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981731C3304;
	Tue,  1 Oct 2024 13:14:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F529EEC5;
	Tue,  1 Oct 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788484; cv=none; b=nczEXTuSLrxgJSX+NrKF/cqOgSuf4t7eupV5K0OX0KxiE8OACt/tHp5M9KssyrCvXhnBc40dosHBJKku5BRK+7MlGGIEglFw3fisf4uwzEvn3/DzdOF5Vccg1btplTS9XIOa9rsBG24auPvuCbFzoRa1bNXHkVVeTQh2kTJ/Cp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788484; c=relaxed/simple;
	bh=oyGA8rO9KmQUz/TMGCoig5Jh+IEWCufzGTgu4HNGJyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMqQPseEhQWsLiZzSiKkztCW1Lput8u9fD8GH74/aMpUdtPMd+nAddlgZvMdYgGJ8zUseScOgCQ0kWasICqL2u2oSwg/WHmUVdHgeu3j1m5jPdsq1dyCqLyaVL1OMypVuyGQG3WMkRPd8FEGEJzsCSE1B0TiqR+9IRIKB+Pav4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6112CC4CEC6;
	Tue,  1 Oct 2024 13:14:38 +0000 (UTC)
Date: Tue, 1 Oct 2024 09:15:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard
 Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
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
 loongarch@lists.linux.dev, Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH v8 0/5] Tracepoints and static branch in Rust
Message-ID: <20241001091527.2fe4e039@gandalf.local.home>
In-Reply-To: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
References: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Alice,

Can you rebase this series on v6.12-rc1?

Thanks,

-- Steve


On Thu, 22 Aug 2024 12:04:12 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> An important part of a production ready Linux kernel driver is
> tracepoints. So to write production ready Linux kernel drivers in Rust,
> we must be able to call tracepoints from Rust code. This patch series
> adds support for calling tracepoints declared in C from Rust.
> 
> This series includes a patch that adds a user of tracepoits to the
> rust_print sample. Please see that sample for details on what is needed
> to use this feature in Rust code.
> 
> This is intended for use in the Rust Binder driver, which was originally
> sent as an RFC [1]. The RFC did not include tracepoint support, but you
> can see how it will be used in Rust Binder at [2]. The author has
> verified that the tracepoint support works on Android devices.
> 
> This implementation implements support for static keys in Rust so that
> the actual static branch happens in the Rust object file. However, the
> __DO_TRACE body remains in C code. See v1 for an implementation where
> __DO_TRACE is also implemented in Rust.
> 
> When compiling for x86, this patchset has a dependency on [3] as we need
> objtool to convert jmp instructions to nop instructions. This patchset
> is based on top of the series containing [3].
> 
> There is also a conflict with splitting up the C helpers [4]. I've
> included an alternate version of the first patch that shows how to
> resolve the conflict. When using the alternate version of the first
> patch, this series applies cleanly on top of rust-next.
> 
> Both [3] and [4] are already in rust-next.
> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
> Link: https://r.android.com/3119993 [2]
> Link: https://lore.kernel.org/all/20240725183325.122827-7-ojeda@kernel.org/ [3]
> Link: https://lore.kernel.org/all/20240815103016.2771842-1-nmi@metaspace.dk/ [4]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v8:
> - Use OBJTREE instead of SRCTREE for temporary asm file.
> - Adjust comments on `asm!` wrapper to be less confusing.
> - Include resolution of conflict with helpers splitting.
> - Link to v7: https://lore.kernel.org/r/20240816-tracepoint-v7-0-d609b916b819@google.com
> 
> Changes in v7:
> - Fix spurious file included in first patch.
> - Fix issue with riscv asm.
> - Fix tags on fourth patch to match fifth patch.
> - Add Reviewed-by/Acked-by tags where appropriate.
> - Link to v6: https://lore.kernel.org/r/20240808-tracepoint-v6-0-a23f800f1189@google.com
> 
> Changes in v6:
> - Add support for !CONFIG_JUMP_LABEL.
> - Add tracepoint to rust_print sample.
> - Deduplicate inline asm.
> - Require unsafe inside `declare_trace!`.
> - Fix bug on x86 due to use of intel syntax.
> - Link to v5: https://lore.kernel.org/r/20240802-tracepoint-v5-0-faa164494dcb@google.com
> 
> Changes in v5:
> - Update first patch regarding inline asm duplication.
> - Add __rust_do_trace helper to support conditions.
> - Rename DEFINE_RUST_DO_TRACE_REAL to __DEFINE_RUST_DO_TRACE.
> - Get rid of glob-import in tracepoint macro.
> - Address safety requirements on tracepoints in docs.
> - Link to v4: https://lore.kernel.org/rust-for-linux/20240628-tracepoint-v4-0-353d523a9c15@google.com
> 
> Changes in v4:
> - Move arch-specific code into rust/kernel/arch.
> - Restore DEFINE_RUST_DO_TRACE at end of define_trace.h
> - Link to v3: https://lore.kernel.org/r/20240621-tracepoint-v3-0-9e44eeea2b85@google.com
> 
> Changes in v3:
> - Support for Rust static_key on loongarch64 and riscv64.
> - Avoid failing compilation on architectures that are missing Rust
>   static_key support when the archtectures does not actually use it.
> - Link to v2: https://lore.kernel.org/r/20240610-tracepoint-v2-0-faebad81b355@google.com
> 
> Changes in v2:
> - Call into C code for __DO_TRACE.
> - Drop static_call patch, as it is no longer needed.
> - Link to v1: https://lore.kernel.org/r/20240606-tracepoint-v1-0-6551627bf51b@google.com
> 
> ---
> Alice Ryhl (5):
>       rust: add generic static_key_false
>       rust: add tracepoint support
>       rust: samples: add tracepoint to Rust sample
>       jump_label: adjust inline asm to be consistent
>       rust: add arch_static_branch
> 
>  MAINTAINERS                             |  1 +
>  arch/arm/include/asm/jump_label.h       | 14 +++--
>  arch/arm64/include/asm/jump_label.h     | 20 +++++---
>  arch/loongarch/include/asm/jump_label.h | 16 +++---
>  arch/riscv/include/asm/jump_label.h     | 50 ++++++++++--------
>  arch/x86/include/asm/jump_label.h       | 38 ++++++--------
>  include/linux/tracepoint.h              | 22 +++++++-
>  include/trace/define_trace.h            | 12 +++++
>  include/trace/events/rust_sample.h      | 31 +++++++++++
>  rust/Makefile                           |  5 +-
>  rust/bindings/bindings_helper.h         |  3 ++
>  rust/helpers.c                          |  9 ++++
>  rust/kernel/.gitignore                  |  3 ++
>  rust/kernel/arch_static_branch_asm.rs.S |  7 +++
>  rust/kernel/jump_label.rs               | 91 +++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs                      | 37 ++++++++++++++
>  rust/kernel/tracepoint.rs               | 49 ++++++++++++++++++
>  samples/rust/Makefile                   |  3 +-
>  samples/rust/rust_print.rs              | 18 +++++++
>  samples/rust/rust_print_events.c        |  8 +++
>  scripts/Makefile.build                  |  9 +++-
>  21 files changed, 379 insertions(+), 67 deletions(-)
> ---
> base-commit: 88359b25b950670432ef1da4352eb6cc62e0fa9f
> change-id: 20240606-tracepoint-31e15b90e471
> 
> Best regards,


