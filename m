Return-Path: <linux-arch+bounces-12386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2AADF2FA
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B3D3B6D26
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604592F5463;
	Wed, 18 Jun 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiDKRDgr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D42F49FD;
	Wed, 18 Jun 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265389; cv=none; b=Sq/GDTEv2CXAbcJhAXocK2Oe6widb66oiSC72SiDHmLSeferLSI0r+Zn5dP3eTkqAPxpOnRWOKM9elomulejgiX+YT7VpcjF/+F+WiVB2viwjLwZiGYyIKyBoFrRCzG8935mytxxrSaiz+Mh9HEjD3MplZa/bWt2vJ08cBQfAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265389; c=relaxed/simple;
	bh=/HcW3eZAjE++VugN9ilKE1n8C1cr+cpOFqBk7hSOwts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFplkZK0wBZfGIopL+sfGks8Fe+8Pcavmle/l9VRB7YgXqE8RLEYgqCRSPoqkEN9HNPKwLBbUfTK+LtZKAtqOob/ZaFI4sxgNGPOwvcFjn2u+6hc2IhDU5hDvJ3UkbKrwsECGQwce+tQQ3v/g4GM7y3Dxn69impKVRO8dcHzjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiDKRDgr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d38cfa9773so751382085a.2;
        Wed, 18 Jun 2025 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265385; x=1750870185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ENRbZ3eGBDLlJvyZh4O0swl7RFRKz4H+todkYakjL80=;
        b=aiDKRDgrVw3c4bfWCqMaP+Tax3xCitN7GXUdI1Sy0oaTuyLPumIam4OyhddcjUXchb
         esQY4KAp/dKEnsGb7Vyf1sjZI5qztaEHvO0pd0ixo0R0i1qqWxU1NiI4cYkwHYgDBW7V
         mkjtT14YZImUV64OSLJ2kTP1BcNV0U+PcZM87C6+J4LYvqCnjtXdHHnD0d2BrrUsE45e
         st19IVshUkNPClxyJQer//LsH4+0YcvF/gY/WuTt6DgAryyAJUNIv3fswNYs5myOB82+
         9cHrFrjevM79kHt+sCzgMSAddyRyxen+o8EaRUbc9ccy1ycUjOfAvzsdYj67VAZ1ijO8
         Z0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265385; x=1750870185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENRbZ3eGBDLlJvyZh4O0swl7RFRKz4H+todkYakjL80=;
        b=pbW/2NU7vTi3NNGi563N8m8FCBk0c/kKruF+j4U99OvNIxg3b9nO45eolf3SBhVZGK
         Dcj4KJRAw3zDM7XYGoTF2DUQLFaCB1vOLVaC39LqED1I/p/q4y8fSU6y5GGChraVIeJK
         kQzvTDQffao63ZAwi6MmXiPSFNc+dKcTE7fUjV7utCNbUF/0t1ekl8mHL6ftoMwzgh+L
         TuSdRIBKlJLeyFcnIJ2i7k1kO6ltqhYpXa+rxV2/1tEHzW4N0rxBPGz1i9VKoXD7NTJG
         S4SJ5a1+G8AJoijs8d5UxgYTDAouE0rggOcZmB2/+Z3dhDSrtZ++byQkEwuAqYT3kyGJ
         gGEg==
X-Forwarded-Encrypted: i=1; AJvYcCU59+bhOqbXWL16z5bDlQZZbo5fktz02fpo/Cndxx/ylku4mAdOyRukGMKLRNDt9XUsTLnqIX9M2/BM@vger.kernel.org, AJvYcCUSMxGKG0rWIeUjiwYNuRMasJMKZ334SsoDw4N1a76DQBXnH9XEktw4rP/+++0HOnlp1O/H6doSmDkCysaRYG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmRav6imxLNbZHl9TUM1RgAhqgDzW9s4zE0XXObi3qs1EVaMQ
	fyn4wjLM2+Mt/3g4nzS0qYDf17C+h6zkqYU0WCHb25DIxr0X5qh9ng88IBdrnQ==
X-Gm-Gg: ASbGncvCP1w8joP2mR8QR01WM/dVoYbZ7gdR0leLqV5lZFnR+TyZjbSlXK1MyHXwwZ1
	nSUlF9JW3GKSE0zaOqnz0zBgdQ/4ziY4rdCwGeBERAfWlTW9GQkIQt5MuVmIE2kF2Lnc1MzjWcL
	URb5m54PU0d7KXNcXLQR6PpgKMh/mXkm3h4ucpuKEOcjV2evJfE5EbnFZMCpxFbwQAu+Bd++xri
	zINv7vRGwvT5+HDzPohiKNelYAX95Db+n+KpxAqu89dVMqf5/5UZwYJJNtAq8ZxsHsBF/Xk0qdg
	SuShhXqy3TRTiR+DbC9jxsyRUYZEqIo8ObG9065cmjszRlzLhW/N5jn3M9cAea4yuhR0aCVOjuL
	qqsC1lxMambqYf9kCA5e9BAJOSqSU/GMgQXT6XHYWAnGUT1A0/Al5
X-Google-Smtp-Source: AGHT+IGC1AEyixCKYVuCrByoXCVkH0MBctNVPqJOz7FMrF9Sg12FGAUf/jdhG0AMuNCF9tEpZCrcpQ==
X-Received: by 2002:a05:620a:63c8:b0:7d3:9025:5db7 with SMTP id af79cd13be357-7d3c6c1e568mr2487575585a.20.1750265385507;
        Wed, 18 Jun 2025 09:49:45 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8e28623sm784699285a.51.2025.06.18.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:45 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 95B261200043;
	Wed, 18 Jun 2025 12:49:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 18 Jun 2025 12:49:44 -0400
X-ME-Sender: <xms:KO5SaJutRO1BMWucqsHvsc5lgBXoYiJCBqZ-cBjBeXex6ZjrndJEIw>
    <xme:KO5SaCdJEXdeWRI6cUgr_kd1Kir4wlC5MAtfTK-QFZFDW4_PrYk20zRa1BP3QGMfy
    gyFjWYjhCs5L5-U1w>
X-ME-Received: <xmr:KO5SaMyHaXMIBDtIzDtkOqKhbQq_rDh2SPLdTqGzylpDwpgLuiJCP9LSIrzS6w>
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
X-ME-Proxy: <xmx:KO5SaAOG41Dt1WwLY6isNcW1Zid6oX6WB6XQKY2L26DvFIaJ_-gs6Q>
    <xmx:KO5SaJ-FTjzwHknR3I4n5OPq39a2WpXU3Jx2_q48JWeL7hzJt1g3rg>
    <xmx:KO5SaAVb9srMuo1WE0_tzXP4Htiv0oSTeTXW9VXZ1a6-IVFqn_jg5g>
    <xmx:KO5SaKfQ5HEP1xPtcg3HT_O32PFmUvvjGVSRK0dLFwWhtHAbI1wZAw>
    <xmx:KO5SaPeth0ZBKaYnbZzfAOfTbFjYfNd-wcw-b78yuWhV_ORIkff8EjvK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:43 -0400 (EDT)
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
Subject: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg operations
Date: Wed, 18 Jun 2025 09:49:29 -0700
Message-Id: <20250618164934.19817-6-boqun.feng@gmail.com>
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
index 73c26f9cf6b8..bcdbeea45dd8 100644
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
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_xchg(a, v),
+                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
+                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
+                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
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
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_try_cmpxchg(a, old, new),
+                OrderingType::Acquire => T::Repr::atomic_try_cmpxchg_acquire(a, old, new),
+                OrderingType::Release => T::Repr::atomic_try_cmpxchg_release(a, old, new),
+                OrderingType::Relaxed => T::Repr::atomic_try_cmpxchg_relaxed(a, old, new),
+            }
+        }
+    }
+}
-- 
2.39.5 (Apple Git-154)


