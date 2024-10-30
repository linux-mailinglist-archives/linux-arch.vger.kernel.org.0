Return-Path: <linux-arch+bounces-8728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D79B68D3
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875331C21C37
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AA215014;
	Wed, 30 Oct 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCsKG9et"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE82144C8
	for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304305; cv=none; b=JWLdmjxNUMjdZo6/3aOKaLZRcuESEleGcNIFD9+59QvcT4xoGQ6dXITPbjTCMojG9VFdzB24peklpmsvQ1RPjRHTBRPJh71Ni0jCJr7XELl3XOmOHfsGUErL3rcoapCrTmSlSbN485ghuTFI43pygs1myfvGkk2QQD0pVJ/ORe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304305; c=relaxed/simple;
	bh=6E1WLLql+lELSHgkVX0zcOXTthdmIBZjrDBlYLHV8VE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rE/EG48byIz+9viGZPIblAaOyO+urlydSNXMAGF4HBlaQrelOY/Yxh2JiCUB6VYhww0i5HGsBz2aoC5ZGvPjK6LREIbA2RfCqYNSYJL5B5++g1ogxyyVj+xOfMXX1PLgSV1ViTA5mmCsOuMToxOJKlemegrh4MjNV8rB5PU4gY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCsKG9et; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29142c79d6so9037065276.3
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730304302; x=1730909102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=54C00wXILAP4wDE2WJebdXFCv98gErGHm0LgpmOmMWo=;
        b=eCsKG9ete77tTiTYmXqcbBPaJNZBL/UuBoWZtQybVxok1AtcgHkPmi9dWTvq5pDT5k
         ez6WLwmqUeG716InDy1tEHgFN8lBbdqHjoKY6qGKzgAX8SuzPDW7y5GOpF6GrErYRfBZ
         dfQX/yvnqXQG+jXn+2mUU+lBo6vf53lO1ZD+eA+iar4kA5wxM1oXPqETG06dFfY8meX3
         TlHyJ/sYe3ScSHuvl4ELGNXVF12cGJI2C4b56mSMNzUR2lgAPTPBAffGdYKv/y9ADsQw
         fAM5F9KdMQci0PmTQxNx4dczadK3+N1DneeukMZne9qil2A2tFJFeFvJtLzO5Op3UeQL
         SMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304302; x=1730909102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54C00wXILAP4wDE2WJebdXFCv98gErGHm0LgpmOmMWo=;
        b=GeggfH76b2Zr/Trjr9HqefaZk88dqJHJhKXtc/SjjneumWOkpRvbucjAtuvVf1IG2I
         O35NGu/SaqlLM+5zqjpzdnGTvBj7BuIJcEq+rqClRZlX2rNLZXKfYPQV3UUdXC1XTHtY
         nIwWxogyIxxJAANBVBMiOPF/MgUjwKzx7TxMY2Tbbv2Sfjxtb2p7PA875erESkzQkca4
         SxOhhFRuArJYDrxLq7bC1JTadl9ijLGNb4wXamMiJwQSy3gvCXRR9qvRztO/CqHNPd0l
         Ud7c93B2GIliGRBVoB8SqFYa5IrTbM+7FVIQJt6B6xr6TDOb6JfXgZ4OspPrebrikprw
         gCxw==
X-Forwarded-Encrypted: i=1; AJvYcCUlcfN6dHd9Q/1v4twVFC56D5k1uQROiwmBqsLsOty/YnTWv3R+vOLiOU6/SEUMSTk6mXaLb5iiazrK@vger.kernel.org
X-Gm-Message-State: AOJu0YztD+lskJPTwiouBhAOhpgByef4UK03BemE8u/hlx2NGZg3JLI9
	q4pnwABdPpEdrmDuObmqF/t8QzAGOmHpQGyWvmrabKZnWvNTLzU2MkFYgL9O8Otn1YxMIpa9TYf
	eL0yl71tDNiDijg==
X-Google-Smtp-Source: AGHT+IH02CpxvtSPol89CK83WsKKG+/9Mwolu1CUUBZ+Whn8Inwxg2VMatkn1IVi7GLj+0ruemL1utAOuG8/YqM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:7481:0:b0:e2e:3031:3f0c with SMTP id
 3f1490d57ef6-e3087bc8ca5mr10454276.7.1730304302410; Wed, 30 Oct 2024 09:05:02
 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:04:26 +0000
In-Reply-To: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4317; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6E1WLLql+lELSHgkVX0zcOXTthdmIBZjrDBlYLHV8VE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnIlkij9ArugE0ISxftxYGap6R5sPzZ34MTem3X
 YAfJWcND5GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZyJZIgAKCRAEWL7uWMY5
 RtyHEACM0N0SSCrGkN7dCmCzwyY3cCJ5+/ZS8EiisT++meOQqOellWnDP/PWSwMYNbKLQj01avU
 DJklGMUi2rgWkgWLWUw3GrMRK/18oqPSId9Yq7MRtYctCEBNv4faTk2F5MMNKzh2HAbp896wyn/
 +OUeotpRorcYeqS+fhvGRpZUsOt1I4hRqeCODknNXG7YJfnveRdyeX19Nqoc5Nmrr/Uxd/dfeSt
 +izMRDn9xRkm4BNbNX1yq7vxHnxw03+3+w2BuTdWsH+PLbA+jLAlxlYckKuVq3d81QH7/gRF5yo
 7Bmw48EA4n5UMfHLSMXW6eu6yyNK/4rXD98UpVyaC0tmhhzevjQCifkvST3x0kK43p1ik/cpkal
 MSJn+2cTR1oSj+CjlBikD10FZecb3FGmhyvrlttp71kJqGbsuhJeKmPlg+/CLdw3SVqr8fxyI1U
 8AokMAWfRmWN/BaLCLAHONLfPeoaVdg79U5+cIJeaAipIbx41O8Zan7uEfKAwyK8BTa/ialGsSi
 UvFlK8LwyS8au0VyyKicDxE7Tswji9RMwtfM4BmxSauM4ltVnXcRWuSQpV3V2W7tJkLqtZu77EN
 Kyr2CONG7Heet1+fPXd8k35lT0KGZoZdqTppbnog7dJLj1eDulTzDBYyiVEbnrBibgMGBS/dBZA Bfq3ja4N4Z6u9OQ==
X-Mailer: b4 0.13.0
Message-ID: <20241030-tracepoint-v12-3-eec7f0f8ad22@google.com>
Subject: [PATCH v12 3/5] rust: samples: add tracepoint to Rust sample
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
2.47.0.163.g1226f6d8fa-goog


