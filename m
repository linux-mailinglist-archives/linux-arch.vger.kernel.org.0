Return-Path: <linux-arch+bounces-12619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625CCAFF934
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5822216832F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC512C3256;
	Thu, 10 Jul 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk7A4leA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C82BE7A5;
	Thu, 10 Jul 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127271; cv=none; b=cEzhDEfDP8Tg1PpItkEh6zzYaTB+MWWHyZdtnzT3+Tk2OlpEWDoWuUcKJPh6mbAQYrKvsmHGbT8ZOPVhB9Mkjy/YfZA3lLMYQSIG2AbArreQq0doY9FiFl8Cv5TpTv5X/uhYBZDEgCX9ipWXARwf7AnVmtfPqSISPLM5s1ShAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127271; c=relaxed/simple;
	bh=HAq/kPb9ujAzsSU+sqSF/chqGGoNuLKQjburQo4hTb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2TzamJHyKO3j071r1RUICMovi2wrHak55A4YhuAB+IHRhv533res9MyC/goNCEATqpe21BN2ItnQZtjo6XNqXHRf7y2GBTasDmjdiCn7BUd1RHi8Bv6GjkRkECraafvUyvwZXfGOWIOaIVk7OYOJSGcXf1e+7oUrbd8niVlpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk7A4leA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fada2dd785so7387096d6.2;
        Wed, 09 Jul 2025 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127265; x=1752732065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T8APr2O5lJC3B4ujP5dNsioemZHw0iFX0dcBhhyWrqo=;
        b=kk7A4leAVp3bArwS3hyMxCzhGNwYzMn0KMsNI47IPq1RYeyLxuxjVEPZSyrp221itf
         J8ruI1s2vJTTq+D6oqrpkcva4PxYLvKpk2mLdpt1RqLERZ+w8uKH1MchOgco/7mODN4r
         0dxV7qLJBQVUTkHfsiS1W4u68p9J0xKVQrfvr9KsxzeFCinqA3RTX/G4B8aOREpT4Gp8
         NnzjGEczshXo16+NI1yz9G6Xi0wiTA6eeRXN0ys3P9vK4H1HjuIpDBeBZT3yiJW/806O
         hyNzQn3Oc+xdbKy9ATWVS+6WtvSluXVDvPhsoIG/UWcuw1NonMQ1zVpAVSLw1ZLKeijd
         oXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127265; x=1752732065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8APr2O5lJC3B4ujP5dNsioemZHw0iFX0dcBhhyWrqo=;
        b=DSCvpIGYL+mGkXm4lncfV1mFiHudIW8QkvyWJJyfRhEl9OdHzWQfjc+bvl+qRUDfvL
         DTN3KsU7/ux87C6wnx69CsfHYf01oVtYbeeYiZTSChDWi9AZXqY33JOfpkVOfX3le/VL
         S9fhKyO4UER5wkOVk12Pu2J09WdMiEZG3L2ao5tzA9d1Vn5KoCAvM30Xllm1sYRE3OLg
         s0BBToeDN0WBXwKa5fmO7wb/3fFbcf87GE8zHh7mki+hR1lbN4rwOKa2utagsI17PFJp
         nr0atfWuK+RFtDt0hMZh9FDLyS8QfU/rqmhQKhlHBTAgVEU0wBQZ5Ww7pYtgulgY6lEW
         ve6A==
X-Forwarded-Encrypted: i=1; AJvYcCUcAxhhobPeEUk8fkRqnuYP2D/vi/9MGcpwwGsPmuDJHHap5GpF+RS7vTzKH8HBaL6WmCsrGSP8oUyu9KLGJ+s=@vger.kernel.org, AJvYcCV5MCOpC36iGf6JKBz0AV2m9Um3UaB/a1LZKb79Ftrd0YOGAKvM2o1WSkx0vspne/h1pMszpFi6vBp7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywor8k2nmvBQubdFM0INfs4alk3Xy6BfThPomy0IlCDxdfOueWJ
	aNEU6loIVrSKECxj40TIIzno/UdDGtzlW+a4z1SAj3clUR6ceJpcPSfw
X-Gm-Gg: ASbGncsSId0y2LDRB2zwccey3phDNHz/k6mzlxKepTkCfwK9bM6Ts6SnBL1k7BukVq6
	o9ebt/k4uVfI9y3wh5OuGMjFx0r3e4HCdgk7hssZP1p9TIIak/yI/IF1SOvYeI0+mEYn3LtihPN
	2uWlAGCF46TnVW6gSXRIPE0qSKRi/wih0JcxIJUqZGDIIlDhUDNCmosSVgNTiB0wBh2qpYkVyq+
	QcgvyWR8iPt8pZdU6VbPMl+0K1S1dTNSRBEn5uUoL9NxL4D6P/pRoIQenOhZGFcw03fml5yBgi/
	Re5v6iK+96AdheWr6A6KlhiREpyiGBN5mHkN/pXbSvCIw6+7plgnfkxX7QjRiUgO8vopzoXQKPO
	VLz1+SfKcpgiup7UezlRyjduPRdjMgbqpnrmhIiK8WLFMOh/lzAhzaLtf5krcl3U=
X-Google-Smtp-Source: AGHT+IE8tPZMqE69NFvrAIW1je5hQqrEOgjBcNp5sZnw9s555Jd87fOsPrYBBFfrv14daEqRamAneQ==
X-Received: by 2002:a05:6214:1c48:b0:6fb:51c:395 with SMTP id 6a1803df08f44-70498224156mr17953176d6.41.1752127265034;
        Wed, 09 Jul 2025 23:01:05 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb1dc41sm62661885a.4.2025.07.09.23.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:01:04 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 066ABF4006C;
	Thu, 10 Jul 2025 02:01:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 10 Jul 2025 02:01:04 -0400
X-ME-Sender: <xms:H1dvaBphgvNuNMQ4n4pn6kq4zYOp7DjAGMx9FxoK8oUE8525vPDzXQ>
    <xme:H1dvaFIdiisyWCbCD1P3Z_WpbTSL_ZLNwrjPuQxyOrTq7V_Gq-gIJd8da62WFH_SE
    dlOUj3rmd7m9QBVww>
X-ME-Received: <xmr:H1dvaCyHzQfZqOHj-D6dyXqwcxvT_p6FRALh2V35InSNCU9wIZky2uDlpg>
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
X-ME-Proxy: <xmx:H1dvaMa_dWIklsYUtgoG1hoF74gmc2ydRTfPKvCcCWe8M68TOz4Org>
    <xmx:H1dvaO7i7ez-kDjq5VFhkqhSIP08UDGksigjcqI-2rSikRCKkHpW_w>
    <xmx:H1dvaNCJN7xph6qWjRrMUpDHt78xi6-qgQKNZhLv3Y3JHJPnXs3gGg>
    <xmx:H1dvaEuX58QPlqPyFT0ZEcVgKFi41agNyMsZpZnnxjZD-pUkeAZ3Ng>
    <xmx:H1dvaCuuWmkM9jdA2ZmlNUCuHTT2TyYqLBS6MTU8OKFPiECykHCGFkLA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:01:03 -0400 (EDT)
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
Subject: [PATCH v6 5/9] rust: sync: atomic: Add atomic {cmp,}xchg operations
Date: Wed,  9 Jul 2025 23:00:48 -0700
Message-Id: <20250710060052.11955-6-boqun.feng@gmail.com>
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

xchg() and cmpxchg() are basic operations on atomic. Provide these based
on C APIs.

Note that cmpxchg() use the similar function signature as
compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
the operation succeeds and `Err(old)` means the operation fails.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/generic.rs | 170 +++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index e044fe21b128..1beb802843ee 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -287,3 +287,173 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
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
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.xchg(52, Acquire));
+    /// assert_eq!(52, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
+    #[inline(always)]
+    pub fn xchg<Ordering: Any>(&self, v: T, _: Ordering) -> T {
+        let v = into_repr(v);
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is also a
+        // valid pointer of `T::Repr`.
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_xchg*() function:
+        //   - `a` is a valid pointer for the function per the CAST justification above.
+        //   - Per the type guarantees, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr()`:
+        //   - Atomic operations are used here.
+        // - For the bit validity of `Atomic<T>`:
+        //   - `v` is a valid bit pattern of `T`, so it's sound to store it in an `Atomic<T>`.
+        let ret = unsafe {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_xchg(a, v),
+                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
+                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
+                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
+            }
+        };
+
+        // SAFETY: The atomic variable holds a valid `T`, so `ret` is a valid bit pattern of `T`,
+        // therefore it's safe to call `from_repr()`.
+        unsafe { from_repr(ret) }
+    }
+
+    /// Atomic compare and exchange.
+    ///
+    /// Compare: The comparison is done via the byte level comparison between the atomic variables
+    /// with the `old` value.
+    ///
+    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
+    /// parameter indicates, and a failed one doesn't provide any ordering, the read part of a
+    /// failed cmpxchg should be treated as a relaxed read.
+    ///
+    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guaranteed to be equal to `old`,
+    /// otherwise returns `Err(value)`, and `value` is the value of the atomic variable when
+    /// cmpxchg was happening.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
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
+    #[doc(alias(
+        "atomic_cmpxchg",
+        "atomic64_cmpxchg",
+        "atomic_try_cmpxchg",
+        "atomic64_try_cmpxchg",
+        "compare_exchange"
+    ))]
+    #[inline(always)]
+    pub fn cmpxchg<Ordering: Any>(&self, mut old: T, new: T, o: Ordering) -> Result<T, T> {
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
+    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg()`].
+    ///
+    /// Returns `true` means the cmpxchg succeeds otherwise returns `false` with `old` updated to
+    /// the value of the atomic variable when cmpxchg was happening.
+    #[inline(always)]
+    fn try_cmpxchg<Ordering: Any>(&self, old: &mut T, new: T, _: Ordering) -> bool {
+        let mut old_tmp = into_repr(*old);
+        let oldp = &raw mut old_tmp;
+        let new = into_repr(new);
+        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is also a
+        // valid pointer of `T::Repr`.
+        let a = self.0.get().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_try_cmpxchg*() function:
+        //   - `a` is a valid pointer for the function per the CAST justification above.
+        //   - `oldp` is a valid pointer for the function.
+        //   - Per the type guarantees, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr()`:
+        //   - Atomic operations are used here.
+        // - For the bit validity of `Atomic<T>`:
+        //   - `new` is a valid bit pattern of `T`, so it's sound to store it in an `Atomic<T>`.
+        let ret = unsafe {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_try_cmpxchg(a, oldp, new),
+                OrderingType::Acquire => T::Repr::atomic_try_cmpxchg_acquire(a, oldp, new),
+                OrderingType::Release => T::Repr::atomic_try_cmpxchg_release(a, oldp, new),
+                OrderingType::Relaxed => T::Repr::atomic_try_cmpxchg_relaxed(a, oldp, new),
+            }
+        };
+
+        // SAFETY: The atomic variable holds a valid `T`, so `old_tmp` is a valid bit pattern of
+        // `T`, therefore it's safe to call `from_repr()`.
+        *old = unsafe { from_repr(old_tmp) };
+
+        ret
+    }
+}
-- 
2.39.5 (Apple Git-154)


