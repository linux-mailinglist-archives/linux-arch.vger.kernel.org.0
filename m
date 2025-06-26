Return-Path: <linux-arch+bounces-12463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAEAE9B09
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632BF3BA9B6
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC82221DA8;
	Thu, 26 Jun 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5looDtN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC921D018;
	Thu, 26 Jun 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933047; cv=none; b=k3h5DU/jmmVIykpvflNL8H/QAM/juJZVLuUDU6SWKG2ZiMctq94N8cfYYdv81bsGy3zUXIEC7uu42GjgDp/E48b6EETYJIuWMzUh5Sd7cnojC4CbHpOokAB1U8/gwHat1niQmiNsoH0XDvgKnPiRV7/2aem8kuaJgU14PUh5TXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933047; c=relaxed/simple;
	bh=QV62Fyue/QcIfoMjlFwMbjK5HSz9WDxVMrNLfIDynck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FJfyQAGWx74GSAsIeGwT4H4/zwJz8ldRfJo3LAOJLy/v93LPYyIrBqgBHZNVMEm39QVexrBg6x3ry7giR0XSahkbF8jYJZ/j7XoYsZguZNOHie5hV0dHBmTgFamrQDmoP2EgWcIJh1VkQZOGQfUafMJNLYnrGfAlE23QgwSRIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5looDtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74DAC4CEEE;
	Thu, 26 Jun 2025 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933046;
	bh=QV62Fyue/QcIfoMjlFwMbjK5HSz9WDxVMrNLfIDynck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V5looDtNrGI2O2gfld09wdA6gAeVVpXPOUHi2K2ZyAGF/E8gYI9ftDpEz7WYDHfBV
	 qdiDH0hj9CccXmZeF2GDRSAhnPItAelPpUSzZeJ3ymBUEyQvHX7+LYiRjX8NzTc3i4
	 eeC3taaROytAdH2868y0TXFUcokeWbhVS2xNRZQ3mKWtMz48hl/Lb9NCnahPr1OMsq
	 qMhALuTK4pEWLYkV/40K/V5vxZdTyeSOYuhmfn91ExrGKS7wzLPd6Jnxi/MgGSHXaf
	 PV7crPQJIwAMOIwpK29gl2aBcDMitSo5pCk0aHQQigP4893IqoXBjrnw3H5XMtuW8n
	 dRtfWaYlWlkpA==
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
Subject: Re: [PATCH v5 02/10] rust: sync: Add basic atomic operation mapping
 framework
In-Reply-To: <20250618164934.19817-3-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:26 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<CUuSJ1MRuO5_kQUQw69PENREVroAdiGBE0Rfy5-G7AD2Z5TNu1FUYRME9kvZZHT0GSIqtYK3yID0jB8xvfg2Qw==@protonmail.internalid>
	<20250618164934.19817-3-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 12:17:14 +0200
Message-ID: <878qle24et.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> Preparation for generic atomic implementation. To unify the
> implementation of a generic method over `i32` and `i64`, the C side
> atomic methods need to be grouped so that in a generic method, they can
> be referred as <type>::<method>, otherwise their parameters and return
> value are different between `i32` and `i64`, which would require using
> `transmute()` to unify the type into a `T`.

I can't follow this, could you expand a bit?

>
> Introduce `AtomicImpl` to represent a basic type in Rust that has the
> direct mapping to an atomic implementation from C. This trait is sealed,
> and currently only `i32` and `i64` impl this.
>
> Further, different methods are put into different `*Ops` trait groups,
> and this is for the future when smaller types like `i8`/`i16` are
> supported but only with a limited set of API (e.g. only set(), load(),
> xchg() and cmpxchg(), no add() or sub() etc).
>
> While the atomic mod is introduced, documentation is also added for
> memory models and data races.
>
> Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
> my responsiblity on the Rust atomic mod.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  MAINTAINERS                    |   4 +-
>  rust/kernel/sync.rs            |   1 +
>  rust/kernel/sync/atomic.rs     |  19 ++++
>  rust/kernel/sync/atomic/ops.rs | 199 +++++++++++++++++++++++++++++++++
>  4 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/atomic.rs
>  create mode 100644 rust/kernel/sync/atomic/ops.rs
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1d245bf7b8..5eef524975ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3894,7 +3894,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
>  ATOMIC INFRASTRUCTURE
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -R:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Mark Rutland <mark.rutland@arm.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> @@ -3903,6 +3903,8 @@ F:	arch/*/include/asm/atomic*.h
>  F:	include/*/atomic*.h
>  F:	include/linux/refcount.h
>  F:	scripts/atomic/
> +F:	rust/kernel/sync/atomic.rs
> +F:	rust/kernel/sync/atomic/
>
>  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
>  M:	Bradley Grove <linuxdrivers@attotech.com>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 36a719015583..b620027e0641 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -10,6 +10,7 @@
>  use pin_init;
>
>  mod arc;
> +pub mod atomic;
>  mod condvar;
>  pub mod lock;
>  mod locked_by;
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> new file mode 100644
> index 000000000000..65e41dba97b7
> --- /dev/null
> +++ b/rust/kernel/sync/atomic.rs
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic primitives.
> +//!
> +//! These primitives have the same semantics as their C counterparts: and the precise definitions of
> +//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memory (Consistency) Model is the
> +//! only model for Rust code in kernel, and Rust's own atomics should be avoided.
> +//!
> +//! # Data races
> +//!
> +//! [`LKMM`] atomics have different rules regarding data races:
> +//!
> +//! - A normal write from C side is treated as an atomic write if
> +//!   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y.
> +//! - Mixed-size atomic accesses don't cause data races.
> +//!
> +//! [`LKMM`]: srctree/tools/memory-mode/
> +
> +pub mod ops;
> diff --git a/rust/kernel/sync/atomic/ops.rs b/rust/kernel/sync/atomic/ops.rs
> new file mode 100644
> index 000000000000..f8825f7c84f0
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/ops.rs
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic implementations.
> +//!
> +//! Provides 1:1 mapping of atomic implementations.
> +
> +use crate::bindings::*;
> +use crate::macros::paste;
> +
> +mod private {
> +    /// Sealed trait marker to disable customized impls on atomic implementation traits.
> +    pub trait Sealed {}
> +}
> +
> +// `i32` and `i64` are only supported atomic implementations.
> +impl private::Sealed for i32 {}
> +impl private::Sealed for i64 {}
> +
> +/// A marker trait for types that implement atomic operations with C side primitives.
> +///
> +/// This trait is sealed, and only types that have directly mapping to the C side atomics should
> +/// impl this:
> +///
> +/// - `i32` maps to `atomic_t`.
> +/// - `i64` maps to `atomic64_t`.
> +pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {}
> +
> +// `atomic_t` implements atomic operations on `i32`.
> +impl AtomicImpl for i32 {}
> +
> +// `atomic64_t` implements atomic operations on `i64`.
> +impl AtomicImpl for i64 {}
> +
> +// This macro generates the function signature with given argument list and return type.

Perhaps could we add an example expansion to make the macro easier for
people to parse the first time:

declare_atomic_method!(
    read[acquire](ptr: *mut Self) -> Self
);

->

#[doc = "Atomic read_acquire"]
..
unsafe fn atomic_read_acquire(ptr: *mut Self) -> Self;

#[doc = "Atomic read"]
..
unsafe fn atomic_read(ptr: *mut Self) -> Self;


> +macro_rules! declare_atomic_method {
> +    (
> +        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
> +    ) => {
> +        paste!(
> +            #[doc = concat!("Atomic ", stringify!($func))]
> +            #[doc = "# Safety"]
> +            #[doc = "- Any pointer passed to the function has to be a valid pointer"]
> +            #[doc = "- Accesses must not cause data races per LKMM:"]
> +            #[doc = "  - Atomic read racing with normal read, normal write or atomic write is not data race."]
> +            #[doc = "  - Atomic write racing with normal read or normal write is data-race, unless the"]
> +            #[doc = "    normal accesses are done at C side and considered as immune to data"]
> +            #[doc = "    races, e.g. CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC."]
> +            unsafe fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)?;
> +        );
> +    };
> +    (
> +        $func:ident [$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)?
> +    ) => {
> +        paste!(
> +            declare_atomic_method!(
> +                [< $func _ $variant >]($($arg_sig)*) $(-> $ret)?
> +            );
> +        );
> +
> +        declare_atomic_method!(
> +            $func [$($rest)*]($($arg_sig)*) $(-> $ret)?
> +        );
> +    };
> +    (
> +        $func:ident []($($arg_sig:tt)*) $(-> $ret:ty)?
> +    ) => {
> +        declare_atomic_method!(
> +            $func($($arg_sig)*) $(-> $ret)?
> +        );
> +    }
> +}
> +
> +// This macro generates the function implementation with given argument list and return type, and it
> +// will replace "call(...)" expression with "$ctype _ $func" to call the real C function.

Similarly, I feel an expansion example is helpful:


impl_atomic_method!(
    (atomic) read[acquire](ptr: *mut Self) -> Self {
        call(ptr as *mut _)
    }
);

->

#[inline(always)]
unsafe fn atomic_read_acquire(ptr: *mut Self) -> Self {
    unsafe { atomic_read_acquire((ptr as *mut _)) }
}
#[inline(always)]
unsafe fn atomic_read(ptr: *mut Self) -> Self {
    unsafe { atomic_read((ptr as *mut _)) }
}


Lastly, perhaps we should do `ptr.cast()` rather than `as *mut _` ?


Best regards,
Andreas Hindborg



