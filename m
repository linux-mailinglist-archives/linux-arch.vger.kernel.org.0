Return-Path: <linux-arch+bounces-6116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187794C399
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B2D1C2123E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DA191466;
	Thu,  8 Aug 2024 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HiBJruDB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B919005E
	for <linux-arch@vger.kernel.org>; Thu,  8 Aug 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137828; cv=none; b=RaQVBOPiWoVd5myuxzLqkBiXiihe40eO3QHLWKPqTlmTnAVZQbmX6A2hxfWzrKf0DL51yQHOMp/angzNy8yqtiBymMeZZohC4yM4l5SB0IZxP6JnVumIG3D7uox271O/dAzdQaklVnuWdEbKlGydlWIxkQZLd5k4akjfVwpEvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137828; c=relaxed/simple;
	bh=EXrTZ5R7zXGaTHEthIw+hSVSLI3+CtkeI6b60UAGLWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h/WrHB5VVk5lXDSRZI2euNyIpCobCzO4kXztJLLZFh5QZLzKdJIoON9yf1cArwNX8zFRYMzhc5zZXjzBnWF7DrLRoDMr13Gj8bImhU40ZukwLq2ddY4E72cNAENpC7QQKl/36gE+9pbmKf+POgNZ9N1v4HR3tLlz1cUE3/2RIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HiBJruDB; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-368374dc565so425923f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2024 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137825; x=1723742625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lj5cEaK01DMF+Ts55tD11YdG34VpHT9zpqu9sa/BQA=;
        b=HiBJruDBG5DfhS7ZuhQM86suJbWdXW+hO4LMvqTVgwUs/0pwdUZ06w06g0TXgyTqXn
         GjDBMSuLfseC4M/uEx57PDtjREDDoscFzAlXMqyJznkMukEN8fVfoODZYoHxOWM2pRRk
         0CrzPgynuObpqWEjI5+oX/+uXOabfIewGR4gnq7g3lz//DsZYtMyviDiQZXAX9feUV3r
         Zew6OGAfuch208EjlexQK4P9VpN/iq5xdtZTctZ8170nWi1mGioIW+u4F8rwloWDlbdG
         MWHZQF53G/ScvWYXjqDN7ZZuAYFvjzkbC9JqsYjWAbsj1IaymDLaZTyNlKnJBdkQJP5q
         i3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137825; x=1723742625;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lj5cEaK01DMF+Ts55tD11YdG34VpHT9zpqu9sa/BQA=;
        b=RwvVOPWCnY+x0x4d1SL48nSHDiHDkqOQem5NEblxr/nRv5agnnsLx5VzAZWV4KXX8X
         SZ0u52BeP5L6b2iKbzQQxfRUeMH72BgGSMt94ExXJszQe5oG8KJpNpZTsILTQS2PqcCa
         zsIffYNHJJU+PEx2mHUBCwEPurDz8UyJl8IkLTxMKikBLpD6jTyF7rHNLiMdjo/MKopS
         Xs5Q7Np6dF7OeKhHHINTcAI5OZVKGez2f3ozGUhqAjzKZte9vLTXCKMZlZaJ7HfM52XK
         ux2cvc3s51oPunmOI8tyzEgmFPczWvm0rx/KyUvUW/GXQw+nZC/VS6wkITEQ6Gd4h8Mc
         PEcA==
X-Forwarded-Encrypted: i=1; AJvYcCXbMUMqWTtkhehAtVABm6zCe6qUDyfaFWL8L5I/TdM7DYp6PRUAZP6oIZxuLese673qTW0EBLQC4dap@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhyW1N22N9lSSBxlyBRFDyrCjj0vYRHXVmiwj9bB/sroyhnP8
	RuByRjASMsj1xajzsMkUMFmigIku2OWEPSjrryVkHrb8fhDBKgqMZJkfKRJDdiUbVzBoZDeTz3u
	VtSzB7M/KMxk+1g==
X-Google-Smtp-Source: AGHT+IFUyUu+65lTZkbGz5xkESYfzEgxbLVm+RbfRwHdwMW5RdJRZNPPWyqzUyct2N0zKQrC5Yb9Bug/AQUUIsY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6000:4014:b0:367:9812:b7e3 with SMTP
 id ffacd0b85a97d-36d2758eba5mr4651f8f.12.1723137824521; Thu, 08 Aug 2024
 10:23:44 -0700 (PDT)
Date: Thu, 08 Aug 2024 17:23:36 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABj/tGYC/23PQW7DIBCF4atErEvFDAyxs+o9qi4Ajx2k1kTYs
 hJFvnuJNzVylw/p+zU8xcQ58iQup6fIvMQpprEM+3YS4erGgWXsyhao0CirrJyzC3xLcZylBgb
 yrWJzBlHALXMf71vs86vsa5zmlB9be4HX67+ZBaSSlggsnn1P4D+GlIZvfg/pR7w6C+4sqMpis
 b1j77oGvCY6WL2zCJXVxbZsDDM79M3Rmr1tKmuK1aQ7Qu3aAEdLf7ZRWFnabnZgjWlNF+r/ruv 6CxPXLhWVAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6191; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=EXrTZ5R7zXGaTHEthIw+hSVSLI3+CtkeI6b60UAGLWU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtP8apye15CDPjep8a4sKbnjhVshmQj6bqmEpn
 FY/clEVV4iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrT/GgAKCRAEWL7uWMY5
 Rn6pEACJelIjUYMObVtpvs7JKcQ/GkHNHGNbyVCyd2s7wibhbrfX1MYZ22uey8alwOOYoAABCnX
 oVYjkJUUFisP4QR9yOy4cgV+2SPewumv8vEPfIm/46xYfbvkPwM2d4kUJrsFKsJY17ljll2L5br
 IBsGTTcBscKsnI96M1/kBhykao3Ba6wcjc1CKbePG1XNHOwIIwURIMNQP2JltG1syenoCRVbb6J
 UPAKXNYPb+eDt8kNMRBpKzD+q+6aQcDUB5Il2VgQAvhV0B11G0rVkBgJ3UrUOnuIcbpWGhb6wfn
 BEFrvyEk2A2PuDz5QmkBGym1Ts9uEV1/JzQDr6UH1m6Z5jzy3aZ0XrVrkMN0uAxRQxebID41Cok
 6qfFbFF12H4ygvaSrCCcbo9vB4ws2pAOa5G8rsNuqUl67UL8BJzdulss1MieqD3o5JnzLlKhTk2
 UasU3G9XTc2+xzyfmoXvmH6ZWCnKWTxc0D0B5AsH0yxrMdVbW6ymo9GGsAOEyBlbOKEADCCcQuA
 etl5yY6SvHpw69V5tOpSGGot2s6wwZ7JZZ+j/ZpjOTmC6PZNvPdWb3vvS5k1U85231d5zkrH7fm
 hK/wpLZM7TZAtS70qsbbJAda95xy1x1S8DtiMCUgN4/8J6vs3Qe43wguoau5p81BS9fda7sl/aB +AA7X+swvP8JnCw==
X-Mailer: b4 0.13.0
Message-ID: <20240808-tracepoint-v6-0-a23f800f1189@google.com>
Subject: [PATCH v6 0/5] Tracepoints and static branch in Rust
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
 rust/kernel/arch_static_branch_asm.rs   |  1 +
 rust/kernel/arch_static_branch_asm.rs.S |  7 +++
 rust/kernel/jump_label.rs               | 91 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                      | 32 ++++++++++++
 rust/kernel/tracepoint.rs               | 49 ++++++++++++++++++
 samples/rust/Makefile                   |  3 +-
 samples/rust/rust_print.rs              | 18 +++++++
 samples/rust/rust_print_events.c        |  8 +++
 scripts/Makefile.build                  |  9 +++-
 22 files changed, 375 insertions(+), 67 deletions(-)
---
base-commit: 58e218fe517eff550f8a6cd5f2179d973b006d10
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


