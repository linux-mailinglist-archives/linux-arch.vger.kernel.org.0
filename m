Return-Path: <linux-arch+bounces-12866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9510CB0AD9E
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 05:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C983F7ADE63
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56A2206B3;
	Sat, 19 Jul 2025 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhDlceeZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276521CC60;
	Sat, 19 Jul 2025 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894522; cv=none; b=bwvUohfdMOiztstsu4XLTwqvzd2TwW6bavu6P19+VsSAhCBwCgbpWmg3ihNbH1QP1z57hMaY59qmzqQP6U5wef94njw1Zm1XTD8Xh2umc6oafbPq+HNENxuDhTWR8cdMcTvoyFvLi3BY6ZzwY5JFfA8rmKGCPKm/bSf3CK1VdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894522; c=relaxed/simple;
	bh=qr/BLV35XP2oSWzk0PKe6iGENLQXmDjK4lcR4P9eqss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMv2ya1/LnIxgPneH0LtxadkTZUAFO7oucqPrUsyODn1l5Uph1P+7szltGYfQvwooKnX7x1fR0DNOF1bllfaq21V86Hg/O03aTTfzUJGGhGCY7DGb1Ndn+OsOBbv0NRQ20jN/W3by7WU+CePFA0Rs2wkoVqKCv6mMI723TAzaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhDlceeZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e32cf22fdfso245287285a.0;
        Fri, 18 Jul 2025 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894520; x=1753499320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0xTbZ5T5Hvj0Ijk0x3qff7deKH90th0WSGebbz2fch0=;
        b=DhDlceeZ5yRr+6E3hfoz3BTY3N0cVfjE3bJ+qiy3JerEiWs4RCAuUhr9iStfglI8c8
         Di3/l1onsPD1BTH3bIxdJvB6ttb0FQsZzatIBVwX45gByiMkSRygTsDP5Moe2ZL5k7fH
         2otSmrLwtTItczpT0SNoXpbuTLezScJT95jLn02m2Buh903lTExj15xwya54hgPeJIVB
         qBuKOPx853R+27GpYYQeV+KLXrKy2YYyQegwDnMrmKBateJo0w7ivVbDKr29jQ8cqZfv
         mwe9TRNytkNmrblEOy8r/Lq9S5NjWi9PuncNhYyRMbg+wM2CzdmAR4hJiKVSn9nfp6wL
         rwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894520; x=1753499320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xTbZ5T5Hvj0Ijk0x3qff7deKH90th0WSGebbz2fch0=;
        b=hwFFU4sxsWrDpNE05ro8auR7VIbxr/qjx08wqOID/EClxZfYwwVDhzUAWqtEaM+oL8
         60A92IgBWL42t5iwzZff07fMbjulZ2VsHcjw5BJJLyPKmvMEbXt1cOQHDs0Vcg/WlmyC
         Rddtc9hJfvu7m4LVqjm5bc/OhgzXlxLS+5aIasf1N9JqBFa4CfbBlQZGi+86vwgPcecp
         jmf+CKrWbY0QLE2PPHFdu2zlRl79O/9xu2UQFoyNnbvWOX5FmPq0LTLFpBoYzGXnCrRQ
         tGBWAdhAbDqOyx0TdBn125FfFnIfDKAqahD9bskbGl1WCFexPt8hV7mSKYDYS4SNgx8o
         TSew==
X-Forwarded-Encrypted: i=1; AJvYcCWW8X1cmIKVL7+sCweU0BSIHgK5sYXeox0I+s10JSKuHesAZNAfQdRL3RVL653DrLw2cPJz03coxgXRDsDUMug=@vger.kernel.org, AJvYcCXHURNzk3DmU0aSGn8s4mtSbzkWVZXjejElw4xBQyCCZDh0ZAArlhEVVVOy0hwfypKCK3bLZ2hhwPlL@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMEUzT6SIXrFAk9CHUPXPLhZ/TMkEg0EQYWTLm/RTOXtXlV7d
	fkr/tsGqLNSifwGRpPYYL+CqTRw2bmsy4pmYP4UVaO+OSji07HF68FIe
X-Gm-Gg: ASbGncvE4fKrg7/a7hrSG2rh6RHMVXDuR4LkZRnlKu7d1pRDzWI7poJMBt8IJOn/iRF
	iGll+jzifMTMV0sdsGBj/WV73Er5baa69t4Py366KTs9Z3b+ZYU5qq9YTPYNDSSWPI34Avba2RY
	Ygn8Ifi3pveIiQJyC0hJe+kzvKQWWPASXmtve183fog5JtaUYE6bBziYVV+6YoPB58pg/IyfPHf
	0GqjHkqhZi2KhPN0bsUN1KysYTmP9e5uaYRs971uQ0vVZlFZXuDwk6b3OnPwGL5eqDowXi9wZdq
	bkKwXXfkvAV9Q25cpKi1+S7SuQZVRG3yZUf+85PVyv5YfQBp89IhqWwrIEogpn5ZdQte5s8ra8L
	yizRYOamrYyM4IsIC8WR4Bzrnb0T+S28q1P+OewBv4U/x3PeWpo+bOzrL07YEMWgmr1vFDT9bYP
	w4niWr69nbBiQMEbGZWLiyEV8=
X-Google-Smtp-Source: AGHT+IFf1+u3+wvJoL53DLwYJThiLBprhFka7dPRpaBpXbAoP/xf6bKPE2chYFWWswYnYug5IQhnzA==
X-Received: by 2002:a05:620a:4405:b0:7e3:5620:1683 with SMTP id af79cd13be357-7e356201704mr792644785a.19.1752894519629;
        Fri, 18 Jul 2025 20:08:39 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c9242bsm157500885a.97.2025.07.18.20.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:08:39 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id A1500F40066;
	Fri, 18 Jul 2025 23:08:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 18 Jul 2025 23:08:38 -0400
X-ME-Sender: <xms:Ngx7aEYe8k7-ovJ9HXPHjKSJd50QbhIoSaW2Dt0-tdw7M8FIW_BhqA>
    <xme:Ngx7aA4xowr4YVgsklFwr6TZnwwOckoyjU0ptkPtY_jSSRKUHtQh32MC8hBjrHadV
    bfTfQlqWTCxQfkXMg>
X-ME-Received: <xmr:Ngx7aDjWhcYEZe-1hL2ekW_RZNttQgdqlO25flfM_Rr1c231DBfNVBhw_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeihedvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Ngx7aOIvBHXMcaE4goihocG_-Xv8-rKErOdX5dmPZNABOnPwTbU76Q>
    <xmx:Ngx7aNrGHG5i3RhTilUqiaN7N3Jp48Zp-ZravrO7ey5euP5f0OVV2Q>
    <xmx:Ngx7aEydhKM7noztigdRrObmDBtVIa1vtbbJfrOeM8nB_jl9Vgn1lg>
    <xmx:Ngx7aBdLiv7p-Y59JuVoEkbr3LOp2LjdPozI4HfIcmiwVVIwjWH-Lw>
    <xmx:Ngx7aAeEOsk0hRIHWsxBzz8xCKFJHiLUOgqDBThwF1I60nE8RsMyHNv4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:08:38 -0400 (EDT)
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
Subject: [PATCH v8 5/9] rust: sync: atomic: Add atomic {cmp,}xchg operations
Date: Fri, 18 Jul 2025 20:08:23 -0700
Message-Id: <20250719030827.61357-6-boqun.feng@gmail.com>
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

xchg() and cmpxchg() are basic operations on atomic. Provide these based
on C APIs.

Note that cmpxchg() use the similar function signature as
compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
the operation succeeds and `Err(old)` means the operation fails.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 168 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 14097ebc5f85..793134aeaac1 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -25,7 +25,7 @@
 pub use ordering::{Acquire, Full, Relaxed, Release};
 
 use crate::build_error;
-use internal::{AtomicBasicOps, AtomicRepr};
+use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
 use ordering::OrderingType;
 
 /// A memory location which can be safely modified from multiple execution contexts.
@@ -296,3 +296,169 @@ pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
         }
     }
 }
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicExchangeOps,
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
+    pub fn xchg<Ordering: ordering::Ordering>(&self, v: T, _: Ordering) -> T {
+        let v = into_repr(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_xchg*()` because `v` is transmutable to
+        // `T`.
+        let ret = {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_xchg(&self.0, v),
+                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(&self.0, v),
+                OrderingType::Release => T::Repr::atomic_xchg_release(&self.0, v),
+                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(&self.0, v),
+            }
+        };
+
+        // SAFETY: `ret` comes from reading `*self`, which is a valid `T` per type invariants.
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
+    /// [`Relaxed`]: ordering::Relaxed
+    #[doc(alias(
+        "atomic_cmpxchg",
+        "atomic64_cmpxchg",
+        "atomic_try_cmpxchg",
+        "atomic64_try_cmpxchg",
+        "compare_exchange"
+    ))]
+    #[inline(always)]
+    pub fn cmpxchg<Ordering: ordering::Ordering>(
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
+    fn try_cmpxchg<Ordering: ordering::Ordering>(&self, old: &mut T, new: T, _: Ordering) -> bool {
+        let mut tmp = into_repr(*old);
+        let new = into_repr(new);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_try_cmpxchg*()` because `new` is
+        // transmutable to `T`.
+        let ret = {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_try_cmpxchg(&self.0, &mut tmp, new),
+                OrderingType::Acquire => {
+                    T::Repr::atomic_try_cmpxchg_acquire(&self.0, &mut tmp, new)
+                }
+                OrderingType::Release => {
+                    T::Repr::atomic_try_cmpxchg_release(&self.0, &mut tmp, new)
+                }
+                OrderingType::Relaxed => {
+                    T::Repr::atomic_try_cmpxchg_relaxed(&self.0, &mut tmp, new)
+                }
+            }
+        };
+
+        // SAFETY: `tmp` comes from reading `*self`, which is a valid `T` per type invariants.
+        *old = unsafe { from_repr(tmp) };
+
+        ret
+    }
+}
-- 
2.39.5 (Apple Git-154)


