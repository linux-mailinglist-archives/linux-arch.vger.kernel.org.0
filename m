Return-Path: <linux-arch+bounces-12387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0234AADF2FC
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A04B3B7D14
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE002F5481;
	Wed, 18 Jun 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfagVAjQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFA2F4A0A;
	Wed, 18 Jun 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265390; cv=none; b=ooxOi90mHojTWOUOrYtFzK/RFRIQVKgUfZtnTzvUwLFznIr0MzTA1yJsPcQzqdczeIQpurprRc4/HY6ZyVaLJxw5CwFjJk3ptRftp8DPBlUGcJCvC1EzQjZ6vpUPXccdPbvym64OWGR/UY1W++EKJM17cLiR2xpBcQODzULQycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265390; c=relaxed/simple;
	bh=/xbsQlwVEwP5ylKy/kZdE5AStjYv/8ecIplTxNP+IrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dO0tMsCCQ1R3kU50iYzcnxETkPavqMpKFN9wKEcSxF3mDkYgt0Pkt4J2dzSNRBN82sMlEI04o20LnEoXIQ5r7kdsOZ8+iU5SPIAV1R682ZPiqDEVLHRGrHEpNeEFOPB3+41tq1/sKaOmmQmMjph1lNCQ9gXvm+raiUbhqitp6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfagVAjQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a4bb155edeso84077161cf.2;
        Wed, 18 Jun 2025 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265387; x=1750870187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=unAsjELoLmXleQcHS9ahtkPNHQOwUCjesMQMuSuNj88=;
        b=DfagVAjQWMQ+dpUQ1Q1Euw21xag7TPFOqijhhDX++cPvgICo0KEqY5HR+a/nqi2pjx
         qCR7VWXNiQyqJLDvATdgG8KC05wGesjc0mkpepX1wQ8j1p5Wb+l1DXMSUtuLUtKN2EsU
         nzfxkpiR/6wHRY+m//Z3DbnAgKO/+JcRKkBW3RAMEqnD4lO3l4slvc51gAWf6i8E/oeq
         SrcfZ9EXd0btLdjkhKSWKke97lLu4Xl8+qCVoXaJbmZQ87OduSL0wqmDX/+3MK9zS3/p
         iqrKofMpyUhP3YqGL7SRE1RF/kJF+/jIzk4AdZ3mELK/gBjo+P6kQaH37I8/Uy1FNHDV
         YBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265387; x=1750870187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unAsjELoLmXleQcHS9ahtkPNHQOwUCjesMQMuSuNj88=;
        b=YW/jNtKEoDOIpCU+ASARw5xuLYr/wJF4MhnQwLq0E6vv6O53L4tsSs2Yzzuxy2SnhU
         iUwZ7D9z+1yT1ABc8hamJFcArRv5I0XOVJAs5IgeKyxvs7xaxnZfNQ7t0LVUxODB5Bgt
         0MxbY6RVSDOUiOYKa0ARYEDB0CHZySEc4vrSeP7FbFxAf9kjbxLi8s6rgA9JdBg6DLKB
         VML4RFaYSp2AKSQtUxTJy+J7uwngyyenykte0auNvOOq+Lbhg4dGqaJz9RSTDUITdtJd
         vAQk/xfZ52jJGJXhmdvqF85Vhmf43BPvGW1n/Si4qFcpErDixOcXZjGbPByofQ4zVXMz
         q7cw==
X-Forwarded-Encrypted: i=1; AJvYcCVgQecJjgNl38v1Eu0QwZ5cFnaMXLFunvFlRzO9cFQQLJlgfYWw9O+B3YuJd6qOluEazDbHNkjMeFsUc2LevaA=@vger.kernel.org, AJvYcCXHQ6RYuOjkM1i3U7wmjCkujYOQEweGH/hyiK+xekiBDlqml3zQGdHKUicONpCQuZWln7NA9ESsBOpV@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYjHN0Sy2eMk9NB+ffjBZf2h73S+gusO0ZJ6dqHi5MSt5IvCg
	+IYixw7p/n9rx2u8MaBmfWGnod8tEFPI85KS8/RmRhXVbBxvsZXk6PHh
X-Gm-Gg: ASbGncsnO+PGI9MyM2OxbGDWtj/zCbrAbUuUBQxrb6kdT75w2L0FyXzfxqW730U726C
	Tq1YtylfgRXTNoK4xSmf15t75Tg6lO66iRalXJX4OSJ4REidKercCOcIp/a+SElFMdz5SrHZrYY
	3DyDhouc7uA18vFlsvhFfyLUjN1ZAy0VedKMQuIdw4O6PeYvT3Oekf7GBcs88dqVjv/WQ9aXZnd
	Dbl2OXQKOsWMz7tgjWwim0AjO4eJGgxxx4QpA3nWZESBKeMyQ2Jq3Xhw/S69C57tojp88fDuPUq
	FPwEp35LkwLQWEtrFkjGIqigo0o2GBio8ZdCKFhd9Lv+6M/7aj7QzIZksyaUTV/yR4NfEfYa4S1
	0VDnF3FAFI3gEjVEYgE+J5JhZi44mWPsL3suYqeNNyGpmCnAEFxcjr6vWKxSGxqQ=
X-Google-Smtp-Source: AGHT+IFkVX3zIQ+FXhVhrpQUa+yf0WzQ3i1XCNfjg0amMvG7G3bSmAgM/tJM3TFRmdtKO5Cru+Hzfw==
X-Received: by 2002:ac8:5186:0:b0:494:950c:6dca with SMTP id d75a77b69052e-4a747b5cb07mr187296341cf.23.1750265386911;
        Wed, 18 Jun 2025 09:49:46 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4e0026sm73651941cf.61.2025.06.18.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:46 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 01DFF1200043;
	Wed, 18 Jun 2025 12:49:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 18 Jun 2025 12:49:46 -0400
X-ME-Sender: <xms:Ke5SaPw3zbsp01HRY2BqVJ8mNURGZRdPU5GyWJ_EaAY0qg1Gls9S6A>
    <xme:Ke5SaHRa88KP-9WMr4smhBWZ73w_juWhZrHPgcTLvV_RX-MYWG-SuDNHCm2Q1Ve2E
    Twd5ElHSMEwF8mzmw>
X-ME-Received: <xmr:Ke5SaJUTMpfDZVSot8yPbucImwBLjFwiGm8X2hNEyp7vFHHEhf_dg8Vcq4-3xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefudeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:Ke5SaJigKeYUZLlHvqw82M-pryq1HzRCZdXwSl5jn0poiClgb_15aQ>
    <xmx:Ke5SaBC1ZX5-P8lnN7zqPdxh_7rWacqqdQEcxwsa1cRn2R7XIw29Lg>
    <xmx:Ke5SaCIUoX2M2gJwPus2cv6M6Ob0qiF65s6AZqgxRAlwuk6KFvBy6Q>
    <xmx:Ke5SaACwobMz3Udhgfoln5itMrBVCCHaNZ4fC1Qr14ETbExcYXIuuw>
    <xmx:Ke5SaNy8qAjmVsGmzrDI7VzeR4VQ5kWWsJQHs97J9vFyTrrZ979wTRSH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:45 -0400 (EDT)
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
Subject: [PATCH v5 06/10] rust: sync: atomic: Add the framework of arithmetic operations
Date: Wed, 18 Jun 2025 09:49:30 -0700
Message-Id: <20250618164934.19817-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250618164934.19817-1-boqun.feng@gmail.com>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
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
 rust/kernel/sync/atomic/generic.rs | 101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index bcdbeea45dd8..8c5bd90b2619 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -57,6 +57,23 @@ fn from_repr(repr: Self::Repr) -> Self {
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
@@ -410,3 +427,87 @@ fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
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
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_fetch_add(a, v),
+                OrderingType::Acquire => T::Repr::atomic_fetch_add_acquire(a, v),
+                OrderingType::Release => T::Repr::atomic_fetch_add_release(a, v),
+                OrderingType::Relaxed => T::Repr::atomic_fetch_add_relaxed(a, v),
+            }
+        };
+
+        T::from_repr(ret)
+    }
+}
-- 
2.39.5 (Apple Git-154)


