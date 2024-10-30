Return-Path: <linux-arch+bounces-8730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA5E9B68D7
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 17:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449D91F2155B
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECBD21744E;
	Wed, 30 Oct 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmZJWuPm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA6215C42
	for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304311; cv=none; b=lUtvNGQ7hxwE/NuFNOJymYTTELr7ORMAqxWjT8AMQ7bkwB7cljbrbxrqDcoCw2LzSacwlcqnx2Tq1KjlgrjMpB0gAGjKDWZFEgFt6f3IcpBDMeI9PPbrlrovtlieP52raYI4iNoEOApNzHMbQ77v4sebsY7WwW+Rkyi2jKdSpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304311; c=relaxed/simple;
	bh=tEriRl1s5aMKzJQzUep/R+6Ah6Myzoilu5Gt/biRO6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GUQEOQqfRFyjngLplUy09OEx7/GJnRQazF1aj44AzjUU/+xMkTG4DAT/dtJ8qaWoCnHTOCQZ+blCe/iw5SrLrV392QFPeW74TSpGyDcaKeVy78Og63CZJjdrEPAqbBHWnQUGt5uhaqjwqMvXX798BfAhkkL4AWCwg1BKKPyc7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mmZJWuPm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30cf121024so2065732276.1
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730304308; x=1730909108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqrmG66m6B1UCkhHvZIk418M17bGfpbVQcwN/mZmV/M=;
        b=mmZJWuPmy0eZ3G5XAH7HhCgrqwGdjbFehO38Ynnok2hQJUIAT+0xbWmrYFG3SldMZi
         4FfWOvJXZevf6zrB816MafunbmaMQemOkY/lMFJBiCVEwgxB4jBbl+hWpPdGgo7dRw7d
         KLw4a65AfgVLkfOnKPRMTjh7Mi4+QmwtSUkcNUPx4CV11Kaz2PqS/ziwtm8m/3udiZ7u
         fJl+c7oyqtO1RopSyFMHtcOFpsL/Wy8nTS8oIHU1MQ8ZiaWEopJvOMONXSLkIwa0ybAp
         zvtkOoaN5/yXcTmbNmpKrR2MUDaSHdk2vW/bnxGnCI30H+nx6MyA65XwPdU1KNT0tHeb
         zQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304308; x=1730909108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqrmG66m6B1UCkhHvZIk418M17bGfpbVQcwN/mZmV/M=;
        b=mzT75IWesnHTX7Oft+Ne7HbLcz/HyhgV5T4syvyvFCFO4VDWJpVGTmuE23y5p5joWd
         xS4oYX8655SOWUYUobrhFyTz0eAaZ/TYP2uXk2zKj/La8PgBMN5emYibWwi3tuKRy/Io
         p6HRhT0NnGtWKEMV3c55j3I8WKFI5yDVsEgLJsgaP1p5A2jP002tn6UoYGKG+Y/5kDrH
         BhUX4vsYbguOvYQlCfm09fUw/7vAgT/zVbvJ40tUqeaJojD4mpdUPwQ9+aQhrYJ5OqdO
         VstxmcMsYV4Rd+v6WIc1eP5kJqr5qBOH/IBqu6S1DaVv2wrt0XQUHknzk/T+RrcTQgfA
         ++GA==
X-Forwarded-Encrypted: i=1; AJvYcCVDx2U8dmL2OsA4Srym+D6P6urKfLL86WryPgLgjT/UW4qSm9GexPpSODE8nR+VmZ31DjXVfKPX4XwA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno2R3WXaF1JigQhxj4YiP/5bst7cckd15hBezjBT4IP1mMZao
	6Ee8j4zqRASm5a3yd3qEZc6lVX2C3DdUhOg4q1TfYCqfCTdBKCjsDPOByJnhIwF7Enk9lObPn0r
	Ey2hNe/hzPV8prw==
X-Google-Smtp-Source: AGHT+IFi/aR3eZmVoAL9Wz4p5EtnW6YunurLPIJuDUlAryYR3kFyV0YKLO6vsDSY51xhlGqCS1gC7bq434rMmfY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:ed07:0:b0:e1d:912e:9350 with SMTP id
 3f1490d57ef6-e3087bc765dmr51968276.6.1730304307760; Wed, 30 Oct 2024 09:05:07
 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:04:28 +0000
In-Reply-To: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7761; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tEriRl1s5aMKzJQzUep/R+6Ah6Myzoilu5Gt/biRO6w=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnIlkj+zi/ZeCsvvjAjU6Nb9xOSl6DubI5Y/Iwy
 1JbUL9MEGmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZyJZIwAKCRAEWL7uWMY5
 RnMrD/9GOSq+2yFRe/8k8SIbCJosPtOngpcRFceZEKecE5pRUpUhsuGpdIulecGorZlT7tcfTF7
 yrDZPb5ueqeo9wHnC6xEW3CZNx87ladgXT8SQj1lNkcnP6KpD/alvOkTHSD/BnedRWQxGRVK9Li
 KHP0TINKG2hcDqPbkYkjlwdgZF7Ta5ggrweahQAMEnVTa7FcVsR1ZEVdVt+txPh8Zb9IJIsdph4
 STpTD9SIC/TLDzSC+1hjY48M72ZHuuabI5ePkc8rstSiDkDlkFgq/FUVeMEhCSlC2irnl91KtQT
 6WDkAKn7sVk30GREem94CI7KAcp9b6i7T1vMhm4XEaru6w9wPARl1Gy/6IgJ3JCGGZU+edYb1u2
 POCxtK/YUwn1oGWe7DeODIBNXcD3mtVoqOLtwiVSI6pRIRsJALNDpWY3Mvj5uMsBDtXsL8GG1nD
 QxMhI85t3tzOpDcPvQhG8+6026MCkv1TRefxTfga0067dSW1G1owYNYkV02PndF26FrhYGnXCSb
 GrG/OGiQzLTKvkgCaePQiB9/qbWor/pEW3K2kT8dTceXB70qm1u9ENXA0wkUkMF72UB0+C3Jo9n
 aAvVHTvLeIEQgUuSurrni4jzoRe+diXRQH6uSIB8H38CHj2nIVPEDbQ0y3VyGQomV5QcHr7cMuq bDnNS7IMkNetjhw==
X-Mailer: b4 0.13.0
Message-ID: <20241030-tracepoint-v12-5-eec7f0f8ad22@google.com>
Subject: [PATCH v12 5/5] rust: add arch_static_branch
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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
index b5e0a73b78f3..bc2a9071dd29 100644
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
 
+ifdef CONFIG_JUMP_LABEL
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
index 55f81f49024e..97286b99270e 100644
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
+#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
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
+#[cfg(not(any(target_arch = "x86", target_arch = "x86_64")))]
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
2.47.0.163.g1226f6d8fa-goog


