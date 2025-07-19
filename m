Return-Path: <linux-arch+bounces-12867-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1994B0ADA2
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 05:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CD1882021
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9C224254;
	Sat, 19 Jul 2025 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1dypLCs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98E21FF42;
	Sat, 19 Jul 2025 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894525; cv=none; b=nchPrVhyae5ukq7pjHrnIBSPxlDwCcy91IWY82YuewIRENb1Zd9fAIA+W2WNfef1e3XLeSUf5nwBILrKggX0fwOBSnZc4AHlJKAVLJyIhC8eTbJuya44ErPZ9ZV8P1ENQzZGsvdTN+qZNY+lbcyeG/BsQ0kUrtooG5FOt2ZWvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894525; c=relaxed/simple;
	bh=rT8/jX4sRu6LTU4WYteSZSqRX1DtiFWLv/jTGTQzhU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o07UDDGzaMQs0dgB9ls9ZbRHOsvEGtJc20FNJvWVg0Z/9EC89uOWPsTUA4AF4pqe9TmkINEYFeppZz8MWKU3PSUyLucAnEtFu2jPPDUdGDMTK8yzqVUqcDHqmVjqUcZ+6dhCmVMTE3+ztibZItVhEHw4tG89xTmIonUG+Y3yMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1dypLCs; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab7384b108so30259911cf.0;
        Fri, 18 Jul 2025 20:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894521; x=1753499321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=COdJ3V51vaX1EoPXgut8XfxRVUy1aTIFOkuQTW2lPh8=;
        b=V1dypLCsmaK0IiibqyuOJbaDI8XMr7lPiC6t1FbLEiKsG7KskE1R9F/78yTHPt0SvO
         hVyWtwtyaI9jm5X+dpgx18uN1WtafXli0/ejgF8s9FO6VRHdVmoIcYYusIzm8T2bGXgz
         qfz4/me6qX0H/hDBu6Edk1fkbSlPKLY3tGpcbduEJUprefH95npAbIJDtW+x/b6ee0rY
         KHXUbmsLlo7domWnrkVPrTzqsRF11Zs5mQ13JHbOrPXuiAVCv30pBk+G+9cWEgH59n1F
         +QFa8WQmqnoJPODEzfl1iJB+Yf+wIZ+OVpkkHo1wIZW+K2y8fMkF9Muouh3uPwCpCbag
         tODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894521; x=1753499321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COdJ3V51vaX1EoPXgut8XfxRVUy1aTIFOkuQTW2lPh8=;
        b=b5v8JBXhCXYw03P7XKEXuIF6ppc+uJixXVvuSOpswgmCWLpSylV4CyGDJDyGNFLCwV
         RUvFEzy/g9XccAgJKYlbFWkFNVsUH0B/z/d9r1REsrdUDHxbhlyUo0+hZnMrzoEXpRIm
         XpZVX01YRJzlgqVkz4t5wvcTPSxKCK6LjJIuHEJU+zJRK2CYD4QAT9FrDLMTtdMuN3AZ
         iOzigSiLNS0e4ObVYYhcebglf/LLdJmOonE3iDjg/CL7tAYG3FfEaJxNpEO8mg7AroKN
         5n0DRlvzpf0bbtziM7XpAMRGtpgPC+v/vd4EnhwpLBWYoPscxvfqJW4/DnmgWIoN74oy
         OqDg==
X-Forwarded-Encrypted: i=1; AJvYcCV2SQsATu3B2s1tqANfuVN3//B26SFTnBz2/2XF9934i1VE+/LQuKxHeVxh9hZ1upjQsB9Vi/7frXnbXsQQbNQ=@vger.kernel.org, AJvYcCVpcNzzTGJkt2pXIE2ttOrAQWi4Rwj962aU+zLHRSJM9qtaG//fxDNcD8fSYK+6ZqqQa7Rubp3SWQOr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48txqnYE/jRK4V3Lq6FB+DfDkSsqriw80w1nGQsBUpXIzc/BN
	RITEW0dDA2PHrztmSk/GMJ3w/nPCxiFmh8UzTvkF1tzT6heKDYxenhOb
X-Gm-Gg: ASbGncvXHlN/iMIzHOYeNQ/Pn2S/tNfrRm2nqybCFGZIubN49e7I6rfJzBNoeDAG+zq
	9rCcT5fMi2x3MtDcQW32dkDhZ61KESo7ZfkJz9SOHcB4/7jYSiHQwyIWE8EvDYM34aQmV5wSyhi
	YAcKYG6R7cp/YZw0FxDLCkpWxC5BF4y4EdKoMKaw7h/cSFunAxHiMrjpd5s0+Te/Qf4HTRwR+2D
	WY9Zxk1mQX0am7Y7VZSC1hK8bSV5J+bpswmNyc/JHZhzGkttFgx3gNOwioyGV5DkCSd1uumhDgA
	GHVnF+qiwHfhf2XEOfGUY0j40AQsIB+svOHFByrT9yxQGkKMaU9yD34xdNRRqQKKqzIpdlae4YH
	lb/QmCBQgmstG6qAbA/RvjJVQc5DzMDyTPxMBaewKyjKmxEZz4P4IEG1Ttftoy2NYa2FV0AZYFj
	nZ360Zp/Wee1C6NMCLrwXJ7Ds=
X-Google-Smtp-Source: AGHT+IHCBuOpr0SfTTkjVmMnXUqgVAxXWB+r+qSXNqH0RjbQYzPVXuRtk2OZeOKwIh5pkAUtU9SfvA==
X-Received: by 2002:a05:622a:1898:b0:4ab:3b66:55dd with SMTP id d75a77b69052e-4ab90a22088mr214094271cf.17.1752894521123;
        Fri, 18 Jul 2025 20:08:41 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4aecf6dsm15080441cf.47.2025.07.18.20.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:08:40 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 11D8BF40066;
	Fri, 18 Jul 2025 23:08:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 18 Jul 2025 23:08:40 -0400
X-ME-Sender: <xms:Nwx7aLwifqofOdl2tSnbvfRLTvtLM3Z_Vqg0rX7NFWNmgClA_UloIA>
    <xme:Nwx7aEwbC0K_93TgOcKFhHSDEPWJUKAVaSyHBPLZ_4aHiTLvKnBZPgxiRDDbKmXyD
    D1JEly5weyMoFTXqg>
X-ME-Received: <xmr:Nwx7aJ5GYG-moGcUxDqKPEgy3yV4yaHbLZXnSgNrDMFBXOWcf6rS8OkXaQ>
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
X-ME-Proxy: <xmx:Nwx7aFCvCa1vzLFBLMO7qNsAbSsHwCmKnqR8f8EE3Tvr6vN2KRO2Hg>
    <xmx:Nwx7aLDcWBa89o4RKqWn6d1vWemajcagohhdI4AB_jQCqt7IAwvPaQ>
    <xmx:Nwx7aGotAPaTgEddDgK9Tqc5cZs4gtuOTddf7rojpCgtZPiYj3TzxQ>
    <xmx:Nwx7aN2bSQAsFX77uTPBy9FkGe1jia_-MmqFCH0Vbib6zM3UEz31gg>
    <xmx:OAx7aFXMyZRUGfuAUUt-Xaum8fTZWKbnHQ2TYMoVnY8d8JA2CQAchwMq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:08:39 -0400 (EDT)
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
Subject: [PATCH v8 6/9] rust: sync: atomic: Add the framework of arithmetic operations
Date: Fri, 18 Jul 2025 20:08:24 -0700
Message-Id: <20250719030827.61357-7-boqun.feng@gmail.com>
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

One important set of atomic operations is the arithmetic operations,
i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
make senses for all the types that `AtomicType` to have arithmetic
operations, for example a `Foo(u32)` may not have a reasonable add() or
sub(), plus subword types (`u8` and `u16`) currently don't have
atomic arithmetic operations even on C side and might not have them in
the future in Rust (because they are usually suboptimal on a few
architecures). Therefore the plan is to add a few subtraits of
`AtomicType` describing which types have and can do atomic arithemtic
operations.

One trait `AtomicAdd` is added, and only add() and fetch_add() are
added. The rest will be added in the future.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs           | 93 +++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/predefine.rs | 14 +++++
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 793134aeaac1..e3a30b6aaee4 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -16,7 +16,6 @@
 //!
 //! [`LKMM`]: srctree/tools/memory-model/
 
-#[allow(dead_code, unreachable_pub)]
 mod internal;
 pub mod ordering;
 mod predefine;
@@ -25,7 +24,7 @@
 pub use ordering::{Acquire, Full, Relaxed, Release};
 
 use crate::build_error;
-use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
+use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
 use ordering::OrderingType;
 
 /// A memory location which can be safely modified from multiple execution contexts.
@@ -115,6 +114,18 @@ pub unsafe trait AtomicType: Sized + Send + Copy {
     type Repr: AtomicImpl;
 }
 
+/// Types that support atomic add operations.
+///
+/// # Safety
+///
+/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
+/// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
+/// yield a value with a bit pattern also valid for `Self`.
+pub unsafe trait AtomicAdd<Rhs = Self>: AtomicType {
+    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
+    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
+}
+
 #[inline(always)]
 const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
     // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
@@ -462,3 +473,81 @@ fn try_cmpxchg<Ordering: ordering::Ordering>(&self, old: &mut T, new: T, _: Orde
         ret
     }
 }
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicArithmeticOps,
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
+    pub fn add<Rhs>(&self, v: Rhs, _: ordering::Relaxed)
+    where
+        T: AtomicAdd<Rhs>,
+    {
+        let v = T::rhs_into_delta(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_add()` due to safety requirement of
+        // `AtomicAdd`.
+        T::Repr::atomic_add(&self.0, v);
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
+    pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering) -> T
+    where
+        T: AtomicAdd<Rhs>,
+    {
+        let v = T::rhs_into_delta(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_fetch_add*()` due to safety requirement
+        // of `AtomicAdd`.
+        let ret = {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_fetch_add(&self.0, v),
+                OrderingType::Acquire => T::Repr::atomic_fetch_add_acquire(&self.0, v),
+                OrderingType::Release => T::Repr::atomic_fetch_add_release(&self.0, v),
+                OrderingType::Relaxed => T::Repr::atomic_fetch_add_relaxed(&self.0, v),
+            }
+        };
+
+        // SAFETY: `ret` comes from reading `self.0`, which is a valid `T` per type invariants.
+        unsafe { from_repr(ret) }
+    }
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 33356deee952..a6e5883be7cb 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -8,8 +8,22 @@ unsafe impl super::AtomicType for i32 {
     type Repr = i32;
 }
 
+// SAFETY: The wrapping add result of two `i32`s is a valid `i32`.
+unsafe impl super::AtomicAdd<i32> for i32 {
+    fn rhs_into_delta(rhs: i32) -> i32 {
+        rhs
+    }
+}
+
 // SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i64 {
     type Repr = i64;
 }
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `i64`.
+unsafe impl super::AtomicAdd<i64> for i64 {
+    fn rhs_into_delta(rhs: i64) -> i64 {
+        rhs
+    }
+}
-- 
2.39.5 (Apple Git-154)


