Return-Path: <linux-arch+bounces-12306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 949EBAD29A1
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51591161B23
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49AA22D4D6;
	Mon,  9 Jun 2025 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSeWAeB3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4022B8D2;
	Mon,  9 Jun 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509209; cv=none; b=VsUCeftIEW3oJ7gv9V2VOnu/IJVtvBuY6VuWwc/zceepJdPoIGl0bFeqCdB8u2wS3cPTI2Kl9vJWC7syMrVaTrJimolWBfwsOSZvh11kB6YD6klnshpkM8SUrHrBkRfv+SuXTxbXBdyC77Fq016tRZ3mSMVWudc2nXkoB4IB23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509209; c=relaxed/simple;
	bh=Anqrl5cWjcAsA5b2G9jSaTOPpHxzWAGMmgi9KYl1kyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luZD7iGML5UvGQFjW7HUlz2SCKt209+pw0DgapUbtXE7IqZEwk9YwxPn7xz+Npkmpjwi6P0n1ZvIjhnJE+cMzr/LhPQjXR5oonkv3pPGPSQbJQD1tdX0fRbr05k2kkR9JTpxgYmfPpoWRT6rLwfOoYXnUo4bAo1R1FWZUvbXsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSeWAeB3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8a70fe146so92811376d6.0;
        Mon, 09 Jun 2025 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509206; x=1750114006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aVh/Q3YvKlU1Rq5I19BJ7b1z8f+dcy4cBENHfBypeho=;
        b=FSeWAeB36kHbQ5kUiAQC6TsgMU6FFkrreMltHhtS3fLBPyLxEvsUJKxVf/Iq+2jb8g
         l0Y5osKE4SdAAvVVr5aMr7JmMzk11C1pBwarLbHawEcS8YnYJ8DEM/C0ZPMSzzvF7aYz
         +F4Eu4g5cqo/CpS3Yb24uPWqiGZCG6L1ddBTG0nmxV8Lz+qsBrKV17W4webKPtesHpry
         SVh/Z+ppV/zBTI/0KWFohHqoIkY5/SoQpz1yM9sRL/1t8XGhWp1p7SHL6e5HDy1X+Jji
         7CxYO4GZOT/aHiM7GDM7yo9bCqnIe7p1FqcKJQRRd4mHjFFEs8stxoQAScdG4m0MzmWU
         78zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509206; x=1750114006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVh/Q3YvKlU1Rq5I19BJ7b1z8f+dcy4cBENHfBypeho=;
        b=nKpvU1yRDonosAzTSqeElhFmGvw81AilQ+RkuLb1/2cYeGCV8cFn7k1IRXtn8OzCEB
         rwfSjkpgdqb/KZ+aVlcIJDLTmP2trma7eC3PeE+LP7oqZhxykFuVNnKSotbL0peJruMR
         l6EZezf++g+Hz7uIGKKGYV4x8B0Yz7T6+fl7fF7m76WeOp1rdyezoxy5D+mVB6zatHY/
         ie+ciKs7i1KTlBLdmO1kBmoKNtZ67CEMBBH+J0Skz2PNVQv/fGnjf9dfJ1YqIHJCDglR
         m2eOUKt0p7IEqSRiqKEk4+XFho2O96FirPGHWf910uXiC1O4DrkSP70gH4TrHgEmRhdU
         SNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJNCaDpFs1nAoh1d4np8Hk3iaOGLzeY9KKgRqF2CFaOtEXB36ayvPseuMnn1f8rY2NnlfwJT3Bn0wl@vger.kernel.org, AJvYcCWL6RH1Tzm95GrBLmiQVHA7psy52nDnKBklMFpNXZbZhsCwoY05gKSXN6HLwbEGymRK13AQfFQBroNThBSPvYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsNgtgbsqSu89fS3JYhKAtRh3CXKUKKBUCdVLQLxYSe4qfLHN
	4Py8fB2dplKnPvDLrN2gQTL48zuo/WXLq6pUjLctDI0ZwbYhGMVQeU4A
X-Gm-Gg: ASbGncuRPnM8goSMC15M4nhotgdK8dxEWXAzyGO1bo274Jl1baP2w3vaTsLzAqp9pTs
	xKNpuC80YWAE+0/2jAilor4nJ8dK7sFysj2Yv2aSu6AVMT7yajpOgG8gJR16QK/0HIb7Ha9KwIB
	6hBAJGUxrMP7KLq7GOy9cf8apCmXl5XNCIOxkbNXFEA1sw6D2XmWlYdML42Ke8tNKqC6xL4uWl3
	7LCHJc4Ct8QXWcQkIoeOhV9gm7dvPisnCnL2klhuq93310zBs/p2sUIplHV+YlqbGEGc97EYOjC
	lLavmENw/goh1NW++NNHqNq0gadjwGztrwfGvnTx9r57yw+AZJ0ANcmdLk3PtcynLGMy5Aycaev
	SgyWXWxXYmDOJufIv8a7T3UwPBc1H9lFTSHUaSWduP/p6dspkc2Wf
X-Google-Smtp-Source: AGHT+IFumn8OwjYXPgXZ16qqTX9xz1gY58UxpowoDVxCsQHRJ60EJ7bd/NwPv4mxtLSYcvshs3G6lQ==
X-Received: by 2002:a05:6214:268f:b0:6fa:c46c:6f9e with SMTP id 6a1803df08f44-6fb08fd9af0mr224426906d6.5.1749509206360;
        Mon, 09 Jun 2025 15:46:46 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab8479sm57902056d6.20.2025.06.09.15.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:45 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 657911200043;
	Mon,  9 Jun 2025 18:46:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 09 Jun 2025 18:46:45 -0400
X-ME-Sender: <xms:VWRHaGfeuqfaTsfEhV_LpIrhNyhzWKIiN45quFjZGSHxgsoEeOokVA>
    <xme:VWRHaANYS-9EPbydHD-sjzoKVt34TxIx4xdw3zOl4XRap0KOk_5WipJtbwYlkDWYH
    PIlE5V6JBHphOOr-w>
X-ME-Received: <xmr:VWRHaHiDS0jJsZHUtb43CKAzQVGBTatYnWPpWIa-Rzo0us8VKnuSJGYk2OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelleduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:VWRHaD82yCfh5OywHAYF_VLdNfBB6XPS_yuSEXXKrign0aaeMeYFIA>
    <xmx:VWRHaCt3U7HVb8WCTNR2JVSZ6u-hf5HicdNfWEzX2o84sGmcxpFGKQ>
    <xmx:VWRHaKH7JCT23_b6qRlIcAnwlIu9UaEazUyWv6Ujxa6ldBf8VF2IzQ>
    <xmx:VWRHaBNb26YqM8H4lX32N5KlrCzPiH_P0sfa4azgTtdYAGvFLEZ3SA>
    <xmx:VWRHaPOlbZcKXJKD4ln61UjpxP5bWNkTnJjEIqs6iMkaUXzysTAYSpwm>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:44 -0400 (EDT)
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
Subject: [PATCH v4 10/10] rust: sync: Add memory barriers
Date: Mon,  9 Jun 2025 15:46:15 -0700
Message-Id: <20250609224615.27061-11-boqun.feng@gmail.com>
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
index 0e7e7b388062..928eca7fbbb4 100644
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


