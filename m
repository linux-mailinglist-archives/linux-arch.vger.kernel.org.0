Return-Path: <linux-arch+bounces-8023-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B1999A100
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788C5B24446
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94755213ED8;
	Fri, 11 Oct 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2RmlnMe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4D2139A8
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641663; cv=none; b=cD+x6AoVWIAWt0oGaikhvA7xpIdhYY4XivYbJbbtrGoGC8cpN0h/xrrXcrXIoHou39r4Nb8jtwj33VSjL5S64QwzWTGDUsXNjfLLvM2l9qRyfbCeqt4qnCFjSVPX8v77IL8QCB7ZmwixjopRPhH34vq61Jg67FQ97amMBhAujnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641663; c=relaxed/simple;
	bh=wthozKz61nBwTqsdkL/dd5IHBHSbPc3jb7JMQXND02Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mIyGjJvbhCPJV9fe6/QJXAZzrM85II7EaN2esYA7qme0m5+e0YN/idJbm6zZzotS8qIYAHS8YZggZlCw/7iX4JWpMlLBdxigYI4VH41eQa1SSfabFDRyZgiF11GD2e8TuQESNDzEMI6NIOsjkxdgONIUNawpK9qHXGb4PkCkifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2RmlnMe; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-430581bd920so11524685e9.3
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728641660; x=1729246460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZneAmtjYaP5W4qvsAgvZmY0+FlDJmT5YgM1QOUVihI=;
        b=D2RmlnMeo3FLS4zPlwonzeiN29Z3RreK7srerPcrGlzf7O3cDyqmAZ+k1yW6ywsJYf
         a8G5KgNHkTPT4J+tbh9O/ppNalvjOPfSgd+dRV14u/T6G4kU+CgqviY9lqVixpWbq+xy
         bIaP9TFEcHMcv914L5i21yNQfo8eWWs3cULf/wvcH7Y9eJP2F5xYdJCsVIJev5+qNBYb
         tdbAShdMLyMZ8iaplKj0uhTaISVgVbDd93kZzTLWFjlTb9y7XdF7DPNK8k695z2CtlkM
         JMTQtME9LwRdFuMwi4lOjHng8NwULfcIEqoEvc7CjGVDXpR75mZlw9rZN6vbDFBGZ66+
         4H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641660; x=1729246460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZneAmtjYaP5W4qvsAgvZmY0+FlDJmT5YgM1QOUVihI=;
        b=My1qX8dINeg5jxiC6mkioLZgiCWTFIUSK1bfPlHjDfOAksuXHzMB3gCygocp16EUAl
         Mh1DYZPBbz3kuJvMUV730xUcZyShI5bIgyN+GwjrIYZgS7Ha9qGFaZU+VlzOMD6u8/9X
         9IKVC9uwos2gK/bXRrRFn3hMZnTEFWSDrGX8JiopLUPx2okNcIJfLU6ZB/bfuokJCErh
         p8kDcK2djahHjqEMjX6fYz15AeegZBTBPJfObjJpDZb+GY6VsRb23I3yJ1IJLBmTos4A
         SYd+pGDHseHyJAS16UFMcSbDZI08as115RElxpHnEUSTPfZOoUDsoKo5fY1NFw8pfrvI
         E9CA==
X-Forwarded-Encrypted: i=1; AJvYcCVlaLcLpxlpxw8uvRe2hc2PQi+a4D+jDiR+BzwdLllsUZuMT78ZBj8QyX0TLzaTqCgzegBgQtTJKTVk@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmO9KctP/PKneNhiAhAca3qLGpWzBARYndTnbgMt+8r6M7vEO
	xz7JcDpN4a9Y3iioZi7U48fNIYqZ/oTpt57Y2sjSivXaeu00T0X3pBXdCqobEoeueMJtGOK4Lao
	ATMkXyRyoIQUfqw==
X-Google-Smtp-Source: AGHT+IHwSshcnmQuyVjoiggjp0suaGgugY0GhsgHeqQ62Wpnp4cvxzx9Leg6f46QE7rgGmMJJguSn62m3/uZW1k=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a7b:ce91:0:b0:42c:b3cb:296c with SMTP id
 5b1f17b1804b1-4311df4b8e8mr27955e9.7.1728641659750; Fri, 11 Oct 2024 03:14:19
 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:13:36 +0000
In-Reply-To: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4321; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wthozKz61nBwTqsdkL/dd5IHBHSbPc3jb7JMQXND02Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnCPpwllzrVPf0XbtgvnBfNst4p6IA1aRL6WpWU
 4aylkW0T0aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwj6cAAKCRAEWL7uWMY5
 Ru61D/9dPQkiC24ZCDf7aZ+W5r69bavpsSXs8AyW+ckOYlQsP6mfv+X2iABRlZF/31B0HIIV/15
 oJwDb5xAklEo4SWnZWxcLInom3QnwykoLyuX/COb7z6y9xUVPeoiYdCFJG6NNdCxJwsuyr5NvSh
 VjEebkjDS0xhS6z8n1fPr5m/L3soem8NznQy2LHFRyIIE0mrm1dl8kH96KBFRxjS0KO/MEprY74
 pq3TQYFY8ML4ZAFqGQRh72m0aJdTc5HBH0gaWNz91GIEPLLJeO4AAOSGu5c3L+fKXLEYMpBoKxZ
 8w2Z9r0InuRSX0Cz7aiKu4Zo3lxbztreA0iMxruWgP85OFkFthJQL7LnqWKhA59trIYL6UNwU+Z
 GW7NkyAwkgpHvMn06ZiIwo4qWSY04XYpF/dusKW5qzQuGOEi4VFDOucrRLfZkFcQpY8hA3Z/7lg
 ltj7PQ17KRKt9KuGNhcNk29CwETmCku96W5Ou7LVhbZp9/m4AZW+YlMDVs16jdkpPV8Mz8L+gYL
 RyE4SNWpTlI2APc0JkX1ReFLFlakd5wWADdgkhdCcmZYAQ/aZQ3iVRVRUGiyaUZkXsK6NVMDIbB
 FWQhq1SbuvK2r8aH8L8me8NZBUe2OiPWAPbO5AWZqbVvPaWTrDUnzMKrGDn/XJCN1InZ4WhYdta +6raBZmdMFrnMSA==
X-Mailer: b4 0.13.0
Message-ID: <20241011-tracepoint-v10-3-7fbde4d6b525@google.com>
Subject: [PATCH v10 3/5] rust: samples: add tracepoint to Rust sample
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


