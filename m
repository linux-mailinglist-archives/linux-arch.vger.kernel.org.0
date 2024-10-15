Return-Path: <linux-arch+bounces-8174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5299EC87
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62ED81C2336E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4861FAEF8;
	Tue, 15 Oct 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSbzKFVG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EF2281C3
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998134; cv=none; b=KZNxjYvsIm+l1KYS7/ER0VGkZfXSa7TIzAJ3/e+q3C/4QxF4YWk4JuOFyWERgslUK4SnRFO3ymwlTe/LtObaJOuh0lBTKbkE8RCAY3FLu+Cb5bVrosfKpXM+SHVlEaOzL6kpufbDE86XUyOPB78qxLi3zoYS03CCy9k7bGVUa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998134; c=relaxed/simple;
	bh=wthozKz61nBwTqsdkL/dd5IHBHSbPc3jb7JMQXND02Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b8hSCFDkpm1ZacHAjbjNIZWbA266Vm/Co+FD7i7VGqzzuE+WaV7K0IV8DB0JyxoeGQiJvcwC52Y5MRRTWesCtuDps3h2iySqhpqFAtY8KX2lkFUW5IqWV60bcd7WDUc5VEFgSinA1semQ0l8ue7F94IEKkt7kBSR/McgCu0jKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSbzKFVG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so6381716276.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728998131; x=1729602931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZneAmtjYaP5W4qvsAgvZmY0+FlDJmT5YgM1QOUVihI=;
        b=xSbzKFVGZuI+2Zwb3qrMHfJHz4qWbA2L/DuQOL+BDCIJebgclHQ8WilCQ5EwJ1i/mt
         J2BtRtuUqq0QvUhYtWfCnVyp/FIeDC0VZbW3yVvmYXPQ3PBTy5uA6wZUvYNVkI6UI2z/
         /UO2xVkP3dWUAD1/tG8qywJX1W3XFYutky2aTbJKSW+mKl/tGBUXaIiFME2zeO1wxN/v
         Cr37f616xs907cdxKGPwU5OTBG/vWBD/Gx9dBSdibxq6KzpepUo0lXbuAXt+A4dKv8eX
         qtMZXHy+xYwLFJsYz0y2YUYSh9ssbb3Iif+Qu7wj2G/rwGEMO2rUerwGurgocTi58KoJ
         R80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998131; x=1729602931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZneAmtjYaP5W4qvsAgvZmY0+FlDJmT5YgM1QOUVihI=;
        b=ZBLpBY++cV0HTow7r0Ye5jYZWD2dOsyd4jwp0OvteeFWvJyX65binWnxptza7loImp
         PnIPoEi/QS0DmyZMQLtvcU61NYDMV6qTokUzW51mxDc9UvMIOVaapqKtFaKyKFWjL1/p
         +5lyIr9KB3F/2TZF0cPqxSgqd1UK7vWUtFFBFuB6+7szgjAFU32Z9J8JaKvFcvlf6aKJ
         1+7oXScIO+zSI+6gucAeubpwLFRGjBHvjYEpH5u3g26xB8pWsrgcqgwCQwXgXsi3eUGs
         WeLIo/qLzyOuOZ/IVCK2BPpMKMufA2LnfIle7Oi28OkIfP0c7WQSTzAV9o2vYSu6JFRG
         EvVw==
X-Forwarded-Encrypted: i=1; AJvYcCV+OhWRIW5X1lkGi+J4BUIppqKFF0LEO7+YUBfG6yf6a8/PiPN0LrO1gM9GZ440o935pLDV9/Wuv+FZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8NyqWVDgp2n41wrwF1aDcplquP3jw26c5wsllDJ0aoQSk40q
	y8Hc4Kb8EaYgw5Q7pCooP28js2jLdSHnmO/zEsiP5yJmovapWRX6yAPO/Fgcu4a+8CrefPgVONu
	hBB9NLIJ3H1khKA==
X-Google-Smtp-Source: AGHT+IEzL6yBZNlDa979UyqaKi9F1PyvGo7lYn8YswH0l3PcfVNksqbLlmaMvQMZzFMWKz7gTAN4h9OzzLcAOhY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:ed0d:0:b0:e11:5da7:337 with SMTP id
 3f1490d57ef6-e29782e7f49mr153276.3.1728998131411; Tue, 15 Oct 2024 06:15:31
 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:14:57 +0000
In-Reply-To: <20241015-tracepoint-v11-0-cceb65820089@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015-tracepoint-v11-0-cceb65820089@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4321; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wthozKz61nBwTqsdkL/dd5IHBHSbPc3jb7JMQXND02Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDmrnVE+FoIcfCQnaz9Z/nNlTaNIkQb/bJaHvv
 wlL8YA9NLeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw5q5wAKCRAEWL7uWMY5
 RtqND/4qpfG1RTZIbjGjCAjBRTqE/qdqMEFHvsouDl288HuGkKkplByjrXDUNDoEHNOYlJD1+9L
 WLQReVgBvvMuxrju4XEqD4hSSOQodect6dsVeKL1A0EqLjCKRUx0IJ7rxMGnfkYPHMrgzue5Cjd
 5Kr9dkif5IABz7/bYcKaYqNCUnvXexQyMR5ADH7G/SQX0ZbznIvDDi2kMjS60zYxH/6s73/8Zej
 WQussULMf/kVrPqQeIRA68F+DDaTMAFZw6FUYVKcqnLrBDPtObsH4A13fp5yZ2REjajAcVHD0Tg
 OcgmE6d4YmEILkSLiCvaTU2Q0XKEiBEvT4YUQ0Po3HRlMMHngRr3gpX9isQE89xTxyFyPDrOEkO
 vUhW3ioHS4u/B+e8uxovfsgtdVOtRzofmUbQQ7eGmpdMk8SEmvhY8OV4g5uxDjMcNnwMLqGgTnZ
 /LjS741b7nmcXXktia2Q903daEcfxsHbVM8hanld0A0A7Zg+n6mtnD9vY+dMLgMAby8+DCij8k9
 NxocILc/Lzu3LKDraG6IP6WymRrrX3XufsItDQpytfyFoTSRK5hWyHh5n0AywPiuDQ1kr5tfJw0
 T6N/zussmON/rM04BBqllIU46HDRtdol8edsiKo2sMso/VvxB4XzBblyDXV7OWJgyP583WnGwZV oXb3CAvdBW2ur6g==
X-Mailer: b4 0.13.0
Message-ID: <20241015-tracepoint-v11-3-cceb65820089@google.com>
Subject: [PATCH v11 3/5] rust: samples: add tracepoint to Rust sample
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

This updates the Rust printing sample to invoke a tracepoint. This
ensures that we have a user in-tree from the get-go even though the
patch is being merged before its real user.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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
index a097afd76ded..a9b71411d77a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20223,6 +20223,7 @@ C:	zulip://rust-for-linux.zulipchat.com
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
index 752572e638a6..b072c197ce9e 100644
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
2.47.0.rc1.288.g06298d1525-goog


