Return-Path: <linux-arch+bounces-6523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27495B494
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5158B246DD
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 12:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C701C9EBE;
	Thu, 22 Aug 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ad6h3hYG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9C1C9EAB
	for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328300; cv=none; b=qq6427rWI9EMQ9yqgGU++pu6W7chr8ZehuB8IaE4J1mQoXMg9xdXuX1N9AyizMZP8wpb9Dec2zXsZE5fymbPzzLliPdp7pFhNO+0TtaB318tnnLA1MQg4oR5Y087+HmAnI2eDDygNDfcqUiVPf3y52A1b2Tz8PjPSFf0DOVjgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328300; c=relaxed/simple;
	bh=FjpJXotW1KGtmig+hIm0KQivxPyDztMFhKa3lXhpNM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IPz1Ht4cW0P6vCUHfsTKrmDjaR1N4Lv/tuvm5ntCewq4tAcAV/TcSX9YIfN7q3MfwSVpiBeuLZnLIKeP6juHyo15nQzDcOyRdWOXNcdaD2m8ku9gFweVyMKpPFFRQ4N1aWsV/uorjwtECX78F9gFa/wID59X56CUFdunlryENa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ad6h3hYG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b46d8bc153so15787627b3.2
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724328298; x=1724933098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WXJYVeFW+jGG7DCrz93gCg6JPKvPQ2Wf4cfjKgCwaM=;
        b=ad6h3hYGznuRmOw22l2BRUiE1CHgMA9crBP+Q+hkqQRZ0ZgtORye1adQZYlXmHktCP
         hqAnmPi87bzj3bOVN4D3QHJRgadGKsZ6JHa1G5yJPtvehh4aKmfMGeY17+YmRVRaReEH
         zEU1MFxSEBuPi7DU+Rm9eW6rYjSM8ZXo967ewBPyd9OAsyrcDbW4QlREqXOAWRds8Wjn
         +IAa6Qs3lX3y0qnv3gJwjzMtsO0/CsOkR7IAvTccjFQ9r9lmz6UHBRlbAMW/VGTHN5yd
         pbBcs+m9mcwulT0qp2edFHLXGe+X0lrVlDjfSMQVPCR/x2oNNGKUBJFYPFFI4t9jHGhS
         g9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328298; x=1724933098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WXJYVeFW+jGG7DCrz93gCg6JPKvPQ2Wf4cfjKgCwaM=;
        b=qz3PeirOealsZrvvnjmoAF7Eb0XTgIyuonTyFhP6TmrGkMfZLxoiTVS+SzxfB1XZUC
         YFD808/MMr3opk/JwWaMlBFw9nKNEWqp6ONwW6l4XPWBp41oP17FOHnjqQiGojXi2A93
         BeEwZ4NyfNkTKIKbZkNqkctcvJSv6wuPKePr73Zo9/hB2evqBE/5TJZTkKJ+VaAsbNaJ
         AN2HSxrWePMDOCON2bkxDMcetp4gaCg2+N5x2XMkKbuLF6LhX6znWzTCiUQ/pzRTTa23
         Qq4Kic0BanWI36Dh/DISjCyJU3kPdLvd0myFm9N6WxFDfM9V2O8E9bsFrW8WrQZsiUYV
         GZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRvXiMbh+RF6pSOmWkmxlzbyVUTs6CpuBZekY407+HybF/HQYgGspmJefBAkc2BPWrJKpeX0g22TtQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzmbjA9+ZypLX+JvSjSD1J2SY4Ac3yeDHoNg92WJ8uX+YZxA1kO
	ZOSbaF+upZSSWANnPmwrBxfLTI+rrFmJYyEdERZxTJxScNR2f6bufKMkr+xx89Acm3wdyFp7vIN
	k5Pd3UTOTiYE5WQ==
X-Google-Smtp-Source: AGHT+IHOwQ7F4WwpIwCYP14vLZEMvblPZGwmqHarUMkdlvedNsRunUgeqjgc8IGJA2wVHg86ug/U3YKoS2Z6kS8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:7483:0:b0:e11:44fb:af26 with SMTP id
 3f1490d57ef6-e166540e1eamr8764276.2.1724328297474; Thu, 22 Aug 2024 05:04:57
 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:04:15 +0000
In-Reply-To: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4269; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=FjpJXotW1KGtmig+hIm0KQivxPyDztMFhKa3lXhpNM0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmxyldDFylo0W2FYUlH9zPLgV0aNf5JfdXWxC+k
 EV6BXx+qxOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZscpXQAKCRAEWL7uWMY5
 RmwSD/9lb6aazG/rJFEouodeNF6AgBtP/doqXucmQsYP5lsbpIKM6wD/RrdAfk8KvahqhtiKNZo
 M80qvgsWx6kR60U8/3k8BpYVdbSLtWq8iy7kDwbqPsW7/lbh6lSSN7po7WTvUGkLxdy55aBL7Sn
 pxvZeuKi80CsU5j1xBKwqA64hnBiiXrCmIbUYWMsfWCV1QC7IB3G4FGcWnkuPdSj/Sec7odVug3
 UGVoS0jRtXoInadAPmAvJimKkQGrM9XN/1U3Y//9PfoOiMapFuQ1CRn8NPVS3wLdpTesPhUn9u7
 eexLr2wbBy043Lp3azw2EeBu0AAzJ5FYxBnV7XKV7V+5VISDYLTQky2gSjsC+RTTVAW0ZxL4ExJ
 7tcK/uSNtex2S3P2p73VyR46otDTS3YeIjA7K6J8Cw537m+mpFL257yU0gdDeWj4RBhhIEH6JzO
 Y+Fi1fjq/r5jug7WVznXBOO0L9iN+HL/NGCTv/tRN5iexYDGVO0utnbT5kTx9B3ePtHUT0FmpGN
 DxAq0+0gRNwsVdxm4jY7ARuozjUBGvHfrKfTKGfwBzWN+t8wjR5lnxyPtKMfDczcG0A9Ii5xWdu
 wOQZQ3zt/bMwGS3BgCox0QdlxbK6m1+NaZgBJECLHrZEBYyYJo/0uQgI8Kd415KJtvBEaMpr5xh HbPkWR325Lp7a5w==
X-Mailer: b4 0.13.0
Message-ID: <20240822-tracepoint-v8-3-f0c5899e6fd3@google.com>
Subject: [PATCH v8 3/5] rust: samples: add tracepoint to Rust sample
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
index f328373463b0..1acf5bfddfc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19922,6 +19922,7 @@ C:	zulip://rust-for-linux.zulipchat.com
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
2.46.0.184.g6999bdac58-goog


