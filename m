Return-Path: <linux-arch+bounces-12727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6EB035F9
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23BD7A8CCA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADBC223DEF;
	Mon, 14 Jul 2025 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwXETQdg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4F221FC8;
	Mon, 14 Jul 2025 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471436; cv=none; b=tFFuiyZevyy/EkRVoKHhWSJ8XAtmKEgWAEl/Zo+ngYjY1gDNr1TePmGLaUcQQouHy/7Zz7nGx0I410HfhT4Shs8Wy8SfQ7B9ykbonqFn4xmpbcwIXCFLDud+9zuDMqjoNjBRlCSxnSUy/iFF9grS/riwOHaEhRLtI5fv6PxYdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471436; c=relaxed/simple;
	bh=tQRIXOjQt/G4BbfoakV420RE3iFISVqEOqhjGPULAjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vye+yjxSRK2G/FYXes2hys1wfzTUVUWSX4lTI0DvcZWfSYAlJ/9N+miHIUEj6ChZc0qHGSn11U3WuMghAfyDh3XLwzVl/oS7EirKvbqBbBtK62mwzHBWChZRBWqUjpNvYEBV2YitN0pHG+fUTr9LkrY534YIgIYUF7pMRQVgyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwXETQdg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58f79d6e9so51645051cf.2;
        Sun, 13 Jul 2025 22:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471434; x=1753076234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7iQezcDKX45u7T7jf0+8vs//gWeKVYRGgAdvtsdbNEI=;
        b=FwXETQdgbBSwZvSgnGo8arUGBGCws6ir0p31VxNNZXFqCCHjbCWj+qHk6DqlkzSK+1
         33lE70jKyBKkOGfs3pQnpe/1y64qKv+07UhBbCZ6KvE11e5cl1QdWWsgDLaJLXt8BrOo
         9hcd6Gw7CNrcDPYZGmcJgsS62stFy7dFRxG8gAbvTtTVyd+K0FJCYTb5saqMBbu8SLly
         V9JmydeVxHqaUBfcRMVQwzlIYiRnZ40+zG8N0ER3fDpvQbhiiTqWTsRRhS2q3eU4Xs1e
         3iK2eJUDebXv536Kids33d++8e0orE/fo/4eI1brTMS92Q/wZYw9M1dLuUXO/ljyDwPu
         aofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471434; x=1753076234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iQezcDKX45u7T7jf0+8vs//gWeKVYRGgAdvtsdbNEI=;
        b=DWugOQzYSOSg5Qv7WG10ilBjeOmA5d9dEmhcvhAPKxC8xY1S4lQBPMPx6SG4WMqq0Y
         r3Ohw3J6cuT1pdLCo12V02uYlvj5m3/qUflgsJLtAAHPGB8RO3n/32YPHmB9lk20hSnh
         IedC4gXJfGVdg4HCuNA7cxD+aOu88C4hAv8U6b+RCmNUVFIjjFebhVPk/5FsgviCAqjv
         XYYXWJpKjzvv/0cQLAASW/Hqd3eZ9b0Mh7gNue8J/N78P6UF//5MlyP/0JUksBJHM55t
         lBwH2JpnkPFXp0x99Zw2R52LOP8PhpnNKfHyJPrEUB8Z/G9xoa70h3+LJeDaCwjmjNN9
         kTGg==
X-Forwarded-Encrypted: i=1; AJvYcCU4jQVFM6jdZkLBPBeZY7+rf6NaPRHNIlxSnKOQJ/ZA21ZflAoauNQa/vJ56DTnFzsWRU/8KPqTRsXJ@vger.kernel.org, AJvYcCVmSeHNHDFtrI6GaWYdn7Qr82do+xCkYU4N0i6YQHwNJJQVXmQ/lfgboLfYM+iVhoEMc2QbBhlaR3ODkhjB7TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXXm1ksKSCKD/YdTYqiTORWFk4Y2yvZzvAjOLgd/U7gIU0vyj
	MnqKJJLLzgK2i4xR84djF7g/0OfFMQPfQyVjQhe5UIov7vSKFQdD15AB
X-Gm-Gg: ASbGncu3Q4Ghyc5XA2xEH5yXqKcYoLsk0IwN784Ik6D3twVD5a8iQSl0syYgvSNLJ4v
	zddaIOZz6nxPNP6ot1eNHRQO3Q2rpz7OomS+b6FAJiWQQKsh27knZWRJTcvrIJ8U+jG0//0snWQ
	VND94CngtuE0u6M3RzbSSam9D7bEGVC57bIfWe96pAN3VuHhe92h9B+HlILunvF75iJIi+Bv2RQ
	xHEl13aAbeqXZz2B6xm4rGjfZwBAuxXq8MP1Vijee6pQrJa0zvKKkTFuvqBe8MARotKzNp+2u/5
	0Lra6QKDL6mVXFupAP+xWb/3wP2Qh2RDqUIj04HrfbneucLVcYxzfy+rXtWl+PLnUEbdXVpaXHK
	fWMZ8w38p0Owoewf33ichgN9X8zsNxqR/mEsDH32+0zcSqtsKbdt42z/twnBijFo0a1b+2ts0Er
	HrsBqNAoEE+mu6
X-Google-Smtp-Source: AGHT+IGEK6OTHWyVkiXtk3A2/5TOpoBBjDF0pkraUTwQMp3vvt/Hp8Ixn8FNj90tzIfGYrAAgLeOCA==
X-Received: by 2002:a05:6214:2e8a:b0:704:ac29:dda0 with SMTP id 6a1803df08f44-704ac29e0b7mr120334996d6.18.1752471433728;
        Sun, 13 Jul 2025 22:37:13 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e44fcsm43442056d6.48.2025.07.13.22.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:13 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9250AF40066;
	Mon, 14 Jul 2025 01:37:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Jul 2025 01:37:12 -0400
X-ME-Sender: <xms:iJd0aKNy3PiaYmL7oMYtdQvLHYZ3I-EQQhiOFI2NGD3ujiPB8q5jaw>
    <xme:iJd0aKmgLlHEaz0_OqAdQGhnnkuTdMGCZlnQLIE2oh4ie6WPaHc_OmVfjHhV73-XU
    uSb3NVQ8mOlSRj-3w>
X-ME-Received: <xmr:iJd0aP_n78LTa_z9LDplEYSqRay_hwKKfGchfuleeNK9ba4nu9tsZKWmRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
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
X-ME-Proxy: <xmx:iJd0aDM5oEPLFiVeZkavtZYBK5pKuiuLaoEzpbGjpEgYQYy69n2S1g>
    <xmx:iJd0aDFDRD0iCwfXWJksLlBFvABod5SX2iBswN4P_7iXvbG1ArVcMg>
    <xmx:iJd0aJirSynPcSHVXaB_bPkH2LrO_hJVi6ovCe10WSbnvTzKdB1k2A>
    <xmx:iJd0aPSAMI_eTEfW89VZBKL0_YX4LRKuQ3G-SgfQrwXUvVT18aE4MQ>
    <xmx:iJd0aB9zlUFF5nNNYI1hoDHob4gtIDQ2O15rngJNuo0FM3BV-6NXUE9Z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:11 -0400 (EDT)
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
Subject: [PATCH v7 5/9] rust: sync: atomic: Add atomic {cmp,}xchg operations
Date: Sun, 13 Jul 2025 22:36:52 -0700
Message-Id: <20250714053656.66712-6-boqun.feng@gmail.com>
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

xchg() and cmpxchg() are basic operations on atomic. Provide these based
on C APIs.

Note that cmpxchg() use the similar function signature as
compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
the operation succeeds and `Err(old)` means the operation fails.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/generic.rs | 181 ++++++++++++++++++++++++++++-
 1 file changed, 180 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index b3e07328d857..4e45d594d8ef 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -2,7 +2,7 @@
 
 //! Generic atomic primitives.
 
-use super::ops::{AtomicHasBasicOps, AtomicImpl};
+use super::ops::{AtomicHasBasicOps, AtomicHasXchgOps, AtomicImpl};
 use super::{ordering, ordering::OrderingType};
 use crate::build_error;
 use core::cell::UnsafeCell;
@@ -283,3 +283,182 @@ pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
         };
     }
 }
+
+impl<T: AllowAtomic> Atomic<T>
+where
+    T::Repr: AtomicHasXchgOps,
+{
+    /// Atomic exchange.
+    ///
+    /// Atomically updates `*self` to `v` and returns the old value of `*self`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.xchg(52, Acquire));
+    /// assert_eq!(52, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
+    #[inline(always)]
+    pub fn xchg<Ordering: ordering::Any>(&self, v: T, _: Ordering) -> T {
+        let v = into_repr(v);
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
+        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // `*self` remains valid after `atomic_xchg*()` because `v` is transmutable to `T`.
+        //
+        // SAFETY:
+        // - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
+        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
+        // - `a` is a valid pointer per the CAST justification above.
+        let ret = unsafe {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_xchg(a, v),
+                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
+                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
+                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
+            }
+        };
+
+        // SAFETY: `v` comes from reading `a` which was derived from `self.as_ptr()` which points
+        // at a valid `T`.
+        unsafe { from_repr(ret) }
+    }
+
+    /// Atomic compare and exchange.
+    ///
+    /// If `*self` == `old`, atomically updates `*self` to `new`. Otherwise, `*self` is not
+    /// modified.
+    ///
+    /// Compare: The comparison is done via the byte level comparison between `*self` and `old`.
+    ///
+    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
+    /// parameter indicates, and a failed one doesn't provide any ordering, the load part of a
+    /// failed cmpxchg is a [`Relaxed`] load.
+    ///
+    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guaranteed to be equal to `old`,
+    /// otherwise returns `Err(value)`, and `value` is the current value of `*self`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// // Checks whether cmpxchg succeeded.
+    /// let success = x.cmpxchg(52, 64, Relaxed).is_ok();
+    /// # assert!(!success);
+    ///
+    /// // Checks whether cmpxchg failed.
+    /// let failure = x.cmpxchg(52, 64, Relaxed).is_err();
+    /// # assert!(failure);
+    ///
+    /// // Uses the old value if failed, probably re-try cmpxchg.
+    /// match x.cmpxchg(52, 64, Relaxed) {
+    ///     Ok(_) => { },
+    ///     Err(old) => {
+    ///         // do something with `old`.
+    ///         # assert_eq!(old, 42);
+    ///     }
+    /// }
+    ///
+    /// // Uses the latest value regardlessly, same as atomic_cmpxchg() in C.
+    /// let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
+    /// # assert_eq!(42, latest);
+    /// assert_eq!(64, x.load(Relaxed));
+    /// ```
+    ///
+    /// [`Relaxed`]: super::ordering::Relaxed
+    #[doc(alias(
+        "atomic_cmpxchg",
+        "atomic64_cmpxchg",
+        "atomic_try_cmpxchg",
+        "atomic64_try_cmpxchg",
+        "compare_exchange"
+    ))]
+    #[inline(always)]
+    pub fn cmpxchg<Ordering: ordering::Any>(
+        &self,
+        mut old: T,
+        new: T,
+        o: Ordering,
+    ) -> Result<T, T> {
+        // Note on code generation:
+        //
+        // try_cmpxchg() is used to implement cmpxchg(), and if the helper functions are inlined,
+        // the compiler is able to figure out that branch is not needed if the users don't care
+        // about whether the operation succeeds or not. One exception is on x86, due to commit
+        // 44fe84459faf ("locking/atomic: Fix atomic_try_cmpxchg() semantics"), the
+        // atomic_try_cmpxchg() on x86 has a branch even if the caller doesn't care about the
+        // success of cmpxchg and only wants to use the old value. For example, for code like:
+        //
+        //     let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
+        //
+        // It will still generate code:
+        //
+        //     movl    $0x40, %ecx
+        //     movl    $0x34, %eax
+        //     lock
+        //     cmpxchgl        %ecx, 0x4(%rsp)
+        //     jne     1f
+        //     2:
+        //     ...
+        //     1:  movl    %eax, %ecx
+        //     jmp 2b
+        //
+        // This might be "fixed" by introducing a try_cmpxchg_exclusive() that knows the "*old"
+        // location in the C function is always safe to write.
+        if self.try_cmpxchg(&mut old, new, o) {
+            Ok(old)
+        } else {
+            Err(old)
+        }
+    }
+
+    /// Atomic compare and exchange and returns whether the operation succeeds.
+    ///
+    /// If `*self` == `old`, atomically updates `*self` to `new`. Otherwise, `*self` is not
+    /// modified, `*old` is updated to the current value of `*self`.
+    ///
+    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg()`].
+    ///
+    /// Returns `true` means the cmpxchg succeeds otherwise returns `false`.
+    #[inline(always)]
+    fn try_cmpxchg<Ordering: ordering::Any>(&self, old: &mut T, new: T, _: Ordering) -> bool {
+        let mut old_tmp = into_repr(*old);
+        let oldp = &raw mut old_tmp;
+        let new = into_repr(new);
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
+        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
+        let a = self.0.get().cast::<T::Repr>();
+
+        // `*self` remains valid after `atomic_try_cmpxchg*()` because `new` is transmutable to
+        // `T`.
+        //
+        // SAFETY:
+        // - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
+        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
+        // - `a` is a valid pointer per the CAST justification above.
+        // - `oldp` is a valid and properly aligned pointer of `T::Repr`.
+        let ret = unsafe {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_try_cmpxchg(a, oldp, new),
+                OrderingType::Acquire => T::Repr::atomic_try_cmpxchg_acquire(a, oldp, new),
+                OrderingType::Release => T::Repr::atomic_try_cmpxchg_release(a, oldp, new),
+                OrderingType::Relaxed => T::Repr::atomic_try_cmpxchg_relaxed(a, oldp, new),
+            }
+        };
+
+        // SAFETY: `old_tmp` comes from reading `a` which was derived from `self.as_ptr()` which
+        // points at a valid `T`
+        *old = unsafe { from_repr(old_tmp) };
+
+        ret
+    }
+}
-- 
2.39.5 (Apple Git-154)


