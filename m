Return-Path: <linux-arch+bounces-12301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC0AD2996
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26809188FA81
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F8229B2B;
	Mon,  9 Jun 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX22C2rE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ABE227BAD;
	Mon,  9 Jun 2025 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509203; cv=none; b=EsejOGySZaSPyF3ecian9G2omOEVnpyjZkSyaW8jTBzyXxi2LGMjishQeP43I3NBAdtQ+ssMDQbko6ehMz5fdwYcDw7rg4r5pOvc3/N0U9p86s1CiLbMGHbK+gg99fsL1vbISm1QNysqHf581emi2Pk55VJfbVAvFxN753cq6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509203; c=relaxed/simple;
	bh=C9Im3rurc6OjYvlbCyDvwT/Ur5KVIFPvRRV4pmzupDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtVnAf165BMjkO3QvfzsV0BaqTxtq+uvU7XeX689vap+6em42WcRVsm/766x/JIJcAeZaklgBYembtZjqPKMcBf337Y5nRa6lQbsg6zaY5XCwx40/zOtvG0DlamOLy/meSKACUWpYBCv5xhfhCy0Nb16ZVt1AMbdDAyjS0BGbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX22C2rE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso34514396d6.1;
        Mon, 09 Jun 2025 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509200; x=1750114000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IObR9F++JkDqWSsb6EV+eGSQG5TSZzqg4I7RnfQH8w0=;
        b=iX22C2rE1GHfdmlPD6F1o55lVA42vh2/9IBtwGMwjWna226eKVJv3VM7bOvSffboav
         vPvOpx1fh8ZJCi6keZ2ORJHkeU3yzlBVNKMRIWKPnlugFsEpizCf8Z0eQJqjJUP9ZPz+
         LAL12H0fVhcQy3fPo2dNCVrd/HqPDnwh8NFDCI/+u9bLyMHUlt6aOQNU+b0y1VtaiP1W
         kdwxSmcb7oELIzy9MaYmdwC/IRjMEQMdZlxRfgdMtNoVsKIgz0e0pg1qLOt6N2Bb6IjM
         PA+g5+B9hplBX6avgA0BCdgvcFJO9UnKXyfzePn4NprPZu+OK1y7vdswKo04MTKpK5Dd
         cy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509200; x=1750114000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IObR9F++JkDqWSsb6EV+eGSQG5TSZzqg4I7RnfQH8w0=;
        b=Uf18T9GfJGujwDm0oFsxGsTw1/0mnrE8f58Oz5SKTs2ol9YEF7hZUJIPBRxRBsLbj4
         OzzhdQ0WGuA7irbIA/V1XHQSxBPF7icAGvjRkiz1JOE0Kx246/NsuvibqS119G0/sXFQ
         CwlQcUhCmCzhd/SWBXLzT02PSB/+J8QDm/JXERF99o7Gli+8MGEnpgM1bNik8PQeqOFX
         WnHzFYS8wDKsYab7ZHM9UiY01HmNsSnajUg2u2zmyeaIMJrMVqe/RkPTdz9m9cKigVE+
         xrMFxCBkNee1FgMx5BfrpSBaiZcW9GbxeeuFSl6TXQXhTJbkqvCst2KlvYOB5PW909Rn
         +Q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6aatDSTbhkWZuIUiKPiDnJGOZKGxueJnNy6kPVMux55OG+0rhkn+d9ru1tB/4S8PGFVFNn16a0V1vaHtDLqg=@vger.kernel.org, AJvYcCWp9xVkzvZQnuTOdebvkIYibU9oQ/O+QJd9KMp/eF6o3Ou++4HLB/UPTRySX0W4bVRZ7evS3z76/YzP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nWzFD1yi8qXbdlAMu3khtUO8BXqwSbFu4YZ4KWdCMs3Xrzyq
	XVb/h7wj1GKnPCFowIsPi+dEeBfxrg+A2kgUPhJnXnU7G4xpOZwBs4DU
X-Gm-Gg: ASbGnctzMkj8X8paOjGUnOC9FUtnrnvqpCGYM88/k6N+nIoNTOyUmXz5jhyI/I6t2wH
	gea5iemNDsRlxhf7wr40sDEp/Fb/fp9bu1dj+6NKS0s/4tRqm5dEZgwqWpuSd8cNzKw7DQDbQLC
	u18KztbTHk4bZLakBszmusJkXkD96qbaZpsXJacDCU+AIxClRRRCS9j4QofTYiiWrX5pQZENFqf
	LcRIR9daey23y3UOVDgbhM/eIIjG7rAHDeHol5Uen0gU0jDRnuY39TrFa8YB1vFXupnhLm5I+Y/
	BoKA8hnRk1r9Loj0+XCyFCoUNCj2jYvGTiWWWOb90VfOG0WDo/lYLeTNOZsTr72Hxno+HiEe17O
	ihYuv3TLTRHY8OOAFUiB4VN/kAKpEW3v/J/SfWbHFi5VGjwumT8ld
X-Google-Smtp-Source: AGHT+IFMe2T3d3AQDY8nv3ixHYzt2jrNEFp9cLzUunVNKoutc8cZR5sOsy2x0vOgxNB03WtcFwvEiw==
X-Received: by 2002:a05:6214:e88:b0:6fa:a5c9:2ee7 with SMTP id 6a1803df08f44-6fb238f98ddmr20547046d6.8.1749509199574;
        Mon, 09 Jun 2025 15:46:39 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab94bfsm57591876d6.18.2025.06.09.15.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:39 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 87AB71200043;
	Mon,  9 Jun 2025 18:46:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Jun 2025 18:46:38 -0400
X-ME-Sender: <xms:TmRHaB7k8vtHIUBegAkuqFdedDWZnlbS5dH2kE0kXJafX5rzWwzfgw>
    <xme:TmRHaO4w_Bb4mlDdi_foORpmAJyvAAXjWOIJEQxzLjCtKdSNLMSCpHy9Y64Jxb2-U
    QJibCX01RoA_jIzRw>
X-ME-Received: <xmr:TmRHaIcBH9TxF4CNz-JtgDA2L1Ara6ss6RHzJrd-yrFu_2z_XGeOX2TQ2WI>
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
X-ME-Proxy: <xmx:TmRHaKJc6usqG1oO9dzgP1dr4OXSfbtDe5bhduuf46FlWNg3OxVVgQ>
    <xmx:TmRHaFLBnh-q6DFpf9fi5NwWaTEphlBPHUmmfRUQAByoXS10GiDDMg>
    <xmx:TmRHaDyYxuzC9U88mpytGpDwnRwLN-Oo5XWHdBLEeCv66eyyMZAagA>
    <xmx:TmRHaBJLQg_CMPxsLxzWMEKtjqacwTGHn-RXSntZ2bQGI_1Oq-pNqA>
    <xmx:TmRHaIbv9OfzNBZNQ8MhqAacwoCF1ezhyacHDDCrSSkfAOMktIjmreCG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:37 -0400 (EDT)
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
Subject: [PATCH v4 05/10] rust: sync: atomic: Add atomic {cmp,}xchg operations
Date: Mon,  9 Jun 2025 15:46:10 -0700
Message-Id: <20250609224615.27061-6-boqun.feng@gmail.com>
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

xchg() and cmpxchg() are basic operations on atomic. Provide these based
on C APIs.

Note that cmpxchg() use the similar function signature as
compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
the operation succeeds and `Err(old)` means the operation fails.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/generic.rs | 154 +++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index 73c26f9cf6b8..39a9e208e767 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -256,3 +256,157 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
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
+    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
+    #[inline(always)]
+    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
+        let v = T::into_repr(v);
+        let a = self.as_ptr().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_xchg*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        let ret = unsafe {
+            match Ordering::ORDER {
+                OrderingDesc::Full => T::Repr::atomic_xchg(a, v),
+                OrderingDesc::Acquire => T::Repr::atomic_xchg_acquire(a, v),
+                OrderingDesc::Release => T::Repr::atomic_xchg_release(a, v),
+                OrderingDesc::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
+            }
+        };
+
+        T::from_repr(ret)
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
+        "atomic64_try_cmpxchg"
+    ))]
+    #[inline(always)]
+    pub fn cmpxchg<Ordering: All>(&self, mut old: T, new: T, o: Ordering) -> Result<T, T> {
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
+    fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
+        let old = (old as *mut T).cast::<T::Repr>();
+        let new = T::into_repr(new);
+        let a = self.0.get().cast::<T::Repr>();
+
+        // SAFETY:
+        // - For calling the atomic_try_cmpchg*() function:
+        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllowAtomic`,
+        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
+        //   - per the type invariants, the following atomic operation won't cause data races.
+        //   - `old` is a valid pointer to write because it comes from a mutable reference.
+        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
+        //   - atomic operations are used here.
+        unsafe {
+            match Ordering::ORDER {
+                OrderingDesc::Full => T::Repr::atomic_try_cmpxchg(a, old, new),
+                OrderingDesc::Acquire => T::Repr::atomic_try_cmpxchg_acquire(a, old, new),
+                OrderingDesc::Release => T::Repr::atomic_try_cmpxchg_release(a, old, new),
+                OrderingDesc::Relaxed => T::Repr::atomic_try_cmpxchg_relaxed(a, old, new),
+            }
+        }
+    }
+}
-- 
2.39.5 (Apple Git-154)


