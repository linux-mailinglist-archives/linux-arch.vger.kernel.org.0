Return-Path: <linux-arch+bounces-12654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A966B0169D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D9E1636C5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFBB20AF98;
	Fri, 11 Jul 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRXMSgdE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5071F4C8A;
	Fri, 11 Jul 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223340; cv=none; b=NrLs2ug4a9899Afdua6wdRrD/v4ZIDO2OSlNdaikrUy1VgEnNCoLvzNH/Hp2IkMX7YCKurLpRzkEnFkHbfzwSPlwK0JbEMFaphQccF6FMPh709ruwCKBXg3RoyEq9ihvQ6GkF5VYjWu2mhfgKRCH+IHQzRBGTCd9gPwXssfVpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223340; c=relaxed/simple;
	bh=OGJUruQVcaBDKN3rePA36dlzoqWqojuGcbjyp/TC8eg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gLl2eDKyR798NamTEAecwfaEHTxUuUjYuF2QBGL4HptD/64RdC7vDylCY74M+qONt6uiUl9ljgx/5NBGwRUiYoiRLaMtIVlC8i7zUptw1B0cUT2vwE4ZAZCY1HvVpagAEXxkJKcMJUYuu35wdJfMyFLXWW+Xe+9SRGvXZxTIaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRXMSgdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E665CC4CEED;
	Fri, 11 Jul 2025 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752223340;
	bh=OGJUruQVcaBDKN3rePA36dlzoqWqojuGcbjyp/TC8eg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tRXMSgdEsWNdYatRbBNg5kegtNGJOj5AubJr76sJzGCgwCq0UT1DeNyKu0ZZq9RWr
	 23ugx0bMq2dgm5t/a78BeBG2dko2wDYw1saALBiu+I93tfQq2aiQa8qFXqOMJECrMs
	 xuu3/+1matyi0554+PLtLFrpxFmRxxREftZYunB6M/gaYwK+m9NZN/1KMH6JCUCYry
	 /Cwng9TQHmVLMH6P8sajBBK5XPkgmsK+ppQfkNbKRceY7o9v0radE/akOUf/mxx+Sm
	 Ny+1OHpkxx6vdVTlY0FyIMZxO4FOy9tYrt2TVuQ4XH+ZK7zvekk1eeJVCJyhO+0ayB
	 zCVdKMQukYkbQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:42:14 +0200
Message-Id: <DB93BZ5X63W4.2N48BXJEJOQ3F@kernel.org>
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
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 5/9] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-6-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-6-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> xchg() and cmpxchg() are basic operations on atomic. Provide these based
> on C APIs.
>
> Note that cmpxchg() use the similar function signature as
> compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
> the operation succeeds and `Err(old)` means the operation fails.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic/generic.rs | 170 +++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
>
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic=
/generic.rs
> index e044fe21b128..1beb802843ee 100644
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -287,3 +287,173 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: =
T, _: Ordering) {
>          };
>      }
>  }
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasXchgOps,
> +{
> +    /// Atomic exchange.

Please also give a longer sentence describing the operation.

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
> +    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
> +    #[inline(always)]
> +    pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) -> T {
> +        let v =3D into_repr(v);
> +        // CAST: Per the safety requirement of `AllowAtomic`, a valid po=
inter of `T` is also a
> +        // valid pointer of `T::Repr`.

Ditto as the last patch (I'm not going to mention the others).

> +        let a =3D self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_xchg*() function:
> +        //   - `a` is a valid pointer for the function per the CAST just=
ification above.
> +        //   - Per the type guarantees, the following atomic operation w=
on't cause data races.
> +        // - For extra safety requirement of usage on pointers returned =
by `self.as_ptr()`:
> +        //   - Atomic operations are used here.
> +        // - For the bit validity of `Atomic<T>`:
> +        //   - `v` is a valid bit pattern of `T`, so it's sound to store=
 it in an `Atomic<T>`.
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
> +        // SAFETY: The atomic variable holds a valid `T`, so `ret` is a =
valid bit pattern of `T`,
> +        // therefore it's safe to call `from_repr()`.
> +        unsafe { from_repr(ret) }
> +    }
> +
> +    /// Atomic compare and exchange.

Also longer description for this function.

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

Why did you chose to say "should be treated" can't you say it is a
relaxed read? What would the difference be between those two be?

> +    ///
> +    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guarante=
ed to be equal to `old`,
> +    /// otherwise returns `Err(value)`, and `value` is the value of the =
atomic variable when
> +    /// cmpxchg was happening.

s/cmpxchg was happening/`cmpxchg` was executed/

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
> +        "atomic64_try_cmpxchg",
> +        "compare_exchange"
> +    ))]
> +    #[inline(always)]
> +    pub fn cmpxchg<Ordering: Any>(&self, mut old: T, new: T, o: Ordering=
) -> Result<T, T> {
> +        // Note on code generation:
> +        //
> +        // try_cmpxchg() is used to implement cmpxchg(), and if the help=
er functions are inlined,
> +        // the compiler is able to figure out that branch is not needed =
if the users don't care
> +        // about whether the operation succeeds or not. One exception is=
 on x86, due to commit
> +        // 44fe84459faf ("locking/atomic: Fix atomic_try_cmpxchg() seman=
tics"), the
> +        // atomic_try_cmpxchg() on x86 has a branch even if the caller d=
oesn't care about the
> +        // success of cmpxchg and only wants to use the old value. For e=
xample, for code like:
> +        //
> +        //     let latest =3D x.cmpxchg(42, 64, Full).unwrap_or_else(|ol=
d| old);
> +        //
> +        // It will still generate code:
> +        //
> +        //     movl    $0x40, %ecx
> +        //     movl    $0x34, %eax
> +        //     lock
> +        //     cmpxchgl        %ecx, 0x4(%rsp)
> +        //     jne     1f
> +        //     2:
> +        //     ...
> +        //     1:  movl    %eax, %ecx
> +        //     jmp 2b
> +        //
> +        // This might be "fixed" by introducing a try_cmpxchg_exclusive(=
) that knows the "*old"
> +        // location in the C function is always safe to write.

Oh wow the mentioned commit was an interesting read...

---
Cheers,
Benno

> +        if self.try_cmpxchg(&mut old, new, o) {
> +            Ok(old)
> +        } else {
> +            Err(old)
> +        }
> +    }

