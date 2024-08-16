Return-Path: <linux-arch+bounces-6248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A854B954784
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 13:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD05E1C21722
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5F1B86F8;
	Fri, 16 Aug 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7EZps9A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6E1B582D
	for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806515; cv=none; b=eYj8WtrCFNXxnub4vh71e4M9gi/H1+/LQrLPlHoyNGVC5mxZGMSUwDHcmpdc65yjZYm2/S3zqJDbBZ+azaa/qOfae56jR7FD6aG40AYalTjR/y6u+B+JBgQD15r4ZuohwFHliZCkUXaOd4nV5uhZRgXq8Nk8nMCvXIV7R654Smc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806515; c=relaxed/simple;
	bh=eqhw7ynCkyqRTBYr25akl57ew2XiOS3KqCJmdV1FKbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJBh4kPTR5IFETQkxmBRo7Vwe7PFeU9upF/Xd9cNITASx5rnkewyRKn1ob5EOJYU1PWTZjgCqRRRl14a5KzO/W/5Dtyg07Wl0FzO3PWpHGXU6ux3TPxHTkU4Kwq7aj+Iko26FOJhlqd+q8JwBxbn1nJ61ZT4NYnK8BWeDSVNwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7EZps9A; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e118098bdb0so1581851276.0
        for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723806511; x=1724411311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kYdvblUgw1OrOR7Jj8FoRwUp6cU/heH8TLgLEsBdOM=;
        b=N7EZps9Abc9AOPqWBcnvkBndrmTRAVQE5uow8FzUYA7rWT8iuwOYgQZ/OYTEVJXvst
         Ln3saNBzdZ7sJMJ/alUNOpMf8nU6TuxOBYdTNyfWXEpxRICi73/GWKl9LCg0e/XNVSM8
         1T2xZ/KthfyfAUCsLdjtU++w+t+ItHKLUO0sIGmEQg6DB/C35lXSVAg4S26uNDLpNMmx
         1nQOMdKu+Ns80RE50VYMzXXqJb8PIQIBoh6YIIFeCggZFLeL2kChwUE/iy7Mn+tKDgab
         pLDVSbuZcv2IlYoOp+XZwmdsAHXej6f9aREooNlvugVS7RfwJ8GgPIzndrhgWNv94n1z
         455A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806511; x=1724411311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kYdvblUgw1OrOR7Jj8FoRwUp6cU/heH8TLgLEsBdOM=;
        b=AJFX+HxKfgLW8jRDhHjgpQ8FfIDpzae5osCAVFQJ5wBXLZQoxJA6APVo9HNipfpQ2y
         4Xb8QB5CnepCDGKvgfc1x0SBij49JSazwNBGQ7Q4lZs1wqjlMmsnm+e5bM9KbCp5KBCa
         40TL1gCpPwBXyvadbJekZ647wPhPIZjcgpkttQYwv92a4dlFr5apmTnGlHKuXaJIFRc2
         WTPNuzTN8PQA9hr/hL12Nvcojq4DK2iuWGrr+ybEoPFvntvLjdtJJ5oWews4E4vlgFL0
         sNG/YtWIDTdMxK8uD3bwEC9Es7Z62QauZECkF66tJoP0r4WkcvMJT6L2Df1ajA4P7pbu
         SDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMBM/x887UiViK0ZFlU2W7TIh0lMCzLZRi8rNAJpsjvFDQTfkLxP/EvmiT1gJ4tEeLZJmbwIE4PQr3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NuTt2aDdTnOydX/k+fbazxH7gWH2TF2pcl4fE/0bp0gopELd
	XIYUUFezfCsBs34sPsNrSF9B2EOFiJBGpMJKrSDVoQRZcDBh1xGNq8cB5DL9B4z6JheKCsCotqc
	iAHhA8LuOcfCuag==
X-Google-Smtp-Source: AGHT+IHHn3SbNiaCXJVjGPZrPAeS795rmnbHQkIGg2oTGHUByE9noAMpW2KQu0mkZPJ0Vqp6E7Vjez3yz4VfD7s=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:c7d1:0:b0:e11:623d:874 with SMTP id
 3f1490d57ef6-e1180e6098fmr50843276.3.1723806511454; Fri, 16 Aug 2024 04:08:31
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:07:42 +0000
In-Reply-To: <20240816-tracepoint-v7-0-d609b916b819@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816-tracepoint-v7-0-d609b916b819@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8293; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=eqhw7ynCkyqRTBYr25akl57ew2XiOS3KqCJmdV1FKbU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvzMfcXLQpUYwewTAhsSdNWmokGVZvVA8EJG//
 aC62ZEklIeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZr8zHwAKCRAEWL7uWMY5
 RoZHD/9KDdVUP3BBgQ8pSdZ3eJOAhx3HVdp/bSXL+MXcHSRDrSDIsJwxRWZS60hr6EtwT6AurLn
 UPla/AqD6Oay++sCbgaH8VLUixf+Tbvt7yuogvGmQZWZNTHWTJDEc7r7qZQ59/R1jI/PupK3IZ5
 WAKHPbXBDCc1TSWmWKgCFLofieTPsG6pwHc+YnT24Cvn0VDvTF1OGXGhR1ekG2wj4rGEoIzzJj8
 s0exuGT7OLyWPcxq2VBhvcWcxbplSMH3JfAhlhEIZ42Cf9mKPcSIZZYz+6VFdiCQDNMXfuP3B9J
 8KwdUNCYWQpJaNnDIQUJuUGCmngfihTxD8GOr/qT2p2xdPfLiSmaXHlmNBJ7+xdHCwFXZbaq6KF
 BbD9z1HOS3dl2AdojQ32VfZPxSruVbQpUqw5oQpLhm2qZafOgiQBCJtxBSJm8Q/XmXjDSu9qu0F
 iPWOoS0lzTbWgbZN5Aje/U+aRPjdSm2CvTOXMzPyf/FsfsvBnpDucB5mAJffbfo+3yYunvJBkCr
 rDQbQiObpHhbXbEBg4y6KMY83Load++HUKIJRkrniazwGFJnMUFvqMrN/Hk2gQuAQNbp8fvd93b
 +NGHq0nYPgGFl3/jed1TAWrgBirpddAnt31c3ls16hHqlKFV/OG1ygnWvnSfgYhxUF/djO7+BZx 9GKLEuK+9ku6UiA==
X-Mailer: b4 0.13.0
Message-ID: <20240816-tracepoint-v7-5-d609b916b819@google.com>
Subject: [PATCH v7 5/5] rust: add arch_static_branch
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

To allow the Rust implementation of static_key_false to use runtime code
patching instead of the generic implementation, pull in the relevant
inline assembly from the jump_label.h header by running the C
preprocessor on a .rs.S file. Build rules are added for .rs.S files.

Since the relevant inline asm has been adjusted to export the inline asm
via the ARCH_STATIC_BRANCH_ASM macro in a consistent way, the Rust side
does not need architecture specific code to pull in the asm.

It is not possible to use the existing C implementation of
arch_static_branch via a Rust helper because it passes the argument
`key` to inline assembly as an 'i' parameter. Any attempt to add a C
helper for this function will fail to compile because the value of `key`
must be known at compile-time.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/Makefile                           |  5 ++-
 rust/kernel/.gitignore                  |  3 ++
 rust/kernel/arch_static_branch_asm.rs.S |  7 ++++
 rust/kernel/jump_label.rs               | 64 ++++++++++++++++++++++++++++++++-
 rust/kernel/lib.rs                      | 30 ++++++++++++++++
 scripts/Makefile.build                  |  9 ++++-
 6 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 199e0db67962..277fcef656b8 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -14,6 +14,8 @@ CFLAGS_REMOVE_helpers.o = -Wmissing-prototypes -Wmissing-declarations
 always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
+always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/arch_static_branch_asm.rs
+
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
 obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
@@ -409,7 +411,8 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros --extern bindings --extern uapi
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
-    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
+    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o \
+	$(obj)/kernel/arch_static_branch_asm.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
 endif # CONFIG_RUST
diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
new file mode 100644
index 000000000000..d082731007c6
--- /dev/null
+++ b/rust/kernel/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+/arch_static_branch_asm.rs
diff --git a/rust/kernel/arch_static_branch_asm.rs.S b/rust/kernel/arch_static_branch_asm.rs.S
new file mode 100644
index 000000000000..9e373d4f7567
--- /dev/null
+++ b/rust/kernel/arch_static_branch_asm.rs.S
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/jump_label.h>
+
+// Cut here.
+
+::kernel::concat_literals!(ARCH_STATIC_BRANCH_ASM("{symb} + {off} + {branch}", "{l_yes}"))
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index 011e1fc1d19a..7757e4f8e85e 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -23,7 +23,69 @@ macro_rules! static_key_false {
         let _key: *const $keytyp = ::core::ptr::addr_of!($key);
         let _key: *const $crate::bindings::static_key = ::core::ptr::addr_of!((*_key).$field);
 
-        $crate::bindings::static_key_count(_key.cast_mut()) > 0
+        #[cfg(not(CONFIG_JUMP_LABEL))]
+        {
+            $crate::bindings::static_key_count(_key.cast_mut()) > 0
+        }
+
+        #[cfg(CONFIG_JUMP_LABEL)]
+        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
     }};
 }
 pub use static_key_false;
+
+/// Assert that the assembly block evaluates to a string literal.
+#[cfg(CONFIG_JUMP_LABEL)]
+const _: &str = include!("arch_static_branch_asm.rs");
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(CONFIG_JUMP_LABEL)]
+#[cfg(not(CONFIG_HAVE_JUMP_LABEL_HACK))]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        $crate::asm!(
+            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
+            l_yes = label {
+                break 'my_label true;
+            },
+            symb = sym $key,
+            off = const ::core::mem::offset_of!($keytyp, $field),
+            branch = const $crate::jump_label::bool_to_int($branch),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(CONFIG_JUMP_LABEL)]
+#[cfg(CONFIG_HAVE_JUMP_LABEL_HACK)]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        $crate::asm!(
+            include!(concat!(env!("SRCTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
+            l_yes = label {
+                break 'my_label true;
+            },
+            symb = sym $key,
+            off = const ::core::mem::offset_of!($keytyp, $field),
+            branch = const 2 | $crate::jump_label::bool_to_int($branch),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+#[cfg(CONFIG_JUMP_LABEL)]
+pub use arch_static_branch;
+
+/// A helper used by inline assembly to pass a boolean to as a `const` parameter.
+///
+/// Using this function instead of a cast lets you assert that the input is a boolean, and not some
+/// other type that can also be cast to an integer.
+#[doc(hidden)]
+pub const fn bool_to_int(b: bool) -> i32 {
+    b as i32
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d00a44b000b6..9e9b95ab6966 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -145,3 +145,33 @@ macro_rules! container_of {
         ptr.sub(offset) as *const $type
     }}
 }
+
+/// Helper for `.rs.S` files.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! concat_literals {
+    ($( $asm:literal )* ) => {
+        ::core::concat!($($asm),*)
+    };
+}
+
+/// Wrapper around `asm!` that uses at&t syntax on x86.
+// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
+// syntax.
+#[cfg(target_arch = "x86_64")]
+#[macro_export]
+macro_rules! asm {
+    ($($asm:expr),* ; $($rest:tt)*) => {
+        ::core::arch::asm!( $($asm)*, options(att_syntax), $($rest)* )
+    };
+}
+
+/// Wrapper around `asm!` that uses at&t syntax on x86.
+// For non-x86 arches we just pass through to `asm!`.
+#[cfg(not(target_arch = "x86_64"))]
+#[macro_export]
+macro_rules! asm {
+    ($($asm:expr),* ; $($rest:tt)*) => {
+        ::core::arch::asm!( $($asm)*, $($rest)* )
+    };
+}
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 72b1232b1f7d..59fe83fba647 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -263,12 +263,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit
+rust_allowed_features := asm_const,asm_goto,new_uninit
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
 # modules case.
 rust_common_cmd = \
+	SRCTREE=$(abspath $(srctree)) \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
@@ -318,6 +319,12 @@ quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
 $(obj)/%.ll: $(obj)/%.rs FORCE
 	+$(call if_changed_dep,rustc_ll_rs)
 
+quiet_cmd_rustc_rs_rs_S = RSCPP $(quiet_modtag) $@
+      cmd_rustc_rs_rs_S = $(CPP) $(c_flags) -xc -C -P $< | sed '1,/^\/\/ Cut here.$$/d' >$@
+
+$(obj)/%.rs: $(obj)/%.rs.S FORCE
+	+$(call if_changed_dep,rustc_rs_rs_S)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 

-- 
2.46.0.184.g6999bdac58-goog


