Return-Path: <linux-arch+bounces-5196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E967191BF6D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 15:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994632852BF
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69615FCE6;
	Fri, 28 Jun 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCBVeg1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93991ABCDE
	for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581049; cv=none; b=LvgKleQUwiOQ+CxxOcl0/pN5mjYFsLfXFyTlj0X2mbsJSz0Xc2D33DeiSd+TrqUxWKEVhzXbf+kf51aXSdcsE+RYVHflknLPHrXkn0C2E622ImOcQ5H3H2EluPHCAjdNd4aJEQC5MyrWz3MCM0JNrrdJ9yPgBwqmm9vxxMubk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581049; c=relaxed/simple;
	bh=hzMKCUkrpzkRAGO9VQJLlq3A2y9r17X3xIBP4Vh3xGY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W6wTVSl6raHYDwP6SKnJRI/0WxTb/gtBPJVtq7tAhGp5qpCPfdV5qkr0YjydLXEBY02OlvkTUB6VMq0gaJ6wul09Zf+qd8hKglqJQsOabRe44oTsB8brQbib+mVQ49P82TPJPPi2enaG1OzBRc8nzaBgBWIpkpVV79EqFzNzPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCBVeg1f; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52cdcd4c07cso522175e87.2
        for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2024 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719581045; x=1720185845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZuc0ScsA+/koJOZcfg/TO9U75OyrluCKQ0mW+6QsHY=;
        b=LCBVeg1f3T/T5q9FOliIgwEzrlzYsrztTJJyUcmfpDO1bzorVMYZE8X8KWN2Z+6mkv
         OiN/pqP1y+fh/DImWf9V/HAnRiqW6GPuelCLVw+mDPhrPlS66fg+7MDmUaxdxmUdv6oI
         vKcmhiE9itOBYZO9SUwaCGtMXsXJQC4+PmDXShP+3b8w2ihA42Y1iHjOBB9cCo7vELyB
         nkVsZvLsOlM9IKE5qdgOUmtZpNZNaIZe+39ViLyg8cl6qEB3jDWGoNFewsY3UEfGRdgs
         05evw4lWA1/jX6+1WhkKcF02DXHOPnQtcw3bHTezu1nRGN5UClb417JIU7c70KvAVdqg
         +fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719581045; x=1720185845;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZuc0ScsA+/koJOZcfg/TO9U75OyrluCKQ0mW+6QsHY=;
        b=boRCr5JpwU4idWiLV9Smf5qvCpFIpGJPOsG6pRkNCdEp4k2daOwyaHlYDcjGw4jxnI
         MtUGH3kq8XpVbIDTcYi5UNrIidJ8Hy/ogQf472XSsuo82BD+furOSyFuQqOWDhdBRXmP
         TTzXcRGPD9sNUj4uLbmlAUzo7Htq50XVnMZRHm2ABPFMK/Iq3VkP3MDCxYm/LP5Gj/x+
         DEEPu/FZ1n1hmkWX11QTPncbIV2U9nmee1SYjtDl6cpm3+RZsZf+9MuZvjVbvAwqFYLF
         1rv1nehsv7g4QOkETr4P3Yv+7G60OKCVgEdXRIwlErkeNmueyrUI+E907YZx5DoWkOa+
         mJsA==
X-Forwarded-Encrypted: i=1; AJvYcCWEW6d/X9OlyN7gOhnkRnUn0T/TFiTN4BnD1i8qlsnZIPtTgwWPOS2fIMMgUBttdqrWtwUugmdrbkTJAF5yLwvQLlhKN2carQ9sOg==
X-Gm-Message-State: AOJu0YxueFsogI163A9Jtu1rrny9Bz7S2pwDnThzUfOV+EtlV6obEMw6
	6+fKbHFheau48fmoU3gs2RhIO7oJ47Zel3tHYydW+QPpubvJ4jf/avS/mRE+J7hsk4i0fgVwf6y
	s6Te2XFfwDIvUlQ==
X-Google-Smtp-Source: AGHT+IE3s//RYh2BQPLm30cB/Ms2Ha0xC/ghnkwEKFAjhQY+6EEvGjCjw7x+BTYon4IlDQWqeM7sWCMGUVZNEmI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:334d:b0:52e:7030:fc6c with SMTP
 id 2adb3069b0e04-52e7030fe47mr5341e87.7.1719581044824; Fri, 28 Jun 2024
 06:24:04 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:23:30 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFO5fmYC/23MSw6CMBSF4a2Qjq3p7Qt05D6MgxYu0EQpaUmjI
 ezdwgiiw3OS759JxOAwkmsxk4DJReeHPOSpIHVvhg6pa/ImnHHJNNN0CqbG0bthogIQlL0wlCW
 QDMaArXtvsfsj797FyYfP1k6wvn8zCSijWinQvLStAnvrvO+eeK79i6ydxHcW2MHybFuD1jQVW KHUjxU7y+FgRbYXlBIRDbfV0S7L8gWd4iEZHQEAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4798; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hzMKCUkrpzkRAGO9VQJLlq3A2y9r17X3xIBP4Vh3xGY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfrlotXVffeRQRKmrpCRkQR9ZrzcTwpekmobmU
 hNI4tnCMOmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn65aAAKCRAEWL7uWMY5
 RsFBD/9DKLutdOjG7/ZJI58IPTulEbu48TdU6ZyV/vYvd8zD8bbqyQNkfDF1tzG6cHhCWq5YL8D
 kowOvXjKKQdJtflNTYxJANR3G1aae/i87+LlNcZNZO3byBu38FT0TNoxhHFRIIW80ucAuqQxwlA
 nrMmUqAyOWlkOLxmPN3WexWqQyaQAVuBSe3kzxEXSLwYM8INtmrPVLfQrowQi3D6AIJT6WpDl2n
 jY+eCHzQKAH0Aj7xy3EY5c1D4gM0qrhDoEhmy6TI12aFUddDtj371ObSa7HgXNBzl5cTFNS8FzF
 jZuCIVsIHyCv2kPeIl4y9wZS1jlNagSdu1i1ldGstuNWjbJsQ6FCsZX9IdR4vNSaJS8pSHD1q7D
 pOrakf6f5CqbjFbGcXXaNL4siCs/M94wYjmcPLto9pkJSPeDuCnrIpm+7rvUFG0Ev2F6lSVazAP
 OPAfx8p6Z2lYOerI8jdVDaA7uPl75817hzdbSJSg2Q/Z5j+ZjfY0/w7hxjvoFmYAel6Xbu9Wj+I
 kkX6m6xwDYo5JqRT7E6pmia7xUvFw/NLfrV4qpESjb8fAdShSQsUoi0OpICpS4FsO5lqvNIfS6+
 5GNs7DNrSlY+EgemU91Ph8ODIzA+MnA8k+wgkZkkmgkpuuLgodqR2E2WBoi9Iv9OBlHsm8PivKf g8A4yhIBuRyXNig==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-tracepoint-v4-0-353d523a9c15@google.com>
Subject: [PATCH v4 0/2] Tracepoints and static branch in Rust
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
	"H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradaed.org>, 
	Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
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

 include/linux/tracepoint.h               | 18 +++++++++++-
 include/trace/define_trace.h             | 12 ++++++++
 rust/bindings/bindings_helper.h          |  1 +
 rust/kernel/arch/arm64/jump_label.rs     | 34 +++++++++++++++++++++++
 rust/kernel/arch/loongarch/jump_label.rs | 35 ++++++++++++++++++++++++
 rust/kernel/arch/mod.rs                  | 24 ++++++++++++++++
 rust/kernel/arch/riscv/jump_label.rs     | 38 ++++++++++++++++++++++++++
 rust/kernel/arch/x86/jump_label.rs       | 35 ++++++++++++++++++++++++
 rust/kernel/lib.rs                       |  3 ++
 rust/kernel/static_key.rs                | 32 ++++++++++++++++++++++
 rust/kernel/tracepoint.rs                | 47 ++++++++++++++++++++++++++++++++
 scripts/Makefile.build                   |  2 +-
 12 files changed, 279 insertions(+), 2 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


