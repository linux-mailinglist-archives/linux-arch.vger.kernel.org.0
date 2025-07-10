Return-Path: <linux-arch+bounces-12617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C2AFF92A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF3B1C82122
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E02BFC60;
	Thu, 10 Jul 2025 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKtndT0d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88A29B79A;
	Thu, 10 Jul 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127267; cv=none; b=jbR0XoLGMHrfOEAMsn90KwnOJcVbeMFXjjMtyTfJrM8AKJH4A6e70rvnrDpTjK5ZUy0tMhLKKaflSLc6o5/isXkdN319Fqav6R5O4wn6F1zO5ezu+wnuZi7OCpFeL4RvSmlMrXH6TtALDv7URLedBs+mbCzJLNmCzmkjq8h2IIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127267; c=relaxed/simple;
	bh=VmcFGjNBgQVcosHTOemoi6Xs4LX14iibAVEiHEoGvpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgQIyz4aIb6mKVFqBOVzwsMlgbC9U9NINodDyV5+4nuNh3PjVMR+pqPSXxTev/MJQdhwy2kKHcxAtZT+pG225Tu15DAyCtmn63+vRRIbO4BC04YCgvsAIGgFu2Ql59EN68Rhc0JbulIwgiCrnbg6J7+/zrm995zhot/kSujjmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKtndT0d; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d9eac11358so67234085a.3;
        Wed, 09 Jul 2025 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127264; x=1752732064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x+a40BqT8xHs+EEr59GexxnRcUQ9IWcLKWLKYM1OVGo=;
        b=HKtndT0diB5sQO8WZPmccVsGWpEVGIhA45efZmNk8tfbmRAWooJVK4ub7boLB+eP/3
         kOdXtRCtm4AO7Qvt/PxKzOYfOk7YOZoHym0cbbclboudoPPqt16KcMtUPl2yuL2oTmrJ
         XM9lemWdBjgf8MNsReHMwwz7QLDb7jOmJe/9iYCnK/2xxOfGFkJEjy3psQx5P80pi8Tw
         O5GYk9xrDrQQUDJSkN02bZmZ8VUaUgjl0+R0qa70Ufpa2yHqMxHxx43y0zHwd78lt1ER
         sxIaeHtC6BVeyHZmLKo0inJ25K/oWUJhnEOJ8/OG+k8QpSliabOE2c+wlVZs48gg0Jwh
         2hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127264; x=1752732064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+a40BqT8xHs+EEr59GexxnRcUQ9IWcLKWLKYM1OVGo=;
        b=YFHx52p1zAfl1q37CX2LXaYia6yb8qPb1kgObIx1lbP5qBN6WMv1qCLQ+QsQ7D1VP2
         1BljodSlz7a6MpawRGHRqxwgW0adZyQEG0PzYf4pQ8eY2z2xTydN9Q6LVSrFZmuVJUXd
         Xbguk11C8DqTseBRA7AxL3dh/aDO/IpZKNo2BHX1JQHqL2gxdN7fI81Q5G/TAEF8JwAy
         BQTJK973o3iwycYSrTpcrnb2SqAYd5GZ6yGo2q2Q/+g1nguoUBibSomw/RrtdVt/AKQl
         1dTaYneHWrJM2HYcRf27NJ8gtCIEkx/0Qf0rgbG6zVpckW53hI0WsvNXUvskdc06lwLM
         etKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWP9SYfiCFNkfO5VcSX7CsCpJMonRnNu/EY9/g8KpDG2GaW8jdfxyNgfjxepHytI/P1quJJbUc1JUE3jecBbo=@vger.kernel.org, AJvYcCVyQFINoHSdrhBDSRwev/1zhXSyg6EEFy6J8p3SfaAtI3bTquScTUPg3XL8gIrYPOS6P3t8AdrOHwBt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5+0AXSn1kuoafUpmWid6aeR9puWEWCLp4aqJlpn7Qj3k+3ai
	e68qenQvMhZORuOue7m4i/kWEQ/cfEeyKtJSH3T1TpEat5hlGPSJzq1i
X-Gm-Gg: ASbGncs2a64lCRCHDDjmG1J/ktyT60qqrUYlNO9V2ATFJjhXc7ATEsFhcFDR2Js7fJz
	CIXXNNuv1pw6w306sF9YlIW8ogk/GzQ0K8IucAauciQRttwYJlX2T+irpCc42Ek3fk/69h/Wgus
	NWzW6GMgDV3rlHvo470pO34NqY1vuZNQBjZ2ocOF2zNdFk29PSTsjMeQCkIVDGCk2E3nRv2iu0L
	i3AW80Ij141xmwHOO3hYghIbAh4nVvK6y+dzhkmJy9U8erxbsnVnHmIOyj2bT50q3/lDJhrNnyJ
	vaIUxkpGo4Ba/ZKHPpv81cfTJhWeqaICLO1+nVQdF8NE/ps2aLQ/BMVkVwZeRb6RklgVLp7x5D6
	KZVdGn9bKsdMVFUU0LL/voRZL4KE92yTKF/9sMbnOsTpuLgIv3Lmi
X-Google-Smtp-Source: AGHT+IGvdfEaXO1L1LjPSrP968kTWG+2TSbB3wHTVx8GLflxdyv5bd3I8EKlHuRyDvyWyOFJ2t9G6g==
X-Received: by 2002:a05:6214:5186:b0:700:c46f:3bd with SMTP id 6a1803df08f44-7048b8d94dbmr90548736d6.25.1752127263492;
        Wed, 09 Jul 2025 23:01:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3971dsm5105016d6.62.2025.07.09.23.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:01:03 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 88CDEF4006C;
	Thu, 10 Jul 2025 02:01:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 10 Jul 2025 02:01:02 -0400
X-ME-Sender: <xms:HldvaExR9YSDNUFvrTmJ6_zV8adizny5MG4aDKSvBXNJ9ByrhYzYpw>
    <xme:HldvaJxOXyc_OsuoKPmRYQJ-XAjJ7STXLE0aOfnauS2AWWwkAI3IRSFAiitN4vyVz
    Zun1FAEbxCUvbXUNg>
X-ME-Received: <xmr:HldvaK7_E2j9SadNKpvy3e84aWTVjk1yAA_F1kBu-Y5G_NT_PDeBza-MZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeijecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:HldvaCDbk4SyF1-uiI0Ltewh4nGkNQTa0jyEg6aBEdDx5K5m1hrz9Q>
    <xmx:HldvaEBkSsNshPkWOCc84r135RjDnHI-ade-FbG4h6jwVHHYIEcbrg>
    <xmx:HldvaLpFYnFnTfEEZRsWV2Tn4DVe3bpsZ_SjMPB8ueuP_ILL30F0cA>
    <xmx:HldvaO3VpXRavOuU7sJv6-OMUTcFUahorCnzftYyh6QMUwklx_VG9g>
    <xmx:HldvaCXl-GK6DNZvIeY_kEELy_Yycaj_f8toxNflSEdLCP406e72u97M>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:01:01 -0400 (EDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 4/9] rust: sync: atomic: Add generic atomics
Date: Wed,  9 Jul 2025 23:00:47 -0700
Message-Id: <20250710060052.11955-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250710060052.11955-1-boqun.feng@gmail.com>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
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

Implement `AllowAtomic` for `i32` and `i64`, and so far only basic
operations load() and store() are introduced.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs         |  14 ++
 rust/kernel/sync/atomic/generic.rs | 289 +++++++++++++++++++++++++++++
 2 files changed, 303 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/generic.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index e80ac049f36b..c5193c1c90fe 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -16,7 +16,21 @@
 //!
 //! [`LKMM`]: srctree/tools/memory-model/
 
+pub mod generic;
 pub mod ops;
 pub mod ordering;
 
+pub use generic::Atomic;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+// SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
+// itself.
+unsafe impl generic::AllowAtomic for i32 {
+    type Repr = i32;
+}
+
+// SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
+// itself.
+unsafe impl generic::AllowAtomic for i64 {
+    type Repr = i64;
+}
diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
new file mode 100644
index 000000000000..e044fe21b128
--- /dev/null
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic atomic primitives.
+
+use super::ops::*;
+use super::ordering::*;
+use crate::build_error;
+use core::cell::UnsafeCell;
+
+/// A generic atomic variable.
+///
+/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to be chosen.
+///
+/// # Examples
+///
+/// A customized type stored in [`Atomic`]:
+///
+/// ```rust
+/// use kernel::sync::atomic::{generic::AllowAtomic, Atomic, Relaxed};
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
+/// unsafe impl AllowAtomic for State {
+///     type Repr = i32;
+/// }
+///
+/// let s = Atomic::new(State::Uninit);
+///
+/// assert_eq!(State::Uninit, s.load(Relaxed));
+/// ```
+///
+/// # Guarantees
+///
+/// Doing an atomic operation while holding a reference of [`Self`] won't cause a data race,
+/// this is guaranteed by the safety requirement of [`Self::from_ptr()`] and the extra safety
+/// requirement of the usage on pointers returned by [`Self::as_ptr()`].
+#[repr(transparent)]
+pub struct Atomic<T: AllowAtomic>(UnsafeCell<T>);
+
+// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
+unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
+
+/// Types that support basic atomic operations.
+///
+/// # Round-trip transmutability
+///
+/// Implementing [`AllowAtomic`] requires that the type is round-trip transmutable to its
+/// representation:
+///
+/// - Any value of [`Self`] must be sound to [`transmute()`] to a [`Self::Repr`], and this also
+///   means that a pointer to [`Self`] can be treated as a pointer to [`Self::Repr`] for reading.
+/// - If a value of [`Self::Repr`] is a result a [`transmute()`] from a [`Self`], it must be
+///   sound to [`transmute()`] the value back to a [`Self`].
+///
+/// This essentially means a valid bit pattern of `T: AllowAtomic` has to be a valid bit pattern
+/// of `T::Repr`. This is needed because [`Atomic<T: AllowAtomic>`] operates on `T::Repr` to
+/// implement atomic operations on `T`.
+///
+/// Note that this is more relaxed than bidirectional transmutability (i.e. [`transmute()`] is
+/// always sound between `T` and `T::Repr`) because of the support for atomic variables over
+/// unit-only enums:
+///
+/// ```
+/// #[repr(i32)]
+/// enum State { Init = 0, Working = 1, Done = 2, }
+/// ```
+///
+/// # Safety
+///
+/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
+/// - [`Self`] and [`Self::Repr`] must have the [round-trip transmutability].
+///
+/// # Limitations
+///
+/// Because C primitives are used to implement the atomic operations, and a C function requires a
+/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hence at the Rust <-> C
+/// surface, only types with no uninitialized bits can be passed. As a result, types like `(u8,
+/// u16)` (a tuple with a `MaybeUninit` hole in it) are currently not supported. Note that
+/// technically these types can be supported if some APIs are removed for them and the inner
+/// implementation is tweaked, but the justification of support such a type is not strong enough at
+/// the moment. This should be resolved if there is an implementation for `MaybeUninit<i32>` as
+/// `AtomicImpl`.
+///
+/// [`transmute()`]: core::mem::transmute
+/// [round-trip transmutability]: AllowAtomic#round-trip-transmutability
+pub unsafe trait AllowAtomic: Sized + Send + Copy {
+    /// The backing atomic implementation type.
+    type Repr: AtomicImpl;
+}
+
+#[inline(always)]
+const fn into_repr<T: AllowAtomic>(v: T) -> T::Repr {
+    // SAFETY: Per the safety requirement of `AllowAtomic`, the transmute operation is sound.
+    unsafe { core::mem::transmute_copy(&v) }
+}
+
+/// # Safety
+///
+/// `r` must be a valid bit pattern of `T`.
+#[inline(always)]
+const unsafe fn from_repr<T: AllowAtomic>(r: T::Repr) -> T {
+    // SAFETY: Per the safety requirement of the function, the transmute operation is sound.
+    unsafe { core::mem::transmute_copy(&r) }
+}
+
+impl<T: AllowAtomic> Atomic<T> {
+    /// Creates a new atomic.
+    pub const fn new(v: T) -> Self {
+        Self(UnsafeCell::new(v))
+    }
+
+    /// Creates a reference to [`Self`] from a pointer.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` has to be a valid pointer.
+    /// - `ptr` has to be valid for both reads and writes for the whole lifetime `'a`.
+    /// - For the duration of `'a`, other accesses to the object cannot cause data races (defined
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
+    /// ```rust
+    /// # use kernel::types::Opaque;
+    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
+    ///
+    /// // Assume there is a C struct `Foo`.
+    /// mod cbindings {
+    ///     #[repr(C)]
+    ///     pub(crate) struct foo { pub(crate) a: i32, pub(crate) b: i32 }
+    /// }
+    ///
+    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2});
+    ///
+    /// // struct foo *foo_ptr = ..;
+    /// let foo_ptr = tmp.get();
+    ///
+    /// // SAFETY: `foo_ptr` is a valid pointer, and `.a` is in bounds.
+    /// let foo_a_ptr = unsafe { &raw mut (*foo_ptr).a };
+    ///
+    /// // a = READ_ONCE(foo_ptr->a);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is a valid pointer for read, and all accesses on it is atomic, so no
+    /// // data race.
+    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
+    /// # assert_eq!(a, 1);
+    ///
+    /// // smp_store_release(&foo_ptr->a, 2);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is a valid pointer for write, and all accesses on it is atomic, so
+    /// // no data race.
+    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
+    /// ```
+    ///
+    /// However, this should be only used when communicating with C side or manipulating a C struct.
+    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
+    where
+        T: Sync,
+    {
+        // CAST: `T` is transparent to `Atomic<T>`.
+        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
+        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
+        // guarantees other accesses won't cause data races.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns a pointer to the underlying atomic variable.
+    ///
+    /// Extra safety requirement on using the return pointer: the operations done via the pointer
+    /// cannot cause data races defined by [`LKMM`].
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    pub const fn as_ptr(&self) -> *mut T {
+        self.0.get()
+    }
+
+    /// Returns a mutable reference to the underlying atomic variable.
+    ///
+    /// This is safe because the mutable reference of the atomic variable guarantees the exclusive
+    /// access.
+    pub fn get_mut(&mut self) -> &mut T {
+        // SAFETY: `self.as_ptr()` is a valid pointer to `T`. `&mut self` guarantees the exclusive
+        // access, so it's safe to reborrow mutably.
+        unsafe { &mut *self.as_ptr() }
+    }
+}
+
+impl<T: AllowAtomic> Atomic<T>
+where
+    T::Repr: AtomicHasBasicOps,
+{
+    /// Loads the value from the atomic variable.
+    ///
+    /// # Examples
+    ///
+    /// Simple usages:
+    ///
+    /// ```rust
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
+    pub fn load<Ordering: AcquireOrRelaxed>(&self, _: Ordering) -> T {
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is also a
+        // valid pointer of `T::Repr`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_read*() function:
+        //   - `a` is a valid pointer for the function per the CAST justification above.
+        //   - Per the type guarantees, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr()`:
+        //   - Atomic operations are used here.
+        let v = unsafe {
+            match Ordering::TYPE {
+                OrderingType::Relaxed => T::Repr::atomic_read(a),
+                OrderingType::Acquire => T::Repr::atomic_read_acquire(a),
+                _ => build_error!("Wrong ordering"),
+            }
+        };
+
+        // SAFETY: The atomic variable holds a valid `T`, so `v` is a valid bit pattern of `T`,
+        // therefore it's safe to call `from_repr()`.
+        unsafe { from_repr(v) }
+    }
+
+    /// Stores a value to the atomic variable.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
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
+    pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
+        let v = into_repr(v);
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is also a
+        // valid pointer of `T::Repr`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_set*() function:
+        //   - `a` is a valid pointer for the function per the CAST justification above.
+        //   - Per the type guarantees, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr()`:
+        //   - Atomic operations are used here.
+        // - For the bit validity of `Atomic<T>`:
+        //   - `v` is a valid bit pattern of `T`, so it's sound to store it in an `Atomic<T>`.
+        unsafe {
+            match Ordering::TYPE {
+                OrderingType::Relaxed => T::Repr::atomic_set(a, v),
+                OrderingType::Release => T::Repr::atomic_set_release(a, v),
+                _ => build_error!("Wrong ordering"),
+            }
+        };
+    }
+}
-- 
2.39.5 (Apple Git-154)


