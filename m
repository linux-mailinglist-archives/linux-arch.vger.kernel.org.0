Return-Path: <linux-arch+bounces-6119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339394C3A1
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 19:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BB01C21043
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CD192B60;
	Thu,  8 Aug 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4PDIkpC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88A1922CF
	for <linux-arch@vger.kernel.org>; Thu,  8 Aug 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137836; cv=none; b=TaQkR9iq+rTPRxQnGo7l9OvhVrtTZaaUhwakFX/4noEufPPZd/Azeeu0jcVh96Aa+fQSjkJdmt1StaZXjg5SIxnwoob9fCMGs7tNEsSGABt+4XtdD1Vyhm+WYPkZua7lKJS9n5ACRsLtG3xIhUUezyjgp1G5NaBgK6bcXZDx4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137836; c=relaxed/simple;
	bh=n5W5/8RuyQx5yRzRzRXuMwfWxOkJ6c4vZC3cV5tM17g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHc90iK7WoiVLYmzSDW9MBUieBh5mxqMKfVHjp6TFAFEfAi5uwUqZGV4HgVNFjlFzBaNCMkw9/VFr6Ls83BG5bJ0ZGi/+Fw6maVk8mXdvo/PyB3j2Yi5Tu6/TT89IRaBmhThmIHwXsZAbIUfh8uOcffLsx7MRgKDke58PgXFNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4PDIkpC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be2c7c34dso1833453276.2
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2024 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137832; x=1723742632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUmFxerdq8msU7sn8fhzQ+jzd0whlPoW2gAO6N3eFHc=;
        b=e4PDIkpCFZoRTQ08bPhqyjtcSCMRqWWN/e9Kzd/xlqg3TmN4v570l2AADplLpuVbcK
         JjiXd5gK5ElJzSjIIHa8e4k5XZRNTnp9LB7eE1sNlv7Qqi1qSq/DDTh8TXCxDv2uFVBc
         Mps7sE3LiwypKcR8ltNBxwVmBOza/bq6xlscFoF0CEbmrvKfCfxo7LqlMkEwIEt4mrDi
         JHC0Zw+hk6v9KPaMu3tihdEIP5sY6RClg+nfcMAP2vKunb67fgthVppapBfvPI5B8k8D
         u63QA39olFG9L0OsuWFh6EP2qt9QOaROFRLeFpYpsNabhgaZ7Ye5zMsJ7UesXmLwfNvT
         EOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137832; x=1723742632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUmFxerdq8msU7sn8fhzQ+jzd0whlPoW2gAO6N3eFHc=;
        b=C5lq0aPBTvDsIXR5D9TSqDwhQA5/Uee2gPz3PWFFm07PXHU4pQXFUG03c1On83gTV0
         D2PFlqtx5D8O3S+5gSZShAUHSSzNLe5Za2tizP68Gn3d3vRagOpLuJJViMaR4T8P5kVb
         g+xOzkqJspcbXsPX3HAjfO+R6pCHyfXoc23wuziSmoT9ltNWcq6x/c162Y6Frfh4yFZF
         Zes3LRZsjQQZUvuh3f1ENBhZD2csG5Vwd4/eVPQwDvz907ifOGrIQFuRPyrn+21JrTja
         JufW6IhTSKfRs1ibepKCGOaCARAizgQQQ+Z7Iv4H2jfMXjEsBj4U2MY9lrUnpj2haT0g
         l6rw==
X-Forwarded-Encrypted: i=1; AJvYcCW7c9vtUjhhEqgnRcB4zIsR3YeXw9Lnaj+cOW0gpevNRKAjVSRnjv6gl9wBfqPd6XWpFUGxbeeyHm0w5ZmSlqFg3xpbLbtu/cjc5A==
X-Gm-Message-State: AOJu0Yzd3UK2RzsWMqc/kPlEVjiIC0yeMeDC1eHmtmijRZ323rNNViOI
	PsKWg3q06S+lucHNIt7yIMmOaJmUmSNGcZDAOeRk4o5NjxAsYNxDQiRdxOjPrpMGKNBEmxANYDq
	0ZtT5sZgvaOxDjw==
X-Google-Smtp-Source: AGHT+IGRqP7+DFeFNUnQ+V7Y+ipYll5RSViPN5CwU5FJh7fsHlrB6rfBlkvk18OzYnFeixJyiadrP8GgdZMTzno=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:7d07:0:b0:e03:3f26:b758 with SMTP id
 3f1490d57ef6-e0e9da86a35mr8901276.4.1723137832230; Thu, 08 Aug 2024 10:23:52
 -0700 (PDT)
Date: Thu, 08 Aug 2024 17:23:39 +0000
In-Reply-To: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4268; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=n5W5/8RuyQx5yRzRzRXuMwfWxOkJ6c4vZC3cV5tM17g=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtP8cCdKeVKp3Gx4bDIXcskOAFpC0nPFgKpZbG
 ZYZHDxjpLmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrT/HAAKCRAEWL7uWMY5
 Rl9+D/9EFS92/jNIGRd8sGCRkwHTYcuzvvQRMT0VkgQ/FV5v0gR1hJhLi+6rGq1AR1PNPNz7Yfg
 N99rpjYoveK8RqLqkkhJhZ06BIuqtWbMWarRJnalN5AVq/E0GZskbX8qQIbcWI0nEwtZB+Y2I8m
 UvMTKqpRjhFxVuLM6oT/ZLKvXOZ+1g3iE9FWpuwRbcbWwHD9tluTttD9FUTz0/xvBslxbuT1CIl
 iueN5KGjHWQN3OU8KsOWmERvd+5dhftUlATl+2h9yaAAjsGxBEtOOyfO3QdD/1M4IJoPVCkmwjH
 fE41mm2u/8qrybC0f4//dRzk5hrYBYVZLe7gJrDR4923g/mfKCvTqmrbFGcLwXB1/CQOvZ1aybu
 /7TSu6CFSBmhqBLEoSOz9RCWRhETSy8YFZZHSwFQcZJ6aPaFfGaFt2qPjOWsA9FHu+qfqocQ2gt
 vQOnCSsdi+j5EbcxhOI8Ue4A6oRI2jKCl6Avkx95Yh6lQbfBTUAEks2EEzsPK+s+C8vQknuZ5e/
 j7gzC6PlhQCdrD5AmdT0kDMB1Vlwyec9ACveUXEDePzk8ntFGDt8gCsBiKg4tcVgbIM9Dgbrl6c
 CsDRDnp5Q7ZeyYfbsqhNr3xpc+as3Oqc/wiV2IdRdCxfKAR1G2jUTmvhWSi4q2xdN95TBaKPGkf PVWzZTdNrDuvmSg==
X-Mailer: b4 0.13.0
Message-ID: <20240808-tracepoint-v6-3-a23f800f1189@google.com>
Subject: [PATCH v6 3/5] rust: samples: add tracepoint to Rust sample
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

This updates the Rust printing sample to invoke a tracepoint. This
ensures that we have a user in-tree from the get-go even though the
patch is being merged before its real user.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS                        |  1 +
 include/trace/events/rust_sample.h | 31 +++++++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h    |  1 +
 samples/rust/Makefile              |  3 ++-
 samples/rust/rust_print.rs         | 18 ++++++++++++++++++
 samples/rust/rust_print_events.c   |  8 ++++++++
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..465ca809ced4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19920,6 +19920,7 @@ C:	zulip://rust-for-linux.zulipchat.com
 P:	https://rust-for-linux.com/contributing
 T:	git https://github.com/Rust-for-Linux/linux.git rust-next
 F:	Documentation/rust/
+F:	include/trace/events/rust_sample.h
 F:	rust/
 F:	samples/rust/
 F:	scripts/*rust*
diff --git a/include/trace/events/rust_sample.h b/include/trace/events/rust_sample.h
new file mode 100644
index 000000000000..dbc80ca2e465
--- /dev/null
+++ b/include/trace/events/rust_sample.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Tracepoints for `samples/rust/rust_print.rs`.
+ *
+ * Copyright (C) 2024 Google, Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rust_sample
+
+#if !defined(_RUST_SAMPLE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _RUST_SAMPLE_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(rust_sample_loaded,
+	TP_PROTO(int magic_number),
+	TP_ARGS(magic_number),
+	TP_STRUCT__entry(
+		__field(int, magic_number)
+	),
+	TP_fast_assign(
+		__entry->magic_number = magic_number;
+	),
+	TP_printk("magic=%d", __entry->magic_number)
+);
+
+#endif /* _RUST_SAMPLE_TRACE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index fc6f94729789..fe97256afe65 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -23,6 +23,7 @@
 #include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <trace/events/rust_sample.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..f29280ec4820 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+ccflags-y += -I$(src)				# needed for trace events
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
-obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o rust_print_events.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index 6eabb0d79ea3..6d14b08cac1c 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -69,6 +69,8 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
 
         arc_print()?;
 
+        trace::trace_rust_sample_loaded(42);
+
         Ok(RustPrint)
     }
 }
@@ -78,3 +80,19 @@ fn drop(&mut self) {
         pr_info!("Rust printing macros sample (exit)\n");
     }
 }
+
+mod trace {
+    use core::ffi::c_int;
+
+    kernel::declare_trace! {
+        /// # Safety
+        ///
+        /// Always safe to call.
+        unsafe fn rust_sample_loaded(magic: c_int);
+    }
+
+    pub(crate) fn trace_rust_sample_loaded(magic: i32) {
+        // SAFETY: Always safe to call.
+        unsafe { rust_sample_loaded(magic as c_int) }
+    }
+}
diff --git a/samples/rust/rust_print_events.c b/samples/rust/rust_print_events.c
new file mode 100644
index 000000000000..a9169ff0edf1
--- /dev/null
+++ b/samples/rust/rust_print_events.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Google LLC
+ */
+
+#define CREATE_TRACE_POINTS
+#define CREATE_RUST_TRACE_POINTS
+#include <trace/events/rust_sample.h>

-- 
2.46.0.76.ge559c4bf1a-goog


