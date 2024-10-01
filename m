Return-Path: <linux-arch+bounces-7515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6A498BDAB
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570C21F21A71
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023991C462A;
	Tue,  1 Oct 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqOPgDmD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC61C461F
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789438; cv=none; b=bIcxIUGgK57UNVdZrzyLunzEbT5KO7I/uMxNKuHqW8ZwhyXMDkMeWrbqeMVXiBY/Gn2VSYKAyTbBCwpc8NgqY+3jR4pWJpcmf9JtI/QJK7sUlaM8O0RpEtrJ4pihivMMW2E7eCP4EmZVPDhFCbVpfRZPlWKSxfjdlxaSbhVvkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789438; c=relaxed/simple;
	bh=QAR3+Uf8S8g4ti0ixSbviLuiwMUo5f4YoL+bKjncXao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JjeADnfsvmlwAGRypvgS/9fnphu5wzMnfgXqmTBayrD6zW8HOLfBkhQnzadl5NcnZXflXepy4M54BjeiqSSsuz3DpgzXjmBCVJgn6/Bc0hmk5lJsk5YYE0MpNHSkaqV26KuoSwGmcYg2MQvAiTM/SVZnv6LwqwESk8Ibz0wJ8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqOPgDmD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28d223794so24334727b3.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789435; x=1728394235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHT7RCQWh9VJMF8oIXuBP7+2LpYWya7O6BZRCiI/HOc=;
        b=iqOPgDmDozx4UCSBbSRSKuahjVjNUKuTA3S0oUBSAPUjw3ttXO4Kpc7MGx0p8HEb6Y
         Puf28Cn5PKe90esTQ8MH7PdP3c337wlO78QqdtdeTkDQHuw4C8SjG4MHrgBr+Vxxyl8U
         KasTwMCiyKfBD4MugmLbJCWA/ir/SRMFd0iS44D8qi46s12imVe5tRm8BRokYaJhU9cw
         nd/G2kstMD8jmo9anl5+2bmDcmlBTwwInT86BAdbVDE6sROlxGEeksCOnazuwQ1eV3G6
         1x6V5r1B5XfC5gDdbhQc4ernWT+SGbbLYBDB9uWdpMCUU46g17QVw6GXIBrStxkHLwUp
         lzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789435; x=1728394235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHT7RCQWh9VJMF8oIXuBP7+2LpYWya7O6BZRCiI/HOc=;
        b=TAAby1irr5CB9xcOhEUThztE7ZZgUYG8PmLaT/7pxlg5q1VpiiUbrcvQbAcGcolq4v
         76SvKvTpB8wdShJaF1/867TpUDOAEGvjiSTOnD6KESDSdE7/MiAar+LOoJ/3WZ1OPI40
         FL4H9gc6x0XIxhYnBLo/j/NugwKj8dP2LASyYVIXx2znJVp+t9rQ0Zsqv2Zs2USx9bkn
         +VVBZaR8TTCyq8elSNQykqGDPVpJlxynh+c5G2Gc6ulpN6vvoStfXx7OuyXJjnb4E1SV
         u0quapGex59iTWmWtnWv+DsTFoflk+Uc2+O0PeykKvPXrp6x4kFlxSDGrsulXdg0fOvx
         zjQg==
X-Forwarded-Encrypted: i=1; AJvYcCVofOXVqUVWuivqTzuwmhLYxMNWiLQS/IsbRvOllYRTauYsc+CrStFgPjUHS7hqAPnVDEfN3IKFXsFE@vger.kernel.org
X-Gm-Message-State: AOJu0YwhysMD1Fr4mJRaP/N2db8FBlmMss3IToBNMtxYM7n4beNsUd05
	8V1vsNVLnT7vQaHh6DVIhlOtHWOiuUo/oEs61ahMdUpmS04vS/KrC+0fN2fMCr6yKEX2OKoIe3M
	98iwbh4iH6ggj+g==
X-Google-Smtp-Source: AGHT+IHkTUHVo8ojrSDPAhDaM/l29E/UDPZXNOXZHUGDN5vnnYr5okPT46k0myzDL6E14UX9F+O4B3eF5tiFWOE=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a81:e349:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-6e2473994camr609407b3.0.1727789435216; Tue, 01 Oct 2024
 06:30:35 -0700 (PDT)
Date: Tue, 01 Oct 2024 13:29:59 +0000
In-Reply-To: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6914; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=QAR3+Uf8S8g4ti0ixSbviLuiwMUo5f4YoL+bKjncXao=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+/lwLLpJIPmK9F6nIFaq3qeHRS41Xthj8IwUL
 +dYfwevd5iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvv5cAAKCRAEWL7uWMY5
 RnHND/0e5/swnUVhsY9o7C6VXyx98GKYvW6h/sOOvEpHwRdKaw7MsuphOCFBlp3GridSl2CdREw
 kp/PCwtrSdI6P4EfmhKrH1U+QG6MJA12aikTzwudkUJxgWL2jyadrWeeUpRuafUBS4oshCCbVAR
 56k1blE8NbJ4OJIttcUHPn2QkleaQdVFQNlZtzLRbtGdXUPMQvARAJENhTDyFqjFrSFQ5Nw/1md
 ZbD6ky8sXA1sGw0ZKaMOlxcaB7UM7oKYmxP0rg3JEtuMyVPRGTrxkJqWZUZhL9bCCQSRfWvxwuK
 PC2/p7aRxTIBBqTRYRKOIE1FhTqDXe+cbzeY5awE4vH+8ybFrIqkJ4HAyc7o1+SoqDqnOEU72tE
 OG6obmjo9io0JpBu/CFoyxUimdW1TVmPWanZY2koIXdKJczPx1y+xn6d8MKqcbdfKSE8IXdtpG6
 igaZwliGMBU9wxPeRJ2NAlqCcH/oIaODqDVLCz+IM0jbkAuTnLtqpjyR+2R3EgtaC7cjVnpZDJl
 c6pK13s+xQNGHg3LmwKHj+oEvRGGG/G/iR7aMe9BcvzrXgeKqlAWuHZh+f9QEVRa/78GBgcOAP8
 7Fg1csdkSMxBpFtgmhkmd1m61D9+nWPaZyBtreeMY/NNAtHZT0vYpal4VB7VBNDsxdQnKiAYd7M DCPx0zC4o9ThG/g==
X-Mailer: b4 0.13.0
Message-ID: <20241001-tracepoint-v9-2-1ad3b7d78acb@google.com>
Subject: [PATCH v9 2/5] rust: add tracepoint support
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
 include/linux/tracepoint.h      | 22 +++++++++++++++++-
 include/trace/define_trace.h    | 12 ++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/tracepoint.rs       | 49 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 93a9f3070b48..316cb046653d 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -257,6 +257,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
@@ -272,6 +284,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
@@ -356,7 +375,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
index 6dfafa69a84e..77610e19df96 100644
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
2.46.1.824.gd892dcdcdd-goog


