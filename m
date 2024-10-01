Return-Path: <linux-arch+bounces-7514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A0198BDA8
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8C61C236B2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144181C4635;
	Tue,  1 Oct 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw/PKBQq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962E4A21
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789437; cv=none; b=teEx3NId68do5IgTY5h5/in5fPFJ5ejEkB+q5NXC5AGYcl38FBvsPWEp8i2aRdPreENUK50yi1pTEYlmu1hcRhqlhdEd2cFxLEuY7etzGJExa1p3LUIlVFIx6d111FdBQsYE46EsRBGrQBT2QCl4iqKAgM0tdaJETKvHOz+De0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789437; c=relaxed/simple;
	bh=AvPTYbgUDavV8mVnKHm16jwbLov+IgYYrRjsKEF8/Ko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OirdwxJJNJOpeoFDjtqLAct5p7uTGEKnPnVtqKl6QhAVr67OURhkZb7wqmc3Yjh9XoZqx57/fbU9W1HcEIoh2KlnpxwgfCG+ue2rhkxB8dfDwrFsLZ4Bo5kaVyCgRn+GkUls3ph7VMz8kqufE0XFpaDc2sdPfrr9BP04Ay0qI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rw/PKBQq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37cd6655ef0so1468790f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789432; x=1728394232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NcH/txgm4SoZvRl8jrqK6AfP/r/sFmOakhN5fEYqYs=;
        b=Rw/PKBQqi72GbqSGoeqoXtUZaOsVnb7VZt2wFCjDJpQPn1f/Yjjptqd2FpGNmHt51b
         zukzhB6RH0hKHgixjjctCCPW9IKuJSCg4zkm4knyfzLvcBHpA97tLE7jxlNa6Ysjnl59
         P+Y/7TkFWprEyemaCEYeYLtH6XJu8/cvqHcGItLGolrRC1SH3IXYq07ApSVBxY2aZOJA
         LAELeBu+yqDxnX/jeto+303SdMIurhcZ4QavA5ZPqwiBtsnLKKVkd6Lpwjj/An1DOaIo
         SvyxB+x1XGzJSrLtBZLiBO7LwQeziqndiSG/+TBPf43OVJynWDBwoekBEadkB0jhH/ZJ
         Mq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789432; x=1728394232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NcH/txgm4SoZvRl8jrqK6AfP/r/sFmOakhN5fEYqYs=;
        b=jhWYxpUgFgKdfmk9gf7MEUQ8R4jj+yHSHsJgZo2g7MRH2kDErnCIE6xVFPVGVv0xuw
         sA5ejcKQhmM57EMe3F3JZ6xsnh9J9nmJz2wFWCnTuE9MvJEkv/b/HnHJqS1Qj/A2tSRF
         7H7NZHuffbuti21kwmYIyOtZNsNcg88kg07GGj6ia9IB5nNFGzB/CUIbWkfBADYTcK27
         Oksr917tAeC/svTfc9n5S/8Ul5Y5JCqkpqWuBLWa9p1TerKxrqAteVnNBg0NOY0g6BkY
         27qwOx97jzLmTQxNrO8x+GoHpakM7Aym2CEKR0BcKF5jUEB0leG7Gpi8DsoJ/+ijaTEa
         eAJA==
X-Forwarded-Encrypted: i=1; AJvYcCXBnCC61UzA3z+hatZPrUD+PF4GPk9L/tJcieiYMbXStN1X8N2l2ohj2CzgFOjlcgFneW69E/fIvN5L@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxl7Q7ELck3b0Ye/bmgBZocgeV8ma4BawYRIwoJazSUVWatukY
	pONjeYE0hMwb0ewSZ+xQBCeBtZaVKMgaWRu36H6mAdsJ3JMh6S/4wk95NiSaAxTmofzoBL+XXah
	W/nQsxBOZAjDpSw==
X-Google-Smtp-Source: AGHT+IHEHR04HLA0/xTKtqy65DSu4rhuHv96KunVk64O/ZW/4J8kBgg9MneRCFsC6zfzdrsaOIeGwwArA+9MwtA=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6000:e48:b0:37c:d2ed:c51a with SMTP
 id ffacd0b85a97d-37cd5a9ee86mr8842f8f.5.1727789432081; Tue, 01 Oct 2024
 06:30:32 -0700 (PDT)
Date: Tue, 01 Oct 2024 13:29:58 +0000
In-Reply-To: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3861; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=AvPTYbgUDavV8mVnKHm16jwbLov+IgYYrRjsKEF8/Ko=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+/lwNcJAULBaBeL+Dr8YX6BXARPW8IdrfPDru
 oHV4BLfmr6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvv5cAAKCRAEWL7uWMY5
 RrXoD/46qHxmQQefR6J6dxs+nMxE/PeCwUzN+iBASNF6GRFzW+qtSy6GbpoUkBk6lPtMPXIZ21+
 7vYAkFVr51pxI/ktD9Q/9G8vTic38vSwXmAw135cEzOw4quHQWf1CcMO8iaNvtmYwwX23i4p90K
 7b++yxkkUjapjpbwOMqLk33VOnYXWilNEXsK2owifqR8LngjI5Ybp5rmPx/JbOJaPnog5WGamGz
 8vcavGHdPBhs6IxJdmWGacvrmJWdrBe5a5mHtnKnPoAcwtrkGjh1K1xeimz2ARL5bdIUaNTFQeU
 g33eq/B1bfg9vw3Tn/JLEheM10xngvB1fCfiAFRbRISYHdwywqjZSpz4/RrFVCfMWajI+c0aQ2X
 Nv1IdKug4kbpyOdrRJs4ZX4KQTVfK3c/ERGMvUmb1BLYpmyyWV+pgrLZ3g5oxw8tEqL41msxdRn
 rvgFmIp86sYIGFicKbcfzS7pD7DlCREeL00e4mGdetCl2lTUHy31MDOkBY13fi5Yx+G9W9IHdBW
 OsRW4Tt7wHJlIO8mhtb/JxNTSXdLw5OlZSjC4Vvil4u101yVHeMAtrjGcr99GphInredXfMWI6V
 WCfcFx7E6cIEpP3GMqvqRWlpH4etvET/oIetiWYjQgwYiKCZl6i0zVMvIZnp49cR9RiKj+ft9Vq XJjgUh3pWF492BQ==
X-Mailer: b4 0.13.0
Message-ID: <20241001-tracepoint-v9-1-1ad3b7d78acb@google.com>
Subject: [PATCH v9 1/5] rust: add generic static_key_false
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>
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

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  1 +
 rust/helpers/jump_label.c       | 15 +++++++++++++++
 rust/kernel/jump_label.rs       | 29 +++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 47 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..e0846e7e93e6 100644
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
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..17e1b60d178f 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "err.c"
+#include "jump_label.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/helpers/jump_label.c b/rust/helpers/jump_label.c
new file mode 100644
index 000000000000..0e9ed15903f6
--- /dev/null
+++ b/rust/helpers/jump_label.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2024 Google LLC.
+ */
+
+#include <linux/jump_label.h>
+ 
+#ifndef CONFIG_JUMP_LABEL
+int rust_helper_static_key_count(struct static_key *key)
+{
+       return static_key_count(key);
+}
+EXPORT_SYMBOL_GPL(rust_helper_static_key_count);
+#endif
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
index 22a3bfa5a9e9..6dfafa69a84e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub mod firmware;
 pub mod init;
 pub mod ioctl;
+pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;

-- 
2.46.1.824.gd892dcdcdd-goog


