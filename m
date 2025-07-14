Return-Path: <linux-arch+bounces-12730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953FB03601
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CB1161EE8
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF622F767;
	Mon, 14 Jul 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy1suMsq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A522DA08;
	Mon, 14 Jul 2025 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471443; cv=none; b=Ig6lzjTSjcrl53fczijhYNOHXu47M3KCD1DUe86Qg1GombQ7MX0RPqItNaJ0Ob5RSRsCjGU2dIuKtb4xmRzrXW/mjuj+pw1bpWySFVJFRrol8O62niPOfGb4CT/NsYUCWPi0KFHghk6SYMImItjo2r/J6s74cYtuF5zojxVRDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471443; c=relaxed/simple;
	bh=WCT6z5PFKds5elqtScAZ0FqkB10N0S9kF8SYI2tCpwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCkkYIl86+dUSK0n9OGA3NGqOzJHhVDfwc752aoBqlz4KuzUaj4xHxS52ZdgZiC/3L+BOw+FWwfpNH/iI/VdXWgbjxRRdR8Slcg2kBdOZMR0Frk84Cks31gFKpUp1gfP2/zSgaAMgADwlaR0ZZT3E8HibwjrU4m+5wuwygYjUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy1suMsq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fada2dd785so45938256d6.2;
        Sun, 13 Jul 2025 22:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471441; x=1753076241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xbxFvcQp2SKKo4g3N8pGlZT4YowYhGke/9HCeglF0aQ=;
        b=Sy1suMsqapyGepnuAbv2PRQl1w3+12vJabSR/0GVPUNCPGr9LTHrq0FXcpW9SrtM1H
         yh/hzDE8x6r+0WNbO+flprHC3rn+xpW22233Z17KYPQxxf8AV0Y5fw6AzhFmRoHx0wyy
         iInvxNDnuQrpoRReUc/QBnHoI9b/2HCuxKCO8hbEqdGkRNXLCs+pMCixi0RwVG17Ezkr
         eQ246qv+1U3Lg08XE8CRmaheN5TsR1CJZGp7QrsaXuprdvc9y5S53cWhC5iZhKCjq9Vu
         P2JQqoKires2gv1kKw32ZLZ/3KcJtKpoQ8iSqxyva0pEPycwawmX/PK152j6z+CG8vgi
         r6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471441; x=1753076241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbxFvcQp2SKKo4g3N8pGlZT4YowYhGke/9HCeglF0aQ=;
        b=k+xzhkWeIHLaMLYDKHeSfRGg76H2NQSXnQAU1yCyIvXN8Y0qAcZLAg9CNt5pINMc9G
         iFcSv49g4KhqVKchSCMZ57GBHk2mhMukp8r7dpO8HQFIgRhDL1LF9ylfgH+QApsYHOtI
         7hgmAgwQ3GEzvt7eMvXmvbZBJHPjq3VHh7zJ37kv19Imj6jb5vnSchH4PkfCfYONuiLO
         lS4Foy3twtmSmZf7IO3a0MMOAw09PCdRjTyXbOLPTXrcYgOW6N2ubHaFXWlSwltW1MHb
         XhuAqNDCVp20d6TTeZBQlN6MixaJf+BkktBs8BVmNivb044tajNxZWvCh1l5C3MYt6qG
         0tiw==
X-Forwarded-Encrypted: i=1; AJvYcCWOXRhuxwlVrmxAh1dQRHJ9ODYopnPfKMjMk9CBXhXX0d01b4eLdd3WqFWFR6O2DWqTniK1MsCp7aTlzdUo29o=@vger.kernel.org, AJvYcCWn9zH1HudZPaa0qDBewDPHXaNGXwHB8t+8ZbJUOKyCzEHhypwTJ8iZm92E3J7fF3q8GwEirAVSqSLx@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQR7/ksTnkWu9HQ/oCL5YRRfpq64fC344mdlgiO0aQMxrh/5V
	mlm0Zx6l/TqjojTXjAR0h/GTywSK0+tVXFlloXDamdlMFqnjlEM+5hH5
X-Gm-Gg: ASbGncsrfla9Ez0/Vnp7wpO9X/3QSmTbLk7Ko37K1huGNOapYYVozPQpnhtYQ1CPLoC
	mRMqj5ZQKHAsvYg0ufzHNRuHJOeX5mtwGfURjON96BPIs/0V/k+oU+w4wkNrYz8hCEFZKuId2YB
	2H/E6vi+w+5ZiPsEw7wqoR4YyQ3UgzoN7//mHCctNRQALv+16eDdI3/m3GlBkqsKkZOewPvQyhw
	629B6eK6oyZsPlH8Lk92WxIM/TrP3f7hHo2xZ82f95/n2x15iDJwuImDfiyyapP3GHiQoBOy3o0
	uXjbfFcwAR35uaN8Y/S2Wp07lrrwHMpEfUNF8aig27863aV20/hYj2K9ubZLCn5mQWa8BI0eABK
	GXg2YIDluQNFBe0bWzjjdmLWe2uUixHeWnu0Y/zS/Vd/vcloT7Ntzp7FUNgGkezJST89GANOHHh
	TqKpn5hHLKeLlO
X-Google-Smtp-Source: AGHT+IHVTAeaiCrtUcuB/dKAJJixW/vao1xVy21/YuOpjp76n21BwqPdOJotV90WaKdr9UDu6Zfe2Q==
X-Received: by 2002:a05:620a:2b8a:b0:7e1:5efc:704 with SMTP id af79cd13be357-7e15efc0b3bmr906203085a.24.1752471440771;
        Sun, 13 Jul 2025 22:37:20 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e26996873esm111990585a.64.2025.07.13.22.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:20 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id BEBCEF40066;
	Mon, 14 Jul 2025 01:37:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Jul 2025 01:37:19 -0400
X-ME-Sender: <xms:j5d0aIV8DPTRkLnFo6VFyJIHKGaveBiXl80LpzWT3439GkswlCq-uQ>
    <xme:j5d0aOPh24XvbrHGQmmIFoLFfnH8hqWiOllau5oy3hGaSVEs2P0Acr3LUTDgd-bpN
    9tf0t6Arl6bv6T3ZQ>
X-ME-Received: <xmr:j5d0aLHJxkb3Be4Gljq2HIpRf4xs7tLFG5zTxGBvSeSIvabu030P2TfwDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
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
X-ME-Proxy: <xmx:j5d0aP09_ODYZdaY2UfM3Wc9Qx51ZiI2ETPOekV-Fln-hwNepw-3lw>
    <xmx:j5d0aDPJ93_eN_U0vt4v9U98SEkxENY_DavPpwkHCoAY9lkbZ9oYuQ>
    <xmx:j5d0aHKG-R92hezUNW-SBB6-shrEjlOwXvlpH3qoQtkbt5YxFkeXbA>
    <xmx:j5d0aMaLzpaUDVt-qgY3xz8cCpNIiOcVx-TB-3jjtGuZhnsa76FNGw>
    <xmx:j5d0aIm6MJPiAgya4JrGBcjIkXhkvODXgnZ_3J7wCaWa_Idv13GBcEU2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:17 -0400 (EDT)
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
Subject: [PATCH v7 8/9] rust: sync: Add memory barriers
Date: Sun, 13 Jul 2025 22:36:55 -0700
Message-Id: <20250714053656.66712-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714053656.66712-1-boqun.feng@gmail.com>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
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


