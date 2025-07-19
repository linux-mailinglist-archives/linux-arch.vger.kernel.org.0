Return-Path: <linux-arch+bounces-12865-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA0B0AD9F
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 05:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953741C442E0
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8F21D59F;
	Sat, 19 Jul 2025 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVE4R1FF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C756215773;
	Sat, 19 Jul 2025 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894521; cv=none; b=MQpkw5enpK5jfaN8ExysoTi4UhjcSMMUY2aTQ9aiX00AAtIB3J0eMnrs+rmuH5KmL03pE8gJMHl/MZZqj18A/R4+6RnKjXpdweN7/y+njpPdJeA+c52Rkb02C440y6bR1DcDtz3cyOKmBouzPnc4osMTybAoBLKbsHQ9iaTKMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894521; c=relaxed/simple;
	bh=3TofzzU1vS9PaF3vfaB2IJX3q8KqQPHfMx+SNKONC/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdmEHtaEg4kjd91DF3WlUKeJtn5atnskfsHQWSIY3cF9lxGgaWVM05loKm+OAAZt6Dj65GCdzTuCl/5PqvAAlhqqdJv2Lkz6wYroS301c7b/I8PIqnjGZ+udgSvEzbmXKQ/k4sXucOY7O+YGDvMc0SWqUqpdA+TOKdSL2z4Lsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVE4R1FF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e34607e575so462874985a.2;
        Fri, 18 Jul 2025 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894518; x=1753499318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qCMEP7/JiBsXcaJ7IxOVQUtQQDRbDyp8NF6CGJ+yhVQ=;
        b=OVE4R1FFEv/xNhnwDA9pBeCSnRY8lelcHXavT7Y7rEc6awJErzZvVKAMlo8kUR4CMv
         dPzcMjYbbr1qYR+GKej1HwrOp8uD1OVVWnB2P4o7/1iuMw5h561yv5IvNeTIM/EKp4CE
         9TXvndmx25Y2UdWKojUAZhe23n0JAwKmAlS7C2JM+eV1/SfK0lprWnNtUItQ+ZbwHsjY
         NUvrKo6VYB7ncg0hDPsc+2hs4YJ3apOicFcqOq1YfHj92T6OWJqKiVtGgWO1sjo4Lzk6
         TEqdAx0nqzGyWHZcUNpHL742/aPP/CIv9YVMPpaUW9wPPBBEiEgAP0TOlF0Q0Bn6UwL9
         aIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894518; x=1753499318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCMEP7/JiBsXcaJ7IxOVQUtQQDRbDyp8NF6CGJ+yhVQ=;
        b=j5RRHchnDor98Jdcw8LOiSL/FWlCiScXBlJdQoMKT3xThsCW5vU9iN97ntkFFCM0RH
         szW7ReIOt1l+9zJFAV7CoCdqlzfNg2zxqIkd2xxBMfDFJ8LMNlpfvdVKrZk78n3RzloT
         a6Gv/e9Eku9ZaJ9u32o7ncJ18+EBBa23O4kRF+tO39RA5+bh8wYlBSuB4kKKEnvDEEUZ
         X3c6cPwTCQ5uK1di5M2x8WWGz+1DE3X0MUQq7onQn3HnEm4Z/dgIcLt7adkESwFWM78M
         4Se3DvuZphPJKqw8D+xjDCcN9idCPveOSkW0rZIywdPNVSQExq2EOaBLJWAULsSr3Js9
         fZLg==
X-Forwarded-Encrypted: i=1; AJvYcCWDLq7607GCwf0TGgK/hsjNAOdgSxC+gUcBQMqVvpP2+wTmPZafuBvJg7hqFyzTfEZAw9sJ8JeL36mj@vger.kernel.org, AJvYcCXM0xiyAZbesdO/uskSxzhRo6LAEmSqyqDOFc2bKm10/BCiAonAxecLpGBeTTl2LLI/YJM5Q3+ZP6B0V2i8s/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBPlSntoel2pVGX9aR7QbKqP2bd3ah9evFZyQXlG4PTG31kAp
	JsMut80DU7J+It3zLSdu/WH4WZpIYy6HCbiQ9lu6xG3Vta6snZZz4C0S
X-Gm-Gg: ASbGncuGWj1RiSbIZ9AokkjK3QyZqHZc2zwEI5ItJqyTAq6ycGs7xRcL3qdWvz+okd2
	xjv4t5iNU+uoo+x2Mkbg/Tn/Kpe+gcQy60F/Gc41u9G/LmXZ2dp1mBZybGs8wKL7TQgri+pdXn4
	5k0WhP0VMk8b0qnnJaLlPjCZXIjeVKhosW/O1igQJ0pelj1gS5Ud7aN7Bjw/CISP5V/gy2Dqo2V
	U78Q/ZS5HQPi527kLt38luaUffznxceEQQl+mkaVx2BBuiNk0a8iM3Sm/0uHyWRmp817dQXnML/
	1XygxfmUHwt73OzVyUZ6xkbgLZsWt8CgNEqpR+IKuaSi6CGUTkeiwf1r/cko/+01CYKtvHeBGly
	5nhqrjlr60QkYzuiDjSSCDxicuwJsSlIJWnXgX6VpiXa2wx8VlMAOHgDnGGFZM999SW91pczK2/
	1cKPAOcMQ/yvYgk4qIYk2JJfs=
X-Google-Smtp-Source: AGHT+IHj49PauWOY2PTYKnX0AVHbbEr1lCh6ncfAGROs13BKK8DCqtD/6ECMBVe43HfOvhkqTajhUw==
X-Received: by 2002:a05:620a:4249:b0:7e1:5b6c:dd11 with SMTP id af79cd13be357-7e356a6a34emr794853985a.25.1752894518421;
        Fri, 18 Jul 2025 20:08:38 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b28a64sm159087885a.11.2025.07.18.20.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:08:37 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4A151F40066;
	Fri, 18 Jul 2025 23:08:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 18 Jul 2025 23:08:37 -0400
X-ME-Sender: <xms:NQx7aM5VMb3fUoEmsvEVm5O7fY0IcjXaeJ75kZTtgs3THJcccGca8g>
    <xme:NQx7aPj7D-P-wJeGT5NEF2vOgRE9RI5xc-b7Us8k1DUP50ThmlOZqdXDIOyYnawzm
    dQcBkwTrICETXhyXQ>
X-ME-Received: <xmr:NQx7aKLCwAaAHepE-TXGEDdp6jiXIXcDwJ0Ev4lcCQJ1iNzY3xATnuSWGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeihedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoh
    eplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:NQx7aJrCP7CuUJT28m22sVN9jTL7Ju6M_Bv1XDuPZYrqKuppxLyldg>
    <xmx:NQx7aAxOmM_norr_3ZTukRlKMhQuKhcimV3P_iJwAw3SCKt-opP2xA>
    <xmx:NQx7aNcMueRwpqlEO0leJb0aJx6O4Mm8Dsf3eUz6UJnfWo0cisyI9A>
    <xmx:NQx7aMeCNepbHWXhSfZYpw_BohqtVl7rRn7NYaiJ703vFI2bhYZSyg>
    <xmx:NQx7aPbL3iqcl9hRNHeTncOufp93xsbPTV0FNZcyKPCnQ1ZjG486smQ6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:08:36 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: "Miguel Ojeda" <ojeda@kernel.org>,
	"Alex Gaynor" <alex.gaynor@gmail.com>,
	"Boqun Feng" <boqun.feng@gmail.com>,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Wedson Almeida Filho" <wedsonaf@gmail.com>,
	"Viresh Kumar" <viresh.kumar@linaro.org>,
	"Lyude Paul" <lyude@redhat.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Mitchell Levy" <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Alan Stern" <stern@rowland.harvard.edu>
Subject: [PATCH v8 4/9] rust: sync: atomic: Add generic atomics
Date: Fri, 18 Jul 2025 20:08:22 -0700
Message-Id: <20250719030827.61357-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250719030827.61357-1-boqun.feng@gmail.com>
References: <20250719030827.61357-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
added, currently `T` needs to be Send + Copy because these are the
straightforward usages and all basic types support this.

Implement `AtomicType` for `i32` and `i64`, and so far only basic
operations load() and store() are introduced.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs           | 274 +++++++++++++++++++++++++++
 rust/kernel/sync/atomic/predefine.rs |  15 ++
 2 files changed, 289 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/predefine.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 2302e6d51fe2..14097ebc5f85 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -19,6 +19,280 @@
 #[allow(dead_code, unreachable_pub)]
 mod internal;
 pub mod ordering;
+mod predefine;
 
 pub use internal::AtomicImpl;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+use crate::build_error;
+use internal::{AtomicBasicOps, AtomicRepr};
+use ordering::OrderingType;
+
+/// A memory location which can be safely modified from multiple execution contexts.
+///
+/// This has the same size, alignment and bit validity as the underlying type `T`. And it disables
+/// niche optimization for the same reason as [`UnsafeCell`].
+///
+/// The atomic operations are implemented in a way that is fully compatible with the [Linux Kernel
+/// Memory (Consistency) Model][LKMM], hence they should be modeled as the corresponding
+/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from_ptr()`] and
+/// [`Atomic::as_ptr()`], this provides a way to interact with [C-side atomic operations]
+/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`, `WRITE_ONCE()`,
+/// `smp_load_acquire()` and `smp_store_release()`).
+///
+/// # Invariants
+///
+/// `self.0` is a valid `T`.
+///
+/// [`UnsafeCell`]: core::cell::UnsafeCell
+/// [LKMM]: srctree/tools/memory-model/
+/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt
+#[repr(transparent)]
+pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
+
+// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
+unsafe impl<T: AtomicType> Sync for Atomic<T> {}
+
+/// Types that support basic atomic operations.
+///
+/// # Round-trip transmutability
+///
+/// `T` is round-trip transmutable to `U` if and only if both of these properties hold:
+///
+/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
+/// - Transmuting (e.g. using [`transmute()`]) a value of type `T` to `U` and then to `T` again
+///   yields a value that is in all aspects equivalent to the original value.
+///
+/// # Safety
+///
+/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
+/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
+///
+/// Note that this is more relaxed than requiring the bi-directional transmutability (i.e.
+/// [`transmute()`] is always sound between `U` and `T`) because of the support for atomic
+/// variables over unit-only enums, see [Examples].
+///
+/// # Limitations
+///
+/// Because C primitives are used to implement the atomic operations, and a C function requires a
+/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hence at the Rust <-> C
+/// surface, only types with all the bits initialized can be passed. As a result, types like `(u8,
+/// u16)` (padding bytes are uninitialized) are currently not supported. Note that technically
+/// these types can be supported if some APIs are removed for them and the inner implementation is
+/// tweaked, but the justification of support such a type is not strong enough at the moment. This
+/// should be resolved if there is an implementation for `MaybeUninit<i32>` as `AtomicImpl`.
+///
+/// # Examples
+///
+/// A unit-only enum that implements [`AtomicType`]:
+///
+/// ```
+/// use kernel::sync::atomic::{AtomicType, Atomic, Relaxed};
+///
+/// #[derive(Clone, Copy, PartialEq, Eq)]
+/// #[repr(i32)]
+/// enum State {
+///     Uninit = 0,
+///     Working = 1,
+///     Done = 2,
+/// };
+///
+/// // SAFETY: `State` and `i32` has the same size and alignment, and it's round-trip
+/// // transmutable to `i32`.
+/// unsafe impl AtomicType for State {
+///     type Repr = i32;
+/// }
+///
+/// let s = Atomic::new(State::Uninit);
+///
+/// assert_eq!(State::Uninit, s.load(Relaxed));
+/// ```
+/// [`transmute()`]: core::mem::transmute
+/// [round-trip transmutable]: AtomicType#round-trip-transmutability
+/// [Examples]: AtomicType#examples
+pub unsafe trait AtomicType: Sized + Send + Copy {
+    /// The backing atomic implementation type.
+    type Repr: AtomicImpl;
+}
+
+#[inline(always)]
+const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
+    // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
+    // `T::Repr`, therefore the transmute operation is sound.
+    unsafe { core::mem::transmute_copy(&v) }
+}
+
+/// # Safety
+///
+/// `r` must be a valid bit pattern of `T`.
+#[inline(always)]
+const unsafe fn from_repr<T: AtomicType>(r: T::Repr) -> T {
+    // SAFETY: Per the safety requirement of the function, the transmute operation is sound.
+    unsafe { core::mem::transmute_copy(&r) }
+}
+
+impl<T: AtomicType> Atomic<T> {
+    /// Creates a new atomic `T`.
+    pub const fn new(v: T) -> Self {
+        // INVARIANT: Per the safety requirement of `AtomicType`, `into_repr(v)` is a valid `T`.
+        Self(AtomicRepr::new(into_repr(v)))
+    }
+
+    /// Creates a reference to an atomic `T` from a pointer of `T`.
+    ///
+    /// This usually is used when when communicating with C side or manipulating a C struct, see
+    /// examples below.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` is aligned to `align_of::<T>()`.
+    /// - `ptr` is valid for reads and writes for `'a`.
+    /// - For the duration of `'a`, other accesses to `*ptr` must not cause data races (defined
+    ///   by [`LKMM`]) against atomic operations on the returned reference. Note that if all other
+    ///   accesses are atomic, then this safety requirement is trivially fulfilled.
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    ///
+    /// # Examples
+    ///
+    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`Atomic::store()`] can
+    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()` or
+    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
+    ///
+    /// ```
+    /// # use kernel::types::Opaque;
+    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
+    ///
+    /// // Assume there is a C struct `foo`.
+    /// mod cbindings {
+    ///     #[repr(C)]
+    ///     pub(crate) struct foo {
+    ///         pub(crate) a: i32,
+    ///         pub(crate) b: i32
+    ///     }
+    /// }
+    ///
+    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2 });
+    ///
+    /// // struct foo *foo_ptr = ..;
+    /// let foo_ptr = tmp.get();
+    ///
+    /// // SAFETY: `foo_ptr` is valid, and `.a` is in bounds.
+    /// let foo_a_ptr = unsafe { &raw mut (*foo_ptr).a };
+    ///
+    /// // a = READ_ONCE(foo_ptr->a);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is valid for read, and all other accesses on it is atomic, so no
+    /// // data race.
+    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
+    /// # assert_eq!(a, 1);
+    ///
+    /// // smp_store_release(&foo_ptr->a, 2);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is valid for writes, and all other accesses on it is atomic, so
+    /// // no data race.
+    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
+    /// ```
+    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
+    where
+        T: Sync,
+    {
+        // CAST: `T` and `Atomic<T>` have the same size, alignment and bit validity.
+        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
+        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
+        // guarantees other accesses won't cause data races.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns a pointer to the underlying atomic `T`.
+    ///
+    /// Note that use of the return pointer must not cause data races defined by [`LKMM`].
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is valid and properly aligned (i.e. aligned to [`align_of::<T>()`]).
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    /// [`align_of::<T>()`]: core::mem::align_of
+    pub const fn as_ptr(&self) -> *mut T {
+        // GUARANTEE: Per the function guarantee of `AtomicRepr::as_ptr()`, the `self.0.as_ptr()`
+        // must be a valid and properly aligned pointer for `T::Repr`, and per the safety guarantee
+        // of `AtomicType`, it's a valid and properly aligned pointer of `T`.
+        self.0.as_ptr().cast()
+    }
+
+    /// Returns a mutable reference to the underlying atomic `T`.
+    ///
+    /// This is safe because the mutable reference of the atomic `T` guarantees exclusive access.
+    pub fn get_mut(&mut self) -> &mut T {
+        // CAST: `T` and `T::Repr` has the same size and alignment per the safety requirement of
+        // `AtomicType`, and per the type invariants `self.0` is a valid `T`, therefore the casting
+        // result is a valid pointer of `T`.
+        // SAFETY: The pointer is valid per the CAST comment above, and the mutable reference
+        // guarantees exclusive access.
+        unsafe { &mut *self.0.as_ptr().cast() }
+    }
+}
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicBasicOps,
+{
+    /// Loads the value from the atomic `T`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// let x = Atomic::new(42i64);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_read", "atomic64_read"))]
+    #[inline(always)]
+    pub fn load<Ordering: ordering::AcquireOrRelaxed>(&self, _: Ordering) -> T {
+        let v = {
+            match Ordering::TYPE {
+                OrderingType::Relaxed => T::Repr::atomic_read(&self.0),
+                OrderingType::Acquire => T::Repr::atomic_read_acquire(&self.0),
+                _ => build_error!("Wrong ordering"),
+            }
+        };
+
+        // SAFETY: `v` comes from reading `self.0`, which is a valid `T` per the type invariants.
+        unsafe { from_repr(v) }
+    }
+
+    /// Stores a value to the atomic `T`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.store(43, Relaxed);
+    ///
+    /// assert_eq!(43, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_set", "atomic64_set"))]
+    #[inline(always)]
+    pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
+        let v = into_repr(v);
+
+        // INVARIANT: `v` is a valid `T`, and is stored to `self.0` by `atomic_set*()`.
+        match Ordering::TYPE {
+            OrderingType::Relaxed => T::Repr::atomic_set(&self.0, v),
+            OrderingType::Release => T::Repr::atomic_set_release(&self.0, v),
+            _ => build_error!("Wrong ordering"),
+        }
+    }
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
new file mode 100644
index 000000000000..33356deee952
--- /dev/null
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Pre-defined atomic types
+
+// SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
+// itself.
+unsafe impl super::AtomicType for i32 {
+    type Repr = i32;
+}
+
+// SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
+// itself.
+unsafe impl super::AtomicType for i64 {
+    type Repr = i64;
+}
-- 
2.39.5 (Apple Git-154)


