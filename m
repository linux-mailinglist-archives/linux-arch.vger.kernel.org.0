Return-Path: <linux-arch+bounces-12470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 603BFAE9EF2
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C7D1C4392F
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C72E610C;
	Thu, 26 Jun 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkx7OzxB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583922E54AF;
	Thu, 26 Jun 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944996; cv=none; b=kkIUvWWV8P4qWYAIAiHbr+c8W6GtIGe578EFtdD6/gWxgLcI3gVz+16d3gdRWqzNWRe7/uYOWGcOPGtxJ/UjEtCl6+NVmcv96WginyoNQIPwLNO9+r0/r5isfBza4FDkuGM7VbsuWbqwgN0/4cWWtGjaZHNFX2BvgApyego8O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944996; c=relaxed/simple;
	bh=S0Ln0L0FITmTu64+cEXbgyorFVfjS69CFW5Phe8pQhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RKL+UzEjbUIm1bsR1Qd5Pr9QWv7CCCWpWz2pee5Q6us50P1MaGCdiNWdYh+eeoi+WSqR+GYLbhpRYbNjcSBmQKFH1b6yGhirCtadrCGawkVJqHvRnda7fNrx50XFHpFIyYtn4Pckirsx3uvAhWWPRbe/JkWnJeykuMulZtUxiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkx7OzxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D44C4CEEE;
	Thu, 26 Jun 2025 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750944995;
	bh=S0Ln0L0FITmTu64+cEXbgyorFVfjS69CFW5Phe8pQhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mkx7OzxBYzdEqyovK2Sgoog/b6QMRYK1PrfreB2+9b01L34L2mROUWnkSLX7fckKQ
	 NeNjq/KQsJ8RTkASVTQhzMvt42Q7PfdyEATb9bEf1tTT5C+DbYnYpLukhtfyOyNnYp
	 exJ3w1A7dhlbyWFhA4f7dt4sEsyqLGkuKBnVVdhlBzaz0FNGUAwkxywdmFg5yyzUqb
	 QIik8B2NzcpJZPI0xpkOpJM/uK2FCKOd6aQuD3cseuiI7+62nI3SYUJv4G3275dWoR
	 wVJzM49uNSqzPRnuNmeuVP3xsIKk1YF/Jr7IUxuUUp+By+qTJABtOeF8njJccZZFMu
	 uIw8dvMcG6+HA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <lkmm@lists.linux.dev>,  <linux-arch@vger.kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <lossin@kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  "Lyude Paul" <lyude@redhat.com>,  "Ingo
 Molnar" <mingo@kernel.org>,  "Mitchell Levy" <levymitchell0@gmail.com>,
  "Paul E. McKenney" <paulmck@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 10/10] rust: sync: Add memory barriers
In-Reply-To: <20250618164934.19817-11-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:34 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<A-SZkzm2EzwbPsG5Vm5qfT1BIGijzoQ7zQI6ExgXZbSXf8ZfIMw6fe-Z7xWgvKnr0BPylikGRuhEfiKfXx5xTw==@protonmail.internalid>
	<20250618164934.19817-11-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 15:36:25 +0200
Message-ID: <874iw2zkti.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> Memory barriers are building blocks for concurrent code, hence provide
> a minimal set of them.
>
> The compiler barrier, barrier(), is implemented in inline asm instead of
> using core::sync::atomic::compiler_fence() because memory models are
> different: kernel's atomics are implemented in inline asm therefore the
> compiler barrier should be implemented in inline asm as well. Also it's
> currently only public to the kernel crate until there's a reasonable
> driver usage.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/helpers/barrier.c      | 18 ++++++++++
>  rust/helpers/helpers.c      |  1 +
>  rust/kernel/sync.rs         |  1 +
>  rust/kernel/sync/barrier.rs | 67 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)
>  create mode 100644 rust/helpers/barrier.c
>  create mode 100644 rust/kernel/sync/barrier.rs
>
> diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
> new file mode 100644
> index 000000000000..cdf28ce8e511
> --- /dev/null
> +++ b/rust/helpers/barrier.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <asm/barrier.h>
> +
> +void rust_helper_smp_mb(void)
> +{
> +	smp_mb();
> +}
> +
> +void rust_helper_smp_wmb(void)
> +{
> +	smp_wmb();
> +}
> +
> +void rust_helper_smp_rmb(void)
> +{
> +	smp_rmb();
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 83e89f6a68fb..8ddfc8f84e87 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -9,6 +9,7 @@
>
>  #include "atomic.c"
>  #include "auxiliary.c"
> +#include "barrier.c"
>  #include "blk.c"
>  #include "bug.c"
>  #include "build_assert.c"
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index b620027e0641..c7c0e552bafe 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,6 +11,7 @@
>
>  mod arc;
>  pub mod atomic;
> +pub mod barrier;
>  mod condvar;
>  pub mod lock;
>  mod locked_by;
> diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
> new file mode 100644
> index 000000000000..36a5c70e6716
> --- /dev/null
> +++ b/rust/kernel/sync/barrier.rs
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory barriers.
> +//!
> +//! These primitives have the same semantics as their C counterparts: and the precise definitions of
> +//! semantics can be found at [`LKMM`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-mode/

Typo in link target.

> +
> +/// A compiler barrier.
> +///
> +/// An explicic compiler barrier function that prevents the compiler from moving the memory
> +/// accesses either side of it to the other side.

Typo in "explicit".

How about:

  A compiler barrier. Prevents the compiler from reordering
  memory access instructions across the barrier.


> +pub(crate) fn barrier() {
> +    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
> +    // it suffices as a compiler barrier.
> +    //
> +    // SAFETY: An empty asm block should be safe.
> +    unsafe {
> +        core::arch::asm!("");
> +    }
> +}
> +
> +/// A full memory barrier.
> +///
> +/// A barrier function that prevents both the compiler and the CPU from moving the memory accesses
> +/// either side of it to the other side.


  A barrier that prevents compiler and CPU from reordering memory access
  instructions across the barrier.

> +pub fn smp_mb() {
> +    if cfg!(CONFIG_SMP) {
> +        // SAFETY: `smp_mb()` is safe to call.
> +        unsafe {
> +            bindings::smp_mb();
> +        }
> +    } else {
> +        barrier();
> +    }
> +}
> +
> +/// A write-write memory barrier.
> +///
> +/// A barrier function that prevents both the compiler and the CPU from moving the memory write
> +/// accesses either side of it to the other side.

  A barrier that prevents compiler and CPU from reordering memory write
  instructions across the barrier.

> +pub fn smp_wmb() {
> +    if cfg!(CONFIG_SMP) {
> +        // SAFETY: `smp_wmb()` is safe to call.
> +        unsafe {
> +            bindings::smp_wmb();
> +        }
> +    } else {
> +        barrier();
> +    }
> +}
> +
> +/// A read-read memory barrier.
> +///
> +/// A barrier function that prevents both the compiler and the CPU from moving the memory read
> +/// accesses either side of it to the other side.

  A barrier that prevents compiler and CPU from reordering memory read
  instructions across the barrier.

> +pub fn smp_rmb() {
> +    if cfg!(CONFIG_SMP) {
> +        // SAFETY: `smp_rmb()` is safe to call.
> +        unsafe {
> +            bindings::smp_rmb();
> +        }
> +    } else {
> +        barrier();
> +    }
> +}


Best regards,
Andreas Hindborg



