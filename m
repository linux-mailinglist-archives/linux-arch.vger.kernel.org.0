Return-Path: <linux-arch+bounces-12388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BABEADF2FF
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C453B62DF
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CA2F9494;
	Wed, 18 Jun 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh1oKwRf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899352F546E;
	Wed, 18 Jun 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265391; cv=none; b=mG1P4VwKc2eEjcZDufcJFKcVG6zyIzdIupGk6b6j8W2FBFYJC8x3MOQW2hlGqkL5ORo9G1DPemgSHDGiGTZ13SDGP6LIjHcZ0N6i8deO7kI/SwbkOIdFsqaiaV2OQjMySF1M7JeqZdjy+8oEf/c63PLPVuxbHxxhEwkgbeitf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265391; c=relaxed/simple;
	bh=/1u7Gor/8OrPhh8RWM7zBT05ZYt4jbJTlHKK+zHR+1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWIXBq5iPrBxjlnLQU5Rc5PpR771/MmFXD/b85RToTVGX9iY2WFvAk8RcGuF5rYbFdAtFpN+ZKlIiP/A1aduC18TnHxpbks9Mon+gTJo/fLW+AuT+YFTY7HKyI5dZ58JTDtrNq52unvzMYSCeB6ZE+WQY91XDocT8PWfJNOccJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh1oKwRf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d3dd14a7edso403772585a.2;
        Wed, 18 Jun 2025 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265388; x=1750870188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjCJHW7K90LFjb9bKN42TOlFgvmqIavct0SBIAGQ15s=;
        b=bh1oKwRfzV/Mcvje3ZK9Fa43+a2ktE+6RqG8WhHT09Qts3cI4vbfQ9aCx9uIsO++/F
         3SADtAX/3HraV203sjNtTIF1szOX0WDTFdwFYjcCIYAmwYJNFM/QQpa2QBl5tjY9XJsF
         RsILNt7UhTJbfmLi6DyPPSPx1oS+lEgfvVlnrXDUrKhdoSM/fK3rseLhH8BUruny4qU0
         vE3OieCzT4b63l1eTObiF3PSW7CDMsBxx/gpARXURMpWOuuDVr3MOqk25otZ6TBfXayp
         JRbjilpA+y+VsrzvFSDPq1ngGCwWhMJPLBgY7gHlrSrPicv5R5N+NAd+0Rzo2cMMakJv
         JONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265388; x=1750870188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjCJHW7K90LFjb9bKN42TOlFgvmqIavct0SBIAGQ15s=;
        b=IDiAjr0nglSWvOQGPDL8NaoFdUeJubAmjaPLkMfc0gicGg7sZuLznwCD2vje0IkTeR
         tsHmqF7jlpOq8qjS26wd01IGnMvqFtDvBNvIWYal4ARGHFa966UQgvW+RiLFrZx316gv
         v3s1L4YCfNTAux/WfzIvMpKh6Op4EwlAsBgVsJtNwkHbG232RiVOabkC+JGK4SHQFF8i
         s8Ovj3ZBljHYeQ+VUhTzch5u5cO6BwEZaBXM00crfnabdy/tI41g09Nwn4vh6Xr6zVnb
         UyjoKtb5u2CYBjmXPKUpUS2EgVfu4sxLZhVkRwAYEkR00Su5euKuf/ERlaZx+Qsv5xQ8
         4YMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3wPX/4oIyxKpTJnUF7AYDmsqbI4CNgT3hWuQEQR7APWjdKJVHPL9WRqtesoamo+5TYcgl7RkgXFm@vger.kernel.org, AJvYcCWGKMfej5msuB3Sk1KYtXFSPkpyI45IA+xsqMjqMt2vDa8rFJ2o/FB7jByQzS0kW4QqVfrRa24zMzjnioiCmBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDer+pU7rftVj3StFNzuPc3pMIkeDXcrBSK+2aGZolQlETVb2
	Yu3Xqh/ZZzLC8Hk6HAjnjPdxYHhZZFVPoHQcDYx3xBIHR2mIF4XCLZ0A
X-Gm-Gg: ASbGncsEI3wBPmHXRZCk1XxGCvrMkkfpi9lU9DSA9uym5zoi5TniPCmVvc0ibLxW6HO
	ede4AYmZxrctBwmdrd4HbrU0vtiCCiWk5zawmYVqzmwcGKci5Z3u/lKUef74AqskLJlNTtYuNIU
	GUwZx/7EgganNoLUaoJL1JjPLEeNqmqHhDwJzo4DflKRaaB53DD8ZtTQwU5XgJfILPAgVdx6qg7
	QLXndoEZOOIOA5QBwNNGJtnKYXVB/ZgnR0hJ4O3Q9lyoofc4mhr8EbdoMsKkJ3Mlpg+COzxaJ/L
	s+rAm5nRGDHra0lJhjEDiuMd5Pd3k6s+FA7OQFx6SwMMHtLkJDBGYPykOWtMPWF5qvOjcXGemcN
	cBHHUFfgIOvvaQge1fhooGEQ+VTtHQMbdRL0xvvRI6McY/cnBZVk6
X-Google-Smtp-Source: AGHT+IFaLEVg8p8CUnS0SdnehCb3ymzjCbkC0/6SQXVEx3+RzVM1NuRoZXGUVgnreOpmLk9wxUe+yQ==
X-Received: by 2002:a05:620a:bd5:b0:7d3:9012:75c4 with SMTP id af79cd13be357-7d3c6ceedfamr2795072185a.44.1750265388334;
        Wed, 18 Jun 2025 09:49:48 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dc9e7asm789775785a.8.2025.06.18.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:48 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6C1C71200043;
	Wed, 18 Jun 2025 12:49:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Jun 2025 12:49:47 -0400
X-ME-Sender: <xms:K-5SaHHfagE5uMFkzulHi-CZL3D-G4hRZP5Jmt9Bsv3rpKIvw0zOCA>
    <xme:K-5SaEXFYuFFFkYBHeLGHlMwvNT2WwZcWEQR7an7b2YXKZmIbOU5Eyth2wEf4Edjh
    s-0pKwJgmHAM-F0Lw>
X-ME-Received: <xmr:K-5SaJJURl1LWMGmYye6UJ4QD1PynSFntCWiCdcb2upAsVua7jUDnbSRaUjAZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
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
X-ME-Proxy: <xmx:K-5SaFGaaL7WqeaHv4lJozXLvnXRp35_4wWCVoXbfVQw_akxxYZmWA>
    <xmx:K-5SaNU-HsrKsGq8GQ5e_RADd3trif1cTDsLRkPLZkBZ9l7WhGQmoA>
    <xmx:K-5SaAO7ll5Dx_96xCNW69juZcdiQ-_12dVrdfWlZewdxLEv4ck92Q>
    <xmx:K-5SaM3jkyWH6QdYiD7Lt6P415lNVN5US5JGLEQQ01LPghfPTEKP0w>
    <xmx:K-5SaCX5Tq51tBChYcNS7sMOI3R_r5MTC6iTcR-N4zT60YquGs-CGJln>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:46 -0400 (EDT)
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
Subject: [PATCH v5 07/10] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Wed, 18 Jun 2025 09:49:31 -0700
Message-Id: <20250618164934.19817-8-boqun.feng@gmail.com>
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

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Unit tests are added including Atomic<i32> and Atomic<i64>.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 111 +++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index a01e44eec380..965a3db554d9 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -22,3 +22,114 @@
 
 pub use generic::Atomic;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+// SAFETY: `u64` and `i64` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u64 {
+    type Repr = i64;
+
+    fn into_repr(self) -> Self::Repr {
+        self as Self::Repr
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as Self
+    }
+}
+
+impl generic::AllowAtomicArithmetic for u64 {
+    type Delta = u64;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
+// SAFETY: `u32` and `i32` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u32 {
+    type Repr = i32;
+
+    fn into_repr(self) -> Self::Repr {
+        self as Self::Repr
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as Self
+    }
+}
+
+impl generic::AllowAtomicArithmetic for u32 {
+    type Delta = u32;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
+use crate::macros::kunit_tests;
+
+#[kunit_tests(rust_atomics)]
+mod tests {
+    use super::*;
+
+    // Call $fn($val) with each $type of $val.
+    macro_rules! for_each_type {
+        ($val:literal in [$($type:ty),*] $fn:expr) => {
+            $({
+                let v: $type = $val;
+
+                $fn(v);
+            })*
+        }
+    }
+
+    #[test]
+    fn atomic_basic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_xchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            let old = v;
+            let new = v + 1;
+
+            assert_eq!(old, x.xchg(new, Full));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_cmpxchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            let old = v;
+            let new = v + 1;
+
+            assert_eq!(Err(old), x.cmpxchg(new, new, Full));
+            assert_eq!(old, x.load(Relaxed));
+            assert_eq!(Ok(old), x.cmpxchg(old, new, Relaxed));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_arithmetic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.fetch_add(12, Full));
+            assert_eq!(v + 12, x.load(Relaxed));
+
+            x.add(13, Relaxed);
+
+            assert_eq!(v + 25, x.load(Relaxed));
+        });
+    }
+}
-- 
2.39.5 (Apple Git-154)


