Return-Path: <linux-arch+bounces-7513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9598BD9F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 15:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763FF287391
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C11C3F2E;
	Tue,  1 Oct 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAgvNApl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA919AD48
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789434; cv=none; b=Pf2mAFFnhsBvXJ4ObXMHqrLeh352/JM0NSkou7SXeMC6AU7rdWzejjqC9orowiC7qhcdcdk7DzNjkB4cwhWZ4uxf55GdXVNE48znzeZ5TU5fFtr/9UD/sf+Gh1FVH4ZM4TN8v7KWfLrhfKkwREKG14xplGgpcgC5Urb/l/zLH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789434; c=relaxed/simple;
	bh=EuQfsGRSnFvQkOSYyYtL4wlXIaFohOp4AAuswzzTlBA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lMKOSkpo1A1B8UJhW/oF0SkCF743m4O/QUA2r+PT5Z96YlzNIIU2pgcFzlU7wND/f0YpFpRPbkdbrwp4s+Y2/+x2Q5xRlmuhWPvCqAFdVWoC0yixabX/S/VMnNG6+idIr0PTPYh8vLfKRr5ybDrcQwEQ/wnrZP7S8TTBqDaINTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAgvNApl; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37cd19d0e83so2299545f8f.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789430; x=1728394230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UvkAI2ezVCV1+xfQf1VHdfrgir2ol5mq7bS+vL+s0sg=;
        b=YAgvNAplBizxDHacSLKuxSXMcZTuTnDxbWhH3YB1wyCP36UZ2GO0zOygeb5CJ6uI18
         aKGFTcQiQsI0mek06k6tpeFcVpGWFoNvijoAYJuLVC/rcYB19VHNmgZ+ZcO2muHKjGt6
         zr1L98cYPHkH1FP33fegtYf4gJ/sPOnceGuLF/irXEb7zYzciy73Bp/V8FAA1uh85KHW
         YE8OnWDxKjWZTx3a4qFvj50l96Rt4I7AzKMAwjUoSUKAazIRIsk9TSPBgCUJCf8pg7y1
         bXFJRymoA2/3hPgZK5h85NuE6pZl6czGW+WovQaaLkmicBK0zriKHW+bEkFtdNVPefRo
         9o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789430; x=1728394230;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvkAI2ezVCV1+xfQf1VHdfrgir2ol5mq7bS+vL+s0sg=;
        b=IZNOs6rwPnLh4VKvQhpRpks7qoaBxbWIpO7DxVkKloNf61y8s0+CVrNDFdelpefOcd
         MIzSZHk5TKwqqoo3Khv4DZu3eXHHc9aK+hqn9rJZHXza5YmaqZcrHGPYrf9UKhCVEdlA
         gixijI1RhcMVkHn/ON0REfJ09/kzNeUfkeWwW1Z1OshTv0/TzA0N2izQr/dPE3JZGr5K
         JU+qA0obe+GsTDUZtapHBkwqk7BijSsiKhtgcEHZiJmq/4ugn2mYqkr8rBZ3u5AIO5Z+
         x9Svjvv/bVK+OlSvXOTET++EkIk+tI6zfpTTu1EQdJTLd2TESSnTwJFmiXrpILCSFu2f
         a0RA==
X-Forwarded-Encrypted: i=1; AJvYcCVJooDwQDn5z30qFBbeULfXQdxqYSPjCkkXn68Wtnuhny8+1HYW7S98RbC/ZVGAA8CV44+4dGn0skUM@vger.kernel.org
X-Gm-Message-State: AOJu0YxRrtddwKrdiSWrHnssbHR4Yn96fYthASaxYNbOtFl6idBFPOOO
	2uxgzw6ScfaQYfJbvxMuJvV9j79OT7MrUpotBFfsJoDpKQA6a/PEYk+Iy/FDMj05ks3lsfqVw52
	fqH3UymKVmjcoSA==
X-Google-Smtp-Source: AGHT+IHXgOjCejMhQoRo8D7+eGvecwut1OC+PilR/WsDs1KkVSfaAA4AaaW6IeXlhCa5WDmo9bJn4/3pPSEbNak=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5d:688a:0:b0:374:959a:7811 with SMTP id
 ffacd0b85a97d-37cd5ad1afamr9770f8f.7.1727789429265; Tue, 01 Oct 2024 06:30:29
 -0700 (PDT)
Date: Tue, 01 Oct 2024 13:29:57 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFX5+2YC/23Qy2rEIBgF4FcZXDfF31t0Vn2P0oWX34zQjkMSQ
 suQd6/JpopdHuE7Hn2SBeeEC7lenmTGLS0p30swLxfib/Y+4ZBCyYRRJqiialhn6/GR030dOCB
 IZyiKEUgBjxlj+j7L3j9KvqVlzfPP2b3BcfpvzQYDHZSUoNjoogT3NuU8feKrz1/k6NlYZYE2l
 hUbLTobNDguZWd5ZRk0lhdrUAhEtMzp3ora6saKYrnkQTJujYfeyj+rKWusPDdbUEIYEXz/XlX b9l5VrGU8akojgDadHSsL7T+PxQZFjTOgnIbe6sqydrM+NlMvtTGoYuCN3ff9F+io0kZJAgAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5033; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=EuQfsGRSnFvQkOSYyYtL4wlXIaFohOp4AAuswzzTlBA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+/lbWtDLiH1fvK8DtDguryGaG1fJxaVCNAZZe
 kyF+GTyGpSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvv5WwAKCRAEWL7uWMY5
 RhfrD/40zsEgbUFlRGWVdUb4OVoayz7RTfDf+iIi7bmPlDW4nPKZ9CTqAC0MSderuFQ0wXfeZh0
 BbkQztnF54R81W3P7pWOdOCshBGm8fTVXXViSw7q5D2Sp0ik5oep6wI28k6Ub1TyQVCyUeGYxQi
 TuR1jsmeFr3NxQOamMFhvpYaeRS2oPBiOuXjtooA5a8ulJlkctNntTlblXVvZabngkX5iTJS/nM
 gpOSeqo7q+eHdXMsbPmtRyRpdPPiDc1Jpunqq2Ub8kn2ZnU1cfsId9iCprtza4jnzlmufNdGnUb
 9J6b9JKE7IN+31IRaPqJRLGdfOHL6yy+2TgtuVbt+VpZ+wjJkn4r+AW2BiYkVBrA8QSQDxWHg7x
 jCD4zuUrqI3sS/SiqRbqW9yvvrBf0lsWuStVMLrrVSfeyk2kOVvw9X5P1mhYpiIJEf/EuMFzKWX
 btPq3cqAHATbL6+9ZqYqvqMMWsfMOtXWQLrltqLD3BATYZNq9k10URKyZJ94s2zX7guFtOUM8Xh
 pvznqTX2ij3Oo23X8ZCYQzwNGIBeSTt601O4uGM8omHYDELeuKlJQ52/0KtFeB2z7Q7xwLZB/nV
 1F+mv7Nh0/m1B4iKcKdjRBLvGkWBaBoF8LqRf/IB0lzpzHDZ6gccgxe1Uh9UDRtorKwCTx/WxxV bSGOt4f2G1NwgRw==
X-Mailer: b4 0.13.0
Message-ID: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
Subject: [PATCH v9 0/5] Tracepoints and static branch in Rust
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

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3119993 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
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
 rust/helpers/helpers.c                  |  1 +
 rust/helpers/jump_label.c               | 15 ++++++
 rust/kernel/.gitignore                  |  3 ++
 rust/kernel/arch_static_branch_asm.rs.S |  7 +++
 rust/kernel/jump_label.rs               | 91 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                      | 37 ++++++++++++++
 rust/kernel/tracepoint.rs               | 49 ++++++++++++++++++
 samples/rust/Makefile                   |  3 +-
 samples/rust/rust_print.rs              | 18 +++++++
 samples/rust/rust_print_events.c        |  8 +++
 scripts/Makefile.build                  |  9 +++-
 22 files changed, 386 insertions(+), 67 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


