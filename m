Return-Path: <linux-arch+bounces-6121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3F94C3A7
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 19:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833FBB26BEF
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C49192B93;
	Thu,  8 Aug 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFXkthuH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DD1917CB
	for <linux-arch@vger.kernel.org>; Thu,  8 Aug 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137840; cv=none; b=teRPTJDqiKtBf6uL+N6d9FC8uL67d659VPmFz2QYbjgBaPem1HSFsz0KqFSE+txDiJX4fumDq7PgEatFJAL9Q82rmXtsGsnuTG5FIHw6rs3G37D46+IECqsOee6knCIl/NZA1+Qmpfd3Z/8jQyjeRSMFrQ1t0f6+jSFK2K1I9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137840; c=relaxed/simple;
	bh=8HR7rHPbKBgLjaflFT5CEqKyANaJhZ2+rl+HT7rE2Yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VNGCrR6ZX33hXDvMkv6XX0TquuEEh0J9oRxL3OhAeyOb+P0VW9uXKF+AcOw8K3suQMNZTbhcWxJ4WjSDyXQoxjN+rvr0xchKQrMLrZTEecxzrxjxSVjMX804zdFsVrPuTK82XnBfIpsEcO2a0ENTDAXuTJ8hbQ1ftoLFq5wUJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFXkthuH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650b621f4cdso25216057b3.1
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2024 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137837; x=1723742637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKvx2G/xqxSl6cPgYJhgi3OiB0ngiC59Ryype63GHQE=;
        b=CFXkthuHYgLH7AZ/d2np90x1wgctnGuc9i7JneYjqIVNVfsXz3HMAeQlhkPrW27MdE
         ngkr3jomrZ+iH3vb9PnQENJEzV/QFX7/+h6ckvMaQgq4X47YQdMdCI3/TpfTIZmgcnBB
         2UcHVr1aUmT9PfyCdslYAqQp8YdtKnzXUcgQOz8BcaD4ybs4S2idQnWbDEWyBPfRhnD6
         2+H13UnLygaJ7MpqWG5ylUMu4vI0Fnyz+ZxlO0nsyjQ3FIbnE6Kknc84xJGOF/drxZ89
         s7mdKywbtFQy8xb56P7sXBQA3//mmh8TBbdKY/xJAJkovHciUoi88LOd9PVSioiD7eee
         2GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137837; x=1723742637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKvx2G/xqxSl6cPgYJhgi3OiB0ngiC59Ryype63GHQE=;
        b=RsttqQJterwr6S+gtU8Rmsy/Jdzb4VdMOaxwfLmLxFXe6G3P5UYJje1O9tj/+AI/kU
         VCkiwoWrZDawOi01SX/qdhnzfje6cw39HvCy8Pq0f9qWTQSdDf2yM2Ni6wyXEn9HzwQh
         qkqBSKNJMyuFHkdLBS6hOfYOsuR3BT4OFrOvIJP3o38erTrJlzWVA4fDi5K34yVXREBR
         eL47WG4+mruVqZkbb3+E/NXDWnTRMpcAWHum1xOmjcLyrB1SwK3ueef8aUf6WVSSoA2G
         KCeI40hX3DX3+UNUwCK6pk2yv+TJVxx/3+Wun/z2d6kurCsKY78HYRsqyznLTXHWs+k2
         mfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6/KC41QuiskroXii1bgCE/chKWFRteuFGtmBcqdjfOHevyzJC0ROOl9fCecO8kdl/Cvn7tWnt+vbwbTcb8ZzkESLNDedZCJaa1g==
X-Gm-Message-State: AOJu0Yymvykmos/fLyt+9uiXVqsbEID+QSw2IWRgXKbBEiO2Pq3Dcqbr
	oOblcquZR2lFz/zd21GM/n31GjpMD/zlljy7Sdk9Q5VXqb+Cv4b8pbwsIa1hxH5+huzfhJ+03CR
	vNFVD+MDoIfLKsA==
X-Google-Smtp-Source: AGHT+IEgzqTU/t14sWWaVE/IFHEsCHBUkasJCPj+gNG5VhTvgMkpbmuIw0faphhHRzrEN0qF51wzgBly43McB5E=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a0d:c1c4:0:b0:648:3f93:68e0 with SMTP id
 00721157ae682-69bfbf94870mr842897b3.6.1723137837465; Thu, 08 Aug 2024
 10:23:57 -0700 (PDT)
Date: Thu, 08 Aug 2024 17:23:41 +0000
In-Reply-To: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8284; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=8HR7rHPbKBgLjaflFT5CEqKyANaJhZ2+rl+HT7rE2Yw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtP8ddgVCGwKH7HJ5305eaMxT5Ki76ZkVrm4w7
 9mw9UkaP3aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrT/HQAKCRAEWL7uWMY5
 RtgJD/9tPso/NH49qsdk3D++pbDifahzylC1HlJD+AqQTA73qwbRFTauQy4+XE/uOOz+s/H5eKn
 PuQvfsQQM4HS+KhxTqPQBmMug5JiZGjT8oQlB5dKTT74ikYQFn0fY9nh7bYc35CnOS0hkx4wbNY
 0UPJdFoRP0Kh6qEnk2hXJQxRiOtVy53rBBfyRjViBSJAcokfuRn4GVw9GucefSaNCOI9sVQuFls
 eZEpd7e3vn498jd3YeiA9KwEPfVAvpJwAPF4bBYnb430iJ89UXf/5wcURDAWdbkWlqmy9XxNTHt
 JLF4LjEHXnSVDOlSqpCT2BeSzrphEhJWCi7qeG6WbakW1Fuzt/vMqDlbnYdosNSgJFbSSZwxh4r
 kh1h1H1MzdedNzHb8akd5CafxZT2MEE15Z0ICI/wPTIj0DL+1mwPC9Ac4DfhxzKFdu8Lg9+ABgd
 mrKohmtU9JSaCO4KQ8XSd39Jm0DRGQRmvFKMk+PmBJ57G4e2YGO6XJBekjtoHajTbyj2jjNk+O4
 vkxhxl21T2fxLxYC7GOAJ1wgI5UDd+WpWSDbKNAWxpL43kCMhTXA91GuzfwwXej3LjnPqeIETyp
 pMRoSjemfQPLbpBA52iPMDwiDSkQvoqi2mLuBYgrV4wYsi72aSj89J/4kkcY7Xk813NdcDlwjqB KWR6PQPqvuR4fcw==
X-Mailer: b4 0.13.0
Message-ID: <20240808-tracepoint-v6-5-a23f800f1189@google.com>
Subject: [PATCH v6 5/5] rust: add arch_static_branch
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

Suggested-by: Peter Zijlstra <peterz@infradead.org>
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
2.46.0.76.ge559c4bf1a-goog


