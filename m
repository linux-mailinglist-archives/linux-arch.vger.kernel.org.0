Return-Path: <linux-arch+bounces-8022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721F99A0FE
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 12:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879E6286022
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979621265E;
	Fri, 11 Oct 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PcHbisP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311621262C
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641660; cv=none; b=PWvFR3FkQUG0YiOsNbQxN5v20ulgE2FURKDHRV3UB0ljQje2nA6NyLGm9rkH7sZcAuDWSL13U2plCG1yFiFmXStvKv7F1ioHP/jwtlealJX9UEVAQ9QIDdukUWQ+75Ql0v7/0en6V65SI7ldLUbPONDrTCbjCjAmmuOicG9+9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641660; c=relaxed/simple;
	bh=GMLTcVVdmPl90l3vR60nLHEg+YV0m6WjZcRDkYDuaVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcSUARkKMTv+meph5omzTNqKYxnxjC6CN0XVFOZsBS1E8rfCxtSey7vh0mOKBaMGCMtb6XtcRGGDLMjdXWEjarcdWIePC1n8nwJ7BFlqpfy6JGKhrXQlR2nYWKSnaW0pVNeN6trKqh4Rbyw5d0LjW/1e+8ZGVsvxG3zAi0m7Kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PcHbisP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so2840592276.2
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728641657; x=1729246457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvgr+n6BCCNgQWUs70Ofe8Bn1gFUAza68YbSHBnfTLY=;
        b=2PcHbisPSaTAQJId0VGZxKHViN96oattSY3EMY0O5VK3w1QGM2G4RkJCdhBxRuvvDm
         BSd9rrNaNg423RAEiA7sOYcuemYDgUeJAFliu1B0eT2SMpHPO+fm7aKZrKmW5XtpAaJ4
         9UTsgpoejOmESP5sYhZq8FhDnzw9ec5J6wpSCJSVzwMqng0G6+P4Hipx6bhyiCUDNydU
         UUc6ENyFspHYXoylYUYMIIS7VFU5mM9mZFRs+s/E3pXoyf8J28OxAC0eosrUL8RX+XWC
         5xV/6BsvJWXbKroZFRl2Q+icKGz6OjQxmN05C0Llfvo0YFYVU1ZQBJnYwqbjtr5gtpOb
         yJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641657; x=1729246457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvgr+n6BCCNgQWUs70Ofe8Bn1gFUAza68YbSHBnfTLY=;
        b=UG9S0CmnHcgx+YkAA15wNTdN4H+Kl20oTAPp784Q0FsVAdZsAJrfmafM1Yw45MIc8J
         8Ls4HVpWQ3ePEVp95eMpv14rJzhGLMaEE7w5v3hMIBMmQLXaAaw3sg++VEmLytjhIgs3
         D75ODOzNa6JEAEevtl2UMby3iB3qki50D/9wMWluXwKA/5CiShxz6ee4rJTur6YyG1bc
         0xn6lbyME44aG20e7Z4Z+KhUXH3FTWpqGDsuToBw+hnee0F65+26WSQvB90upmJCqZiI
         G0O33XVpkwlr++PRK7ehoDlMbRb3I1B+v7ObGWtfWjWtukyvXdwXzqXOIv3VHyI86hF9
         /yeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeKFCu+8XQv0DWsm2GMW58/fyR/7YCVbIJkbEadpzJY7o0beqgtGNOoFIH0zyIcbTFcn5nfXqhRy+X@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7cEdxIavtM3xNXmPfUPSMm9zdUit5iQMAbTBOgwbXrX0E8sJ
	9r5AlmkaMlHIEAFVRngvCD+lUQLlKbQJR4l6i3oH3jYYvgEbhs99FjbU58NKwMIZAZ2TT9529ip
	bkTMWnUq4L+Houg==
X-Google-Smtp-Source: AGHT+IFgJ+Piz888o+PRmKpSL13qqycy9jfSGc/2HyfyiykHlc8IlbWH++eX+PjZ0yBW1jTMobxjLeChRsf/c/0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:b287:0:b0:e28:e6a1:fc53 with SMTP id
 3f1490d57ef6-e2919dea098mr6437276.5.1728641657145; Fri, 11 Oct 2024 03:14:17
 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:13:35 +0000
In-Reply-To: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011-tracepoint-v10-0-7fbde4d6b525@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7835; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GMLTcVVdmPl90l3vR60nLHEg+YV0m6WjZcRDkYDuaVU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnCPpvMePS1KH3kpkMOwewPbARNHwMg0QB3+FIl
 X+RT4mV+e2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwj6bwAKCRAEWL7uWMY5
 RvnED/9Bqg7tMAqwO7GX+Amlq8W1+Y7t3guUK3mjXF8TWDsstcmrMOoM/jxrR8hxmJLij1fi2pD
 9XHM4fRQxOfuH0qielFCGHGB+mHP9RZOZd53PgInuFxJx9rT99BDW4v+WaEff5icsoYxBVO5rju
 aw+rg+W+oJkxF7h3O3WbH4Uvmfl6jZEidbTXqeJCqzrCS2swRPNkHpd4gPMILxv6fn7Inm9Uwxo
 lT2grKFIIrVvAdSL6slRoFonikS/idXddLbyehkPA9/9Rz8C6q8DEd/IkuO/qXNQY3YGknAI0P4
 yjdoDBkJrETyO/hpa61u7qQnCZnd6e8emdNZtt2iUtNZTqZBg7B0g7RjxcSz2jHXH5rAdn2m2o9
 xtipeYLH8x72C2NEQuaucfRm6qG2rCaFh0Nh5fRtML1d6PQcBTfJWeNz+BgqaiKSkOXj5VFew6A
 FSBQetITA81S3Bn8lTCGcYnyNRG+NUNQ/ywNB8RsFhSY+geecVOlIwVCbNwK5LdBQARL2iXJ+Fk
 ytxyRD+lnjPMkEkQTbl/9ywTCEqTLwKQKs4qRlaZkB+VzIIMRYRfU5HFtyI1EpbCEy4PRLxXx9T
 3z0ntIFmVccY54Tb+14jQfzxJUgv5Z27VwNidcvwezXvX3uF7dsrwm7rMX5IzRX/x2+y2apDzSi 3+WYIi74KZgst7A==
X-Mailer: b4 0.13.0
Message-ID: <20241011-tracepoint-v10-2-7fbde4d6b525@google.com>
Subject: [PATCH v10 2/5] rust: add tracepoint support
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
	Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="utf-8"

Make it possible to have Rust code call into tracepoints defined by C
code. It is still required that the tracepoint is declared in a C
header, and that this header is included in the input to bindgen.

Instead of calling __DO_TRACE directly, the exported rust_do_trace_
function calls an inline helper function. This is because the `cond`
argument does not exist at the callsite of DEFINE_RUST_DO_TRACE.

__DECLARE_TRACE always emits an inline static and an extern declaration
that is only used when CREATE_RUST_TRACE_POINTS is set. These should not
end up in the final binary so it is not a problem that they sometimes
are emitted without a user.

Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/tracepoint.h      | 28 ++++++++++++++++++++++-
 include/trace/define_trace.h    | 12 ++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/tracepoint.rs       | 49 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0dc67fad706c..84c4924e499f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -225,6 +225,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			preempt_enable_notrace();			\
 	} while (0)
 
+/*
+ * Declare an exported function that Rust code can call to trigger this
+ * tracepoint. This function does not include the static branch; that is done
+ * in Rust to avoid a function call when the tracepoint is disabled.
+ */
+#define DEFINE_RUST_DO_TRACE(name, proto, args)
+#define __DEFINE_RUST_DO_TRACE(name, proto, args)			\
+	notrace void rust_do_trace_##name(proto)			\
+	{								\
+		__rust_do_trace_##name(args);				\
+	}
+
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -240,6 +252,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
+	extern void rust_do_trace_##name(proto);			\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -271,6 +284,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	static inline void __rust_do_trace_##name(proto)		\
+	{								\
+		__DO_TRACE(name,					\
+			TP_ARGS(args),					\
+			TP_CONDITION(cond), 0);				\
+	}								\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_branch_unlikely(&__tracepoint_##name.key))	\
@@ -285,6 +304,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)	\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	static inline void __rust_do_trace_##name(proto)		\
+	{								\
+		__DO_TRACE(name,					\
+			TP_ARGS(args),					\
+			TP_CONDITION(cond), 1);				\
+	}								\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_branch_unlikely(&__tracepoint_##name.key))	\
@@ -339,7 +364,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
-	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
+	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
+	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 
 #define DEFINE_TRACE(name, proto, args)		\
 	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index ff5fa17a6259..0557626b6f6a 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -76,6 +76,13 @@
 #define DECLARE_TRACE(name, proto, args)	\
 	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
+/* If requested, create helpers for calling these tracepoints from Rust. */
+#ifdef CREATE_RUST_TRACE_POINTS
+#undef DEFINE_RUST_DO_TRACE
+#define DEFINE_RUST_DO_TRACE(name, proto, args)	\
+	__DEFINE_RUST_DO_TRACE(name, PARAMS(proto), PARAMS(args))
+#endif
+
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
 
@@ -134,6 +141,11 @@
 # undef UNDEF_TRACE_INCLUDE_PATH
 #endif
 
+#ifdef CREATE_RUST_TRACE_POINTS
+# undef DEFINE_RUST_DO_TRACE
+# define DEFINE_RUST_DO_TRACE(name, proto, args)
+#endif
+
 /* We may be processing more files */
 #define CREATE_TRACE_POINTS
 
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e0846e7e93e6..752572e638a6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 708ff817ccc3..55f81f49024e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -54,6 +54,7 @@
 pub mod sync;
 pub mod task;
 pub mod time;
+pub mod tracepoint;
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
new file mode 100644
index 000000000000..c6e80aa99e8e
--- /dev/null
+++ b/rust/kernel/tracepoint.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for tracepoints.
+
+/// Declare the Rust entry point for a tracepoint.
+///
+/// This macro generates an unsafe function that calls into C, and its safety requirements will be
+/// whatever the relevant C code requires. To document these safety requirements, you may add
+/// doc-comments when invoking the macro.
+#[macro_export]
+macro_rules! declare_trace {
+    ($($(#[$attr:meta])* $pub:vis unsafe fn $name:ident($($argname:ident : $argtyp:ty),* $(,)?);)*) => {$(
+        $( #[$attr] )*
+        #[inline(always)]
+        $pub unsafe fn $name($($argname : $argtyp),*) {
+            #[cfg(CONFIG_TRACEPOINTS)]
+            {
+                // SAFETY: It's always okay to query the static key for a tracepoint.
+                let should_trace = unsafe {
+                    $crate::macros::paste! {
+                        $crate::jump_label::static_branch_unlikely!(
+                            $crate::bindings::[< __tracepoint_ $name >],
+                            $crate::bindings::tracepoint,
+                            key
+                        )
+                    }
+                };
+
+                if should_trace {
+                    $crate::macros::paste! {
+                        // SAFETY: The caller guarantees that it is okay to call this tracepoint.
+                        unsafe { $crate::bindings::[< rust_do_trace_ $name >]($($argname),*) };
+                    }
+                }
+            }
+
+            #[cfg(not(CONFIG_TRACEPOINTS))]
+            {
+                // If tracepoints are disabled, insert a trivial use of each argument
+                // to avoid unused argument warnings.
+                $( let _unused = $argname; )*
+            }
+        }
+    )*}
+}
+
+pub use declare_trace;

-- 
2.47.0.rc1.288.g06298d1525-goog


