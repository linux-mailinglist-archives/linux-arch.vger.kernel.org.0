Return-Path: <linux-arch+bounces-6245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B5954773
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DAD1F253FA
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E71AED29;
	Fri, 16 Aug 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8+KafJA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6E19F499
	for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806508; cv=none; b=YH/lscNHAb12MI4TCr5X3nJCqBcm2UzZ+BiyRdKWy8jr56QJLvcZdhAEPKmA5rQPBILITyuSnhzvSM1gTCBSftfmCOoZHh1CUUB0F0OIptqs8+sgOpM4jcqRrNpPrEQEv/8tM1fzIDHjd/8DKYvWHRkO1jJjDPBlsSpvz4yLpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806508; c=relaxed/simple;
	bh=mbr+t2kdtAR0gaGGgahPyE7BcbfXEyne0mHE/YfAoMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bstiw59GeW5bwH0fosKE4UIYvjY9tjgsB58xV0TqbZk+5HlSyDnsvM5oEkYJZreUCplcg7QB17quOXCjOFNiqSQIfTbH8IM89JY+1o+2GnItaI76KZKn6mCx/jDw/C0JwprTpBqB2NQZX4ybncvhc0AI3kyR5wfznzq599O2noI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8+KafJA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650ab31aabdso27410867b3.3
        for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723806504; x=1724411304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8cDHUaReumSMCOwyu04+mqYJDxHlzEMGiEzz4YHS0I=;
        b=l8+KafJAX+BuLRXc8kBvwwvZXecSAxT/zREOn480lVeSQ8CObESlFTs1K7PV6OdxC6
         OeVbfXxMl+ML2QqpvHuW3mTEdel+LhH4C8khQeu/crBC1qg94dxr/oGlhemrxKSr0Alp
         YD0lVOXVFzBDP2hFMpZ02tz1Q7uW960P69PmAWiyapH4kYZa8BnJHns7ARRdP0vb35M1
         dRDLBwt8vQTura0WnKKORU2nKXjvC/4AsIhLKNmbGN/+Aj+5uu/mRg7EyIM9TiVo885B
         QvGKLGkx2aez2b1hUKFzBGe8/3Feaus0yj789i61wHR4/l6BxbIvHOg/Dr/wj6zjFKY3
         WB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806504; x=1724411304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8cDHUaReumSMCOwyu04+mqYJDxHlzEMGiEzz4YHS0I=;
        b=DZ+0aE4yhURqVV8Ksj29f6a+sbUCbikDIl/ppC5kO3WXjkgMZQabReCSNL9E+K6Foh
         CQh9V9KTqbcsOXuB3iODzghNY17HRPDiqhw7i5C5E5Cyi0VWco7Q/oKqVEkNl6faOtrY
         DfurhKBTBnVVykL7sfS94jAP5wZLibJdnD1zNTb+Cq/ET9kU+C4H3RdoKCmHz4wYCwA9
         5WhU62AkkE6r7FfOfdCrCT+7qu3OQkuW5fM7qAjf3GbRihHh8odmx1ViSeh4C60i0/Qc
         ZjeqRNN24deM252uXCdGdEeXgKJPDl50m9ZVg6GxrTYnmcy86f13K/mlFI4KFMkOs89J
         gBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDFnSHHZW33wzLYu6AaTx/m03qx/JRnkXS437eoGrFxQ+O1u6+4Cki+2IYjG0Lu4BTu0Hjp/kEtbs7OsSqJfkjPv9yoak6BJIbAQ==
X-Gm-Message-State: AOJu0YynF3yCFQrewJmydAjNnx/QTgIl8aPF+N8IhKhcpOllVNtCz8Ag
	jgABtBQe0PHbIDlIgL5D7VMUzReoUPl3nea6JIHtvvDHfALMA3wkJmzlLSwf93Hu3ozO4dN4ovf
	hxppIO5JxOnBLvg==
X-Google-Smtp-Source: AGHT+IHH8lqqbhavxoP9Vhrf4pidZ6/IQffeAAO7T7zZPPnk0pGCI+CN5pb9fvzDZryrjR97LYdyHBHJxNwBKX8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:7281:b0:68e:8de6:618b with SMTP
 id 00721157ae682-6b1b72af093mr1195957b3.2.1723806503892; Fri, 16 Aug 2024
 04:08:23 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:07:39 +0000
In-Reply-To: <20240816-tracepoint-v7-0-d609b916b819@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816-tracepoint-v7-0-d609b916b819@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6866; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=mbr+t2kdtAR0gaGGgahPyE7BcbfXEyne0mHE/YfAoMM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvzMdw+Rmuw1TZAV/JDQBRFjlFdszXt+U1btzR
 gGP87RjnbOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZr8zHQAKCRAEWL7uWMY5
 Rn4jEACX97xcITEZga8P+ngCFqMoTIOKDVCNcrHpYF1tLAFZDcR9+ZyrndHeCvZol3Ll5q11q18
 kd9BSXFiKXLVSYTY+FqEDInWIquj6oGSWuz0uoyTkHvbQGQ0Tbc/EdWGx5hU11NcUaGjrsxCGqb
 06bAm9AYahSnbpMI87qadxYJ5tjW/eNhxjQU0S/BxReS+m3/rcmLwrpxQKI/HD7FbdSg69OUEnk
 sqJeeZQVy2CyHsoDWpO2TBYkOpi/zuprwTO3+tjl/9fz/CRV4DfcS5CseZnOOiOTHAYSuUGnT8D
 gf12tNcy2PklPmTCrrpsX9w5hfCPU1NR1/7Hg0wMrkBiBZMY35RM5ScaiPJ5joj/eWQHLDbvrzR
 rGWR3OgLMb91wNGe6mXEe3CarzS9pJKXQu5yyIWcHUYtWYHcKNjF4D3BJnG93RDDkAz4ctOLcuz
 uO0S2+nNx56UrOP7QRbqIu1cKaiGl2M5neW1y6n1Bb/n2cH0PYp5xaeC9sQa+ecyzw3Kj1EaBLG
 MSvgcTS9T5/R/wB5AouMqn8j7gVWaz4asQMshftP+tAgmrCFyi7msOEYSvnhTGx2BlNIJCgFt4E
 gOqQJNjdL+HUbc8+sPDOr9q5HGaDikRjs7pZy3nxtLy4Up0Anr58vd4LLaUoxA+gBe6up974yfC CQrWHCnO/UBYrbw==
X-Mailer: b4 0.13.0
Message-ID: <20240816-tracepoint-v7-2-d609b916b819@google.com>
Subject: [PATCH v7 2/5] rust: add tracepoint support
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
Reviewed-by: Gary Guo <gary@garyguo.net>
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
2.46.0.184.g6999bdac58-goog


