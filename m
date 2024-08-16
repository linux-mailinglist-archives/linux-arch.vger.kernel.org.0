Return-Path: <linux-arch+bounces-6244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715E95476F
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 13:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57B7B21B17
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA31A0728;
	Fri, 16 Aug 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI7Xvd54"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BF19D09F
	for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806505; cv=none; b=awVXPo2BGRO+/vv45sGi5KH6NHIc0mcnf6JVBMLl1ccacor5vIneXnv6O7aMy4hCpEt3v6WxA8wQkS7dUxaFhMvNzY176/KFD821oQesIPxpcRlnthmIpk43Ar097EXFGQNMQfER8i/6p2qSEZCi56HvY3AGyEVwmoMbaoOpILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806505; c=relaxed/simple;
	bh=x4Fj8n509ULmZ45N1WACwPWEQuAc2oLxAGwmKjHodr0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VLy6N19qAM4wg+4GJ1gqN8AsBb+1vs1Y2r186DLuCumwvKl2cfWxqWfjvyGBOstVks+/EZc+Gw2oZo5lyxoCWBj1oBD7VQG4UkPqlKYAeLsZ5Sr7RUvofz8HycB/TxmwQYpFKAJ2bIMZ6uDOZTmZzBp0qD7RMzDWSMv66l6S3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vI7Xvd54; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4281d0d1c57so15067245e9.1
        for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723806501; x=1724411301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m06R8rBHhIV+fNfH7++C5Q7rVR6HteIR9+x3IVgvVo0=;
        b=vI7Xvd54IV4ZUu9D7brDwrCiF2YmRJqOXxDjqyC6HsxXFwOjGN+5sOQrwX841m7d2L
         mf4gPXPeadJ60kYgzkzCTAdb5vQwYq2EIhrmiPQCY/UH8I9GH2xbSTrSStmgOFgCs4hH
         jwfugJU0GDJpK4ZQ+FkIP52Etz5Pu1/uCYvPU/wZ2/2FAUamPJ7PALVGoOmNY2/5rsOf
         R8F1yoGpJkx4FZYprMgOJG+MwELLwfN9TUUxMgUXY7xR8sM9gFPzLLyF2MabSmNJN/hB
         yJ2qhG4LPPrlb417pByxGNRFh/g6rq8UF+c/RcpyS3eiU6/ZEpl7eFlnPhzPVhVz4zql
         g+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806501; x=1724411301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m06R8rBHhIV+fNfH7++C5Q7rVR6HteIR9+x3IVgvVo0=;
        b=fjup5fNxJ6vTki5g7gEUS+7nlCPbLgQc4yRf6loiOjJ6p8xpTjKve8Pahb3aVmwg7X
         3D88peEXp+eu9Y8RfJNWhO/V2kKYk7t1eg02m9ulnwSjr/HebJHffzCmWbR0qjKG8CID
         i4fdf9zig/YCtYYQ94WhkfaLL85lc1kiPrkhusAApIzJBpMax+85rCpv07m7vjyNVUq3
         F7KIc7JRlGdRrgPJYuLRXsADotTc/kz/eJ+LsKeeX4T1e7owdbnCfVbV/5/kConsHhQa
         pxu0s0cvIntc+OgbotF9dI7QOUv2fAXME32FOUunlVRfNKgcNnSRvaKnqXbQyladk4x5
         IzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5uXduqWifbPiEq6DwKWaRIxegSsfgtynDslfJJ+hHU6e0uRhe3O5GSQwMIBsGtOdAV/VBe2F0Cprk7vAn4QBFgRqSnrvjmVHxbQ==
X-Gm-Message-State: AOJu0Yz4SzlhXvcHn21t3VRoXGkpaRudbz90B84gY5dW2SFPRZfQJDKp
	EhjjSyRlMw2kGgzEAvetHevYgNFRoqB7j5xbmBxuafWcqzKTLf3H2fOIn8OFejL4U5dZBfYwfVh
	aZISxcIrrhWKAYQ==
X-Google-Smtp-Source: AGHT+IH+VAsKwfNCiHHe99AmivtojPl8jd65icHQdCeMvqDYGyRGiGAODBeHQJKgR08V8df12KeTAxMnbdJAq0U=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:4798:b0:429:c788:c218 with SMTP
 id 5b1f17b1804b1-429e23a6fdbmr962585e9.2.1723806500805; Fri, 16 Aug 2024
 04:08:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:07:38 +0000
In-Reply-To: <20240816-tracepoint-v7-0-d609b916b819@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816-tracepoint-v7-0-d609b916b819@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3678; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=x4Fj8n509ULmZ45N1WACwPWEQuAc2oLxAGwmKjHodr0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvzMdVneCXly8cWWe5Iu4uc6nbYralCN4y+TmV
 wOYf3kDVPyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZr8zHQAKCRAEWL7uWMY5
 Ri7iD/9j1byicYermmm/i5dPcFPGgulMHHWVSSxshMFGTPr69xesZ5H+/l90d3CEP5L9ih8x7ht
 QrRslTqFF8Yp9ivd8uuelOk1xaXEFPw8P5vRGIUU9b4I4WMxlcb9g7ckF8zrV1qdeFG1PZqDxsZ
 xf1pWqvqszr401XhR+fj7kNQVKbyFT0uPFGKXT3Sb9yrKuFQ5X/hMCfqLBrVhD29P8iiuEQoj62
 Okn2MG+8n0fmnixuWv0j/lp/bG/b3vBJNckorv3W41tf3YW4Sj0kLi2Idk95pBqhlIYisy+dRKb
 MOc2IfnPfQElbeKsEDjMpHy0oQY7LRmRHYv9dX9RsRfQsymv6hB/b9lfSF9M5MTn4jLFWTOQRBQ
 /k+2/1Nqk8i+cA5WE5loHeBrozeYvSmBfJATXTrTjh6yj/dVhAs4nZeqcn6hfSOux836gJFmke6
 Ahf59c/QmBydmV3fW9FO9HENgUanrfI0q3OCvmvwtDyHjA+ZZHCcpN7ZZGOkkPLIty1bxlL2P3W
 8xKYvJqNhw8XQdYqohiOX5Y62t/TPJ+aev1v9H3X1cbjvpKylN1KIjeIwoeRJZEdKSGV2ODqCWs
 RY8tY+QqDcfw9StVvP3jwp5XFJ2EYVh48XZ+qL8U8sgg7kYI0soQk/bI+WslYVmSP2/0f7BRhDZ NICGotH/M88i+uA==
X-Mailer: b4 0.13.0
Message-ID: <20240816-tracepoint-v7-1-d609b916b819@google.com>
Subject: [PATCH v7 1/5] rust: add generic static_key_false
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


