Return-Path: <linux-arch+bounces-12466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA66AE9DAF
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2AC1621C5
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3702E06DC;
	Thu, 26 Jun 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh4yoX5M"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF461D5CD7;
	Thu, 26 Jun 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941601; cv=none; b=uWHcK3lHzUXZL5g+5zkQTr8y4+mAzdpaZA/u60sHnUofeCzYmfY47iWE0bXxt5FbCGHg3tUzvbZEnxXdmt30kTdvN0tEcmYJnvLjNKP1iIg9wKnT+x1wrrr2lWcrTptzzMXe14pfNRKQJxQp2VOIA2cTrlLIGcP/vYeleIi57Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941601; c=relaxed/simple;
	bh=USMsqMX6dnj+Tvvqhu5ElX8Y7rynf5Ee7mCTcpzB3sY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BFWVZO/4HwgkmtEELcfAGDVYFGw9rXVYvR30IbvHPSn8Hhp6+yqhUCx/GitOrTI0aSzJPBPtCuwhcsC6LWYym1uip7Ngg/VqZATN4sxh4PLS7nl8Gxcq4yQVyNbI5mjIrLftpO7a7KhJ+YG7lR6b/2QooRvxs+D8I83h6nj3rOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh4yoX5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B62C4CEEB;
	Thu, 26 Jun 2025 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750941601;
	bh=USMsqMX6dnj+Tvvqhu5ElX8Y7rynf5Ee7mCTcpzB3sY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rh4yoX5Me8TxmIa6HsZFIdb91uQTVO3kl0B4KkKGlXGkdSuF8hqIz7GVygs90YEjX
	 lFF01evhXy3/8dPgroA5jDsZiZTdgkqMIIm4FZTOTPK2MEWb5V8xWrk857QwiJgSMZ
	 Ahbgd4YIJvMqds8jSWNkBzoHO+E8YmJA4De8BzwK15BxddkH1hmMN7vszjkrdCltRl
	 53ADK9GlO0M5BYp2bEfAP/7g8wukdjQvY5vS4a2ieUZCcG7FauImfCCewtOzBMU9PU
	 pCqQP1q7g8I6IQ0TK3oppFBFvhrxafbePxBi1cz8xjVfAMb3qSZEKTpg1SwkAeEdNB
	 IUSHortFXMc1A==
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
Subject: Re: [PATCH v5 06/10] rust: sync: atomic: Add the framework of
 arithmetic operations
In-Reply-To: <20250618164934.19817-7-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:30 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<ZpemRgknqWbwYAShU6PA8VNVPU7cQv8WMNwyb9hlZzfkfXKJ_fyN8xfM2Ca75tXcE6Cv6pGHcNJgrp-p8fm6hQ==@protonmail.internalid>
	<20250618164934.19817-7-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 14:39:49 +0200
Message-ID: <87qzz6znfu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> One important set of atomic operations is the arithmetic operations,
> i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
> make senses for all the types that `AllowAtomic` to have arithmetic
> operations, for example a `Foo(u32)` may not have a reasonable add() or
> sub(), plus subword types (`u8` and `u16`) currently don't have
> atomic arithmetic operations even on C side and might not have them in
> the future in Rust (because they are usually suboptimal on a few
> architecures). Therefore add a subtrait of `AllowAtomic` describing
> which types have and can do atomic arithemtic operations.
>
> A few things about this `AllowAtomicArithmetic` trait:
>
> * It has an associate type `Delta` instead of using
>   `AllowAllowAtomic::Repr` because, a `Bar(u32)` (whose `Repr` is `i32`)
>   may not wants an `add(&self, i32)`, but an `add(&self, u32)`.
>
> * `AtomicImpl` types already implement an `AtomicHasArithmeticOps`
>   trait, so add blanket implementation for them. In the future, `i8` and
>   `i16` may impl `AtomicImpl` but not `AtomicHasArithmeticOps` if
>   arithemtic operations are not available.
>
> Only add() and fetch_add() are added. The rest will be added in the
> future.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic/generic.rs | 101 +++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> index bcdbeea45dd8..8c5bd90b2619 100644
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -57,6 +57,23 @@ fn from_repr(repr: Self::Repr) -> Self {
>      }
>  }
>
> +/// Atomics that allows arithmetic operations with an integer type.
> +pub trait AllowAtomicArithmetic: AllowAtomic {
> +    /// The delta types for arithmetic operations.
> +    type Delta;
> +
> +    /// Converts [`Self::Delta`] into the representation of the atomic type.
> +    fn delta_into_repr(d: Self::Delta) -> Self::Repr;
> +}
> +
> +impl<T: AtomicImpl + AtomicHasArithmeticOps> AllowAtomicArithmetic for T {
> +    type Delta = Self;
> +
> +    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
> +        d
> +    }
> +}
> +
>  impl<T: AllowAtomic> Atomic<T> {
>      /// Creates a new atomic.
>      pub const fn new(v: T) -> Self {
> @@ -410,3 +427,87 @@ fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
>          }
>      }
>  }
> +
> +impl<T: AllowAtomicArithmetic> Atomic<T>
> +where
> +    T::Repr: AtomicHasArithmeticOps,
> +{
> +    /// Atomic add.
> +    ///
> +    /// The addition is a wrapping addition.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.add(12, Relaxed);
> +    ///
> +    /// assert_eq!(54, x.load(Relaxed));
> +    /// ```
> +    #[inline(always)]
> +    pub fn add<Ordering: RelaxedOnly>(&self, v: T::Delta, _: Ordering) {
> +        let v = T::delta_into_repr(v);
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_add() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,

Typo, should be `AllowAtomic`.

> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        unsafe {
> +            T::Repr::atomic_add(a, v);
> +        }
> +    }
> +
> +    /// Atomic fetch and add.
> +    ///
> +    /// The addition is a wrapping addition.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// assert_eq!(54, { x.fetch_add(12, Acquire); x.load(Relaxed) });
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// assert_eq!(54, { x.fetch_add(12, Full); x.load(Relaxed) } );
> +    /// ```
> +    #[inline(always)]
> +    pub fn fetch_add<Ordering: All>(&self, v: T::Delta, _: Ordering) -> T {
> +        let v = T::delta_into_repr(v);
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_fetch_add*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,

Typo, should be `AllowAtomic`.


Best regards,
Andreas Hindborg



