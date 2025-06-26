Return-Path: <linux-arch+bounces-12464-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F313AAE9D4D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 14:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F56B1896D91
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7F2F1FEA;
	Thu, 26 Jun 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOn9Twm7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD42F1FE4;
	Thu, 26 Jun 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940147; cv=none; b=fFofAXeYlkcfEurooQRVEry0IELfhThDr1yWsXmWqwGZD1pjkwLsPyhsmbZM4LDK7BRtZ5c4NnZklmuJ52DnDQtJKrz02Z/WOxley+1ESeKsB2T2lp8SBh+59JN6DF3QcXex429d7/jUWujByTg33Ui0ith66cHYjAbVPvTb2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940147; c=relaxed/simple;
	bh=rO317H3xuWCZdX9BLTv7dshWsqwwlUzyOMx4HJubyN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JCpDzjec87+ImJd2/oFqqwjRnNFXLIayMy64o9ubsGcN1JxzacjDLenOPmaRF2sieWP0iZujWfK3+/Umf/4XowoVyfNuRZOLrAjEeepAegN4KkdFII9jMpLW1Q3A/RUwXzCMgJtxAT1fP669EzxPNxg4fB8EJ75Rcv4LiceNxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOn9Twm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77FBC4CEED;
	Thu, 26 Jun 2025 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750940147;
	bh=rO317H3xuWCZdX9BLTv7dshWsqwwlUzyOMx4HJubyN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MOn9Twm7xNtUwkihn3JedqgUylRmDdJS4ZWJ3ph2oq9sEvwvDa7PynSBEjKqzGL2D
	 rQ4YvvdGhLIP3v0dK0Wq2lhei49URaCog9hdaybvy/oEwUWGefAumQob7+s+kKp1Ni
	 WP5BfnHy15gMOZJuqZJEyizdT59FgxEdWDVMWkxZ1HY8mJhW1gl2s1D4s8g9SKib+6
	 W3X8q6csNhvnupBWQUjVhh2YT7O1Z3CpZQtm/m+e5qpVagwWwpz2jCcxIeWH9SkJ6Q
	 aka9U70Nlgm8grn7xswEyLWIG1ije91x7ox2Te9+QLNR+OsoMky1kS+fMxnj4Vyj/4
	 jOZzjTV2UbYLQ==
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
In-Reply-To: <20250618164934.19817-5-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:28 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<8ISRnKRw28Na4so9GDfdv0gd40nmTGOwD7hFx507xGgJ64p9s8qECsOkboryQH02IQJ4ObvqAwcLUZCKt1QwZQ==@protonmail.internalid>
	<20250618164934.19817-5-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 14:15:35 +0200
Message-ID: <8734bm1yxk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

[...]

> +
> +impl<T: AllowAtomic> Atomic<T> {
> +    /// Creates a new atomic.
> +    pub const fn new(v: T) -> Self {
> +        Self(Opaque::new(v))
> +    }
> +
> +    /// Creates a reference to [`Self`] from a pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` has to be a valid pointer.
> +    /// - `ptr` has to be valid for both reads and writes for the whole lifetime `'a`.
> +    /// - For the whole lifetime of '`a`, other accesses to the object cannot cause data races
> +    ///   (defined by [`LKMM`]) against atomic operations on the returned reference.

I feel the wording is a bit tangled here. How about something along the
lines of

  For the duration of `'a`, all accesses to the object must be atomic.

> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    ///
> +    /// # Examples
> +    ///
> +    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`Atomic::store()`] can
> +    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()` or
> +    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
> +    ///
> +    /// ```rust
> +    /// # use kernel::types::Opaque;
> +    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
> +    ///
> +    /// // Assume there is a C struct `Foo`.
> +    /// mod cbindings {
> +    ///     #[repr(C)]
> +    ///     pub(crate) struct foo { pub(crate) a: i32, pub(crate) b: i32 }
> +    /// }
> +    ///
> +    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2});
> +    ///
> +    /// // struct foo *foo_ptr = ..;
> +    /// let foo_ptr = tmp.get();
> +    ///
> +    /// // SAFETY: `foo_ptr` is a valid pointer, and `.a` is inbound.

Did you mean to say "in bounds"? Or what is "inbound"?

> +    /// let foo_a_ptr = unsafe { core::ptr::addr_of_mut!((*foo_ptr).a) };

This should be `&raw mut` by now, right?

> +    ///
> +    /// // a = READ_ONCE(foo_ptr->a);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for read, and all accesses on it is atomic, so no
> +    /// // data race.
> +    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
> +    /// # assert_eq!(a, 1);
> +    ///
> +    /// // smp_store_release(&foo_ptr->a, 2);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for write, and all accesses on it is atomic, so no
> +    /// // data race.
> +    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
> +    /// ```
> +    ///
> +    /// However, this should be only used when communicating with C side or manipulating a C struct.
> +    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
> +    where
> +        T: Sync,
> +    {
> +        // CAST: `T` is transparent to `Atomic<T>`.
> +        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
> +        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
> +        // guarantees other accesses won't cause data races.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }
> +
> +    /// Returns a pointer to the underlying atomic variable.
> +    ///
> +    /// Extra safety requirement on using the return pointer: the operations done via the pointer
> +    /// cannot cause data races defined by [`LKMM`].
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    pub const fn as_ptr(&self) -> *mut T {
> +        self.0.get()
> +    }
> +
> +    /// Returns a mutable reference to the underlying atomic variable.
> +    ///
> +    /// This is safe because the mutable reference of the atomic variable guarantees the exclusive
> +    /// access.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        // SAFETY: `self.as_ptr()` is a valid pointer to `T`, and the object has already been
> +        // initialized. `&mut self` guarantees the exclusive access, so it's safe to reborrow
> +        // mutably.
> +        unsafe { &mut *self.as_ptr() }
> +    }
> +}
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasBasicOps,
> +{
> +    /// Loads the value from the atomic variable.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Simple usages:
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// let x = Atomic::new(42i64);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    /// ```
> +    ///
> +    /// Customized new types in [`Atomic`]:
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{generic::AllowAtomic, Atomic, Relaxed};
> +    ///
> +    /// #[derive(Clone, Copy)]
> +    /// #[repr(transparent)]
> +    /// struct NewType(u32);
> +    ///
> +    /// // SAFETY: `NewType` is transparent to `u32`, which has the same size and alignment as
> +    /// // `i32`.
> +    /// unsafe impl AllowAtomic for NewType {
> +    ///     type Repr = i32;
> +    ///
> +    ///     fn into_repr(self) -> Self::Repr {
> +    ///         self.0 as i32
> +    ///     }
> +    ///
> +    ///     fn from_repr(repr: Self::Repr) -> Self {
> +    ///         NewType(repr as u32)
> +    ///     }
> +    /// }
> +    ///
> +    /// let n = Atomic::new(NewType(0));
> +    ///
> +    /// assert_eq!(0, n.load(Relaxed).0);
> +    /// ```
> +    #[doc(alias("atomic_read", "atomic64_read"))]
> +    #[inline(always)]
> +    pub fn load<Ordering: AcquireOrRelaxed>(&self, _: Ordering) -> T {
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_read*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,

Typo `AllocAtomic`.

> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        let v = unsafe {
> +            if Ordering::IS_RELAXED {
> +                T::Repr::atomic_read(a)
> +            } else {
> +                T::Repr::atomic_read_acquire(a)
> +            }
> +        };
> +
> +        T::from_repr(v)
> +    }
> +
> +    /// Stores a value to the atomic variable.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.store(43, Relaxed);
> +    ///
> +    /// assert_eq!(43, x.load(Relaxed));
> +    /// ```
> +    ///
> +    #[doc(alias("atomic_set", "atomic64_set"))]
> +    #[inline(always)]
> +    pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
> +        let v = T::into_repr(v);
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_set*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,

Typo `AllocAtomic`.


Best regards,
Andreas Hindborg



