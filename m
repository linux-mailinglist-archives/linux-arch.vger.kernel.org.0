Return-Path: <linux-arch+bounces-12461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BDAAE98F8
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 10:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0401C2725F
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD9295530;
	Thu, 26 Jun 2025 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOhhkIfL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B6295517;
	Thu, 26 Jun 2025 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927817; cv=none; b=i6Orrpe3Bk6aIVZcgW3T8m5me7noRCVi/VILs7cw1QCAY97ovgEGPPiYl6QVZ3y9X7miJB1c9RIIJPN/QyCJp+6juTEzTUAZNggRESxrdjxnmLOwVsm1QIKMO/QnxvHV+H826snDOmLlMpKIq26aijFnppNb8KLygtbOEBcmbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927817; c=relaxed/simple;
	bh=uNjYg/ewMnvuysPUDDt3GNwngbDKWv/d6y88QcyM828=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HomILCLm1Wx9yJgESI4gKnoxOPSfMAc8gSjenUpwnyvFOUY0MDkR+BhSkfRynSVGvvWEIN41J9ul/funD9r6vYitMxEMmVDaTU92ISeWOkfuweWS1vmGsqnbuBDUWdNqkWNN+5kTbkWm0E4li4wyZ36kiua5CBt+deOSWAJCfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOhhkIfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F46C4CEEB;
	Thu, 26 Jun 2025 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927817;
	bh=uNjYg/ewMnvuysPUDDt3GNwngbDKWv/d6y88QcyM828=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JOhhkIfLeUb/1k+YlF7KmQ523EzcBnhPSfMFabFy6OK2jnxUH+XUvha116XgcYTL/
	 HcMy3j7E+c+TWI/ybPfxIbvckH8+QTu3EzQ0TCzIZwum1qIWiJAU+tuEs9MSkLosTv
	 8JING4oCuOrCFmOxRX2L4ANPg70PQF4bGKshiC7lOo9oifJ5e1eNDviTO34+pbvEWK
	 n5QfQHhfZNUNCY1M84xxo8ASkFnqCBJcwVaAAikCS+XBVa9HLeGpbdp0IKNrWC0hQT
	 vRgRyxJXQTgqykAbCiS/chxZFB8DC+By73PTWuVrDTTjJI3UcJTuHR6znHBo+KfgU4
	 8sgxqTA7JRaQw==
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
Date: Thu, 26 Jun 2025 10:50:07 +0200
Message-ID: <87ecv628g0.fsf@kernel.org>
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

Typo in the link destination.


Best regards,
Andreas Hindborg



