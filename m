Return-Path: <linux-arch+bounces-6520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D295B48D
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 14:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF471C215C4
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925F183CB7;
	Thu, 22 Aug 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Gq5eHgC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FD1C93B8
	for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328293; cv=none; b=lwniqMFotuR5IpXlzTMa540FfbEYqtWH2ywcQlb1IgE3B+SgeZLGnKPqwWGvLt2aR5hMO1t/I8v51CN+13WSnjrDod+4uh1pOUpuhha8++Xs/Go1Hj/C8f4dIF0koYYIkFw7nK1PZjnVdVQh19TzVmXeMAJH0myjsfG+/tgoxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328293; c=relaxed/simple;
	bh=4wPruubT8llHHATxdqsGwe1CHDZt4aUPk/RJRbbIGjg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Plk01t1pnIvBuceQlPYrJzGAg1PIu8SOaQTswpmENVLxMGLVl+QdFCRubcq/lViHoa0fwf9WHK9GozAzhgnkbmPtRRYeLr4idMK8Mg6PkMd11uHlk73g7npYh7/sTTVS93wNkp7flh8avit5zSUcQFENwyVkX08YoQ6oEwYgzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Gq5eHgC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be1808a36so1162501276.1
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2024 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724328290; x=1724933090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qaeHNeC4U+gSuIpF/blhfiveOXLPImv9FOraCwj5ang=;
        b=3Gq5eHgCeOeF0ZaGlhHaiBYgDEsS0WoYrr/E1tkekktwlqkY70vstk0j8AzJB2t/jr
         zJvneFSrdh+kcC8uDrW6OuwN261bt5vQ+jD1zzoTBIReO/00bpQd98eyXJaMdZKmhqJo
         ermlNdTySig54dMbqKuUTab8J/XZKTDapoIjZfSXB/oRuhPJu3Yv7hz17bBXFCha9wZy
         eNSvRKLc7ffza1GP91Ckez7Eg72643Kg/E8QJZyhQiULD/i7YTTA2hvmce+bfyzI7oO5
         ZiO3pRnWnU+Zj67y5eJ8s3JTES029KnDUqLcXXu5lU3Ze3z7qCaUG8KwANoEnVDSAmKl
         ptFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328290; x=1724933090;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaeHNeC4U+gSuIpF/blhfiveOXLPImv9FOraCwj5ang=;
        b=flFuhopWU8yeYMlSwFtDv3FXCjfGKGwK5zM1i9cahQ8cqisy7pMEBZFndQVpa7KyRY
         +BqL5e+Yq/x9zMx38DmuagP+Y4XfRmAW/1vD7UcwMNP7bqRhXKW8WMhwoTEDIpYCHu3P
         xH3Hx0+Rr4FEtaOzlalvAPK3LtA4G48fLg+6dvHhk2NWkjN79eASFbSe8je3rlmkgr2I
         3CzObMP8knlsRn0x99aMB8AUDCQ3hV2IarvIZwYdKP7pSAHXlozJbFdy/xffR+3p6wRk
         WHHD4mEwOqsQyctXub8hQQUnFJboDaK1c3OY6ZcYFjqIPXAeKpJv0jsfuInZUkJFBnpW
         v+yw==
X-Forwarded-Encrypted: i=1; AJvYcCWnpnodgkFHWnhVqRcfcdBEdVc0AR7EHzdB6GQQF1M9Rknu+BAYIWE2jzhRdrNjYSjc1lX2RNuSqid1@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHEKwUPh/QtXzUM5f3SG7/C6Jt3U+kf0YUtkp1iSwU0pA8CC1
	wDh9ycAwyU9PMEDJUxUboLTWzN/abXybNupWEYU/0VdKA3AEn7NJQ41yVzLT+PRqgKK11+ULWKn
	LepskbUwchJxAPg==
X-Google-Smtp-Source: AGHT+IEIHScnmgqTJmuCdOdZdFrXk6gyAD2n2QTBVJYojsFAgQWMDhll0TNe5nx6xpeyVM/+JOGxXJdwv2SpyHk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:aa84:0:b0:e0b:d729:ff8d with SMTP id
 3f1490d57ef6-e166543c856mr14145276.5.1724328289940; Thu, 22 Aug 2024 05:04:49
 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:04:12 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADwpx2YC/23Qy27DIBAF0F+JWNcVw8uQVf+j6oLH2EFqTYQtq
 1Xkfy/xpiC6vEjnMjMPsmKOuJLr5UEy7nGNaSlBv1yIv9llxiGGkgmjTFBF1bBl6/Ge4rINHBC
 kMxTFCKSAe8Ypfp9l7x8l3+K6pfxzdu/wfP23ZoeBDkpKUGx0kwT3Nqc0f+KrT1/k2bOzygJtL
 Ct2suhs0OC4lJ3llWXQWF6sQSEQ0TKneytqqxsriuWSB8m4NR56K/+spqyx8pzZghLCiOD7fVV t239VsZbxSVM6AWjT2bGy0N55LDYoapwB5TS09jiOX3jnaSYNAgAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5477; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4wPruubT8llHHATxdqsGwe1CHDZt4aUPk/RJRbbIGjg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmxylZCAp++W0g03p2207w/bZOFkFKkI+DjX+LP
 TlaZhO497WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZscpWQAKCRAEWL7uWMY5
 Rhs+D/9wZyUjJN4r4koXI+//cd7ZcTKIuHeOxcDinqLwj7qF+USMJHsCAmLQ/cF08mTpuaios2X
 1rnPBggHshySYc+DfHxyw2p3+RCkwXEmx74TtThOZsAiNYQ5XQlIF/q0J7CWtLBBmi2uAT53OA7
 6yCfIuo1vqRBSMp66saDoRoQp7S8AL71UyvWD21+jZ/+hFy10wVML+Xu4ouG1/e/V9zK8vwTYk4
 jKfhfjlG9EW8yVXGd+/quQopg5cSGOxvcyIpbN1amP01SLK1aMK1CKGQjuam/l3bwaaWTk5R8vo
 xUgj4NR4iiSa0idNH82zVHgPrlNie9FYJqYnpImHcKcj4/Po5nMsJ6Xxmx6c0/t9rOCk9hJDwmh
 IxHaI7jlU8sH90owV4Mv8AhFU+xbL9uyvsMSmK7svUMcqYCrHOjZw57RxMIV0Vsr35Tvu9CHJon
 NO0S5ogSiOHwCFESn0RltVmLFC7gkLzgIHRReMaGOdcZ0qljSFuGXUCVPD0fsemcIiXLvF/f+Wi
 uJTJ3zks7aA+LnhUAFsmDSe4Rws4EtUizV1kYwm6SfSORqZMqvNKVb9eksXvm3qkzAEu/lLUMA3
 tWaCxOxms2Ns87v3MrKckIUkrNmH2BLHSjt7Ku3PctE/fIjy/d5FolEcgRM5q8PXLKASN9ceGS1 bPjj1UgxpInqEHA==
X-Mailer: b4 0.13.0
Message-ID: <20240822-tracepoint-v8-0-f0c5899e6fd3@google.com>
Subject: [PATCH v8 0/5] Tracepoints and static branch in Rust
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

An important part of a production ready Linux kernel driver is
tracepoints. So to write production ready Linux kernel drivers in Rust,
we must be able to call tracepoints from Rust code. This patch series
adds support for calling tracepoints declared in C from Rust.

This series includes a patch that adds a user of tracepoits to the
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

When compiling for x86, this patchset has a dependency on [3] as we need
objtool to convert jmp instructions to nop instructions. This patchset
is based on top of the series containing [3].

There is also a conflict with splitting up the C helpers [4]. I've
included an alternate version of the first patch that shows how to
resolve the conflict. When using the alternate version of the first
patch, this series applies cleanly on top of rust-next.

Both [3] and [4] are already in rust-next.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3119993 [2]
Link: https://lore.kernel.org/all/20240725183325.122827-7-ojeda@kernel.org/ [3]
Link: https://lore.kernel.org/all/20240815103016.2771842-1-nmi@metaspace.dk/ [4]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
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
      rust: add generic static_key_false
      rust: add tracepoint support
      rust: samples: add tracepoint to Rust sample
      jump_label: adjust inline asm to be consistent
      rust: add arch_static_branch

 MAINTAINERS                             |  1 +
 arch/arm/include/asm/jump_label.h       | 14 +++--
 arch/arm64/include/asm/jump_label.h     | 20 +++++---
 arch/loongarch/include/asm/jump_label.h | 16 +++---
 arch/riscv/include/asm/jump_label.h     | 50 ++++++++++--------
 arch/x86/include/asm/jump_label.h       | 38 ++++++--------
 include/linux/tracepoint.h              | 22 +++++++-
 include/trace/define_trace.h            | 12 +++++
 include/trace/events/rust_sample.h      | 31 +++++++++++
 rust/Makefile                           |  5 +-
 rust/bindings/bindings_helper.h         |  3 ++
 rust/helpers.c                          |  9 ++++
 rust/kernel/.gitignore                  |  3 ++
 rust/kernel/arch_static_branch_asm.rs.S |  7 +++
 rust/kernel/jump_label.rs               | 91 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                      | 37 ++++++++++++++
 rust/kernel/tracepoint.rs               | 49 ++++++++++++++++++
 samples/rust/Makefile                   |  3 +-
 samples/rust/rust_print.rs              | 18 +++++++
 samples/rust/rust_print_events.c        |  8 +++
 scripts/Makefile.build                  |  9 +++-
 21 files changed, 379 insertions(+), 67 deletions(-)
---
base-commit: 88359b25b950670432ef1da4352eb6cc62e0fa9f
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


