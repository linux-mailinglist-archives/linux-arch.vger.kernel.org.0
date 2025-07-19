Return-Path: <linux-arch+bounces-12870-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D63B0ADA7
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 05:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580EE1C257FB
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDEB22FE0D;
	Sat, 19 Jul 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeQjW80m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560122A4F6;
	Sat, 19 Jul 2025 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894529; cv=none; b=W45KeqlnxAi5+Or8CQmwehp8l5YTRX6GRw0Sy2Byty+NafdM09PGAgWI+tNSwmYONhyR61O7VGLF7xstWfvNc79PT9xSBZogpWtSiKe1rNFnXmrjKfawFMD0Mc+bMryrzK70ZwMIubmbIBnxjKMpuoKRCTzs1zuqmrnayC39Hag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894529; c=relaxed/simple;
	bh=WCT6z5PFKds5elqtScAZ0FqkB10N0S9kF8SYI2tCpwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOIOl55kppVwCy8bCk7Z85Xq8QvJnnlsiSunbhUYQ6CCNA25cNKymvqhRAR/zQP6fj2wYLAzCuzG4+Xa9KRTYSzWhp0BFA5gzQGrT4fV9BbmCut5/bxkM8nADN72Ib20PTqkilSl0vft8QT/qJ6gi5/GQhYl+u0CJP/EDtxvzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeQjW80m; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab5aec969eso50398821cf.3;
        Fri, 18 Jul 2025 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894525; x=1753499325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xbxFvcQp2SKKo4g3N8pGlZT4YowYhGke/9HCeglF0aQ=;
        b=VeQjW80mpQwLyDWLA4fFRZACQvYnsZ1Y/mJ0m4VAIB4QEi04jbnRV2D6+8vBdHjjyB
         4jFdqb9ClSlO6yjayaDaiQkPV+wi+TTROzkb3gIRV/Ktc2XGPRLFn53gTaT189n5JZWi
         0PYt1wPbyU2r1Cht+3i4+isztj/fze2ExP9EKoCNm7/TQra4ZYzl6cwY9MpBqkKZ1uwm
         ofsfrOP548MChhz2Srds/2uWMhaj8PTEfMI2llDL0mZ7Win4ACb9ji7DtYvjMeMrThIv
         Nycy2mbAh449kB9rQS36Zb/DzgXDv9haLmgHl+jNf/YMeIWya+3z0tskvcPbTsTEijYF
         TVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894525; x=1753499325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbxFvcQp2SKKo4g3N8pGlZT4YowYhGke/9HCeglF0aQ=;
        b=CVMRQhb2EuS0EzirnuOGl8Yybt1mIll2+bTdXpaeUM59yNQknJ+wE1yu0U9u5RfC66
         PiYqYYeZ9boFWwlbGnx25ePtOdW1pg6W0MucXRrx2qPJZCpCwnwYwoyM1Obh6t4pZEg6
         XGK6C6mz/w2hbZaWH3PMGRQ+CLgs1ADwjf9jhfF3ArxrUZFSecnjHOmPJw/mXNV8tygK
         g0kIGn9PjwQ8wwt/WP87FUsIpSa4jrJU8V7xVFqc7ANjDDVM+Ew4x4jIZpB/EEWeY62Z
         1lo1SqWPPsbBaNjFwhmub88SFrSKriCeqt0zo7LRbLNlWe+NoHP8HwtixBIsO3n0cb5Y
         76dg==
X-Forwarded-Encrypted: i=1; AJvYcCVioDInE/wajm5vm+f3aGmu7XrR7ouXX5uOgpkvSGD9Sfzw9whz3Yb2A+K4XIM2RdHfSZg010CZVtkk@vger.kernel.org, AJvYcCWjl6Q+oByopVLS5bOCDpmQQNIqpdKoBSoLULvCx1X0Tid2WNY/mUurYrMqFjD3HLdatxXpN4THvDiXeXubs7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wVpyL5YOepeSa+qEuEaSCgvXQVo2XyGvcc95MZLZr7rKdiPK
	P8odeYbKe06Qy37644HNiZ8l1C9/gmxU7XFm/NKXwL4B7MosLdUAOBBA
X-Gm-Gg: ASbGncsW3ZB4MelWfzYkLrSGxIQSxkIoCQom1rF4Mk7+vzl2eoew4vlzRJoG89khRvQ
	71dGeWtcDpOwQkbrN6gKf8N4NxX/+xD0LWN9ysW3OCJAWeHoKU464rK/ggwTj9+VNU7tvqvLl/J
	2ykkloO4a2ejJyqHQLJkPOdOAOKwpBXxTOH4Acju8LANLStNPbvdPGBlb00ThLzCinHrCQQV0Bq
	sSeUFrQFV5V9fPeO3uxeqSYw6ezz8b17t++kAm22P0Ps4c1yGzzeND+vHpFksYME4MeA+7hGmcd
	1b794msToisVUOQl0HCrv3KbaQG0kWTMr+QAqTjvPsklCPCK0pW701+HFzCUt/dvULD2osx10NQ
	b31WyjHlnxVeu7ZYHHg8ylw3z48fr+V4d9IObjHavNz6mehMoD1gnIxCzbk5OXznULY9ukjpb6K
	hLPD0GN0Zv1Uaw/poY17euN3XVQdW3OL49UA==
X-Google-Smtp-Source: AGHT+IGvIMhjAo8O2Xy1EXQ+szSYQ0zQRyQvTPo729F9LOE3fLEo20etcZscd7pMYfa3qVnCljRHGA==
X-Received: by 2002:a05:622a:260a:b0:4ab:7e22:8553 with SMTP id d75a77b69052e-4abb2ca84f4mr72883261cf.12.1752894525404;
        Fri, 18 Jul 2025 20:08:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc2fdsm14615996d6.23.2025.07.18.20.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:08:44 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4B4A0F40066;
	Fri, 18 Jul 2025 23:08:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Jul 2025 23:08:44 -0400
X-ME-Sender: <xms:PAx7aKnVdgbtIVsnBc_6AEWqRg8-xIgJnuKRrPI-0gfoDBvvS5BFGA>
    <xme:PAx7aDU4LFRlSFbdcnuJDoKyT92YuQnZUmWUYhmkLiQ8sObDJcdcCXJweBZfCNCEA
    35lr9UGC9iJBRuKUA>
X-ME-Received: <xmr:PAx7aNPrPpyjad1BbY0NbwScDFr3x5_uxWfa-Yivg9FB7f8IV1KwSGXmiA>
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
X-ME-Proxy: <xmx:PAx7aOGkHxN3pTrVrM7IyiJuObQKcl0h9jfFzjcRT7DrVxmFfP8fEQ>
    <xmx:PAx7aG2x_med2JBhHVJ3uzCGIlis1z2Yx02hUiQR8HvhGJ72n0EdOw>
    <xmx:PAx7aOOP-bou4dJjNjKenIjeUNTt-eLFBc5j9AUJBHwSyivCrsNCmw>
    <xmx:PAx7aGI_faKFehD1xTFBteRUKRKXgqtZm6rEyEmZCjmfYNH_76T8pg>
    <xmx:PAx7aPbpSx6b6orp5axcccZQTVLc2vbpwEoud3BZ6nEeZbq3a2SsjOeB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:08:43 -0400 (EDT)
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
Subject: [PATCH v8 9/9] rust: sync: Add memory barriers
Date: Fri, 18 Jul 2025 20:08:27 -0700
Message-Id: <20250719030827.61357-10-boqun.feng@gmail.com>
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
 rust/helpers/barrier.c      | 18 +++++++++++
 rust/helpers/helpers.c      |  1 +
 rust/kernel/sync.rs         |  1 +
 rust/kernel/sync/barrier.rs | 61 +++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
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
index 000000000000..8f2d435fcd94
--- /dev/null
+++ b/rust/kernel/sync/barrier.rs
@@ -0,0 +1,61 @@
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
+#[inline(always)]
+pub(crate) fn barrier() {
+    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
+    // it suffices as a compiler barrier.
+    //
+    // SAFETY: An empty asm block.
+    unsafe { core::arch::asm!("") };
+}
+
+/// A full memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
+#[inline(always)]
+pub fn smp_mb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_mb()` is safe to call.
+        unsafe { bindings::smp_mb() };
+    } else {
+        barrier();
+    }
+}
+
+/// A write-write memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory write accesses across the
+/// barrier.
+#[inline(always)]
+pub fn smp_wmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_wmb()` is safe to call.
+        unsafe { bindings::smp_wmb() };
+    } else {
+        barrier();
+    }
+}
+
+/// A read-read memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory read accesses across the
+/// barrier.
+#[inline(always)]
+pub fn smp_rmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_rmb()` is safe to call.
+        unsafe { bindings::smp_rmb() };
+    } else {
+        barrier();
+    }
+}
-- 
2.39.5 (Apple Git-154)


