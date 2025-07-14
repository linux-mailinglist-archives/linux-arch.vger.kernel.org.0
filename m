Return-Path: <linux-arch+bounces-12736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A845B03BE5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 12:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFCE189876E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9D20C030;
	Mon, 14 Jul 2025 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgm+mYt3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843417A2E8;
	Mon, 14 Jul 2025 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489019; cv=none; b=dlyz9wUtcCWABihAKdn3k8ZUlC7BUJvGZ3IU1i262rpWcBKRKxyClcZuqeiuZmKQsZe/JkuYMDy9rhJ7Q2tgQHhCJ1t+KZEQ6nng/D+ucX/CztWuCQfDqDwyUKkDGHVZ8AeIibsZiQOUKScdWWBvxi3ls0/ftVPkHkOPi30wQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489019; c=relaxed/simple;
	bh=xsItK91VrA1bskmLr1oLwQycl+FijrGORy+M8bPXaCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OyvmXhLym7XTqU1aXAtFEq3b3WoZsxfJlkXfcU/lLdm7vXAvUjjc9dFtLbBfscZokYndnc3w06UmdTBNHOu3eAcpsv5rw7/yeBUt3fZcejBJ6D9pgNjvSNqoyM0rdjXIQ1RwHgBc15Il72/4scNpbiGaOID8FhfTiIR79FjC54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgm+mYt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF6EC4CEED;
	Mon, 14 Jul 2025 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752489018;
	bh=xsItK91VrA1bskmLr1oLwQycl+FijrGORy+M8bPXaCc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Qgm+mYt37Cfu6IoTaKYbAdMpasPfy1iQeePXJvJVqYmagimt9UnEgdkmqcvMrUTXr
	 pyOV+LI5ut9H6P2GDRSXJixSlgds7dSD5G0y/iEVS/BUlSATywUX2wKLeDjBYODiXh
	 9znSBNYhwrmKAeIEYERrg9ekzXDyet2IieQC5wFz85iBZB62u1LJpTiHRq03lPjSSR
	 ZfQUYn3r0hnc2c85tJDbfhTJJWivcG5r596XvHffljbEANVYvoJgn4LVVxccLFLFmT
	 643uFApPtjfRWiqo5YtFkcGk+Km68P7+9wiyWaREcVH/8t6LqMC1eDc3Ur5Wut1W8t
	 ZgvGaArzJAvrw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 12:30:12 +0200
Message-Id: <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org>
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
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
In-Reply-To: <20250714053656.66712-5-boqun.feng@gmail.com>

On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> added, currently `T` needs to be Send + Copy because these are the
> straightforward usages and all basic types support this.
>
> Implement `AllowAtomic` for `i32` and `i64`, and so far only basic
> operations load() and store() are introduced.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs         |  14 ++
>  rust/kernel/sync/atomic/generic.rs | 285 +++++++++++++++++++++++++++++
>  2 files changed, 299 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/generic.rs
>
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index e80ac049f36b..c5193c1c90fe 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -16,7 +16,21 @@
>  //!
>  //! [`LKMM`]: srctree/tools/memory-model/
> =20
> +pub mod generic;

Hmm, maybe just re-export the stuff? I don't think there's an advantage
to having the generic module be public.

>  pub mod ops;
>  pub mod ordering;
> =20
> +pub use generic::Atomic;
>  pub use ordering::{Acquire, Full, Relaxed, Release};
> +
> +// SAFETY: `i32` has the same size and alignment with itself, and is rou=
nd-trip transmutable to
> +// itself.
> +unsafe impl generic::AllowAtomic for i32 {
> +    type Repr =3D i32;
> +}
> +
> +// SAFETY: `i64` has the same size and alignment with itself, and is rou=
nd-trip transmutable to
> +// itself.
> +unsafe impl generic::AllowAtomic for i64 {
> +    type Repr =3D i64;
> +}
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic=
/generic.rs
> new file mode 100644
> index 000000000000..b3e07328d857
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic atomic primitives.
> +
> +use super::ops::{AtomicHasBasicOps, AtomicImpl};
> +use super::{ordering, ordering::OrderingType};
> +use crate::build_error;
> +use core::cell::UnsafeCell;
> +
> +/// A memory location which can be safely modified from multiple executi=
on contexts.
> +///
> +/// This has the same size, alignment and bit validity as the underlying=
 type `T`.

Let's also mention that this disables any niche optimizations (due to
the unsafe cell).

> +///
> +/// The atomic operations are implemented in a way that is fully compati=
ble with the [Linux Kernel
> +/// Memory (Consistency) Model][LKMM], hence they should be modeled as t=
he corresponding
> +/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from_pt=
r()`] and
> +/// [`Atomic::as_ptr()`], this provides a way to interact with [C-side a=
tomic operations]
> +/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`, `W=
RITE_ONCE()`,
> +/// `smp_load_acquire()` and `smp_store_release()`).
> +///
> +/// [LKMM]: srctree/tools/memory-model/
> +/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt

Did you check that these links looks good in rustdoc?

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
> +///
> +/// `T` is round-trip transmutable to `U` if and only if both of these p=
roperties hold:
> +///
> +/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
> +/// - Transmuting (e.g. using [`transmute()`]) a value of type `T` to `U=
` and then to `T` again
> +///   yields a value that is in all aspects equivalent to the original v=
alue.
> +///
> +/// # Safety
> +///
> +/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
> +/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
> +///
> +/// Note that this is more relaxed than requiring the bi-directional tra=
nsmutability (i.e.
> +/// [`transmute()`] is always sound between `U` to `T`) because of the s=
upport for atomic variables

s/ to / and /

> +/// over unit-only enums, see [Examples].
> +///
> +/// # Limitations
> +///
> +/// Because C primitives are used to implement the atomic operations, an=
d a C function requires a
> +/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hen=
ce at the Rust <-> C
> +/// surface, only types with no uninitialized bits can be passed. As a r=
esult, types like `(u8,

s/no uninitialized/initialized/

> +/// u16)` (a tuple with a `MaybeUninit` hole in it) are currently not su=
pported. Note that

s/a tuple with a `MaybeUninit` hole in it/padding bytes are uninitialized/

> +/// technically these types can be supported if some APIs are removed fo=
r them and the inner
> +/// implementation is tweaked, but the justification of support such a t=
ype is not strong enough at
> +/// the moment. This should be resolved if there is an implementation fo=
r `MaybeUninit<i32>` as
> +/// `AtomicImpl`.
> +///
> +/// # Examples
> +///
> +/// A unit-only enum that implements [`AllowAtomic`]:
> +///
> +/// ```
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
> +/// [`transmute()`]: core::mem::transmute
> +/// [round-trip transmutable]: AllowAtomic#round-trip-transmutability
> +/// [Examples]: AllowAtomic#examples
> +pub unsafe trait AllowAtomic: Sized + Send + Copy {
> +    /// The backing atomic implementation type.
> +    type Repr: AtomicImpl;
> +}
> +
> +#[inline(always)]
> +const fn into_repr<T: AllowAtomic>(v: T) -> T::Repr {
> +    // SAFETY: Per the safety requirement of `AllowAtomic`, the transmut=
e operation is sound.

Please explain the concrete parts of the safety requirements that you
are using here (ie round-trip-transmutability).

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
> +    /// Creates a new atomic `T`.
> +    pub const fn new(v: T) -> Self {
> +        Self(UnsafeCell::new(v))
> +    }
> +
> +    /// Creates a reference to an atomic `T` from a pointer of `T`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` is aligned to `align_of::<T>()`.
> +    /// - `ptr` is valid for reads and writes for `'a`.
> +    /// - For the duration of `'a`, other accesses to `*ptr` must not ca=
use data races (defined
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
> +    /// ```
> +    /// # use kernel::types::Opaque;
> +    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
> +    ///
> +    /// // Assume there is a C struct `foo`.
> +    /// mod cbindings {
> +    ///     #[repr(C)]
> +    ///     pub(crate) struct foo {
> +    ///         pub(crate) a: i32,
> +    ///         pub(crate) b: i32
> +    ///     }
> +    /// }
> +    ///
> +    /// let tmp =3D Opaque::new(cbindings::foo { a: 1, b: 2 });
> +    ///
> +    /// // struct foo *foo_ptr =3D ..;
> +    /// let foo_ptr =3D tmp.get();
> +    ///
> +    /// // SAFETY: `foo_ptr` is valid, and `.a` is in bounds.
> +    /// let foo_a_ptr =3D unsafe { &raw mut (*foo_ptr).a };
> +    ///
> +    /// // a =3D READ_ONCE(foo_ptr->a);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is valid for read, and all other accesses=
 on it is atomic, so no
> +    /// // data race.
> +    /// let a =3D unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
> +    /// # assert_eq!(a, 1);
> +    ///
> +    /// // smp_store_release(&foo_ptr->a, 2);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is valid for writes, and all other access=
es on it is atomic, so
> +    /// // no data race.
> +    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
> +    /// ```
> +    ///
> +    /// However, this should be only used when communicating with C side=
 or manipulating a C
> +    /// struct.

This sentence should be above the `Safety` section.

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
> +    /// Returns a pointer to the underlying atomic `T`.
> +    ///
> +    /// Note that use of the return pointer must not cause data races de=
fined by [`LKMM`].
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// The returned pointer is properly aligned (i.e. aligned to [`alig=
n_of::<T>()`])

You really only need this guarantee? Not validity etc?

> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    /// [`align_of::<T>()`]: core::mem::align_of
> +    pub const fn as_ptr(&self) -> *mut T {
> +        // GUARANTEE: `self.0` has the same alignment of `T`.
> +        self.0.get()
> +    }
> +
> +    /// Returns a mutable reference to the underlying atomic `T`.
> +    ///
> +    /// This is safe because the mutable reference of the atomic `T` gua=
rantees the exclusive

s/the exclusive/exclusive/

---
Cheers,
Benno

> +    /// access.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        // SAFETY: `self.as_ptr()` is a valid pointer to `T`. `&mut self=
` guarantees the exclusive
> +        // access, so it's safe to reborrow mutably.
> +        unsafe { &mut *self.as_ptr() }
> +    }
> +}

