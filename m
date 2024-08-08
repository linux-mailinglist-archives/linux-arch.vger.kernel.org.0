Return-Path: <linux-arch+bounces-6118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C376994C39D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 19:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF521F21D3C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC8191F93;
	Thu,  8 Aug 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSdj//9I"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37C1917F8
	for <linux-arch@vger.kernel.org>; Thu,  8 Aug 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137832; cv=none; b=XfwOctxbh5nxuKFx9HJiDu2HQ6Z+9388KjadEJHtI78cQVFGxLL8b0hoZJ5JTGhrqlz8Y05Fhr9XU+aRc5lO6tOcZTjvREF8/3de9GoJ+NnyETYdYGXX95J0AGKU8ZYvxQRFf538klo1qeZuDTNdlIR2uqkFTpzV0YGQR8xCrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137832; c=relaxed/simple;
	bh=ScFhXqb37Sff9tROWdFZiuOFbIagmHmjk+412o40cBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P3Ur6hciXWxXogucNFpYWuDZ/DrLgjZbNRS3Nc+yLe+djEetg6B1E/NXTPzJblOhYeHDK19UvRFIfChuEq4KCh2oEDPoJOpD3SmcxWPOtNZYOS+s8UYA3nDB3yH4CiFv+YKYxjOIfkJBKBMQYbLk88MEDwr/b3v6Q5FSpn2x86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSdj//9I; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e087ed145caso1981322276.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2024 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137830; x=1723742630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2BfL5qwScrigsjrjdMgd0qeyg2ikaATGXdmtZgZMqs=;
        b=XSdj//9I64N+DFDxSvbknsjcA8b7NhIHBdTqD/taeQ+usaSwX4PL79Vj74qT0MA7E1
         qrc5+ykVf8duobuadNbu+59vS0QipT7KhqdhsZji9S52CDbpYJgYGxlE7BH7J3QexE9H
         BgQ487+s2dO1Dw1s0LOB8RGZic4GMquDldlkZclaYwYUk0XhyRuLtssZIK+OeYcCNBzm
         uHkWtdIqnBz/Hjld5ygSNyPQUFbEQ3+szni/7aO+fQoYEFASRSyMUGOymx581dX9VTLu
         TBzYlSIIi5k6KLM8NTE2FpK6U5eZAyrQ5QLGOHXDnvXl99qkCRmWs+3gUUuBbulACmFn
         xEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137830; x=1723742630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2BfL5qwScrigsjrjdMgd0qeyg2ikaATGXdmtZgZMqs=;
        b=UDNFp1a99Iu4gBVcB7U0MFrklLitBPhBZO4jLiz3AKMUH7Fp7QkopYNkSQJ8nzgJJX
         Ma4jnvOFPN3RXNhB8KfyniAI+VEoxg6gAZ+LIRNG2lztUta1ddYFRDaqZP6JsYqj4TRB
         WTVAsNDcPSUn4sc7Ba0t5NENLrtMT348uHJmWXQOlge7razWLOkJmERpOhgy79pVVcRD
         IXLqiPDx9nW/D9rkkyntomU7vTioT2bpNBEHrkS1MoGDaw2vaauW72TP7tGu8VSiHUoM
         izAJphSkgXV1d1hfLvgGs5zoHh1GeU4IY3kPn/ytdcInuetIsO/+6RI4M1BuC7shPxc7
         ReRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnKrvY9hCjz/yycWTvh9D6iRRk6fpH19g3xINC6NDziGTmXtFiZ+oQ/iRqFgkxsXB3X0yWasvaRlEqgIzux+5bVmyeVi/rj9GqaA==
X-Gm-Message-State: AOJu0YxUSZDHSKScDEUj0OSXOfU4PxeBpCbIHBXFYn+GE7neFp84gRb/
	l8SuhV4Dhlm4/VKSB5ldmq0qLrDZ/4hTngoI4uhODSTA4I3XZuoIvpZKmIgiSjfMD4zUzPn93s6
	MR0obRJXuSiofLg==
X-Google-Smtp-Source: AGHT+IFs/QBztwofGn6gdEx9lIRoKacN+f2juIEvrjczeOQ+1VBZECHa8m0Py7oBu3JwuvTxeSxySbI30Na6JbI=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:5304:0:b0:dfb:b4e:407a with SMTP id
 3f1490d57ef6-e0e9dc06144mr100237276.9.1723137829660; Thu, 08 Aug 2024
 10:23:49 -0700 (PDT)
Date: Thu, 08 Aug 2024 17:23:38 +0000
In-Reply-To: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6823; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ScFhXqb37Sff9tROWdFZiuOFbIagmHmjk+412o40cBM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtP8bKBJQzPdHrRNULXgDOiP9J4adZ8/RL3zY1
 TwE9qCPENyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrT/GwAKCRAEWL7uWMY5
 RpH0D/0fxo5D4TfrvpMcRHlO64Kfv3c4LOEheRcCbCJugkos8/63GXm2Ocfb5W+ClDXQlJh8jg+
 CJoPzQ7zfhn3wnmY4DDPtSb9WTwzasXXKrxPrs7tibbH/yCofkcvnXzuABlu0Ul6hlGnvSTZBNu
 GD/JWO4+baZG7hvNMr7vNpdVGX5VsHTGNm6DnsD+DWo6XRd+bPE70COn2MccXdzlDWYBeuCYT3g
 tM0a39nhMhqUnSdcBoAc6zRbtKxM8zk7dki9AhpTF0gYVEeeuxj6xsS1IZ/SknH6ozZtAP9eb56
 4TB4YELJXs4K5JoJxd54kTOBQK+uPoC9HJ2ZbE6QSzZv7VIKFDibIBK+BFndK3rueR0gwLqNjZ1
 wAOVBb5Zgvj4RG5DJJeAWMOFDxSHWulkNkiCm6t9nmFIgTUos8MFCYy4Tq3ZxZSZg5hAjiCGN7U
 micU59j4FQnI1hxZQxN4FbPi5KV2vbxxeFQl6iM8r8/bLNaOKICvTyuf6BrNka3+S//V26PBU/d
 Uu66oMpFnNWc8/R7thO/icIUF75gwBC6Ix6rfueypp/75MuWQZGNMsRpwYCTpho62Nw2Bj5vsy0
 nHEjgNgs+M1/4bf3Vw4JDpFGforqASjYFzvsMstM5fWUQI0nvzWxKxs8NaB28r4Q7myo+j8A1pF YsISQxO7z82a0LQ==
X-Mailer: b4 0.13.0
Message-ID: <20240808-tracepoint-v6-2-a23f800f1189@google.com>
Subject: [PATCH v6 2/5] rust: add tracepoint support
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/tracepoint.h      | 22 +++++++++++++++++-
 include/trace/define_trace.h    | 12 ++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/tracepoint.rs       | 49 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 6be396bb4297..5042ca588e41 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -237,6 +237,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)
 #endif
 
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
@@ -252,6 +264,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
+	extern void rust_do_trace_##name(proto);			\
+	static inline void __rust_do_trace_##name(proto)		\
+	{								\
+		__DO_TRACE(name,					\
+			TP_ARGS(args),					\
+			TP_CONDITION(cond), 0);				\
+	}								\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
@@ -336,7 +355,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
-	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
+	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
+	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 
 #define DEFINE_TRACE(name, proto, args)		\
 	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..8159294c2041 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -72,6 +72,13 @@
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
 
@@ -129,6 +136,11 @@
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
index 8fd092e1b809..fc6f94729789 100644
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
index 91af9f75d121..d00a44b000b6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -51,6 +51,7 @@
 pub mod sync;
 pub mod task;
 pub mod time;
+pub mod tracepoint;
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
new file mode 100644
index 000000000000..cf2d9ad15912
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
+                        $crate::jump_label::static_key_false!(
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
2.46.0.76.ge559c4bf1a-goog


