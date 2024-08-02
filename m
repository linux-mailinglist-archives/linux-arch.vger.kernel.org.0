Return-Path: <linux-arch+bounces-5912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FEA945B00
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6228120F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306851DAC4A;
	Fri,  2 Aug 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3y8NmVXE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663951D1F54
	for <linux-arch@vger.kernel.org>; Fri,  2 Aug 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591116; cv=none; b=GcyLz2sVtfu/egFrbqZ63th2NtYUZ5BiDaArlqtDub4J9OThFh8iCBPq0cBfIh/t0QudR9DzDokkoNCD1C5VOIgpMXbjlBzow3SqQorxAu2T5GlTSTp4YYgJbz+4DFc2PxvBwvI9VaNGouSOqY8gWSLL09URJzFzXsTpYFlw+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591116; c=relaxed/simple;
	bh=Lq8/8nOedBDzGVATWs1OYBNxhNXFDJ3hob4IMvf7KlE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UnripYTmQPlxIo5Hdd9tKPvnME5N55Ynur3Xi1IyT5xV10fP+Q3Y3pkAhYux8P/OTC4ijgasD3EgU42da2aqTJfSLm3Fy7dZSzgw182pMVUnl2lmQlAeRxEFtOKdZU44XyP2mPIJ7EsJQOCxJYwlj3AyOxRVHv5WACvaAFYOkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3y8NmVXE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be7c74d79so735572276.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Aug 2024 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722591113; x=1723195913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RB3WNrleQAM+G8VZ5UON6+iAnj1EW7T948JJOLSla1M=;
        b=3y8NmVXE7ygpGGbDE6UoiDi5k103CDCpEBXQA430GGmFdx9a5yPz1PNIxRs7Tg/nXo
         9iOeAVKiG4MlpWyjDPyEzcJasEdB2+fw3sztNlNrOBIDb5/P5S1LDH1JBDfkfLXBsCCR
         LPfJ0+m+1bRV/nfT2CaQJVOICm15EspV1+vJxgX3nBRdmCVvkURxVUj6sbgWB3fW0x4r
         KDE1hdjbCfAGLhUJLJbc0ZZwlgLlsjq+wUQ3+VwYAutNQvfk05V8EXFDuNvqt+C7ZfwF
         Tal5NW9oVJiTf/46rjFQwQ0XcjVHj+LEgnzm4WSGkGYRYg0ndA7RnFFZhhHuPYHOiYW7
         WBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591113; x=1723195913;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RB3WNrleQAM+G8VZ5UON6+iAnj1EW7T948JJOLSla1M=;
        b=KCWQMZ3ymxbVYshonJqeV16uO1aPqBLs7Iwt0bbx8kwFWbLTag5m+SLChcjZ64pMz6
         5qxSu5uBPsNHGsYVPQ9kTXQWVfx/Ti9RUw/L6NTDWRGKb6LJnJZbLJ7Q+Oq1EocBt3ll
         Wi96Obf9Azh6fFSNTfJHvavMJvg6XUSuyqL7WYDKF74VS0FIAkcGoQIIUOliP7iIFQgn
         PxkndLQA0Ga6zijQ2ljnCRAPFGvzNqkSdiP0Q96Q/lwUq7CErdOcJcxq0O57Qg2hHqzp
         RM0UrCraF8NnWujb2UmdLYMPP0iJODVdVuTvz7fF7G7DVSk4OSoNPYJ6a0FLZtI8FAHi
         asyw==
X-Forwarded-Encrypted: i=1; AJvYcCXR69CEB/r3flvvmXBZ82xH7WhWnp9ZixuObmuEEKIwll1hzb4VFPmhLm0nc7+ryJtgTfb43UR+pul8QQGHPx1gUNlfPpwxj/7D8A==
X-Gm-Message-State: AOJu0Yy7AqNJUyE/tkN2yNHMW8wczoSz9M6Q1rAqOcwZCpo/WbBvC9KA
	qYXq22G2b7QJPy9CeqgO3lkzRiVD5suDOOaJxRuCpPeEayQ1WyH2u7E5vO9WrxKnQ+d4WYhJgGW
	OcCgOqFXVRwX0Lw==
X-Google-Smtp-Source: AGHT+IH2SpPyciT6fSHCADXNwAw+3O5Dddl/hDZQ/ZAbwThOiynggNtR8Jb6ii0WHgf1CQZJNfb+sDHyDgWAtjU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2b8f:b0:dfb:b4e:407a with SMTP
 id 3f1490d57ef6-e0bde42f736mr101860276.9.1722591113252; Fri, 02 Aug 2024
 02:31:53 -0700 (PDT)
Date: Fri, 02 Aug 2024 09:31:26 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG6nrGYC/23MSwqDMBSF4a1Ixk3JTXJ9dNR9lA4SvWqgNRJFW
 sS9NzpS7PAc+P6ZDRQcDeyWzCzQ5AbnuzjwkrCyNV1D3FVxMymkFqlI+RhMSb133cgVEKAtBOk
 MWAR9oNp9ttjjGXfrhtGH79aeYH3/ZibggqeIkMrM1gj23njfvOha+jdbO5PcWRAHK6OtDVlT5 WAV4smqnZVwsCragrQmIiNtfrZ6b/OD1dEqVBVKZYoSjnZZlh9hikQHWQEAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5489; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Lq8/8nOedBDzGVATWs1OYBNxhNXFDJ3hob4IMvf7KlE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmrKd5qxNN60MM9Isjj5Ozq2KvtpES0WddiLx4u
 o/HqJe9DzyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqyneQAKCRAEWL7uWMY5
 Rif5D/4/vw17knMOrEm4mmFX3Sfx6OQs0LSlcl21lcHjy6j3fghqzlcApxtxBOUw1QLNf1ftRy/
 GoW1KcNfX/5rPYP3S6hA6Sz2cDxKENAMFnDnPgYFO3A1w959iOSTq4VUtp4VHEKditqFinhmWAs
 rkcZsorqa8vMgsehYSiH0eaLBX//u85RKWrYXdfKcw0S4hRTPN9okvD15zNuWsrAJEw5ONgjWly
 VZ7Y2NZpMKcpb8qUoO+xRAEgqW9jq5OoQ4HWhmBCPV9RDBEH0tI0v+BGOlfXXL8dJ7HU00mpM+7
 OnTclmtrDRfCTV2TMIzvtYbP/XKQJJeYNe03zFKg9RQ/khmeoaaawzd3pgizqlLu5H8MXGEYpMV
 6oSfZvXuQJjBafgtG6tPSjibHd5K1yNHsf3BjAoBLRT7qPTxo/UZREVafvywDqnDMdKCw0FBvZp
 NILBX/3fD0duKMlB4eGkX0Lf6P7UwiH2gdD7tdSH0TT3Pc+XK3FrD0P0KoBsRNs/3pWIWD+fOGV
 RBzogcxgZ3Q0vcciS3ftotHwRi7RjKDdO1wQ9A43xdZIb9ZQ7NKJGghX3RjbpSAhhsWCG/feTpQ
 issvvAxk6x4/DXDsJW38TzatdwnTLsCuvTJxTBJqF/Omh4BMZgjbN2Xd4fY2z+/hz3w3f6zSMCt EjNDWJ8TKpPsG4g==
X-Mailer: b4 0.13.0
Message-ID: <20240802-tracepoint-v5-0-faa164494dcb@google.com>
Subject: [PATCH v5 0/2] Tracepoints and static branch in Rust
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
	Alice Ryhl <aliceryhl@google.com>, WANG Rui <wangrui@loongson.cn>, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="utf-8"

An important part of a production ready Linux kernel driver is
tracepoints. So to write production ready Linux kernel drivers in Rust,
we must be able to call tracepoints from Rust code. This patch series
adds support for calling tracepoints declared in C from Rust.

To use the tracepoint support, you must:

1. Declare the tracepoint in a C header file as usual.

2. Add #define CREATE_RUST_TRACE_POINTS next to your
   #define CREATE_TRACE_POINTS.

2. Make sure that the header file is visible to bindgen.

3. Use the declare_trace! macro in your Rust code to generate Rust
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
Alice Ryhl (2):
      rust: add static_key_false
      rust: add tracepoint support

 arch/arm64/include/asm/jump_label.h      |  1 +
 arch/loongarch/include/asm/jump_label.h  |  1 +
 arch/riscv/include/asm/jump_label.h      |  1 +
 arch/x86/include/asm/jump_label.h        |  1 +
 include/linux/tracepoint.h               | 22 +++++++++++++-
 include/trace/define_trace.h             | 12 ++++++++
 rust/bindings/bindings_helper.h          |  1 +
 rust/kernel/arch/arm64/jump_label.rs     | 34 ++++++++++++++++++++++
 rust/kernel/arch/loongarch/jump_label.rs | 35 +++++++++++++++++++++++
 rust/kernel/arch/mod.rs                  | 24 ++++++++++++++++
 rust/kernel/arch/riscv/jump_label.rs     | 38 +++++++++++++++++++++++++
 rust/kernel/arch/x86/jump_label.rs       | 35 +++++++++++++++++++++++
 rust/kernel/lib.rs                       |  3 ++
 rust/kernel/static_key.rs                | 32 +++++++++++++++++++++
 rust/kernel/tracepoint.rs                | 49 ++++++++++++++++++++++++++++++++
 scripts/Makefile.build                   |  2 +-
 16 files changed, 289 insertions(+), 2 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


