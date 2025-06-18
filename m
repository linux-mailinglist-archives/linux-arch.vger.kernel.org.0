Return-Path: <linux-arch+bounces-12391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7CADF304
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB86189F521
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A72FE37F;
	Wed, 18 Jun 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPDuO+MY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E22F4A19;
	Wed, 18 Jun 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265395; cv=none; b=YRvLH8mTccOpkvFNnSTA+lHzLhAQNicxWPJSAvgv7+L7Px2W410rDwEmkTSbqjDMVKNQ/z4k16Rerv3p+NVe4HvZ4OPRVhHTV+VUHVRakyMxa9n5k/8cd1ntfpFeMHNJnmkLirCCUzNYa4eXxWsB7wO+23T4iWoOfdhfEyEvQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265395; c=relaxed/simple;
	bh=bw14+xZqI0w9yxj/j5uKeKXaYLL1MtfH8KsStGXN1Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i18FtkdijlFe7Ux5uq0wKcva0ILIJo+bFajeNm0aAoSQT+GgfsvixNUCJP2rRipSuoIhPxbUj1xdtAmfL45beTSVGd4t3RFVA35T57xQz1h88+jQsHromzk4IUxry+5ld5jUGSRLplZLVfUzSQvFKq7fCV5zCCaQkTwNv38GZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPDuO+MY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d3900f90f6so771986685a.1;
        Wed, 18 Jun 2025 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265392; x=1750870192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hO2T4XtpSZqQqdPFG12LlFMg3J8jBgvJe6Qf6HA4HQY=;
        b=iPDuO+MYWCj+GbINbGUxOPDg+/Bss5iH7Yt/uuunkSwqVAdDi58vgsle/E1FbusIsb
         W6E4VnXtBetsuda04kUo1E1A2M/bfM9DezAH/14dcDR0iwb+R+6/lDM8VjNoHme+/fol
         qTsGomWFqqmYrB5lbWjgY/WmhANWAcurnFeloKjGqpoLFWJLlRjvGojM7YpiDf7f4tAb
         3EDs5NO1RxntWJ09j7IiuhjvFt64Kil8dKBUTgDVItNgXCW3CuyDLnDPVTF9aWRyfPCy
         Hx1NmoZWFFDi8pNGhdy6ShNUchmX7yOJCT0q8/BPcFPOCjR8CYPo604sS+LMLmXWxz/9
         Gfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265392; x=1750870192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hO2T4XtpSZqQqdPFG12LlFMg3J8jBgvJe6Qf6HA4HQY=;
        b=RCoBgB6sGWINU+H8C1uWfzEZbNSjHUyxEpSu6cUQANqKXeLeeODrbwNhnPqwwgftqa
         sy88Kv5oAv1BGzFKmR21Kd+G4AIGUM8om5mhs0UzrFfxzGETy50lZHCbHJaZ1czfYvnB
         oiSuRGBlYuRejN1l4f5VXRUhBG2v6u3HSDfyFdTAGRpVnL6bqkVNfoo11cQekj9QSyWH
         2lRlTdAxH89ZeJ4jQxB8kfYV74RI5egDa+hBmtrY7Pgkb5hb9ADCDQLKFF852oABMScl
         Ab++3XvKY8kRK8wsvdqdb60MPl83SD0WcsEoZCMbjsc2ZOGAq9tLxyFbYMaUeZeqNeFN
         qW9A==
X-Forwarded-Encrypted: i=1; AJvYcCWlwpCN0O3Q3FGrINYEujZstl4HzdFOOpDEco+HOoqgOaMs8kcWZFKGDTPWwLll18jJy/wIyBGezX6nSh81ypY=@vger.kernel.org, AJvYcCXrm+BBrVTf68dbrnaqg8Xr85ElmIea4Dh8vMJ4r++xeWpHHmms7AN+PN3pf3wQHWdkX9s/BwHPNng7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YgpZhkMfWtqpVV4+Z4clQLGpooXLV2KMgxNuDkF2mU1S6rfq
	pejizMYJ7SBBYpo+rDpf1NRrsC8l/Y0kW2JWbQvfrvO3aIeKtV5+AQV2
X-Gm-Gg: ASbGnct0l3YkAPOmWn3QlwUr8QtzTXXhOXOVwIhAd9SVj68hPjsZko3IZy942Xq3fMy
	mlJpeQXhUNm8kY+MKRDIKwycrW6P+3uJ1bqdoPFALOwlZm1gFn/MPcBFaWwd2XjjZ4i3jqTVvWU
	1iXIK2Q8c1whq0vGMJnKmJ1tlfhL1DzVbiw6fUgV+4GLGNjGQ34iCu0wguohwsH3ktRx6LNuAjA
	oi/p9qpcWupfpYWQPdxYFR8G9hzAL7UDpOn30CtnYzYc/sdv+S2rAgSipoh6idsZzoXr0xI1WI4
	53iJetEnPOyN+5hegCq1rxPKpfSl6yxsfnQM561m3mh1/oTUtxyq7z4ACoXAtC4sC0MfC11Cti7
	fhsJgIa7lnhFDpoZkV0KzGcF6ehNYaoU0ZUpgWo4/rD6DfDbrzu4r
X-Google-Smtp-Source: AGHT+IFkHVXdIToKeS9IYC04H0XhotnExqBscPeT2KS3dLGvn7Ooi5xAI0y8yvE+Wp85XtZepw3pvA==
X-Received: by 2002:a05:620a:440f:b0:7ca:f02a:4d2b with SMTP id af79cd13be357-7d3c6c0d3b0mr2596059785a.12.1750265392346;
        Wed, 18 Jun 2025 09:49:52 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c927cesm74824436d6.124.2025.06.18.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:52 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6E4AB1200043;
	Wed, 18 Jun 2025 12:49:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Jun 2025 12:49:51 -0400
X-ME-Sender: <xms:L-5SaPZs7INv9PvJEjATrx34D-oOEMwd89GdvaBB7pP72BOpHwziAA>
    <xme:L-5SaOaETaR7yn2MtJbfHdEe8ng44l4dwv0I4DlBze_-KTXI5PjnaupFhHZQ5BLbK
    zO3NDuQHw3rMFR4XQ>
X-ME-Received: <xmr:L-5SaB-S0IkR5iOtkAXq0rz1sxMiS1A6JsSMwXP3S3CoutpJgrmZ8RevsP2bbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
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
X-ME-Proxy: <xmx:L-5SaFp9jezQUuWT8ghuBZ3Rl77GwSkiCeloXIaZqeJAl-8Vo9KvbQ>
    <xmx:L-5SaKr_GK66wQWUqSCUCxSyZwWup2ZfYEUX1qOPB4xHjoEZunEfdQ>
    <xmx:L-5SaLQz9jN0WCCf99VytGe4F0h4tSrM_bVqGbdT4NLYRI5c5SmQaA>
    <xmx:L-5SaCpN1YZWFrNxfAcwVjJ5J_JeKhSWsIuKJm09pEtP-Ul4kumFmQ>
    <xmx:L-5SaL5jjqNpvF_3JPV9GWgP1Qon6C0JifsG5phYICaZJlqrynyswStv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:50 -0400 (EDT)
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
Subject: [PATCH v5 10/10] rust: sync: Add memory barriers
Date: Wed, 18 Jun 2025 09:49:34 -0700
Message-Id: <20250618164934.19817-11-boqun.feng@gmail.com>
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

Memory barriers are building blocks for concurrent code, hence provide
a minimal set of them.

The compiler barrier, barrier(), is implemented in inline asm instead of
using core::sync::atomic::compiler_fence() because memory models are
different: kernel's atomics are implemented in inline asm therefore the
compiler barrier should be implemented in inline asm as well. Also it's
currently only public to the kernel crate until there's a reasonable
driver usage.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/barrier.c      | 18 ++++++++++
 rust/helpers/helpers.c      |  1 +
 rust/kernel/sync.rs         |  1 +
 rust/kernel/sync/barrier.rs | 67 +++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/barrier.rs

diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
new file mode 100644
index 000000000000..cdf28ce8e511
--- /dev/null
+++ b/rust/helpers/barrier.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/barrier.h>
+
+void rust_helper_smp_mb(void)
+{
+	smp_mb();
+}
+
+void rust_helper_smp_wmb(void)
+{
+	smp_wmb();
+}
+
+void rust_helper_smp_rmb(void)
+{
+	smp_rmb();
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 83e89f6a68fb..8ddfc8f84e87 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,6 +9,7 @@
 
 #include "atomic.c"
 #include "auxiliary.c"
+#include "barrier.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index b620027e0641..c7c0e552bafe 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 
 mod arc;
 pub mod atomic;
+pub mod barrier;
 mod condvar;
 pub mod lock;
 mod locked_by;
diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
new file mode 100644
index 000000000000..36a5c70e6716
--- /dev/null
+++ b/rust/kernel/sync/barrier.rs
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory barriers.
+//!
+//! These primitives have the same semantics as their C counterparts: and the precise definitions of
+//! semantics can be found at [`LKMM`].
+//!
+//! [`LKMM`]: srctree/tools/memory-mode/
+
+/// A compiler barrier.
+///
+/// An explicic compiler barrier function that prevents the compiler from moving the memory
+/// accesses either side of it to the other side.
+pub(crate) fn barrier() {
+    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
+    // it suffices as a compiler barrier.
+    //
+    // SAFETY: An empty asm block should be safe.
+    unsafe {
+        core::arch::asm!("");
+    }
+}
+
+/// A full memory barrier.
+///
+/// A barrier function that prevents both the compiler and the CPU from moving the memory accesses
+/// either side of it to the other side.
+pub fn smp_mb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_mb()` is safe to call.
+        unsafe {
+            bindings::smp_mb();
+        }
+    } else {
+        barrier();
+    }
+}
+
+/// A write-write memory barrier.
+///
+/// A barrier function that prevents both the compiler and the CPU from moving the memory write
+/// accesses either side of it to the other side.
+pub fn smp_wmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_wmb()` is safe to call.
+        unsafe {
+            bindings::smp_wmb();
+        }
+    } else {
+        barrier();
+    }
+}
+
+/// A read-read memory barrier.
+///
+/// A barrier function that prevents both the compiler and the CPU from moving the memory read
+/// accesses either side of it to the other side.
+pub fn smp_rmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_rmb()` is safe to call.
+        unsafe {
+            bindings::smp_rmb();
+        }
+    } else {
+        barrier();
+    }
+}
-- 
2.39.5 (Apple Git-154)


