Return-Path: <linux-arch+bounces-12621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A416AFF948
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB2F7BCF4B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490522D29A9;
	Thu, 10 Jul 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4SeyLt+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725A2BE7DA;
	Thu, 10 Jul 2025 06:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127273; cv=none; b=H5GGN8cbvHsZlrs2e5uX5U4m4prNGXcMc7p/u2zIoPbrLF8CyUsrgzax815wSQ0gyFH27j69NcHkCtu3m/pUQWMuIy17hgwG/RmTPG/vrETL4S6IOpJUeBchPcRgYIgcDW3C1VvbKOOtzhRs/JSmLpK7JQK3XWZbWL4xVDZWexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127273; c=relaxed/simple;
	bh=ozeoBnOqwbQq17fV9bnwWSOJc5c/pE7wVstv10Q3mtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3MUmC9ky4bqtyIQrLGSrp8tmnrMSY5BeOQMhOTagJBhviPzAHcwVDUX/ny28VtvQd4mKIMUWl2SY9DtTp8adP1ucsBPyf7ECgy5azaV2zzntVtwxULjpACGFKtrdEGiAw5Qkm2bOAxC5yKcJUlAqWKOHVtN+kF7c0ibtd7A/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4SeyLt+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d5d0ea6c8dso47476785a.1;
        Wed, 09 Jul 2025 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127270; x=1752732070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gZcVZieU5Z+uvN44hThFdBaHpSKgklWNBMovXp1yeb4=;
        b=D4SeyLt+Nv4xKqADnWJc8ZCRZ0NcRpEfEErrVrcmEbqh0gUUuXdAY8jSgFShyIw4BJ
         FfD2L+JFwOcA/z5fQcRGL1JF2D21T2MgCBqncd+cXlapP1ZT1Poe51Lf4uDvdh0g67QR
         B4zONGpsZQm3Xs1PVLNi7fJfPDz5eB/mWKRS0Oo8EN85LCYbZ9UZ50ksG6AL9MG7h0Wq
         WEH1C7L3+SUJBj2ks7xbTF0vHFzFZvst6t+epS5Id5POL9GF3yKfmEOaPqrncofidbDR
         aguCS64kO0L40jTHwCTin2a+Rdwi8f9Cs0v4deNDPLtTUAXaPp8DjGC5zw8TGS+afAP/
         wDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127270; x=1752732070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZcVZieU5Z+uvN44hThFdBaHpSKgklWNBMovXp1yeb4=;
        b=Pe3p7mAFG0KmY/XMg/4DgSabLoMbtkWWUxR2tggW/KkhAl9I64Md0LXY+xvmvFmY9X
         +GkF0FQQ5VkWcSAQ3wVfcGIp3bLwt11bK4w8rLQ3jemmMa6qyfoM24jGWfg26x1LXZ4M
         U6xmJyeaOztZWM6PUu+2Rc7oVEdqIS9SGHKLZTRncZOFpykuaBFprM1x61+PUXh62naq
         EPZTFCATaCpNBAnUVuMtXND3IPRKYk93IyWkXoo1amK1eLCHVHZHSscDVBLjZJ9yuaUw
         TQMZ4bqHtH+8/8FysVAmoyQ97C0HBZZMIdDy1g5HzhtH1az459T0cldoMPQjGZi6Adgi
         wo6w==
X-Forwarded-Encrypted: i=1; AJvYcCUMGem6GtATJBgSfPCsUbXOiCpXOR7l98ts71PqcKh267kQjvebJseGKzM8ARPqjhhDOGF+I7vA/AMC@vger.kernel.org, AJvYcCXA+p5jG0wBZZ628S87lvElVQ5KZgRzjv7lv07bdf2Dmygy+F4wVPVwddC2f1AzhoT51YcUSsS34jWoqzmqIr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPqzG5VmTVUwCy023hFHAOgPxoGUmY1oaKio1isthsaDj3fF8
	y6572zf9jayIcvL0pF1D2H1YEPNo3P7VjP/7pdoyMi9QpSKsO8gyu+5o
X-Gm-Gg: ASbGncsEdEIi7drzExL8EGdJJ0waI57rgJ2OgDAp4Ld8M9IEKzcJbyOdkwtxdihjVe/
	HReysmwTG6OW4fP9RyDAsqedZNpHz6TNdZma4J+d3Ro0DJsSh6qvMwbVZh0JJvBvA4H9MSzw25h
	t+lw/liC0tzXmdkJKK8b7D3m1Pk+/tNZwgeq2XMDlSp94iG+OaomPzt9jlP7/tXM3+94UGfTI+c
	B+yxlP2ikd83ZhE8soXu2h81nxuqKEH7hqE9+G32O5ocZpweel51utjnwMg4EHYyvqfsZ1EfoFQ
	m2zqzmpyFhfAccEyHiy+Jw2rq98f7TtJyYqjD2uc4wZvf1WCMWjVuPzE4KSJCRUCYS8OLV6v0ts
	h53Vs7DOAlx9zoclMQfFRVQ0YSXb3n6ItZq1in87qZW+H4aflxh83YwpW9rEH7yE=
X-Google-Smtp-Source: AGHT+IGcYnLsbKloZsHICdUNilWsHX+3z30OZqCHiQbTiaU+c2oJUDnyuAP2Fw5NufpnpZLid0bQoQ==
X-Received: by 2002:a05:620a:8908:b0:7c5:65ab:5001 with SMTP id af79cd13be357-7dccc583ad0mr193807685a.39.1752127269531;
        Wed, 09 Jul 2025 23:01:09 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e45c5sm5242826d6.51.2025.07.09.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:01:09 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8EBE7F4006C;
	Thu, 10 Jul 2025 02:01:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 10 Jul 2025 02:01:08 -0400
X-ME-Sender: <xms:JFdvaGdgutNEpG4hISTf6ZxpVjDn-PH2BCghzzpmiR-v1T3Uer1pyA>
    <xme:JFdvaB31-g3Bj8mCC_Gg0PSwrXb8wJBJf2mQJNVZ47lLMEctLUxlapSMB7X3SjuLt
    -cx5LfSa3TyTZgVmQ>
X-ME-Received: <xmr:JFdvaGMVwCwV7AH_TGrUDbm7YE2hMKwwRKjMGL_UDE4LGWhQMNwdmHmNVA>
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
X-ME-Proxy: <xmx:JFdvaMdkO-ruv15iq9w7-N3iLVCnmOayG7lzMKWa2CWdLeF7G3NKzA>
    <xmx:JFdvaDXJ7BqHF8g8a_hCSqccca-4t7AQc7zhkiKYXVE9YrU8NRcqdA>
    <xmx:JFdvaExTJPbh7m5-wcTMxBJFfxn8Ohg2es8fyxlsAZbPusJvpTJ3NA>
    <xmx:JFdvaJigCyDKh8TIWzroSVPGxUlblRRnQyYQq-0SvV2EdL1iq_LC2g>
    <xmx:JFdvaPNDfzB6gEzNUtVmWRCZyqyjYBcXzZthILaWYGJ4k4BgMzULZr5F>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:01:07 -0400 (EDT)
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
Subject: [PATCH v6 8/9] rust: sync: Add memory barriers
Date: Wed,  9 Jul 2025 23:00:51 -0700
Message-Id: <20250710060052.11955-9-boqun.feng@gmail.com>
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

Memory barriers are building blocks for concurrent code, hence provide
a minimal set of them.

The compiler barrier, barrier(), is implemented in inline asm instead of
using core::sync::atomic::compiler_fence() because memory models are
different: kernel's atomics are implemented in inline asm therefore the
compiler barrier should be implemented in inline asm as well. Also it's
currently only public to the kernel crate until there's a reasonable
driver usage.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/barrier.c      | 18 ++++++++++
 rust/helpers/helpers.c      |  1 +
 rust/kernel/sync.rs         |  1 +
 rust/kernel/sync/barrier.rs | 65 +++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)
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
index 000000000000..df4015221503
--- /dev/null
+++ b/rust/kernel/sync/barrier.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory barriers.
+//!
+//! These primitives have the same semantics as their C counterparts: and the precise definitions
+//! of semantics can be found at [`LKMM`].
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+
+/// A compiler barrier.
+///
+/// A barrier that prevents compiler from reordering memory accesses across the barrier.
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
+/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
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
+/// A barrier that prevents compiler and CPU from reordering memory write accesses across the
+/// barrier.
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
+/// A barrier that prevents compiler and CPU from reordering memory read accesses across the
+/// barrier.
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


