Return-Path: <linux-arch+bounces-8021-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1E99A0FB
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181671F231DD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6904210C0E;
	Fri, 11 Oct 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wn99qLAa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88E210C32
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641657; cv=none; b=aHz926jogXfOTbncGoaLiwftCxZD35UzYrmi3+bbujaa4EmhKwgW+pGvgF+UCLJDf5bJnCr+rmZB48evWj62Q66KocSJvA0LR1s40NIx/Smkdg35JxYuSOYpfT+d6gIe+nFsUBKZ2cwlxIpEppzwOo4BMHVD5PbLg3U3wB9n5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641657; c=relaxed/simple;
	bh=InIXqZbQ2UsIGkgB988EIK/mKm3HwkMiS/ZXhKi30VE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SDvPoBNvu4JlRnw+Hon/xzGxiXDbrpLlw2iDQQbPGdNRtBX8Oz3W7A0wE0C4Sa493SS3up9GYI8FofSopMZmt+DCFPWnl+SOI6DFSxsWx0zISE6YPCXBAVlsR1xGKV7Ek/yiD5QGSoAXMz/S96KmNPgEVtDSEBuInZpsaYArJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wn99qLAa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e347b1e29dso7087217b3.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728641655; x=1729246455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFE2ikPp0UZhCPNVJ2m/j/nsy90Mrtse7k8dbsw5+Gg=;
        b=wn99qLAa7Xw6W6KA2rQSoFHcctwu/XmSQYGhd2K9g5hzhn16HxXhdfqHK5WiAbkPO+
         84DeFIPEruM2V8qG7AGVFugczPgND0m+KXzTJmxQeBrLgqtYHHBc0DwxFpSJndD2rYZ6
         l5/HQ8wpZgUGt4n4j0UyM3ynD/BzNf//5sqeCJyudvGy0GjY/oUlL522VVGqoliHbaHB
         UvJYHn+mD7SDdWPyET4qgoJ548Mtj0ip7F+ogs6OSr+FyxCWa/DnQbGz5ReucfYOmCWk
         WSMj/mWDtxIUm3BthXMSdR4yxpScNUQ8rWBJBiILyrA0qxcBdccVRojrhwvp7IC9Snns
         QfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641655; x=1729246455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFE2ikPp0UZhCPNVJ2m/j/nsy90Mrtse7k8dbsw5+Gg=;
        b=LO0gGe6qNhlnyWq8Y3VQdByggHSrOG6EsZZ1GYRV/FP/GMpbm3FZNNieU3g4/aU8dj
         kv5snIhJVvWyntkgOZkRws24qRDiCGVtLJ7yZXxA1pffVE1U56e6PaF2qpN8foFndtOF
         +dVi7oBZI1/xN4g9lLu5eaDNBemnpcdYX6uu9sZzSYUKgEVM+eC0QCNKaWm0MEA6bXaj
         Kkre3f/i63PT5iN1GiqPBE/44EZEqDHxLmxjdk7EZxkj9CaP8QQLC+Rmc1HwuKViny63
         ZyKOb8byX8w3Wx05Tfx+gftgCvF68/sNUkL8xsfEOzGdH1BbqEq+EpZncjWZ2YxNEUlw
         zLQw==
X-Forwarded-Encrypted: i=1; AJvYcCUY9WPXk3xPyzpnNFmAsYVkGglbGdhglLIpVtDrHPJvGSOV+SVdXAwqyw2b++W3axbmzvHIwrF2Pe2X@vger.kernel.org
X-Gm-Message-State: AOJu0YyiP357EAAypupMGb1kB5R1aflvOa5Y/yUuOPDMbz/fqOj7IbH0
	gmCUMqQ9CFKNA8jEazyuFDuMb1L/BoeFnlr7F01TaxpxM8nEQ/U4U4q3+FIxb4JYQrwyVzFzLWp
	i3JFiUZgsthvXZQ==
X-Google-Smtp-Source: AGHT+IGpfJF0B5G/uIllp7xlp0AhMjEVDfZqgoGdnuBNXxme/+AG4H/P90AhJ2bPoNxKyzEqiqWw3jG98G1uYSk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:670e:b0:6e3:19d7:382a with SMTP
 id 00721157ae682-6e3477c0764mr340997b3.1.1728641654667; Fri, 11 Oct 2024
 03:14:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:13:34 +0000
In-Reply-To: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3958; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=InIXqZbQ2UsIGkgB988EIK/mKm3HwkMiS/ZXhKi30VE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnCPpuj5sSq3+OB11ESiA6TUOR98xUjIx+kmVLm
 B2utekqr/GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwj6bgAKCRAEWL7uWMY5
 RqFuEACdRrTaSJ20ihG7QEIJoAxYLsT0g7NRrZJBoI6+1kRpkqFjVd8FE/gmwLxtsVfs8EkEKMp
 +IQgvMZL9CYOt4nTM2L+RUdyXtQOXWA/StEbEOLdoLLy+E6pdfIAk+7wg4BMX7XiNQ+DIJUWxyo
 OYGqW9Qjp6ba19Fgq+BPF4HIg2Pgrp31bQlUP+BpXxUWAJHdxyawZBXMDl/7/M9i+rzVq/tCGfD
 AUhIK7TOfwDe+yQbhAXA3Ksog3f2zZzoLhdBa/Qp0ik7mWePSuHa7JBRJfglFKZ8zd1qEzSdYPn
 mE3EcEiQc0uPeLjYY52A08yaf33FumomjTZXy4BxrtY5YRY+ct+4uKkLTodMnemoaSYascB4OlU
 kylUY3ZF/NxWi5PdfXLkgxTTnB6pRzWrY4K8IxTP7MLYcm+VZdLbz64YitvhDTGlq85VazXRmgj
 wsqWu5Ga51BMrDK5pISfzXczrJ81IGd/HbIh3uUU9WBs16Gw2PP41Xb0IlZKl4whWo6duj/Tm6Z
 yZsABEXNs3ZNz3lKSjboZNHHQU7nvuvm7UE+kTpEM47V4n3FVUDkY5ySlkxlLRw8Jxj7YzCL0Xh
 ySfDcoNn0fbubMA68pyNfeGr6u3fTv++KxbzqBHKRlxGd5qq+MzGlVd5wUTZDjV0sbt9/gHBa3L hbS//5X0LNyiXhA==
X-Mailer: b4 0.13.0
Message-ID: <20241011-tracepoint-v10-1-7fbde4d6b525@google.com>
Subject: [PATCH v10 1/5] rust: add static_branch_unlikely for static_key_false
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
tracepoints. Tracepoints rely on `static_branch_unlikely` with a `struct
static_key_false`, so we add the same functionality to Rust.

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
 rust/kernel/jump_label.rs       | 30 ++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 48 insertions(+)

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
index 000000000000..6948cae5738f
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
+	return static_key_count(key);
+}
+EXPORT_SYMBOL_GPL(rust_helper_static_key_count);
+#endif
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
new file mode 100644
index 000000000000..4b7655b2a022
--- /dev/null
+++ b/rust/kernel/jump_label.rs
@@ -0,0 +1,30 @@
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
+macro_rules! static_branch_unlikely {
+    ($key:path, $keytyp:ty, $field:ident) => {{
+        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
+        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
+        let _key: *const $crate::bindings::static_key = _key.cast();
+
+        $crate::bindings::static_key_count(_key.cast_mut()) > 0
+    }};
+}
+pub use static_branch_unlikely;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5f4b3ce6b48..708ff817ccc3 100644
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
2.47.0.rc1.288.g06298d1525-goog


