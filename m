Return-Path: <linux-arch+bounces-12302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4965AD2999
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4F1891D2D
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5368522A4E0;
	Mon,  9 Jun 2025 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFGxZXbX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8D227EAA;
	Mon,  9 Jun 2025 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509204; cv=none; b=rX5X46kY61dpf51yDwG+SVpFZzTTCEhoqmXrpkNH8hWE0OQWhIUkP/Bb9+9RIefQPI6O9mARc6fhNanKnrYTbWJRQUFUeSq+YS7j226y0Wi0bUsyZYLd6Cm9zTF5tu2DtznbDqHqrpUi8TdQ3WoFgzW2gD8Goe3YprbAOxWyE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509204; c=relaxed/simple;
	bh=xsHACheX02cEYcLip88x4wtB948B0xWNzAMevS8qR2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHf6GSNoSSmN7JduCh7ajzCocVSH72YIC4/41HQZUYhr3E5hEWd2m6PxRm/FSvhSm+QVr3PjJVNiaE5T58z8qaAzgsSzeBrLmdu/2wKSseBCbV1rILwbFVXYI/VgPyYFdxUwjnFUn3mFBU9jzYCgAxQzCfpzjVfzIr1l9FZeFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFGxZXbX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fa980d05a8so47334456d6.2;
        Mon, 09 Jun 2025 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509201; x=1750114001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AbuO++RMiLBujeQcBYpEohvl/WMGSiraH57rxKvmSTw=;
        b=cFGxZXbXfM2OwNny5upwP0G0g63zUnBSD2Vi48VTkw4qtEC5p/dGz5jau02S3JieZK
         WJJPuGj8zMsMXbh5lBNbjq8ofvu+WmffMRl9vPQUsTE/LYMtmDNpF9KLE9G8Lm0O8fWf
         LtskpVSq5avPe5tbiIMhf0KNzjbSOMGetBAO2eXPTaNT548bHSBogsM6RUQeLgA45ylf
         YY4zRLQStVh5zF8+WsIzmFv9RTMZbhFUzQihXnNfefNktCIyg5HzQ+jFbbYJzdx0IITx
         ewXhZC/NGzTB0auVChyWEQhvD7L6HVp2F8OnSvrQzmOKsrvChQj9mFsnzWkV5gZ9N594
         ewEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509201; x=1750114001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbuO++RMiLBujeQcBYpEohvl/WMGSiraH57rxKvmSTw=;
        b=LfwnFY9W3Lv5iTyV+kEpqbdzAxUR3x1onoX+HErQ3S5GMpByKZSEiSb+Db88gLYl/J
         lndavlZn60oRHIO2Z5mzzLggDN2ogWNlDO/39qV0ERmtaKYo7Drvuf1db7RmWgTD86iM
         TcwYAW0gDKn6DeqSD6DhvtZzUCeHDEo81YiH010lZavFkjeWtieJEFojjgg0S1KOMprz
         avkOa7sSifGea+XTtgzeQkx3D126sb13mvrrGCg7Rycf6egB6el8p9t+W2E95i61dkeb
         c8gAuv2NgYBsPung0SGaf6Jn/SCM9DrCOdpFRK7is+t+5rzmg8NUX+Wa69mSWOgPgbLX
         6qiA==
X-Forwarded-Encrypted: i=1; AJvYcCWtdPPOHKBVCr11ej18H1fVBb+Yo/9QAxw/w3GwZ/UD7pD6Zu5EZgeg2AKcfkkQm+gR8bqY0ZT7+0/n5ADSRoM=@vger.kernel.org, AJvYcCXXQ4OQ6y9AITWsHjhctzeCJDhbc/NhLZaYFX5fs4NUvySBsygKsCW4qBgLVxbJwjyRKrM5aiM8xr2Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbgQDRobvgIRufpbZ6zQG53UiZ+LvIJX60kNPXZwr65b729Tx
	n6Zr7nE7ShzaGAM3TElQKkWrBAUEt+yPhzikD2Te3Gw7PVf0JA7zE6vwaWTuPQ==
X-Gm-Gg: ASbGncsA7gGRAtCVWalSWkJCU1Ztlqf+16xcc97+TgQLp67sOKbqFnw7yHjrLrbwIF8
	pD27P4i8fqi3WEj1xSICZ3gNApIeuUnw8irM63L6eSIuKnm/Tq79Z4qnJIBXK+oVLTb3kv//65G
	gSK+N7ABiLAh0Sv6U900QkiXiUZLC8SAEt9vzXKgiq0cDRxjsz4ESwtysaD1l3oqWWwZACu0ZO2
	hbAcrGEbrEmktLfhIcGONR0wT3SWvOwMEoNbYBUJjzwRVg+MZAoIAAQIHacQSkJ3/o8HvJzjJor
	/WRDn+P5kkRxEK4SKtB8dUmKY7LVA14yNa40NofXoILJO5X/b3Vr0J/rK5aNJyePqlUm3lNVpid
	AKzx/QvRUkvJWovr2vDbns8DWWJVAk74Zfkp1esNGLGtU2tpOcPDv
X-Google-Smtp-Source: AGHT+IEDIGSzlCnVFl9GQWNMSfgr9LFPsOTm8gYIWNg0ODq/n1RXj0yeteLcHT3eW2v16F5a/3qa+w==
X-Received: by 2002:a0c:f643:0:b0:6fb:f00:48a9 with SMTP id 6a1803df08f44-6fb0f004bdamr154394836d6.19.1749509200667;
        Mon, 09 Jun 2025 15:46:40 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b3648dsm56955106d6.107.2025.06.09.15.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:40 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id C898F1200043;
	Mon,  9 Jun 2025 18:46:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 18:46:39 -0400
X-ME-Sender: <xms:T2RHaPf2Q9qBHCzUXcmhTrAZYzSCOoEMsHXe991HTGkeJOGts2svjw>
    <xme:T2RHaFMtfCS7wemG2N7YM-fS6tzWQAu2Q8xcZFw3BJuI1wppLTQ5N8mRIWVfkOdCt
    Z3bsaC3i-MdsdYRRQ>
X-ME-Received: <xmr:T2RHaIg2fNMvu2IexrRo-JjlZyd1HF8L9Me4k7JlOwrawsONDnlalfX4HRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinh
    hugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhu
    nhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:T2RHaA_UJB_kRbTvAljJd_vCprotjmmEgvmEj319_QGyUCPi87qF6w>
    <xmx:T2RHaLuISxUlbySjDNiSV0-UY81nyU3SDEhVy8lUVOHM0cW2AN5LGQ>
    <xmx:T2RHaPHVS6XjmyGjd4cpU8gSyVCrYXbgL26sFawVMoRr3I8Bgzyb3A>
    <xmx:T2RHaCMvSi5hWZjsO0fxM9hg0iA1N0qO5pXI3DanpZYcbihPVs9aww>
    <xmx:T2RHaMNQ5DIo5SNV29T75o7JhbBE958GtQ2Hhv7hpyigg4YMhKG-Wl3k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:39 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
Subject: [PATCH v4 06/10] rust: sync: atomic: Add the framework of arithmetic operations
Date: Mon,  9 Jun 2025 15:46:11 -0700
Message-Id: <20250609224615.27061-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250609224615.27061-1-boqun.feng@gmail.com>
References: <20250609224615.27061-1-boqun.feng@gmail.com>
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
architecures). Therefore add a subtrait of `AllowAtomic` describing
which types have and can do atomic arithemtic operations.

A few things about this `AllowAtomicArithmetic` trait:

* It has an associate type `Delta` instead of using
  `AllowAllowAtomic::Repr` because, a `Bar(u32)` (whose `Repr` is `i32`)
  may not wants an `add(&self, i32)`, but an `add(&self, u32)`.

* `AtomicImpl` types already implement an `AtomicHasArithmeticOps`
  trait, so add blanket implementation for them. In the future, `i8` and
  `i16` may impl `AtomicImpl` but not `AtomicHasArithmeticOps` if
  arithemtic operations are not available.

Only add() and fetch_add() are added. The rest will be added in the
future.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/generic.rs | 102 +++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index 39a9e208e767..f0bc831e8079 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -3,6 +3,7 @@
 //! Generic atomic primitives.
 
 use super::ops::*;
+use super::ordering;
 use super::ordering::*;
 use crate::types::Opaque;
 
@@ -57,6 +58,23 @@ fn from_repr(repr: Self::Repr) -> Self {
     }
 }
 
+/// Atomics that allows arithmetic operations with an integer type.
+pub trait AllowAtomicArithmetic: AllowAtomic {
+    /// The delta types for arithmetic operations.
+    type Delta;
+
+    /// Converts [`Self::Delta`] into the representation of the atomic type.
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr;
+}
+
+impl<T: AtomicImpl + AtomicHasArithmeticOps> AllowAtomicArithmetic for T {
+    type Delta = Self;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d
+    }
+}
+
 impl<T: AllowAtomic> Atomic<T> {
     /// Creates a new atomic.
     pub const fn new(v: T) -> Self {
@@ -410,3 +428,87 @@ fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
         }
     }
 }
+
+impl<T: AllowAtomicArithmetic> Atomic<T>
+where
+    T::Repr: AtomicHasArithmeticOps,
+{
+    /// Atomic add.
+    ///
+    /// The addition is a wrapping addition.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
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
+    pub fn add<Ordering: RelaxedOnly>(&self, v: T::Delta, _: Ordering) {
+        let v = T::delta_into_repr(v);
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_add() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        unsafe {
+            T::Repr::atomic_add(a, v);
+        }
+    }
+
+    /// Atomic fetch and add.
+    ///
+    /// The addition is a wrapping addition.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
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
+    pub fn fetch_add<Ordering: All>(&self, v: T::Delta, _: Ordering) -> T {
+        let v = T::delta_into_repr(v);
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_fetch_add*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        let ret = unsafe {
+            match Ordering::ORDER {
+                ordering::OrderingDesc::Full => T::Repr::atomic_fetch_add(a, v),
+                ordering::OrderingDesc::Acquire => T::Repr::atomic_fetch_add_acquire(a, v),
+                ordering::OrderingDesc::Release => T::Repr::atomic_fetch_add_release(a, v),
+                ordering::OrderingDesc::Relaxed => T::Repr::atomic_fetch_add_relaxed(a, v),
+            }
+        };
+
+        T::from_repr(ret)
+    }
+}
-- 
2.39.5 (Apple Git-154)


