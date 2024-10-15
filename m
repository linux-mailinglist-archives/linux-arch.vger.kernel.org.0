Return-Path: <linux-arch+bounces-8176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D807599EC8F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F3C2839F3
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED581FC7E9;
	Tue, 15 Oct 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCJ5Dahx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A51FC7CC
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998140; cv=none; b=rAI3ynFRD/XmkUiE5zFB8ZRPmnXLcw/Vi6gUGpgtcne08ASq5nip1+R/NMSllVzModK3CY+OtbSDvwBIxughvvli99BM9Y1Q8h582QaMw4YMEMZ2RMXSTTfCVi/ybzuwC+daTU1yKQvb3sZDYab3VxgKwpzkNaSe/fVCb5BANH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998140; c=relaxed/simple;
	bh=eK3QPWJfPHsQ0D+Mv4+pB9b02dDVotmmPYxMSSgJtx0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ljx3N7TUKnK4izKv0Yn+dsisQxikD8NBwGf1j9BACxfHsfHaI9Yr6aLEMdHj7S7jJU9CumKmUcVKCwjfliylD73F19yBD1USgNSOdFP8j02v533xn5KJTKHnfBgAit6GO+EqeYuw8FZ/bRaJyeI2tSOGlk+qmwovtdTV+RovrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCJ5Dahx; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d462b64e3so2179717f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728998137; x=1729602937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyXoFCzw05lDye/rmen1tIcE8JZP+/sHWOh99jIK40M=;
        b=wCJ5Dahx3cRFBGW+1xRmEd3O0F/W3JnP/b7ccydVHt55vIVpRZdKZom7F5eB5FbyRD
         8y53qaj6klo+EqaxLFsNiDm1is/RqjngmRGV1Kf0OlosjIO8nGviGRB/KkepAsrnFhKT
         REMSupuMHiY/pfC8TLlmX7QQ/pbTEl588eibmm+G6u8i84VLMZTkGtS+5RtANPuk99c0
         5ro1mkx9DvK7GCd6x1XlBfJir9PMo835E7yaDoYGnOiOlwxebiH80j7wBVV2+jf4IPHt
         v/cduzN2AUhc6T1BZdKuWhDbVHNbLkHyZ1ZTRYNJnRqYE/qeVKIqQtJLet+g3JXNxw8/
         4wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998137; x=1729602937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyXoFCzw05lDye/rmen1tIcE8JZP+/sHWOh99jIK40M=;
        b=Dz8Wl0RwPnGiELuDY78K5CbFAjBiAepBGllVjGr3MVG3tMmXmlNswovWRFeRWoyzeW
         liuDZQgc63hTVJoCc+o62MLaT8BNAEJtvLEcAB17QApZEkTOLTfO3uTut0RbcH4GuIqG
         fMqceY9ZcHHyx5iXH6i/A4tNXrNWnQe5nk4CttFwviZA/AUyDdHBFrN1iEesmeVJsY6I
         JZmbKh+Q1+AolLB6XooUYNMdmLxjD+UTf4qB1Sio+YiytJN+52I5akFVYX+jxuEStxVd
         RpSRwhd8DUhB3scZ6AI0ENCRC4LGyQfhbqPDS29Xo2oblaAI9N7MS2YZFjWHfOw5KjNg
         l/zw==
X-Forwarded-Encrypted: i=1; AJvYcCUtPu5R6GMiKaGJb7D/QWGKNRJdP7MwZ09BzG1lfwydfeD/XbYVNcF7ChiuNM6sMF+srQssLFn28fHc@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyayxvUBHEjJe8ywywQCB1U3bAKHJ5Lk7NkjhDvsB4gae0fac
	xE2CaUqOJu2l3jo7g/2yWtL4rKFQ6MSHtTHyrUdvY4QmaZWzsLWEKSwrLXdKiNAHbN50DZmDtel
	Na8DR/Jy88dwtEA==
X-Google-Smtp-Source: AGHT+IFm0lWc1N/mvNw1XRwFO/PNPGxKC3RoH8/5lztACjdQRe/HDR9ClwhwQXuTbmWWoxd56NVX3u34WuN4Sjs=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:adf:ed92:0:b0:37d:4517:acd9 with SMTP id
 ffacd0b85a97d-37d86bcea72mr76f8f.5.1728998136586; Tue, 15 Oct 2024 06:15:36
 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:14:59 +0000
In-Reply-To: <20241015-tracepoint-v11-0-cceb65820089@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015-tracepoint-v11-0-cceb65820089@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7671; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=eK3QPWJfPHsQ0D+Mv4+pB9b02dDVotmmPYxMSSgJtx0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDmroDm6b7V28j2nRc7TZeHER7PPsv7oFqHjEH
 hCgX/lAAaOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw5q6AAKCRAEWL7uWMY5
 RrerEACmXGfHNGP8+1pSkor956lZWl2S/mXh8Q3Dqw31pE/jG09VNUXpRUWgqSb04l+AlnvNs/e
 YipBq+c25SyGuq4DLpl5apMS7H94vGUkdeeXFRgtORE6xswH+8C6ZQJmvNrdSRKcS5VGnpVnOVk
 GBpYLACnqBbLpFC+O7Z3Zv0Vn6wHc/NnJpzRB+9u1QwJLEiQvfbCSg4yIavrM4vrjSAqjelfUYu
 80nBkSoJYyLjq0FnQWKowST/EKxRqDhSKWFyCxMNH76Yp/G26N8yRGP0pxVF18pFsoX9kAB75ns
 0wwXQ3ojU6lEFuoMduTRysO8mq0Y2Bjl6rV9hk9YmZqQKTBfMvP+6/VpH3Ru3VZA8jnSP55LLa4
 OgQPL7bWoz681/Ok1bcvQeG80SjH6ZQHtD4kZDJWCUQfeX1flRACM6Tw0neU0bAEadLym/nBer8
 4SCcqjZD0RpdfMGtBQvktz21gfCu6GqJEW0ZQcJx4C7c+lLVaeJJ0QL3zyjintLAhqKM4k05CMR
 hKcTxpdj3e/O+p61aDbv0dDVRfc8toPM6H0OccOq3uCKtmrnOdWZIt9QUWCEpMs7PS5cYtGaWnw
 UAqIv+eOZ9X0gDezMTfrCHgj+ZOZUA6V+hoKjkKMYiawCo1XxMgHLCA1yX+M39lG6etiwj9Ft7P sYCJRWafAsITgmA==
X-Mailer: b4 0.13.0
Message-ID: <20241015-tracepoint-v11-5-cceb65820089@google.com>
Subject: [PATCH v11 5/5] rust: add arch_static_branch
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
 rust/Makefile                           |  6 +++++
 rust/kernel/.gitignore                  |  3 +++
 rust/kernel/arch_static_branch_asm.rs.S |  7 +++++
 rust/kernel/jump_label.rs               | 46 ++++++++++++++++++++++++++++++++-
 rust/kernel/lib.rs                      | 35 +++++++++++++++++++++++++
 scripts/Makefile.build                  |  9 ++++++-
 6 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index b5e0a73b78f3..c532f48b79de 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -36,6 +36,8 @@ always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
 obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.o
 obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
 
+always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/arch_static_branch_asm.rs
+
 # Avoids running `$(RUSTC)` for the sysroot when it may not be available.
 ifdef CONFIG_RUST
 
@@ -424,4 +426,8 @@ $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+ifneq ($(CONFIG_JUMP_LABEL),)
+$(obj)/kernel.o: $(obj)/kernel/arch_static_branch_asm.rs
+endif
+
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
index 000000000000..2afb638708db
--- /dev/null
+++ b/rust/kernel/arch_static_branch_asm.rs.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/jump_label.h>
+
+// Cut here.
+
+::kernel::concat_literals!(ARCH_STATIC_BRANCH_ASM("{symb} + {off} + {branch}", "{l_yes}"))
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index 4b7655b2a022..2f2df03a3275 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -24,7 +24,51 @@ macro_rules! static_branch_unlikely {
         let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
         let _key: *const $crate::bindings::static_key = _key.cast();
 
-        $crate::bindings::static_key_count(_key.cast_mut()) > 0
+        #[cfg(not(CONFIG_JUMP_LABEL))]
+        {
+            $crate::bindings::static_key_count(_key) > 0
+        }
+
+        #[cfg(CONFIG_JUMP_LABEL)]
+        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
     }};
 }
 pub use static_branch_unlikely;
+
+/// Assert that the assembly block evaluates to a string literal.
+#[cfg(CONFIG_JUMP_LABEL)]
+const _: &str = include!(concat!(
+    env!("OBJTREE"),
+    "/rust/kernel/arch_static_branch_asm.rs"
+));
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(CONFIG_JUMP_LABEL)]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        $crate::asm!(
+            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
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
index 55f81f49024e..c0ae9ddd9468 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -148,3 +148,38 @@ macro_rules! container_of {
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
+/// Wrapper around `asm!` configured for use in the kernel.
+///
+/// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
+/// syntax.
+// For x86, `asm!` uses intel syntax by default, but we want to use at&t syntax in the kernel.
+#[cfg(target_arch = "x86_64")]
+#[macro_export]
+macro_rules! asm {
+    ($($asm:expr),* ; $($rest:tt)*) => {
+        ::core::arch::asm!( $($asm)*, options(att_syntax), $($rest)* )
+    };
+}
+
+/// Wrapper around `asm!` configured for use in the kernel.
+///
+/// Uses a semicolon to avoid parsing ambiguities, even though this does not match native `asm!`
+/// syntax.
+// For non-x86 arches we just pass through to `asm!`.
+#[cfg(not(target_arch = "x86_64"))]
+#[macro_export]
+macro_rules! asm {
+    ($($asm:expr),* ; $($rest:tt)*) => {
+        ::core::arch::asm!( $($asm)*, $($rest)* )
+    };
+}
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8f423a1faf50..03ee558fcd4d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -248,12 +248,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit
+rust_allowed_features := asm_const,asm_goto,new_uninit
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
 # modules case.
 rust_common_cmd = \
+	OBJTREE=$(abspath $(objtree)) \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
@@ -303,6 +304,12 @@ quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
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
2.47.0.rc1.288.g06298d1525-goog


