Return-Path: <linux-arch+bounces-12726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8450B035F7
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C577A7649
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957252222D2;
	Mon, 14 Jul 2025 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cINuQI67"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9B1FE451;
	Mon, 14 Jul 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471435; cv=none; b=UNOfk13sPrapIu6o7c7QJGYHR0ghffRQTswwe3BqRWW+Y3tU73kIN71dElxsepxcjO8cXs3KYdcYFp6t8fRhssiUKMBP0ittS2hhWGa/K657ipssOfcybRiZcyFb00QhTQy3oE9pmPBt1cebb1B4SjZZra3IJQ0vTqu67YsKCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471435; c=relaxed/simple;
	bh=AOpC4nLV0ayXAQjhNEWyt8cYV0M1f04jwfy/8d6V11Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+prSP20WfFNGJJ4cEfSIu9iuAtd/Ye3lCL2kGOsJx8yyPREJ1in9I05Vpvye/5mQ4+fxHmjmGmGrvNioIcuJn2uB7xnzjYVRGxUXKp+K7o98oXCAi8mHyjMVNQ6apfwB8EK4aV5fV+Nxu/FcPo3KMrLhPGYrX84TeSVVkseAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cINuQI67; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7dfff5327fbso319419685a.1;
        Sun, 13 Jul 2025 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471432; x=1753076232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R47XgB/2q6odbPziaMCGNZTE+GhWB/ReI/ubO+uWNN4=;
        b=cINuQI67KQjjF11x5ZbPV1+edyHfYsifYCyKTTlI0n4nkjgZq0cF/ScnvEJ8wUSjPK
         P0jRGRehfMtXVc1hZJrbK8aq9fUFRa+5fjpG2TD0zmeAtN+dkP3HQPMRIDrCcNbV9wNv
         dYaBh6/BxfHIatqXglVKxune6BHjSG9ZV1z9kNYjz2vzhHYFAU20ksl7wyceE3HlIlyo
         z56omapKPo4YUyFcY1sqiwnfNrtx/WdxoTOmX1lMrDQ0II7V5zXN9XeB7c7c0/xzRRwE
         Nyfbx64eSAul6+JsNkbr48Xe7WV+Wfr5sIAZv3ZV9RgVnjbE+CPawaUwLVvFKySlW0DE
         hDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471432; x=1753076232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R47XgB/2q6odbPziaMCGNZTE+GhWB/ReI/ubO+uWNN4=;
        b=jtvnRddc2pEdGHeLGZItW9dhZDBAQPnR5XCN2Bf8nAVeQW+JocpR/3zOdJilHoJ96c
         nfnyTNF+NfV4EvYg0hpDK3cE+YjTOBFOGhwmqBEMQjG0qHdR1ZWYlxRC17JI6pbA3z/g
         h/6bgDnXPoM9k0gNNkoOMs3gPqMDzeRzjRr+hPUghj6OIlao3ogY+aGFwer11vAobgae
         Zk0OuSzRzL+AlYoZmbSodEGD4qaH1HP/u9nAsOaMG7apgTrc6e7YhcTSO+qsf7/Odrl4
         NNdyo30VUShXKXiPOXSVPyfS+mSI90KVTdsntgDZq/LFc6qKtN2TC3mnOlY/XtFr0bQz
         4kAw==
X-Forwarded-Encrypted: i=1; AJvYcCW3G9tVq2dj8LRn8+14sz8O8MWvp/j6z6LtuciB1NduXAmB5lVh5S+HgxfO7Pn58h6A++rTpZPy562Ot0FXwxY=@vger.kernel.org, AJvYcCWrrmvKfeiFfOvTnWYe4s1Ww6hFXmtQu7bj+eggBO71sNVTwRr/mY7oALSvanAO9LIfooF5plgueATC@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhEzurwvA8epDlO9VHCwV9gzxm0WWLKR2lfAQNuSlW4LfBksX
	RPVORUXOxP4LqOJA1xkUueTpadPKcsvNCU6h9wELzagrA2Dtge8P6ldS
X-Gm-Gg: ASbGncssDBqHnFMsReGgV/vbui61FBMtyEI6fIDIfKLMjWaPZBwpDgPZX2nFzwGvfzg
	XwdX3RzA44mUK9YBtpqrtEu/94qTYIbQN7XrWRUnSgMmxniq5mmyXYAhUgNHp+3u7/cGdxrxggy
	Jcr0xClQRtV9zKeSdZ5QO3D+NBdGap6sLlq9K1AS2rL+Lk1fn6WM0GEMIWatArt+Tu1qQOa+YmX
	ulIkY3PIB/cDvgDfWrF22r9EQ8bOc1PXKwM887/u0+TVWT83WqtXAPJIlDxu9f2C1e3NvW7qefU
	h6vHpxzze4hxjxIsQGLC1e2obeWlbfQjTkMaJ+KAIBKz1hXvOWmkSiGvDbHAh5CJSIOFtqkm9bE
	ze+iz0zJ/Idew67ker4XgpNDJaKerZF+R0fMMcO6Yh3UfqHeL9n6fNiH2DcOoyL46bOUv6pGPrk
	xUk6dvkYfnPPu8
X-Google-Smtp-Source: AGHT+IFnVcm8bS4GMHARDiXRGgzOvY+eTa7LjuzczhxG76dKUjyjx8yr0Xu9EniLG4HuM9fwYafQWg==
X-Received: by 2002:a05:620a:d8d:b0:7c5:405e:e88f with SMTP id af79cd13be357-7ddea60f5e1mr1902488385a.21.1752471432067;
        Sun, 13 Jul 2025 22:37:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e331294837sm8953285a.49.2025.07.13.22.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:11 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 00F4EF40066;
	Mon, 14 Jul 2025 01:37:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 14 Jul 2025 01:37:11 -0400
X-ME-Sender: <xms:hpd0aD8ZZcY2Hcdq6m9a6vuAEvj_mLJmDLUi7eWZQpinM3-mWFOzzw>
    <xme:hpd0aBPDn3-kBD6rt--PXZz7SL6TNpmuoJAKNVyLVe3hDR30CYRqq4aFy6ZwyxPBn
    cITPO0oJuzTlkCr4w>
X-ME-Received: <xmr:hpd0aFmA3HP4J4T2FzQpo7HH--5mTYgIV8ie2fbpCOSwTgPnS-9e0VonMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddufecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:hpd0aO9FMJSv9qoR90h6DBsz1bQvdxGsCtvTIyzAvMJF6zxU5HuIqw>
    <xmx:hpd0aGPYren341EtdNfXs-Pw9-IFNd9pbZpZ8j8CjTOM7Wx70apY_Q>
    <xmx:hpd0aKEqVo6JA-EuUlX82vFIoj-tQJ-ouZz5Wcd_8rpFjqqGfom5DA>
    <xmx:hpd0aEjWGT-jAhHcK4eddSC7pv-xbuOCtSGotiHCEucISsDctkWxnQ>
    <xmx:hpd0aOTNkgwM-uqnGy2hcBVCG1XrNVXlw6438vUfv3-8_wh1HtOEui2E>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:10 -0400 (EDT)
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
Subject: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
Date: Sun, 13 Jul 2025 22:36:51 -0700
Message-Id: <20250714053656.66712-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714053656.66712-1-boqun.feng@gmail.com>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
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
 rust/kernel/sync/atomic/generic.rs | 285 +++++++++++++++++++++++++++++
 2 files changed, 299 insertions(+)
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
index 000000000000..b3e07328d857
--- /dev/null
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic atomic primitives.
+
+use super::ops::{AtomicHasBasicOps, AtomicImpl};
+use super::{ordering, ordering::OrderingType};
+use crate::build_error;
+use core::cell::UnsafeCell;
+
+/// A memory location which can be safely modified from multiple execution contexts.
+///
+/// This has the same size, alignment and bit validity as the underlying type `T`.
+///
+/// The atomic operations are implemented in a way that is fully compatible with the [Linux Kernel
+/// Memory (Consistency) Model][LKMM], hence they should be modeled as the corresponding
+/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from_ptr()`] and
+/// [`Atomic::as_ptr()`], this provides a way to interact with [C-side atomic operations]
+/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`, `WRITE_ONCE()`,
+/// `smp_load_acquire()` and `smp_store_release()`).
+///
+/// [LKMM]: srctree/tools/memory-model/
+/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt
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
+/// [`transmute()`] is always sound between `U` to `T`) because of the support for atomic variables
+/// over unit-only enums, see [Examples].
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
+/// # Examples
+///
+/// A unit-only enum that implements [`AllowAtomic`]:
+///
+/// ```
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
+/// [`transmute()`]: core::mem::transmute
+/// [round-trip transmutable]: AllowAtomic#round-trip-transmutability
+/// [Examples]: AllowAtomic#examples
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
+    /// Creates a new atomic `T`.
+    pub const fn new(v: T) -> Self {
+        Self(UnsafeCell::new(v))
+    }
+
+    /// Creates a reference to an atomic `T` from a pointer of `T`.
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
+    ///
+    /// However, this should be only used when communicating with C side or manipulating a C
+    /// struct.
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
+    /// Returns a pointer to the underlying atomic `T`.
+    ///
+    /// Note that use of the return pointer must not cause data races defined by [`LKMM`].
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is properly aligned (i.e. aligned to [`align_of::<T>()`])
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    /// [`align_of::<T>()`]: core::mem::align_of
+    pub const fn as_ptr(&self) -> *mut T {
+        // GUARANTEE: `self.0` has the same alignment of `T`.
+        self.0.get()
+    }
+
+    /// Returns a mutable reference to the underlying atomic `T`.
+    ///
+    /// This is safe because the mutable reference of the atomic `T` guarantees the exclusive
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
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
+        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
+        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
+        // - `a` is a valid pointer per the CAST justification above.
+        let v = unsafe {
+            match Ordering::TYPE {
+                OrderingType::Relaxed => T::Repr::atomic_read(a),
+                OrderingType::Acquire => T::Repr::atomic_read_acquire(a),
+                _ => build_error!("Wrong ordering"),
+            }
+        };
+
+        // SAFETY: `v` comes from reading `a` which was derived from `self.as_ptr()` which points
+        // at a valid `T`.
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
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
+        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // `*self` remains valid after `atomic_set*()` because `v` is transmutable to `T`.
+        //
+        // SAFETY:
+        // - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
+        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
+        // - `a` is a valid pointer per the CAST justification above.
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


