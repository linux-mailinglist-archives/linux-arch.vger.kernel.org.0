Return-Path: <linux-arch+bounces-6243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF0F95476D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 13:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6896B21011
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E66198A2A;
	Fri, 16 Aug 2024 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JnPA4x+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693981974EA
	for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806501; cv=none; b=oKzOTKTyCDdmjFC6fyWpFMsvf/4squuV2317slAik//9SNF0kzkoNRxmWFQdhmhH2RVuCoA3T6VdEgsJSeXVupYxMyKGD53wcyOjySzckSVg5z8F704jBZF2dATT+Trw/i6jYaJ4QvGaAIeLOubcXZsBiKk91tY+hQGiNUtd+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806501; c=relaxed/simple;
	bh=4pZVFpJRO3MHz/DoPuIAKSdqaAhQNfTKgM2dcrTjI3I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nYFF8K1Qlx84/pEcUTfLAeNUjpJ8Hy7Di8UE7axE3Mer2KmNxqfGz0+z6rIEIpzXDjuJqt1Y5MO9UOMBmOtc5I1Vf9bN44DC5r7ay2VQE2c47lWOT7jSCpvkX/nS0UXF8sTejWdjcAe6zyeGSk/Jow0kZ3F2vB5giOmunEC009Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JnPA4x+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad97b9a0fbso38017027b3.0
        for <linux-arch@vger.kernel.org>; Fri, 16 Aug 2024 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723806498; x=1724411298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GBSVjeF7/vjpC1dXeVG0LVGAvDGvE8sdoN+9xc5O6HU=;
        b=1JnPA4x+OhWLv0zVSp8dZGeI9ycre6Qguv9ZG6Srt2lBheu44ZUdwconNZpBl3qoZP
         4/HEyPhVuW59tPYD3mZoehPWJvDo4Pvk/x0N63VtW00dOKOA6KN9rIZA8dGHKWM/uxt1
         YsggWflBjo0SlsQOQupF92dkiH1N0n/RqTZ8RCqZAWWbJ1Rtdy9HmeuOi/bcIHi9jyWn
         te0QyUKic6wg36tMC5AQuvyYJ8l2RSSoCwcZFXL5RahsAfTRKnkmUB4OOQVGwEKQXJae
         rhjHlzHftp8ofJpcv9pq7timv7lfQ6FLxW7b5KrAooYUDR8HH0mRohX7TC3cHKXFuPbA
         rsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806498; x=1724411298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBSVjeF7/vjpC1dXeVG0LVGAvDGvE8sdoN+9xc5O6HU=;
        b=UjbI8b1qaARGwpE4Iwn4jOWo2vKkaFsfxdNA38GPhfRjPyRmcOZdlSSJM/GGplyfbA
         yrCZ+AJ1ctMtVaPqolUzk7DURVmOSlmeyD1a2tBw4pAx9+yUGPSxBm7S7hcVZaSj6L19
         sK/iF9b4STbb/6LMxaJNO2/PS5JFAMVqKW3mWI2U31ZFeEy1kRvE4kjdNI5T6DEFbRQ+
         0pawCC5hlPos1DRp08SYlIXeIdbbI+E7QFnUj00LDPhhgD5ZPpIml2hjg27j6zGWFs2r
         BShEnQukHoJb9UvZQPa6b/DgMa6AkZKz0a7i2XjJq2HUKhcx2qM3N7B/thBAJd/LfsF8
         vs+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7n9LjvZcjRp+ewJSTwLCOHzbVwjV//0L0qrUuWEBmHK2rMj7tf4QrdikxT5r8Qh/2Qd0x1Y29Bv2tuWGdjXOn9roXCzsXmtNudw==
X-Gm-Message-State: AOJu0Yxaupb1wt/OXvKaDvwY8QjBCWohAjOkLJdmQrlpM3fH/583qDsF
	IF/3WLy8oOLXa18a8+gNO1lAcyXpG/jw8hwwgNCkhoVfz64epmOC7r0Xenm9A2aczYVqEib2qZC
	KtOZG62PMRtyXbQ==
X-Google-Smtp-Source: AGHT+IHxFvy1KqAYn0MvS6oUKrhauQESgORV1h/F83xZuq+N5sGLBg0AYPrvpVQZa7Oof89hGa3nC7SROwJGVts=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5b:c44:0:b0:e0b:cce3:45c7 with SMTP id
 3f1490d57ef6-e1180f5614dmr4437276.9.1723806498310; Fri, 16 Aug 2024 04:08:18
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:07:37 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPkyv2YC/23PQW7EIAwF0KuMWJcKAyZkVr1H1QUQk0Fqw4hEU
 atR7l4mmwaly2/pfdsPNlNJNLPr5cEKrWlOeaqhe7mwcHPTSDwNNTMppBZGGL4UF+ie07RwBQT
 oe0G6A1bBvVBM33vZ+0fNtzQvufzs3Ss8p//WrMAFN4hgZOcjgn8bcx4/6TXkL/bsWeXBgmisr
 DY68m6w4BXiyaqDldBYVW1PWhORk96erT5a21hdrUI1oFSuD3C2+GetkI3F/WYHRuteD+H8rzn adq+p1kkVrRARwPaN3bbtFzZxMCLRAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6427; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4pZVFpJRO3MHz/DoPuIAKSdqaAhQNfTKgM2dcrTjI3I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvzMAqI6madHbK+l0LjW2ZBvrusxLNCk6x5EZ7
 WANKcWB+32JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZr8zAAAKCRAEWL7uWMY5
 Rqn6EACyr/SU1Cs0JgS1mWu3IE4tKJlLJ7t8RzY9m/fnuo+2ZYJ6uHwfQgOsBGxb2JzzwZil4z7
 jO3XGovFP0HdmRKVeByL3LsRh9S97IsqWkqDNK2TIODg1iYw/6CNSEfetZeAdUihQeKi7iIQdhs
 2DGQsWFhgwNsVPCuZOMwM1Gmmw5oFN/KVNyAaNKrVJM7X7qwqUVD8odlBtgfxpFKkoHk6N35L5x
 Ocp3Z6taLtD/DugADvFcAR+MasYiF1AJIkqkaxobWlO8wcPV6eY4BDjtHJoIP+7O/lRitkUlvBP
 qciD6i59r8k9Zc5+BdVGadx8kHWQ74LrdVQTSXgw9VfSCsGmTwew1Zbkh7zqI/oqTjVpHpBee4c
 6WIXRSHmJKmYpdqQbqpfJdpzQNjr6V6eXgHjA1iAQlaLPUXXL7ri3zXOH/t9m9iQ2dtzpMQpiuA
 y37vprsoWs75OBHsiO+uiqdDImGQnvJswCk8ZZpHXqtBMGwIfZkNCy85wKpkavMnXqjOqFvnU8E
 wKcsDU6bbKOdkHJTDs0DDAdCzpB8eFi+wpzSmkh+PK8AQOec7WWRMyvkvfGnFgdj32mwlAsIqQ7
 hmbIzTMzBWI2WzBM5Zxr5jtwcGokL6zADXDbs6N+MXML9wAakwurMhv7SWG9+eB47zHgIcXNm83 Ry8aemcFhD4M8Ug==
X-Mailer: b4 0.13.0
Message-ID: <20240816-tracepoint-v7-0-d609b916b819@google.com>
Subject: [PATCH v7 0/5] Tracepoints and static branch in Rust
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

To use the tracepoint support, you must:

1. Declare the tracepoint in a C header file as usual.

2. Add #define CREATE_RUST_TRACE_POINTS next to your
   #define CREATE_TRACE_POINTS.

3. Make sure that the header file is visible to bindgen.

4. Use the declare_trace! macro in your Rust code to generate Rust
   functions that call into the tracepoint.

For example, the kernel has a tracepoint called `sched_kthread_stop`. It
is declared like this:

	TRACE_EVENT(sched_kthread_stop,
		TP_PROTO(struct task_struct *t),
		TP_ARGS(t),
		TP_STRUCT__entry(
			__array(	char,	comm,	TASK_COMM_LEN	)
			__field(	pid_t,	pid			)
		),
		TP_fast_assign(
			memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
			__entry->pid	= t->pid;
		),
		TP_printk("comm=%s pid=%d", __entry->comm, __entry->pid)
	);

To call the above tracepoint from Rust code, you must first ensure that
the Rust helper for the tracepoint is generated. To do this, you would
modify kernel/sched/core.c by adding #define CREATE_RUST_TRACE_POINTS.

Next, you would include include/trace/events/sched.h in
rust/bindings/bindings_helper.h so that the exported C functions are
visible to Rust, and then you would declare the tracepoint in Rust:

	declare_trace! {
	    fn sched_kthread_stop(task: *mut task_struct);
	}

This will define an inline Rust function that checks the static key,
calling into rust_do_trace_##name if the tracepoint is active. Since
these tracepoints often take raw pointers as arguments, it may be
convenient to wrap it in a safe wrapper:

	mod raw {
	    declare_trace! {
	    	/// # Safety
		/// `task` must point at a valid task for the duration
		/// of this call.
	        fn sched_kthread_stop(task: *mut task_struct);
	    }
	}
	
	#[inline]
	pub fn trace_sched_kthread_stop(task: &Task) {
	    // SAFETY: The pointer to `task` is valid.
	    unsafe { raw::sched_kthread_stop(task.as_raw()) }
	}

A future expansion of the tracepoint support could generate these safe
versions automatically, but that is left as future work for now.

This is intended for use in the Rust Binder driver, which was originally
sent as an RFC [1]. The RFC did not include tracepoint support, but you
can see how it will be used in Rust Binder at [2]. The author has
verified that the tracepoint support works on Android devices.

This implementation implements support for static keys in Rust so that
the actual static branch happens in the Rust object file. However, the
__DO_TRACE body remains in C code. See v1 for an implementation where
__DO_TRACE is also implemented in Rust.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3119993 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
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
 rust/kernel/lib.rs                      | 32 ++++++++++++
 rust/kernel/tracepoint.rs               | 49 ++++++++++++++++++
 samples/rust/Makefile                   |  3 +-
 samples/rust/rust_print.rs              | 18 +++++++
 samples/rust/rust_print_events.c        |  8 +++
 scripts/Makefile.build                  |  9 +++-
 21 files changed, 374 insertions(+), 67 deletions(-)
---
base-commit: 65ae9c6348cc15f77e2ce2ff41c2bb14de9460d6
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


