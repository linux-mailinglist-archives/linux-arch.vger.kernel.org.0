Return-Path: <linux-arch+bounces-12652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23350B01556
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 10:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E301C46574
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89F1F150B;
	Fri, 11 Jul 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkzR4m+5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC21A0BE0;
	Fri, 11 Jul 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220994; cv=none; b=GkeR9oKw5dRslNbu7HMp6jVR8DLMP8du4tGMsyDEkM9U17Sn8s1RVKfIY3YHywloKiKDvPLVkFZmxDzwiiKXJGF3lZzWRhhqgc57mUHO/ObVrXZGuXizAQGL1tqeT8MA/NiCtJ5g8zawPeLDaIE32qmDysqILI6FBGTNAUXzZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220994; c=relaxed/simple;
	bh=q5kzjw4pdZnlOm1O17X4pF0mstSdCM/tt79sh7n2vWo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=brAUAhclM0O4uTO9g64+2XGiU/mCFMl2Sg/T+k78EW2kWgkEmxO57I0dbet2Jx2pFsjGNM6PzQ2iIOHiPOPeoR/zAnV4MBwxPGDPrqUkrKj0zqQeAki30sSXNlEz0H5GPaD5EcpoebixiD0A6K9wrTX2RaP7hVp5UObs34JMRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkzR4m+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CF9C4CEED;
	Fri, 11 Jul 2025 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752220993;
	bh=q5kzjw4pdZnlOm1O17X4pF0mstSdCM/tt79sh7n2vWo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kkzR4m+5JpsKlfx5a0BWgL8es5hW0oaj8naNBScNdVP6hyKhTHurQDEouumHWDjgX
	 eNAQnwuW4E1hmImXPXezPqVj+awaEqYEknSBc+TYO/UQ+ZRovLKoJj1gqrm/8rBbYr
	 TlxwQMt6pj9Mx8pt2WFgO276fw0PBQuQUEd5c4OmPSVHA4b5SPQVW9+RdXTALaSEhI
	 INo0qRD08pRaDJcw2JUUHl/xZu7CUTVq39Gwt4mhR6eBiDihYixuA4XZd9Y1E4GoJ+
	 aJla0vC27lAxdL9WH9xXpu3OQAsXWtLQhjtgagETdwt/m/rPEI52hnLOZLAoF+qjCL
	 BohyOuU0BubaQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:03:07 +0200
Message-Id: <DB92I10114UN.33MAFJVWIX4AB@kernel.org>
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
Subject: Re: [PATCH v6 4/9] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-5-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic=
/generic.rs
> new file mode 100644
> index 000000000000..e044fe21b128
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic atomic primitives.
> +
> +use super::ops::*;
> +use super::ordering::*;
> +use crate::build_error;
> +use core::cell::UnsafeCell;
> +
> +/// A generic atomic variable.

How about we copy upstream rust on this:

    A memory location which can be safely modified from multiple threads.

> +///
> +/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to be =
chosen.

s/impl/implement/

I don't really think this sentence is that valuable... I think you could
mention several things before this:

* compatibility with LKMM (or that it is implemented through LKMM
  atomics)
* "what is an atomic"
* how big (relative to `T`) is this type? what about alignment?

> +///
> +/// # Examples
> +///
> +/// A customized type stored in [`Atomic`]:
> +///
> +/// ```rust
> +/// use kernel::sync::atomic::{generic::AllowAtomic, Atomic, Relaxed};
> +///
> +/// #[derive(Clone, Copy, PartialEq, Eq)]
> +/// #[repr(i32)]
> +/// enum State {
> +///     Uninit =3D 0,
> +///     Working =3D 1,
> +///     Done =3D 2,
> +/// };
> +///
> +/// // SAFETY: `State` and `i32` has the same size and alignment, and it=
's round-trip
> +/// // transmutable to `i32`.
> +/// unsafe impl AllowAtomic for State {
> +///     type Repr =3D i32;
> +/// }
> +///
> +/// let s =3D Atomic::new(State::Uninit);
> +///
> +/// assert_eq!(State::Uninit, s.load(Relaxed));
> +/// ```

This example doesn't really seem like a good idea on this type... Maybe
on `AllowAtomic` instead? This type should just have examples of how to
use `Atomic<T>`.

> +///
> +/// # Guarantees
> +///
> +/// Doing an atomic operation while holding a reference of [`Self`] won'=
t cause a data race,
> +/// this is guaranteed by the safety requirement of [`Self::from_ptr()`]=
 and the extra safety
> +/// requirement of the usage on pointers returned by [`Self::as_ptr()`].

I'd rather think we turn this into an invariant that says any operations
on `self.0` through a shared reference is atomic.

> +#[repr(transparent)]
> +pub struct Atomic<T: AllowAtomic>(UnsafeCell<T>);
> +
> +// SAFETY: `Atomic<T>` is safe to share among execution contexts because=
 all accesses are atomic.
> +unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
> +
> +/// Types that support basic atomic operations.
> +///
> +/// # Round-trip transmutability

This can stay here for the moment, but it should probably be somewhere
more central.

> +///
> +/// Implementing [`AllowAtomic`] requires that the type is round-trip tr=
ansmutable to its
> +/// representation:

I would remove this sentence and just define round-trip transmutability
in a standalone fashion.

> +///
> +/// - Any value of [`Self`] must be sound to [`transmute()`] to a [`Self=
::Repr`], and this also
> +///   means that a pointer to [`Self`] can be treated as a pointer to [`=
Self::Repr`] for reading.
> +/// - If a value of [`Self::Repr`] is a result a [`transmute()`] from a =
[`Self`], it must be
> +///   sound to [`transmute()`] the value back to a [`Self`].

This seems a bit verbose. How about this:

    `T` is round-trip transmutable to `U` if and only if all of these prope=
rties hold:
    * Any valid bit pattern for `T` is also a valid bit pattern for `U`.
    * Transmuting a value of type `T` to `U` and then to `T` again yields a=
 value that is in all aspects
      equivalent to the original value.

> +///
> +/// This essentially means a valid bit pattern of `T: AllowAtomic` has t=
o be a valid bit pattern
> +/// of `T::Repr`. This is needed because [`Atomic<T: AllowAtomic>`] oper=
ates on `T::Repr` to
> +/// implement atomic operations on `T`.
> +///
> +/// Note that this is more relaxed than bidirectional transmutability (i=
.e. [`transmute()`] is
> +/// always sound between `T` and `T::Repr`) because of the support for a=
tomic variables over

s/between `T` and `T::Repr`/from `T` to `T::Repr` and back/

> +/// unit-only enums:

What are "unit-only" enums? Do you mean enums that don't have associated
data?

> +///
> +/// ```
> +/// #[repr(i32)]
> +/// enum State { Init =3D 0, Working =3D 1, Done =3D 2, }
> +/// ```
> +///
> +/// # Safety
> +///
> +/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
> +/// - [`Self`] and [`Self::Repr`] must have the [round-trip transmutabil=
ity].

s/have the/be/
s/transmutability/transmutable/

> +///
> +/// # Limitations
> +///
> +/// Because C primitives are used to implement the atomic operations, an=
d a C function requires a
> +/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hen=
ce at the Rust <-> C
> +/// surface, only types with no uninitialized bits can be passed. As a r=
esult, types like `(u8,
> +/// u16)` (a tuple with a `MaybeUninit` hole in it) are currently not su=
pported. Note that
> +/// technically these types can be supported if some APIs are removed fo=
r them and the inner
> +/// implementation is tweaked, but the justification of support such a t=
ype is not strong enough at
> +/// the moment. This should be resolved if there is an implementation fo=
r `MaybeUninit<i32>` as
> +/// `AtomicImpl`.
> +///
> +/// [`transmute()`]: core::mem::transmute
> +/// [round-trip transmutability]: AllowAtomic#round-trip-transmutability
> +pub unsafe trait AllowAtomic: Sized + Send + Copy {
> +    /// The backing atomic implementation type.
> +    type Repr: AtomicImpl;
> +}
> +
> +#[inline(always)]
> +const fn into_repr<T: AllowAtomic>(v: T) -> T::Repr {
> +    // SAFETY: Per the safety requirement of `AllowAtomic`, the transmut=
e operation is sound.
> +    unsafe { core::mem::transmute_copy(&v) }
> +}
> +
> +/// # Safety
> +///
> +/// `r` must be a valid bit pattern of `T`.
> +#[inline(always)]
> +const unsafe fn from_repr<T: AllowAtomic>(r: T::Repr) -> T {
> +    // SAFETY: Per the safety requirement of the function, the transmute=
 operation is sound.
> +    unsafe { core::mem::transmute_copy(&r) }
> +}
> +
> +impl<T: AllowAtomic> Atomic<T> {
> +    /// Creates a new atomic.

s/atomic/atomic `T`/

> +    pub const fn new(v: T) -> Self {
> +        Self(UnsafeCell::new(v))
> +    }
> +
> +    /// Creates a reference to [`Self`] from a pointer.

s/[`Self`]/an atomic `T`/

> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` has to be a valid pointer.

s/has to be a/is/
s/pointer//

> +    /// - `ptr` has to be valid for both reads and writes for the whole =
lifetime `'a`.

s/has to be/is/
s/both//
s/the whole lifetime//

> +    /// - For the duration of `'a`, other accesses to the object cannot =
cause data races (defined

s/the object/`*ptr`/
s/cannot/must not/

> +    ///   by [`LKMM`]) against atomic operations on the returned referen=
ce. Note that if all other
> +    ///   accesses are atomic, then this safety requirement is trivially=
 fulfilled.
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    ///
> +    /// # Examples
> +    ///
> +    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or=
 [`Atomic::store()`] can
> +    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquir=
e()` or
> +    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
> +    ///
> +    /// ```rust

`rust` is the default, so you can just omit it.

> +    /// # use kernel::types::Opaque;
> +    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
> +    ///
> +    /// // Assume there is a C struct `Foo`.

s/F/f/

> +    /// mod cbindings {
> +    ///     #[repr(C)]
> +    ///     pub(crate) struct foo { pub(crate) a: i32, pub(crate) b: i32=
 }

Why not format this normally?

> +    /// }
> +    ///
> +    /// let tmp =3D Opaque::new(cbindings::foo { a: 1, b: 2});

Missing space before `}`.

> +    ///
> +    /// // struct foo *foo_ptr =3D ..;
> +    /// let foo_ptr =3D tmp.get();
> +    ///
> +    /// // SAFETY: `foo_ptr` is a valid pointer, and `.a` is in bounds.
> +    /// let foo_a_ptr =3D unsafe { &raw mut (*foo_ptr).a };
> +    ///
> +    /// // a =3D READ_ONCE(foo_ptr->a);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for read, and all acce=
sses on it is atomic, so no
> +    /// // data race.
> +    /// let a =3D unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
> +    /// # assert_eq!(a, 1);
> +    ///
> +    /// // smp_store_release(&foo_ptr->a, 2);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for write, and all acc=
esses on it is atomic, so
> +    /// // no data race.
> +    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
> +    /// ```
> +    ///
> +    /// However, this should be only used when communicating with C side=
 or manipulating a C struct.
> +    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
> +    where
> +        T: Sync,
> +    {
> +        // CAST: `T` is transparent to `Atomic<T>`.
> +        // SAFETY: Per function safety requirement, `ptr` is a valid poi=
nter and the object will
> +        // live long enough. It's safe to return a `&Atomic<T>` because =
function safety requirement
> +        // guarantees other accesses won't cause data races.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }
> +
> +    /// Returns a pointer to the underlying atomic variable.
> +    ///
> +    /// Extra safety requirement on using the return pointer: the operat=
ions done via the pointer
> +    /// cannot cause data races defined by [`LKMM`].

I don't think this is correct. I could create an atomic and then share
it with the C side via this function, since I have exclusive access, the
writes to this pointer don't need to be atomic.

We also don't document additional postconditions like this... If you
really would have to do it like this (which you shouldn't given the
example above), you would have to make this function `unsafe`, otherwise
there is no way to ensure that people adhere to it (since it isn't part
of the safety docs).

> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    pub const fn as_ptr(&self) -> *mut T {
> +        self.0.get()
> +    }
> +
> +    /// Returns a mutable reference to the underlying atomic variable.
> +    ///
> +    /// This is safe because the mutable reference of the atomic variabl=
e guarantees the exclusive
> +    /// access.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        // SAFETY: `self.as_ptr()` is a valid pointer to `T`. `&mut self=
` guarantees the exclusive
> +        // access, so it's safe to reborrow mutably.
> +        unsafe { &mut *self.as_ptr() }
> +    }
> +}
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasBasicOps,
> +{
> +    /// Loads the value from the atomic variable.

s/variable/`T`/

> +    ///
> +    /// # Examples
> +    ///
> +    /// Simple usages:

I would remove this.

> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x =3D Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// let x =3D Atomic::new(42i64);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_read", "atomic64_read"))]
> +    #[inline(always)]
> +    pub fn load<Ordering: AcquireOrRelaxed>(&self, _: Ordering) -> T {
> +        // CAST: Per the safety requirement of `AllowAtomic`, a valid po=
inter of `T` is also a
> +        // valid pointer of `T::Repr`.

Well not exactly... The cast is fine due to the round-trip
transmutability, but you're not allowed to write arbitrary values to it.
Only values that are transmutable to `T`. So it is valid for reads and
valid for writes of values transmutable to `T`.

> +        let a =3D self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_read*() function:
> +        //   - `a` is a valid pointer for the function per the CAST just=
ification above.
> +        //   - Per the type guarantees, the following atomic operation w=
on't cause data races.

Which type guarantees? `Self`?

> +        // - For extra safety requirement of usage on pointers returned =
by `self.as_ptr()`:
> +        //   - Atomic operations are used here.
> +        let v =3D unsafe {
> +            match Ordering::TYPE {
> +                OrderingType::Relaxed =3D> T::Repr::atomic_read(a),
> +                OrderingType::Acquire =3D> T::Repr::atomic_read_acquire(=
a),
> +                _ =3D> build_error!("Wrong ordering"),
> +            }
> +        };
> +
> +        // SAFETY: The atomic variable holds a valid `T`, so `v` is a va=
lid bit pattern of `T`,
> +        // therefore it's safe to call `from_repr()`.

    // SAFETY: `v` comes from reading `a` which was derived from `self.as_p=
tr()` which points at a
    // valid `T`.

> +        unsafe { from_repr(v) }
> +    }
> +
> +    /// Stores a value to the atomic variable.

s/variable/`T`/

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x =3D Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.store(43, Relaxed);
> +    ///
> +    /// assert_eq!(43, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_set", "atomic64_set"))]
> +    #[inline(always)]
> +    pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
> +        let v =3D into_repr(v);
> +        // CAST: Per the safety requirement of `AllowAtomic`, a valid po=
inter of `T` is also a
> +        // valid pointer of `T::Repr`.

Ditto.

> +        let a =3D self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_set*() function:
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

Ditto.

---
Cheers,
Benno

> +        unsafe {
> +            match Ordering::TYPE {
> +                OrderingType::Relaxed =3D> T::Repr::atomic_set(a, v),
> +                OrderingType::Release =3D> T::Repr::atomic_set_release(a=
, v),
> +                _ =3D> build_error!("Wrong ordering"),
> +            }
> +        };
> +    }
> +}


