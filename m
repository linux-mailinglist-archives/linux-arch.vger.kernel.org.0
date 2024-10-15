Return-Path: <linux-arch+bounces-8173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A699EC86
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53216B20D4C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7141FAEE8;
	Tue, 15 Oct 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOrHNuBe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38171D517A
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998133; cv=none; b=MuPzl6IcEGgH81toT29YhNI0xlq9LqpoqzodrxZiAtbDxp2oC5rbuy+cN0dGWcML/AGL+Wi60qWRWjdRSMrON//7NyeRhuCRooekhbBnDouiRNXUy6wgXzRaeaNJFPSYehCAZtx6YbALRXmm0JioT10uSy5CvWCIZ+1d/c7tl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998133; c=relaxed/simple;
	bh=GMLTcVVdmPl90l3vR60nLHEg+YV0m6WjZcRDkYDuaVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTdNrKt5CyLNtRSA5Qj/XcRSJia9sHuZO2jmwemmbCblo1YCuHqhZC0onLdJgNRZIzdJEjGEo+52fNzrqUNFzEnpJO9WfiYOnsGa11KpTtNj3nR/QPVwNuZY2/zy+4t0sdLzmIplb4qG/tX6NaKUH2c8dap0/n03PUTeyrjpCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOrHNuBe; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so8366052276.2
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728998129; x=1729602929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvgr+n6BCCNgQWUs70Ofe8Bn1gFUAza68YbSHBnfTLY=;
        b=JOrHNuBe5CEo3iMcQoalHlpacV0xMTUyZUiqNIEqZen4dwWep3ca4wIug/GWhhmKvx
         AXweaA5EcofbiuKNoWkSKUhTJ5KULREI3km4/X9g00m06qx0bs6HdUhV7kIB1qyS4/bS
         qb3m2WJBTLHA1jNNtT4BZTvIyNFwJRxJI+o676gJdG0H4wO/C4YKvdtOPWS5ITJfpzot
         lzeuAtLBx4CTTuZFcDYIBPqp/Dbj8eBg/wENVpfEAYLuXgp0FwgOl7S6MPBSL7A5y6FG
         w+XyiSGZddLrOzbNmtyQbFg/LBJ4a1bocrxmlxD7X3SFPJzI+YP9sN93AQ00mWbnbzH4
         GGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998129; x=1729602929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvgr+n6BCCNgQWUs70Ofe8Bn1gFUAza68YbSHBnfTLY=;
        b=Ws3/o1uwAGj5G20Opts9i99NlGz3KGleaMt/PtYQstT9g18U9qI7Pa/uFXQjjj/C6U
         F8W6nWSWT9A0FVRJN7sHQ5RsImlHhFp5yYYK8NaE4HqQ7ghtuWa4hMPVMg81e6kDSEKE
         TAg6BO995wwq3anedb5Ng9cFNSAaUINBPseXFVZSQTjkvQ7ZOAuJV5IX5fDEzkHnNQq/
         by9q/YFwnhwe6QmomybRzG31Li0WR8Mae4Z4iqsD194DXW11sIY8m81NC8WWPTDlpaAT
         zpw2Wt+XIiRRFZ3P1uAokMDadqzCcqi3Fredtj+zEvjdnhW4d9XwzUP/XFdodZvNJ4qh
         kWEg==
X-Forwarded-Encrypted: i=1; AJvYcCVKIQBz5x5BM03twxzCttHuelXt36/uQiyaQ1OjlZI7ZFsD7MfzfhDoZ+UeAjOVWmuM1CVVUJkZxF6Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzwT5T2YYIyIUigAEbv2HtAV7Ww6JKMId9vB09odWQbJWIULFA2
	gS5M24JNnkE1l33lzA1pudt/GKsUqHYdqck6X2QPMyRwfo550pCh1WIiIJL4wFYQ5W27iqNLB4x
	D3XitFINlgh46kg==
X-Google-Smtp-Source: AGHT+IH2aipjAuwBfMr6lWsvCGRlG0PFPRVftjjOVqprnLHjHCiydmMQVYwQADN3PA15UjoohsjIs5Ot+NwtIxo=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:d0c3:0:b0:e28:e7b0:ba89 with SMTP id
 3f1490d57ef6-e29782d5437mr91276.4.1728998128548; Tue, 15 Oct 2024 06:15:28
 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:14:56 +0000
In-Reply-To: <20241015-tracepoint-v11-0-cceb65820089@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015-tracepoint-v11-0-cceb65820089@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7835; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GMLTcVVdmPl90l3vR60nLHEg+YV0m6WjZcRDkYDuaVU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDmrmpScs98atPErvy3Y3eDID5B6ICKiw+WaX3
 dd0B5/EcSWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw5q5gAKCRAEWL7uWMY5
 RnB9D/0UA1WuJngFq3RXVOyFVknNYlK5cilfOkXWXwOcoiwZMU6kVx9cPG+1OwA5DfxXhvyvCjv
 6oOSS+gaOV2wBrhGCz5bRclAN3LDMDFwjwfcDdlc7z7KUpJ44fWXi3FHcSvB6hXUDLSXzC361GB
 3rESJnwE7beWBsmzOFPkHdvjSvaXsil0sseYstVZoHs4bVFT4gVRtD/0+64P4CkyDJQ4kpxYK3Z
 he3RpQ1akkRuff0JmCbd50c3smDhO/nHhKal/J1Rx05JeSyaF9bV6+sTGuiiL+IwWyY+MSvCFTu
 GuARc5Cx9bRPG1/U7+V+09IQgApXpjHrAGWXocYntPmyRcLIhNmewXdu0SJJAOKrLqC3/o4m0wW
 UtRk9qxO5wIQs7+cBeW/kG+CVkK7H+BhoGizw/mC7a7GNCLJ+8k7t8Mw2u9ghRyQqRxXYaD8zlX
 BXJ6Z05N+pCHBpOIZGjRBXyDWXeYkbk74RTjbXM7QEYoc++5N2QaeRr+hJxTQN7+h+JxCJlGHR/
 mjvDwccIlqvEPDzuhE4mB327nc10KvLuu6+uCl18YOB5t1vXd+91vLIypq8hyEGDff2zQ29Hyg6
 vzBYqAaxefiiAWIN9sZnUDVQzrzgpqzWwKCXWjog113vaO4y4/2J/8aTDfiuP0dChPs3DuTjwkR sgK5iD1yMaqp1zw==
X-Mailer: b4 0.13.0
Message-ID: <20241015-tracepoint-v11-2-cceb65820089@google.com>
Subject: [PATCH v11 2/5] rust: add tracepoint support
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


