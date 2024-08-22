Return-Path: <linux-arch+bounces-6521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C5195B490
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 14:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E70F1C230E7
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DAF1C9DE6;
	Thu, 22 Aug 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwtKg3Jy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2E1C9448
	for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328296; cv=none; b=PHHV4O3BmdUDKz/bcrOElOb2DK72WGjdePIkW+/HH5ol8CIwLWOOvCEo7u/uzP/ymj2eFWvOTndjkLBpHa7nwvJzTLHocQYMNDUU+3riABvsRZdmvAy/7TxHeq4kkhm08582s+dst7q07HPeGTJQGwvfPiGgwOLg1KgH9Ldsie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328296; c=relaxed/simple;
	bh=x4Fj8n509ULmZ45N1WACwPWEQuAc2oLxAGwmKjHodr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZktFRgw05eIl5QlkXoatTz05daoNmsmcXjaf5xxBt4hH3nzFwPEOGI8iukuZiUglege8sQugN335/U8gQJ0rujc+Wyzdd1xkwYw//d3HIgt/MswCYIkXGI7w7qOL9fkO0/B0xR6cBXrtM3tXml2970TvtSqu4wYzF1zpHqe+kcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwtKg3Jy; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-371881b6de3so339117f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 05:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724328292; x=1724933092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m06R8rBHhIV+fNfH7++C5Q7rVR6HteIR9+x3IVgvVo0=;
        b=BwtKg3Jy4A7j/nmVN65Il9mrfbmhi/sOSda2DQcHvi05s77inySGxqHn6BhV8TAj+4
         Vy2xMx+nxZ5QkH6QWl4ZvEqVmTPcRgLSBBFuqdMOiEEyKgsH8vrHbIdzeK07NAu2etxQ
         S/Bel1RsNjOQzmAb2DiEJ0KkOkLKzDCQdRZVlYUvBJephgQYr6eMkr9Q9/iAIvFRQNjv
         /QOQlzryBQRZKKDU4x1qZhc3AaolqV/030CgaD8x+rQL6MByat7mhXmR5t1LflM1RvUd
         dSLEett6IGDnf0spQFwSmwtjyLcacz8vylcwJlQWD9Gj1YfK+fZCMjxHkt9lUpnhWOcX
         s31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328292; x=1724933092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m06R8rBHhIV+fNfH7++C5Q7rVR6HteIR9+x3IVgvVo0=;
        b=hP24emuJ2HBmyH4kGxxYgqhQcs66ADzwgHrw1Xe3g9pRz9OLI6IpD5E4xcHxsQGaB8
         191zO0XIZkYByYIicIY8mi3jZ4WRUR0XHFitvhSoUMD7mZ48ed7w15RBl+Js3lgJWxUl
         s6LrbGkau4NAr/YIzk/vtLFL1caOjI/se3HxgzpyLfyrQOIHOf2VB5ja8YFqgN78/P6H
         n4/AJirqCd7szPDDyT97bsJuH1bXN4pmOv0mmNWem0Ni2BuHWkhtC4Yyk7850TQVw8Cu
         pVyw7W0QLcTTVG1QrmynZ3/nxmRJkcM2f8WThRVc9zkCvqNsOp2jMTtsYa8ptBkm3xx4
         HVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOWe2LumKEeOSLMqasRthVHa5td2Acn3hThghMpqnkI35Y06el25UrhYbVYPApqYB6N1AA6l92VrFa@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7xDD4+/Hh8n+TtudmClcjUg8trThcDY8PxI/TmyhzZSlUOjJ
	U6qB2HvM2K+8Uu+PDctf9kMLZg0H88IKfGPIuSBoTqoFQZ6G7ErGJH7nz4v1LH8gsTutyrTlGIw
	GueKghful67f8mw==
X-Google-Smtp-Source: AGHT+IERBhVv08A2uZv+MpnM9lKKuFpvF/ldKWmNQbSwx22l+/nHv3lZyxTumbSPIvwOOIsyXNIWmCzz19pCed0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6000:2ad:b0:371:9373:5078 with SMTP
 id ffacd0b85a97d-372fd59721cmr11543f8f.3.1724328292363; Thu, 22 Aug 2024
 05:04:52 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:04:13 +0000
In-Reply-To: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3678; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=x4Fj8n509ULmZ45N1WACwPWEQuAc2oLxAGwmKjHodr0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmxylcN8mcEXadzOJVoentM5FyVm0c7KXiYJoT5
 nryZ6UFTe2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZscpXAAKCRAEWL7uWMY5
 Rh5pEACltjdooXrOi5jfHOH3q4t2NrSAWmz0Wzo7scorn20GnCAwxRr3y/CF07ko6cGGlugqo7w
 fw59+gzaz0SDqS70pEVZt5qbsa21Mbm1GrJKocf2mXPLC9onKsU9xOyLlPXlxi+o89Ln3Lo729R
 IKu+oYEF5yDZC0nRxFTEZsX0YJ/bNKZwEMFsYem9WSrjI4ifDw7HDPifTLoRh1HRJmBRciDe9+f
 V7Tm/sST0aeMNPsFLh/eCQsQvL4Bf916kOL0jkbZGKSoSS4gJPTDf2569fmJ0PU/Z7/62qsKJaw
 paEkLJnj/MQLxgslDQ8lazmAMMDoQYH0CqrkBlIzksOwB0ftEuQI3hrV7ELD/5AnUCrup2fWscm
 jtounuZ8L6EpPLOCSAdPObnCCNgNTpIO3CcN6wt+GW8Flc7OsncgAq2qa8JDNUesF4jHVm9v9u4
 hX2UZM5ou9VSVpxvlf2oOYTmZPnNyvrL9DZu9LjXnEwwg+qXpgQKvEvDY6ufRj+kC8SedA+UB3F
 ulk9WotpkJkTv4PxvDq1h9XI4djWh4uXsdrRizqa+QZAMv/1vjm8bMkaFkElesH5gA5akc2m1NP
 sNi8Jr2dh7/sqpvIvYrOucLMAcK/bzi7/M17+DSgo1+PyKsqSqlwBJiDqkeh3uvgJJRRh7MaE3U UHQDUWgEeb5N4nQ==
X-Mailer: b4 0.13.0
Message-ID: <20240822-tracepoint-v8-1-f0c5899e6fd3@google.com>
Subject: [PATCH v8 1/5] rust: add generic static_key_false
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add just enough support for static key so that we can use it from
tracepoints. Tracepoints rely on `static_key_false` even though it is
deprecated, so we add the same functionality to Rust.

This patch only provides a generic implementation without code patching
(matching the one used when CONFIG_JUMP_LABEL is disabled). Later
patches add support for inline asm implementations that use runtime
patching.

When CONFIG_JUMP_LABEL is unset, `static_key_count` is a static inline
function, so a Rust helper is defined for `static_key_count` in this
case. If Rust is compiled with LTO, this call should get inlined. The
helper can be eliminated once we have the necessary inline asm to make
atomic operations from Rust.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  |  9 +++++++++
 rust/kernel/jump_label.rs       | 29 +++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 4 files changed, 40 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b940a5777330..8fd092e1b809 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -14,6 +14,7 @@
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
+#include <linux/jump_label.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 92d3c03ae1bd..5a9bf5209cd8 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/errname.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
+#include <linux/jump_label.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -133,6 +134,14 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
 }
 EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
 
+#ifndef CONFIG_JUMP_LABEL
+int rust_helper_static_key_count(struct static_key *key)
+{
+	return static_key_count(key);
+}
+EXPORT_SYMBOL_GPL(rust_helper_static_key_count);
+#endif
+
 __force void *rust_helper_ERR_PTR(long err)
 {
 	return ERR_PTR(err);
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
new file mode 100644
index 000000000000..011e1fc1d19a
--- /dev/null
+++ b/rust/kernel/jump_label.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for static keys.
+//!
+//! C header: [`include/linux/jump_label.h`](srctree/include/linux/jump_label.h).
+
+/// Branch based on a static key.
+///
+/// Takes three arguments:
+///
+/// * `key` - the path to the static variable containing the `static_key`.
+/// * `keytyp` - the type of `key`.
+/// * `field` - the name of the field of `key` that contains the `static_key`.
+///
+/// # Safety
+///
+/// The macro must be used with a real static key defined by C.
+#[macro_export]
+macro_rules! static_key_false {
+    ($key:path, $keytyp:ty, $field:ident) => {{
+        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
+        let _key: *const $crate::bindings::static_key = ::core::ptr::addr_of!((*_key).$field);
+
+        $crate::bindings::static_key_count(_key.cast_mut()) > 0
+    }};
+}
+pub use static_key_false;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a82..91af9f75d121 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub mod firmware;
 pub mod init;
 pub mod ioctl;
+pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 #[cfg(CONFIG_NET)]

-- 
2.46.0.184.g6999bdac58-goog


