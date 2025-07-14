Return-Path: <linux-arch+bounces-12728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE47B035FE
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915E3167C30
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27122836C;
	Mon, 14 Jul 2025 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVlXjbjQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BB2253FE;
	Mon, 14 Jul 2025 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471439; cv=none; b=mFsTAn1z489HSfYCArtAR/E1/ITk5EtGOKVoYn4/kNwIkMbvRz7zMpC8lWrn0FW+MVGbLl9HyWFIrq7kI9WZ62P3lX672cB2oN/jccBUyl56cwMvc/aq8Njir3ithxyt6AWrjjisG1Faa7F7cyu+30dMKmVGqGTH5BIiCW3sjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471439; c=relaxed/simple;
	bh=RdqOL7HUpVhGhmtZOWeFb6/5oGV3e0YDMIsRXjOH6lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TphP8XOsAhKwtJSaDT9ZTQjKhsPyjhbOpnDNHz1BS3+XFCetnrXUrooc0NHEXMBm5GHqtyf4eLLB8BgHItGvjb1j2sqDznUykC+b5CJuYN/6hovrKeym+Y/umnEvEv9PkNaBT6DtPo/ukbS6gcjmZEV4XZPQqPoBqcjlDUWja9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVlXjbjQ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e32c5a174cso30139485a.1;
        Sun, 13 Jul 2025 22:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471435; x=1753076235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B9wJ4c2U301QOkQuCdVz7fDf/TBtX7Q85JWYXNeFCIg=;
        b=nVlXjbjQJ5mkPg1UHhvsxfj3dfTzJSAPykyyv2Mnw1CjteNFOhNTsNJ5X37kc0AjmP
         X9Qx10OAjbkkeJIIEGApyDDq8ZBgkgRao246hng4zZAMkHiAH/Bfrs4u1c82fxQ1QCi2
         sXpEZ8B8VWUd82Kz1E8ByYGPnCEyflM27zswqie5w+XV3wr/cZT7hGCWEH7U3TCQYJRv
         MUp6r5SnOZI0sR7Icjl+zWSd0U61+NRUKO3KTB6i1a6pw3nYeR/kKiW8TybRwU5Erp/i
         JEoaOrIF2nmlb1kcmsG8/pnuigi0Z47c/tgv8N1gzzgR3W1GP9XZhbuUu195EHG5Ip6D
         c68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471435; x=1753076235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9wJ4c2U301QOkQuCdVz7fDf/TBtX7Q85JWYXNeFCIg=;
        b=iVBV6vxAbtO3DUmxgMQ+9N/pjKaG2+ZfYZanRnDMhRB1HbWQhzm2IMdv2X7cfFaL4s
         WSnO6UfaBeEtvoOXMaA+dHQtVj+lbqGUTZ2mr9IM9mDHe9WmUCddvhRqqYN2VA7ag6iN
         rGKtZmc4/K/DLGMF3FkUGbyXzRn3BAFR56da+SBJPh6Fi4RXj4FfvbZyOEq8d8b6vv81
         0fLqWL3FVGtHBAbLg8oFNKgU4oVJJoFSSGv5bzeKkxAu/w/tgODh2f6Ey1UgvCjTWwty
         Ddgun0wY8NUli59ILvn8l3UODyJgEREBnTrkHgvyeDhm/Wnq5Quvts6xWqtYgvgRJOXw
         52TA==
X-Forwarded-Encrypted: i=1; AJvYcCVjFC9kNtzvdjq4Ty1K2S2L8jlnQWH5NyeYs8mSe60x10yGdLxSq0uD+saGE7covFkGvi2azq5gKBla@vger.kernel.org, AJvYcCXu6D7jvAm/gfcmZX5StMvpo0gmfdvOcvfWwOrcRAHVkszXJZ8eql324GCw19CKrnvXuXQAuDVC2Y8O0plAF5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc+SAiGDgjlKGRdZCqaNaXf1qn7jDb9w3tfavQz5husouOmKA
	eP10CAJj/x4fEzNpbyCjbrDsYrI8Eke+B9IpUoEtpw5W1568NeiaPjBn2w9Vtw==
X-Gm-Gg: ASbGnctrmVTHziLFL87+zMCwL+SOzWOVGCSDBReVX5QK7kSK6S++P5L3zhujeZhWUbu
	uWCrmzWVkJcUsHc8Sk25GhtLO4VFnU0gaRDUoxQZfHLm2tUCVxSqn43Ao9ShS4WRu/DdRoEW4Zi
	Jd3bmJ2Oc42KTekqqGXoNXAMIlirzguH2yX/BKV1pvvvDnpMclPPQ3dVjULSoDx0XG4CRYc5gIl
	6IOJkNRsEodUcnJnsL2PzkE/I6Ckb2DP93bv7CjFTIcoTS7txuiPzVjp1b4p+Q0kQqb9n6zByQ0
	Xbj3AOn9+QVtGTyKu+slC0YGQGcGeF44xrptIoqvEor9pKM5eVF3J2I6binNyCI2VOg4fKm0YED
	5U/v2Wj9WuTZNTDlWjv2lNExu/7hKfpPbfM+w2qMGXgNSp9a5R6f3X24hC6RG3X4tgzYNR1v4Sl
	zOHE4YihoCrvL1agNTfhJUzhk=
X-Google-Smtp-Source: AGHT+IG5facqxAvDpAAJ11zvnFYDqew6+xXMuG4BL4VHcOgrov9P1XQMep/v3/xqYQo80hELve2k3A==
X-Received: by 2002:ac8:5dc6:0:b0:4ab:6b08:9db8 with SMTP id d75a77b69052e-4ab6b08ad01mr53376821cf.11.1752471435261;
        Sun, 13 Jul 2025 22:37:15 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edea72cesm46260791cf.57.2025.07.13.22.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:14 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3A4A0F40066;
	Mon, 14 Jul 2025 01:37:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 14 Jul 2025 01:37:14 -0400
X-ME-Sender: <xms:ipd0aFJZ0f1phYwPvM1z2SU8GAQyYu5EwAIgSJV0fSxJ8519UJavzw>
    <xme:ipd0aCodzOVhD1V873rLbIGjbl_E4G0ffGTQy8ox_en9v8hIg_ceqI__meMzBq8Me
    zAdyr8gRW3YUf0NIg>
X-ME-Received: <xmr:ipd0aCSG48zlzn5YZ-uU9vEZfit0s74H15NZQAmZc4iusSyuFHznzU0B7Q>
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
X-ME-Proxy: <xmx:ipd0aF4fhixMlSUF9l5bLOk7-1sAGBsQUmlvcvHGwsVl4CbkL-CVbw>
    <xmx:ipd0aKYm6Zv51tbq40qss7AnYHKOwEUOcvMB0ECMbN2Ig3GIj80PWA>
    <xmx:ipd0aCivqvk7IvivIcnxGtfgOcnD5VCRhqhDIxrU9wO1MpOoK9Ix9g>
    <xmx:ipd0aMONmx_L6t8ttHDoEMrwk6jQKOQX9j7MtGoKhZ5RyA8W0FLtXQ>
    <xmx:ipd0aENvCv6Evu05kWQDk2cceuBYi79RUubca_k5NFeYISWMzqKRtlY9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:13 -0400 (EDT)
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
Subject: [PATCH v7 6/9] rust: sync: atomic: Add the framework of arithmetic operations
Date: Sun, 13 Jul 2025 22:36:53 -0700
Message-Id: <20250714053656.66712-7-boqun.feng@gmail.com>
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

One important set of atomic operations is the arithmetic operations,
i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
make senses for all the types that `AllowAtomic` to have arithmetic
operations, for example a `Foo(u32)` may not have a reasonable add() or
sub(), plus subword types (`u8` and `u16`) currently don't have
atomic arithmetic operations even on C side and might not have them in
the future in Rust (because they are usually suboptimal on a few
architecures). Therefore the plan is to add a few subtraits of
`AllowAtomic` describing which types have and can do atomic arithemtic
operations.

One trait `AllowAtomicAdd` is added, and only add() and fetch_add() are
added. The rest will be added in the future.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs         |  14 ++++
 rust/kernel/sync/atomic/generic.rs | 111 ++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index c5193c1c90fe..54f5b4618337 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -29,8 +29,22 @@ unsafe impl generic::AllowAtomic for i32 {
     type Repr = i32;
 }
 
+// SAFETY: The wrapping add result of two `i32`s is a valid `i32`.
+unsafe impl generic::AllowAtomicAdd<i32> for i32 {
+    fn rhs_into_delta(rhs: i32) -> i32 {
+        rhs
+    }
+}
+
 // SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl generic::AllowAtomic for i64 {
     type Repr = i64;
 }
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `i64`.
+unsafe impl generic::AllowAtomicAdd<i64> for i64 {
+    fn rhs_into_delta(rhs: i64) -> i64 {
+        rhs
+    }
+}
diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index 4e45d594d8ef..9e2394017202 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -2,7 +2,7 @@
 
 //! Generic atomic primitives.
 
-use super::ops::{AtomicHasBasicOps, AtomicHasXchgOps, AtomicImpl};
+use super::ops::{AtomicHasArithmeticOps, AtomicHasBasicOps, AtomicHasXchgOps, AtomicImpl};
 use super::{ordering, ordering::OrderingType};
 use crate::build_error;
 use core::cell::UnsafeCell;
@@ -104,6 +104,18 @@ const fn into_repr<T: AllowAtomic>(v: T) -> T::Repr {
     unsafe { core::mem::transmute_copy(&r) }
 }
 
+/// Types that support atomic add operations.
+///
+/// # Safety
+///
+/// Wrapping adding any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
+/// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
+/// yield a value with a bit pattern also valid for `Self`.
+pub unsafe trait AllowAtomicAdd<Rhs = Self>: AllowAtomic {
+    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
+    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
+}
+
 impl<T: AllowAtomic> Atomic<T> {
     /// Creates a new atomic `T`.
     pub const fn new(v: T) -> Self {
@@ -462,3 +474,100 @@ fn try_cmpxchg<Ordering: ordering::Any>(&self, old: &mut T, new: T, _: Ordering)
         ret
     }
 }
+
+impl<T: AllowAtomic> Atomic<T>
+where
+    T::Repr: AtomicHasArithmeticOps,
+{
+    /// Atomic add.
+    ///
+    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.add(12, Relaxed);
+    ///
+    /// assert_eq!(54, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn add<Rhs, Ordering: ordering::RelaxedOnly>(&self, v: Rhs, _: Ordering)
+    where
+        T: AllowAtomicAdd<Rhs>,
+    {
+        let v = T::rhs_into_delta(v);
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
+        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // `*self` remains valid after `atomic_add()` because of the safety requirement of
+        // `AllowAtomicAdd`.
+        //
+        // SAFETY:
+        // - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
+        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
+        // - `a` is a valid pointer per the CAST justification above.
+        unsafe {
+            T::Repr::atomic_add(a, v);
+        }
+    }
+
+    /// Atomic fetch and add.
+    ///
+    /// Atomically updates `*self` to `(*self).wrapping_add(v)`, and returns the value of `*self`
+    /// before the update.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Acquire); x.load(Relaxed) });
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Full); x.load(Relaxed) } );
+    /// ```
+    #[inline(always)]
+    pub fn fetch_add<Rhs, Ordering: ordering::Any>(&self, v: Rhs, _: Ordering) -> T
+    where
+        T: AllowAtomicAdd<Rhs>,
+    {
+        let v = T::rhs_into_delta(v);
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
+        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // `*self` remains valid after `atomic_fetch_add*()` because of the safety requirement of
+        // `AllowAtomicAdd`.
+        //
+        // SAFETY:
+        // - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
+        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
+        // - `a` is a valid pointer per the CAST justification above.
+        let ret = unsafe {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_fetch_add(a, v),
+                OrderingType::Acquire => T::Repr::atomic_fetch_add_acquire(a, v),
+                OrderingType::Release => T::Repr::atomic_fetch_add_release(a, v),
+                OrderingType::Relaxed => T::Repr::atomic_fetch_add_relaxed(a, v),
+            }
+        };
+
+        // SAFETY: `ret` comes from reading `a` which was derived from `self.as_ptr()` which points
+        // at a valid `T`.
+        unsafe { from_repr(ret) }
+    }
+}
-- 
2.39.5 (Apple Git-154)


