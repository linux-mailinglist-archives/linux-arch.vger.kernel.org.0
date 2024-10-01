Return-Path: <linux-arch+bounces-7518-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246098BDB6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 15:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22BA28893E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DEC1C68AE;
	Tue,  1 Oct 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWd7FH7J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C11BFE02
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789447; cv=none; b=BsqDhGgGc9ioWvZf++0paaJOeV0yLbx1jvWC8iR6THIm0fi5EbSIyup+HaZLvHIwSzKZm3OY85kBCyAWwPzEAtWvqLwIrA1CyE6mi22997vlutLaHmx4ClixbDH6fc6pClz841KW6Udt3sU60QPUAMHtjHYViKEx9kX+0NALNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789447; c=relaxed/simple;
	bh=B20XPkbS2BldO1VNXORVIshLvelvNfCPEDgTJEytqJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+ZtPeB4Ln9ws4sm+88qrV+uh1m1CzGpb8xqkWjxFc/LbITQ8WZlMm/ugFVsYE/dif82QlaVh58MdtjAXAGboQpqmvXE/ysXaL3G9yy/kuHijsCP3lsKlqXNtqN/naFt9NUb9jv870IBcZHyrlvC6sYrjeqOeVFber7USYjzQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWd7FH7J; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e230808455so63652607b3.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789444; x=1728394244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkhFbvRkdz/oOfeYJrLg9+G9M/Uj0+RwqIl1/SZKHXU=;
        b=mWd7FH7JGFa3Gmit9k9qrqYpmzypSjOq0B+iR7etHOEcNwmL5SelAIN/ztqNMygNgZ
         Nn7y7zdPjvXK4C735rKcFGm77HLdXzIs/Fxm5WgOuCjC5PgVwieqScpVHTjPglwFvlPM
         NA7IyS239cAimrCfXV83l+gS8FpPaghu8FDREHolZtKf5IV/wIiqJcQs7Z7GCoLPTF8J
         aCCX1upy1R57pTlvFqzQcfTgvE28Ap62LFKON2kqLdD6olPYq2USSNRSh3ZjiqqaeM8w
         1V1TOUjED7lkPH7v0Va+eT29GBij7ey0UaaULBfKUakonbv0CIGMoNOp/QR+Qhp80Rsu
         rBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789444; x=1728394244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkhFbvRkdz/oOfeYJrLg9+G9M/Uj0+RwqIl1/SZKHXU=;
        b=kSb/g8lv3XyfxpTAsK1tPiqfqiAtGqFiItKtczYUaHEY29krtj7rq81qIO8IUIUN2M
         QdN+IMzanqGhf0q5Tagxunjf6TlCcdSGvjX4X/MX1EcAy8i0ybMcLedrJcV8hYtQ56xx
         R1UHx2tMglgrrNzc4vq3E0XUfsPd8rPJATNmtCQmDMru6lmOSjiL6JE744P5PNr8Unn/
         X0tczqru7vng7HioOfNkMhq+E0m9rcE6fchSKlxu2SjCsDMElqKzq8t9EApcV/CmPCeZ
         KRvwO+JG3ULqBgV1OZ2pL+T7lr06FV5TYZQiAHKXTp1V0xdNG8Th5t6AB3TB1azhlvrr
         BHXA==
X-Forwarded-Encrypted: i=1; AJvYcCWMbvRnuWEvEtajrA4KSGHn3Lm6+WX8wNMj9EcwGTq7cGEcg+BJJzbapnE1cJKB142AHBCZ8BAMegSz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrcnfx19u2OYDvR09d/QMWkNyT+J4Tew2OaEJMY0fWhgw5Zi5Z
	FBoc+6i1OoWJqa7VjorAd2Uf8yd7Afljkop97Ey5p0rwnSv/yn4qwuDUQrgmE88NHktqJahML/N
	YL9dpK75KUPfWZw==
X-Google-Smtp-Source: AGHT+IHx8WYLlRQ85MZlmXhOzStV8hphkC3W/SA4f78hZMUVqK+AieUKfwBlCdSzSifKonxye2KCvb5tQYoxE/A=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:8304:0:b0:e1a:a29d:33f6 with SMTP id
 3f1490d57ef6-e2604b2bbd3mr134063276.3.1727789444352; Tue, 01 Oct 2024
 06:30:44 -0700 (PDT)
Date: Tue, 01 Oct 2024 13:30:02 +0000
In-Reply-To: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8506; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B20XPkbS2BldO1VNXORVIshLvelvNfCPEDgTJEytqJk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+/lyTWXV0qt+2jySV7mW4g92htG/ndvQ8HqpA
 dk6PB1Bf0yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvv5cgAKCRAEWL7uWMY5
 RkGpEACtKcH0XvxL+nqPbUO1qDZYBp7bMUnck3VQWyZKLA989Zc7bnXqY74U0cmqeyfj/XoMJ5Z
 lnQ5jogYpeKqs3goYSkOH+M4p4ej9Ie95XbXHIMRYWpPojVgq4djGHfYMtRJrD3hjvEO6RlaQMc
 AeL+nbrCeI1NUFAMheXguFI4z5YgMNFrkdJ3LujbqXfax5LKBopJpR9sIf+2zmz5cC56fRIAyop
 p2Br8NEWvvZd37qk9WAK8Bb8SQTqhS5MslcMU6ATBjPTChXJVV9Zw0Yu9EVkparyOh+lILISo6l
 nj3W1hFE4wA765Q6mxAlnKubwjV5oWtEyPu5Ju6wnL0gXlHvr+c7DmEA0wnBLV37vuy0Vp/6Kpt
 hF041c9wo0ehSoZObI95FnGdJsjNLcm3CdNagGhlWLDqT/juXtplimiVk4Yru1uEtsAKIncI0Kh
 2vBc9thKTWi4uiKDUgoR80YNDNo/khAorOcLybKN7XOXe6XWuZvSsb/Q9vJwO3Rz6PJjFK1/szN
 VWquccbjzSPl3/zsb1gR1lEcyEUuJg9/oIAi7qCT9l7ArCrWTOwyeReOGled4NdKqDou3bXF3fL
 1CoH3B2NyClyJ50UDrVa4jHNW/AwmSHJp8dqwKeIqLeYIpyIxb72ihi3ukO1m3EOe7JWuBRc626 8ofGkmyjOxUAWFQ==
X-Mailer: b4 0.13.0
Message-ID: <20241001-tracepoint-v9-5-1ad3b7d78acb@google.com>
Subject: [PATCH v9 5/5] rust: add arch_static_branch
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
 rust/Makefile                           |  5 ++-
 rust/kernel/.gitignore                  |  3 ++
 rust/kernel/arch_static_branch_asm.rs.S |  7 ++++
 rust/kernel/jump_label.rs               | 64 ++++++++++++++++++++++++++++++++-
 rust/kernel/lib.rs                      | 35 ++++++++++++++++++
 scripts/Makefile.build                  |  9 ++++-
 6 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index b5e0a73b78f3..09ea07cc4001 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -36,6 +36,8 @@ always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
 obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.o
 obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
 
+always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/arch_static_branch_asm.rs
+
 # Avoids running `$(RUSTC)` for the sysroot when it may not be available.
 ifdef CONFIG_RUST
 
@@ -421,7 +423,8 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
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
index 011e1fc1d19a..ccfd20589c21 100644
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
+const _: &str = include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
+
+#[macro_export]
+#[doc(hidden)]
+#[cfg(CONFIG_JUMP_LABEL)]
+#[cfg(not(CONFIG_HAVE_JUMP_LABEL_HACK))]
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
+#[macro_export]
+#[doc(hidden)]
+#[cfg(CONFIG_JUMP_LABEL)]
+#[cfg(CONFIG_HAVE_JUMP_LABEL_HACK)]
+macro_rules! arch_static_branch {
+    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+        $crate::asm!(
+            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
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
index 77610e19df96..448af0880785 100644
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
2.46.1.824.gd892dcdcdd-goog


