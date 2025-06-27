Return-Path: <linux-arch+bounces-12481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820CEAEB1D5
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B374A4D68
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9727F002;
	Fri, 27 Jun 2025 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ1uBfMr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF96229B15;
	Fri, 27 Jun 2025 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014730; cv=none; b=J33f3BgNDFQKl/u3vE1zGOyHZ9F4t5kROuxx1Oxo7LIPzbOnMBpItLFBgPQI7ZIeNezv5WwpIkYEBPYQiDM4ug5IoqwWLjEM2Zg5JqdMGSTAjX8X+yJ87uw3xnztisZrh9RDUOV95g2/tLI/y3ZNX3KapaBq8hsXPw3Iy30BsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014730; c=relaxed/simple;
	bh=7Q0EJNGfoLDItxk7UkA5TTYdcSirFMepdH0/ItIQbdY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JSTux3G4EmE5UWMHX3fsgsNh7P0Mtlv++onlJY1c5fAjC3DF6CdVOPrCoEe+FOt+djDhtKtqePvmX9OiWnORBn/i8x/chtnz/YlIkuwEGIq1US1wBV4m6y/+QV+tPXb4yPK7TUqyOmVgcQ4EC6yQcOcLGXX2XqWTiCI3GBOgEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ1uBfMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED55C4CEED;
	Fri, 27 Jun 2025 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751014730;
	bh=7Q0EJNGfoLDItxk7UkA5TTYdcSirFMepdH0/ItIQbdY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KZ1uBfMrQUHPPAz+Nq7hNbEKd+DazgJ4hhbGGNZtF9sYEAlWqDk2hUkgp7CKHbPZA
	 PO/Z9Cliyx8yWpvUSSEujEPB1WvTpUjeI1WDsbW4IFZFM+1AHCqcwgmxGtdFfxbgQA
	 jfkCYhDr/6x73ihykZhMxtylSWREa8Xi2d5+JXzvIKNB6cjyVeRl5lpkIVh/hSFAuU
	 RdDgcJM09g7WpkXSL4Ql/h3MBBWjipOU/ep4M0Omk8e8+JzYDSEy2nqzC6JwEzlBXh
	 xzFkJ6yUCLBTg5s4xlDLtk5mqiS1gdWDZER9SHXYxBjCzfjORcsL3+MFb95ngw4LFn
	 SyMyA004Wxi1w==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 10:58:43 +0200
Message-Id: <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-6-boqun.feng@gmail.com>
In-Reply-To: <20250618164934.19817-6-boqun.feng@gmail.com>

On Wed Jun 18, 2025 at 6:49 PM CEST, Boqun Feng wrote:
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasXchgOps,
> +{
> +    /// Atomic exchange.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
> +    ///
> +    /// let x =3D Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.xchg(52, Acquire));
> +    /// assert_eq!(52, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
> +    #[inline(always)]
> +    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {

Can we name this `exchange`?

> +        let v =3D T::into_repr(v);
> +        let a =3D self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_xchg*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety re=
quirement of `AllocAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a=
 valid pointer,
> +        //   - per the type invariants, the following atomic operation w=
on't cause data races.
> +        // - For extra safety requirement of usage on pointers returned =
by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        let ret =3D unsafe {
> +            match Ordering::TYPE {
> +                OrderingType::Full =3D> T::Repr::atomic_xchg(a, v),
> +                OrderingType::Acquire =3D> T::Repr::atomic_xchg_acquire(=
a, v),
> +                OrderingType::Release =3D> T::Repr::atomic_xchg_release(=
a, v),
> +                OrderingType::Relaxed =3D> T::Repr::atomic_xchg_relaxed(=
a, v),
> +            }
> +        };
> +
> +        T::from_repr(ret)
> +    }
> +
> +    /// Atomic compare and exchange.
> +    ///
> +    /// Compare: The comparison is done via the byte level comparison be=
tween the atomic variables
> +    /// with the `old` value.
> +    ///
> +    /// Ordering: When succeeds, provides the corresponding ordering as =
the `Ordering` type
> +    /// parameter indicates, and a failed one doesn't provide any orderi=
ng, the read part of a
> +    /// failed cmpxchg should be treated as a relaxed read.

This is a bit confusing to me. The operation has a store and a load
operation and both can have different orderings (at least in Rust
userland) depending on the success/failure of the operation. In
userland, I can supply `AcqRel` and `Acquire` to ensure that I always
have Acquire semantics on any read and `Release` semantics on any write
(which I would think is a common case). How do I do this using your API?

Don't I need `Acquire` semantics on the read in order for
`compare_exchange` to give me the correct behavior in this example:

    pub struct Foo {
        data: Atomic<u64>,
        new: Atomic<bool>,
        ready: Atomic<bool>,
    }

    impl Foo {
        pub fn new() -> Self {
            Self {
                data: Atomic::new(0),
                new: Atomic::new(false),
                ready: Atomic::new(false),
            }
        }

        pub fn get(&self) -> Option<u64> {
            if self.new.compare_exchange(true, false, Release).is_ok() {
                let val =3D self.data.load(Acquire);
                self.ready.store(false, Release);
                Some(val)
            } else {
                None
            }
        }

        pub fn set(&self, val: u64) -> Result<(), u64> {
            if self.ready.compare_exchange(false, true, Release).is_ok() {
                self.data.store(val, Release);
                self.new.store(true, Release);
            } else {
                Err(val)
            }
        }
    }

IIUC, you need `Acquire` ordering on both `compare_exchange` operations'
reads for this to work, right? Because if they are relaxed, this could
happen:

                    Thread 0                    |                    Thread=
 1
------------------------------------------------|--------------------------=
----------------------
 get() {                                        | set(42) {
                                                |   if ready.cmpxchg(false,=
 true, Rel).is_ok() {
                                                |     data.store(42, Rel)
                                                |     new.store(true, Rel)
   if new.cmpxchg(true, false, Rel).is_ok() {   |
     let val =3D self.data.load(Acq); // reads 0  |
     ready.store(false, Rel);                   |
     Some(val)                                  |
   }                                            |   }
 }                                              | }
=20
So essentially, the `data.store` operation is not synchronized, because
the read on `new` is not `Acquire`.

> +    ///
> +    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guarante=
ed to be equal to `old`,
> +    /// otherwise returns `Err(value)`, and `value` is the value of the =
atomic variable when
> +    /// cmpxchg was happening.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Full, Relaxed};
> +    ///
> +    /// let x =3D Atomic::new(42);
> +    ///
> +    /// // Checks whether cmpxchg succeeded.
> +    /// let success =3D x.cmpxchg(52, 64, Relaxed).is_ok();
> +    /// # assert!(!success);
> +    ///
> +    /// // Checks whether cmpxchg failed.
> +    /// let failure =3D x.cmpxchg(52, 64, Relaxed).is_err();
> +    /// # assert!(failure);
> +    ///
> +    /// // Uses the old value if failed, probably re-try cmpxchg.
> +    /// match x.cmpxchg(52, 64, Relaxed) {
> +    ///     Ok(_) =3D> { },
> +    ///     Err(old) =3D> {
> +    ///         // do something with `old`.
> +    ///         # assert_eq!(old, 42);
> +    ///     }
> +    /// }
> +    ///
> +    /// // Uses the latest value regardlessly, same as atomic_cmpxchg() =
in C.
> +    /// let latest =3D x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old)=
;
> +    /// # assert_eq!(42, latest);
> +    /// assert_eq!(64, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias(
> +        "atomic_cmpxchg",
> +        "atomic64_cmpxchg",
> +        "atomic_try_cmpxchg",
> +        "atomic64_try_cmpxchg"
> +    ))]
> +    #[inline(always)]
> +    pub fn cmpxchg<Ordering: All>(&self, mut old: T, new: T, o: Ordering=
) -> Result<T, T> {

`compare_exchange`?

> +    /// Atomic compare and exchange and returns whether the operation su=
cceeds.
> +    ///
> +    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg(=
)`].
> +    ///
> +    /// Returns `true` means the cmpxchg succeeds otherwise returns `fal=
se` with `old` updated to
> +    /// the value of the atomic variable when cmpxchg was happening.
> +    #[inline(always)]
> +    fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Orderin=
g) -> bool {

`try_compare_exchange`?

---
Cheers,
Benno

> +        let old =3D (old as *mut T).cast::<T::Repr>();
> +        let new =3D T::into_repr(new);
> +        let a =3D self.0.get().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_try_cmpchg*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety re=
quirement of `AllowAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a=
 valid pointer,
> +        //   - per the type invariants, the following atomic operation w=
on't cause data races.
> +        //   - `old` is a valid pointer to write because it comes from a=
 mutable reference.
> +        // - For extra safety requirement of usage on pointers returned =
by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        unsafe {
> +            match Ordering::TYPE {
> +                OrderingType::Full =3D> T::Repr::atomic_try_cmpxchg(a, o=
ld, new),
> +                OrderingType::Acquire =3D> T::Repr::atomic_try_cmpxchg_a=
cquire(a, old, new),
> +                OrderingType::Release =3D> T::Repr::atomic_try_cmpxchg_r=
elease(a, old, new),
> +                OrderingType::Relaxed =3D> T::Repr::atomic_try_cmpxchg_r=
elaxed(a, old, new),
> +            }
> +        }
> +    }
> +}


