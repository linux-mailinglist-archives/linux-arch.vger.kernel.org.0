Return-Path: <linux-arch+bounces-8725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1D9B68CD
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2FD1C21C42
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79C213EF7;
	Wed, 30 Oct 2024 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJHw22fj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0681F426F
	for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304298; cv=none; b=i352T4LdPrWeBAysuRqqNjM4dUX+o9f9Uv1oUmE0FotNc4nU4ID+WavwymgG98FzZsydIQcgpGMPzG9RxkTLopTyENUs1g4O+hoOaOYkGxNIIt6+i0q7oijAyfx2/KyzHwpCfUbh50WO8qIPE1P1rb7UZGCVlSmfQrjWZ9/vSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304298; c=relaxed/simple;
	bh=mQU2pzDmzpt11iULsoB16Cf/xP/IF3oTNJcu+P0cuA8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rxvjkGFD6a83kvXaMPZdUCMMHahY/IH0+H8GBR8k/dYezVagT6872fZGTtC79iDC7g6MoA7rNFvG9bS8kDsWKpsUkqNyx2X5RCHSCQ64GgTU/Z2BAn3SeRK6g5pJdzPUmcpPIlLfl1nV3FjaHlrnoZLiN82DfgcipcFmrzyk54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJHw22fj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so107947b3.0
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2024 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730304294; x=1730909094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q0WT77wRON2fu3my9E0wFOB4dWqJ57fFMAi7Ei7+AGM=;
        b=pJHw22fjRBupArcCdaLIzlMOnXLxdiZPxCJnsCeIOLZlLChI2QTn4dj2ziod+/6aTe
         OaKS14Dq6VYjrWsRkpwDxOP6n4n7YLuH073oxr3u9IKrFw6DUdNK/OaY8JOX7n1C2EgC
         gq4T5/rEXHFzoKy1x78Awnz39uthf/KAz/p+yktF8Un9qnNDRyDy43/KXpsG7YHLMoUQ
         2hykkIuIPMAGGAX5MdPWqW3L5+8WfvPUA1yzsZes0lEye01v14B327czcXDjuWD4vvnK
         o4EUIZXWfwCYR0AWHvSMfx1oRbBRkVVNakygUCMPHECuRmQLCE6lgo6UvZU2D1HhQLgi
         2Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304294; x=1730909094;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0WT77wRON2fu3my9E0wFOB4dWqJ57fFMAi7Ei7+AGM=;
        b=g1/QmIcXu12uezA37Q3AQh5aenxCNyFTv98X4C8zWPH6prdAqKtvDFzdj4YnjAup6o
         GGdapSN0Zj5Q+k+ngdV0stxt/eAnzCiHJLnVlNuMsAAvl5N2BDsG8dGIMaTFvT0TOnwW
         FGkD7Q8pQAKcvluazbBJdNnGHxUUDWXVfRIbR/9uci0QNmetiDKSm+vfuE0sh2iV9X7F
         1bHqID2eaz253DeDPpl+B4ugsaTuvo7Z2/BQUtj1oH7WgIqI+iuOnr/8KMwdMCG+M83E
         QZ4EKmNqlutD9wQJpKQtCfiO8Dkq1nLljugNjPJXDf0A14IZJlsmn2dffPmstNDhFh07
         +Ijg==
X-Forwarded-Encrypted: i=1; AJvYcCWxTUGp2BO7/XXAmhhmZBAacyOnEVs9Qh1tXp713kZ4bYpHrQgmsDW+1Sd/VpXmGgon5hvH09c4MzWJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUoWOjEmotLTE1yMTMLqjc1K0KQviFvwy/Dr4q5Wa69veBKrU
	qSkcn6wBI+DLJbKJu9YyjoX3fvTxJrw1wRm00mAJSdFGtmmh43kuf+ENtIIZ+rRsabZe5cbntVO
	sY/9gEUE3Fj8O3Q==
X-Google-Smtp-Source: AGHT+IFsumdNHSKRbfFmvPwbNT1EakQjB4ZRJlJrhcnTXJpDdTCOafftnDFAGrkPp8ZDYDw9k7Z0vNFl+0Pt1As=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:6309:b0:6e3:ad3:1f19 with SMTP
 id 00721157ae682-6ea2c1f16f8mr3956897b3.3.1730304294426; Wed, 30 Oct 2024
 09:04:54 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:04:23 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAdZImcC/23SS07DMBAG4KtUXhM047dZcQ/Ewo9xGwmaKokiU
 NW743QBNu5yRvrG49++soXmkRb2criymbZxGadzKZA/HVg8+fORhjGVBuPAJWjQwzr7SJdpPK+
 DQEIVHJA0yAq4zJTHr/u0t/dSn8Zlnebv+/AN9+7DMRsOMGilUHMTssLwepym4wc9x+mT7XM2X
 lmExvJis6fgk8UglOqsqCzHxopiHUlJRJ4H21tZW9tYWaxQIikuvIvYW/VnLfDGqvvOHrWUTqb
 Y31fXtj1XF+u5yBYgI1rXWVNZbHM2xSYNLjjUwWJvbWV5u7Pdd4aorHOkcxKddb8WAdqcXbHok wgmGesf3Behwtji8t4wmBwSyaSD4n3SiLVWrd7/VowUtLIc4F9et9vtByG/r5QCAwAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6484; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=mQU2pzDmzpt11iULsoB16Cf/xP/IF3oTNJcu+P0cuA8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnIlkJ3et4UkiRFDqzQ/5bZPe9WUXMNUrlp4w/5
 qJQ9m5+HkSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZyJZCQAKCRAEWL7uWMY5
 RgFdEACfjIPWcuU/kPXPZFS0JoWS6SC1zSff77oxH0YybvKyLTuj+/O241P6lqq7GaEzrZlvEVf
 9kcUsPsgAX7cGt1UGQ7w3ofZ93fLp3GiFt9CUPxg5DlkZTsqZwnDnKGNuFXFbreAyyexTSGSpeq
 JkqAuq+cKq8cWFIHyy7sasegzDdTbn/Gu3kMNwLuRpy+y3Zc1qn/8Jfyq/YVh9P7GGcCqWGgWV5
 /irCJSfvPk/ixyNtuF3g44afTxvagik4iBf4NGlsXkMbJAQZjfBb4Ujj0P5QHyvcsGiW5wQV9Q+
 feZFcuQfFyGVVnr/as7iPUvc3KUKYywVeRhjQDNWYcPvgI6nQ3St3Iu9ihFL4G9clmiLN20PxJx
 PV9PUKlwIbsxwvqaGinlSWyigzL7o06E908CcZ9FH7LOI7VMWVDshAnMSbs4XvCimdJguBBbP8U
 j5+nPMXDiIw4n0uGGWgMSuBWQj3y9jVPKSpaQx+1fQFTW+8ETaTGfISTqWQwIJkVyReXtKSkFb0
 Bsw4IShQN4yyxAHI/OFPLaSfBGhAam54t/0xa33wjhlnmzcgphiqQZL663mD/04HW7iMXAO4DaK
 s3JHU/jcM27BOaF/MOig2XWfh+YXIp/tce5FzDELU8cgOHtf983kjhq4xFtSq2SUX/7cO4jjzyO kA/wBWZovsOH0+A==
X-Mailer: b4 0.13.0
Message-ID: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
Subject: [PATCH v12 0/5] Tracepoints and static branch in Rust
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
	Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="utf-8"

An important part of a production ready Linux kernel driver is
tracepoints. So to write production ready Linux kernel drivers in Rust,
we must be able to call tracepoints from Rust code. This patch series
adds support for calling tracepoints declared in C from Rust.

This series includes a patch that adds a user of tracepoints to the
rust_print sample. Please see that sample for details on what is needed
to use this feature in Rust code.

This is intended for use in the Rust Binder driver, which was originally
sent as an RFC [1]. The RFC did not include tracepoint support, but you
can see how it will be used in Rust Binder at [2]. The author has
verified that the tracepoint support works on Android devices.

This implementation implements support for static keys in Rust so that
the actual static branch happens in the Rust object file. However, the
__DO_TRACE body remains in C code. See v1 for an implementation where
__DO_TRACE is also implemented in Rust.

Based on top of commit eb887c4567d1 ("tracing: Use atomic64_inc_return()
in trace_clock_counter()") from trace/for-next, which is in turn based
on top of v6.12-rc2.

The sample added in this series is affected by [3], so be aware that
some bindgen/libclang combinations may fail to build the sample. This
isn't something that this patch series needs to fix, though.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3119993 [2]
Link: https://lore.kernel.org/all/20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com/ [3]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v12:
- Replace `ifneq ($(CONFIG_JUMP_LABEL),)` with `ifdef CONFIG_JUMP_LABEL`.
- Expand x86 asm to 32-bit for future-compat.
- Add note to coverletter about libclang issue.
- Link to v11: https://lore.kernel.org/r/20241015-tracepoint-v11-0-cceb65820089@google.com

Changes in v11:
- Fix build failure with CONFIG_JUMP_LABEL disabled.
- Remove CONFIG_HAVE_JUMP_LABEL_HACK duplication.
- Remove explicit export of rust_helper_static_key_count.
- Add Gary's Reviewed-by to first patch.
- Link to v10: https://lore.kernel.org/r/20241011-tracepoint-v10-0-7fbde4d6b525@google.com

Changes in v10:
- Rebase on trace/for-next.
- Use static_branch_unlikely as of [PATCH] tracepoints: Use new static branch API.
- Update second patch as of [PATCH] tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL.
- Link to v9: https://lore.kernel.org/r/20241001-tracepoint-v9-0-1ad3b7d78acb@google.com

Changes in v9:
- Rebase on v6.12-rc1.
- Add some Reviewed-by tags from Boqun.
- Link to v8: https://lore.kernel.org/r/20240822-tracepoint-v8-0-f0c5899e6fd3@google.com

Changes in v8:
- Use OBJTREE instead of SRCTREE for temporary asm file.
- Adjust comments on `asm!` wrapper to be less confusing.
- Include resolution of conflict with helpers splitting.
- Link to v7: https://lore.kernel.org/r/20240816-tracepoint-v7-0-d609b916b819@google.com

Changes in v7:
- Fix spurious file included in first patch.
- Fix issue with riscv asm.
- Fix tags on fourth patch to match fifth patch.
- Add Reviewed-by/Acked-by tags where appropriate.
- Link to v6: https://lore.kernel.org/r/20240808-tracepoint-v6-0-a23f800f1189@google.com

Changes in v6:
- Add support for !CONFIG_JUMP_LABEL.
- Add tracepoint to rust_print sample.
- Deduplicate inline asm.
- Require unsafe inside `declare_trace!`.
- Fix bug on x86 due to use of intel syntax.
- Link to v5: https://lore.kernel.org/r/20240802-tracepoint-v5-0-faa164494dcb@google.com

Changes in v5:
- Update first patch regarding inline asm duplication.
- Add __rust_do_trace helper to support conditions.
- Rename DEFINE_RUST_DO_TRACE_REAL to __DEFINE_RUST_DO_TRACE.
- Get rid of glob-import in tracepoint macro.
- Address safety requirements on tracepoints in docs.
- Link to v4: https://lore.kernel.org/rust-for-linux/20240628-tracepoint-v4-0-353d523a9c15@google.com

Changes in v4:
- Move arch-specific code into rust/kernel/arch.
- Restore DEFINE_RUST_DO_TRACE at end of define_trace.h
- Link to v3: https://lore.kernel.org/r/20240621-tracepoint-v3-0-9e44eeea2b85@google.com

Changes in v3:
- Support for Rust static_key on loongarch64 and riscv64.
- Avoid failing compilation on architectures that are missing Rust
  static_key support when the archtectures does not actually use it.
- Link to v2: https://lore.kernel.org/r/20240610-tracepoint-v2-0-faebad81b355@google.com

Changes in v2:
- Call into C code for __DO_TRACE.
- Drop static_call patch, as it is no longer needed.
- Link to v1: https://lore.kernel.org/r/20240606-tracepoint-v1-0-6551627bf51b@google.com

---
Alice Ryhl (5):
      rust: add static_branch_unlikely for static_key_false
      rust: add tracepoint support
      rust: samples: add tracepoint to Rust sample
      jump_label: adjust inline asm to be consistent
      rust: add arch_static_branch

 MAINTAINERS                             |  1 +
 arch/arm/include/asm/jump_label.h       | 14 ++++---
 arch/arm64/include/asm/jump_label.h     | 20 +++++----
 arch/loongarch/include/asm/jump_label.h | 16 ++++---
 arch/riscv/include/asm/jump_label.h     | 50 ++++++++++++----------
 arch/x86/include/asm/jump_label.h       | 35 ++++++----------
 include/linux/tracepoint.h              | 28 ++++++++++++-
 include/trace/define_trace.h            | 12 ++++++
 include/trace/events/rust_sample.h      | 31 ++++++++++++++
 rust/Makefile                           |  6 +++
 rust/bindings/bindings_helper.h         |  3 ++
 rust/helpers/helpers.c                  |  1 +
 rust/helpers/jump_label.c               | 14 +++++++
 rust/kernel/.gitignore                  |  3 ++
 rust/kernel/arch_static_branch_asm.rs.S |  7 ++++
 rust/kernel/jump_label.rs               | 74 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                      | 37 +++++++++++++++++
 rust/kernel/tracepoint.rs               | 49 ++++++++++++++++++++++
 samples/rust/Makefile                   |  3 +-
 samples/rust/rust_print.rs              | 18 ++++++++
 samples/rust/rust_print_events.c        |  8 ++++
 scripts/Makefile.build                  |  9 +++-
 22 files changed, 374 insertions(+), 65 deletions(-)
---
base-commit: eb887c4567d1b0e7684c026fe7df44afa96589e6
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


