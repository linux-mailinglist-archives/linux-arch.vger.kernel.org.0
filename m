Return-Path: <linux-arch+bounces-12404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF00AE0A35
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826551C20EC5
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF528C5BC;
	Thu, 19 Jun 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoPIKRk2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BA28C2B8
	for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345886; cv=none; b=sDQHDb4j6ZdWCrUXei+Qj8tdeW4mkxBeBLCwvF54UxS2c8xuEa6wgi1pLgD8qnQvfQsWNkxUdz5IdcFCm9i1JxYFTZA9pDHfkBTSived2cGTSqgZI9V+xjqwVAkEyyEQNUmDA7ycjXXDVRIKk+m5rRFrol8gSDBp2QtUqbCS1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345886; c=relaxed/simple;
	bh=tqKJRFWo4M9VGfuvuDENffmGS3Z20jRq6zUxhulLQgE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bXe7f6iLUbRl/CfkH5LRAmN5mxaKBoEG/Jhl6WKtdN9Jid3zWYc+u9a13RX0GS2fTAbhfgUMDwvzKd/dA5ES4uXOa2Z1sMaW+j3l5uAyJHy0o+IlRVjOyJU5GHnlvOv/XwpURrG4vzwTL3DEFGlDLO+e8Bd+tZUSgBjAv/pyuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoPIKRk2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so4717865e9.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750345882; x=1750950682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RqSblfyVaNLIb0ksq2WZM/4c53P9wG2ZkX/N+AT7PyM=;
        b=LoPIKRk2EavM/ucwkyr4GT949ipTLkowlluOqV8ERAr0uC6ZvTAZLKgXSy7vQDbif0
         kTID4mLm20PyRcXC9nzblIYxtbn5YJ/JudNZLIREdY4u9tIFcGhP4tTJV1uNuG6RkspG
         aibnJl9+Rcz1DLxALx1uAqLAR18AjUUuAW1SM2NWRamNh4sbC3zhEx2HgdvPKeENlxcT
         0t96Ffktp0o0NIOnUE6wNKxCSPq6ip4NWIvu6iW+cFUZLh2dHHyb5ExmaINHlEIOcYHR
         sPcfmnNI/utB9lS9iZ3km4xxSO769tyFZTQoAuh2Yni4ovie5pQNAG0yEFLoVyn/whkX
         BHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345882; x=1750950682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqSblfyVaNLIb0ksq2WZM/4c53P9wG2ZkX/N+AT7PyM=;
        b=MjUGbkQValF3yD2qCAobNMv75L915170Y2b2Q5+9sydGh3Bz1sbyS70L+dPC58ZcPn
         uNHKpnsPsTbZzvx85HKClHWOZf1S6tZaev+tT2TuV6M4+DG+bEzzClbp4qmtWWVa+viO
         1NibDm6xhl6atO/rsfrU1I4fq/tnBVdEBsoM40vzahy3Ed3y62yxNlKefC3Nltxb0wpR
         17ZlfKuESgKF8nI/P8I4xWRsbUqh5ncl6iE8nLNQuXktbXHNr4zm+WBOTiczhhGnJgkz
         tIg0nQXcpHgIrWHq2Ye7ujyS2RbICT6OtleilYCVQz46Z8ll4FS467CfPvl2u5af7mcX
         1bYQ==
X-Gm-Message-State: AOJu0YwK2sLZjA3cR7g+iHH7qAayFM6e22GPMms/qMti1zeAlKHPtsiV
	KY3ov7Mrz4XP0mGHqCCeIW5/b3th6Tcqt40MxWPxDUwDL9tPWjJ7esnm/0LQLnXtcim5ok2cxrB
	6oHhxwhsZBYZ5U1G0ow==
X-Google-Smtp-Source: AGHT+IGzRq3tHlg318hv4WqE3rmjTltkUE72IglWSFPJYzNK2SFRHYe7BzUKjDE/zeXMb7P6d8MT6bj6kb5o+TA=
X-Received: from wmqe7.prod.google.com ([2002:a05:600c:4e47:b0:43d:9035:df36])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5490:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-4533ca550e9mr217824405e9.9.1750345882498;
 Thu, 19 Jun 2025 08:11:22 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:11:13 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJAoVGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0NL3aLS4hLdgsS8zGRdi6QUQ5NUUzOTxEQTJaCGgqLUtMwKsGHRsbW 1AACuJxJcAAAA
X-Change-Id: 20250619-rust-panic-8bd14e564aa4
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=13497; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tqKJRFWo4M9VGfuvuDENffmGS3Z20jRq6zUxhulLQgE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoVCiUuM9UwU9dChnMTSwfdhQi3Ok3m+xC9ULm0
 qUNSRjNdWWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaFQolAAKCRAEWL7uWMY5
 Rj8FD/kBvGs4B/2oeLUN7b++tk0Rn8WvkMVLsGgmM3gdEwqJ2Q21ExsHYnPEIdZEUtL25CEd/02
 V+1zAcfkfDMgruPKfg9jiGbu59n+XA1K7ReXfk0x4Gwpwt/jioaMY7heSR7qRlzqD08ObqwKnSK
 CojD3G2BzyU1tiGK+UY/ltWxgJxaHfaBZTKTNslqhgfps3dobUF+9WlbfsiKjaYwV0dDwejoow8
 ruPbR+xlgnV9T1HUTTCcsg4NjTJw6h1ns4tvFfBGGECiSfYqKR15TxY4l+dgQhc282ySwM+dPei
 KGBxwqMjFlnhMRr//bk/fEio0dBJH2dmIKGaj32n708fqxCKlhIWw+jgnCT3l9PRWS043Nx+QPX
 7j7zzphnzYvEU39ovDYJ6YPw+9rKmd/Xo79GWVFJSwHbPMWkTlVjvPpOlN3+sCQzFI9baknqWfB
 YH1qNU2FPZDQ5zO3xSTVHWtzK44+nPcDTcFmT5AzKiuEOsTs1f7eE0R7WbWGsQxC/JABXXkhxl3
 3F2gqy/QbNpmUoNnNclyzK/Q/d6fBaF/PDoCkHR+tsPQoHGKQEM79UbrOoUAjjA6GZHD5zneFka
 7aoNEcpCQs77aFpF9DMKbvmHutyMq2aeMxN3oPg2O4Yrpss+NpqxzZQFN5kko4Dnj+AbTeRSRYh Eth7RRYHa66Xb5g==
X-Mailer: b4 0.14.2
Message-ID: <20250619-rust-panic-v1-1-ad1a803962e5@google.com>
Subject: [PATCH] panic: improve panic output from Rust panics
From: Alice Ryhl <aliceryhl@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Rust panics currently don't provide amazing panic output. The
information you're going to find first when looking at a crash is the
fact that the panic happened on rust/helpers/bug.c:7, which is not
helpful. To find the actual panic message and location, you have to look
above the cut here line - often quite far above when other threads are
also active.

Thus, change the panic logic to print the Rust panic information in a
manner that is easier to read.

This patch has the pretty major disadvantage that it unconditionally
calls panic() when a Rust panic happens. Since Rust panics currently go
through BUG(), they are able to just kill the current task without
killing the entire kernel. This patch loses that, and I'm open to ideas
for how to improve that. I couldn't figure out how to get a pointer
parameter into the BUG() infrastructure without modifying arch-specific
code.

Sample output with this patch:

	------------[ cut here ]------------
	RUST PANIC: CPU: 0 PID: 1285 at drivers/android/binder/freeze.rs:212
	Kernel panic - not syncing: attempt to subtract with overflow
	CPU: 0 UID: 0 PID: 1285 Comm: binderLibTest Tainted: G          IOE      6.12.23-android16-5-maybe-dirty #1 5a1e41f5fb665703ee943f126e14ab83f85d9b3c
	Tainted: [I]=FIRMWARE_WORKAROUND, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
	Hardware name: ChromiumOS crosvm, BIOS 0
	Call Trace:
	 <TASK>
	 dump_stack_lvl+0x44/0xc0
	 dump_stack+0x14/0x1b
	 panic+0x11f/0x2e0
	 ? _printk+0x58/0x80
	 ? default_wake_function+0x19/0x30
	 rust_panic+0x7e/0x80
	 rust_begin_unwind+0x8c/0xa0
	 ? __cfi__RNvYNCINvMs_NtNtCs3o2tGsuHyou_4core3fmt2rtNtBa_8Argument11new_displayNtNtNtBe_5panic10panic_info12PanicMessageE0INtNtNtBe_3ops8function6FnOnceTINtNtNtBe_3ptr8non_null7NonNulluEQNtBc_9FormatterEE9call_onceCsdfZWD8DztAw_6kernel+0x10/0x10
	 _RNvNtCs3o2tGsuHyou_4core9panicking9panic_fmt+0x4e/0x50
	 _RNvNtNtCs3o2tGsuHyou_4core9panicking11panic_const24panic_const_sub_overflow+0x40/0x40
	 _RNvMs4_NtCsepCoEf1YMFZ_11rust_binder7processNtB5_7Process16ioctl_write_read+0x304a/0x3680
	 ? perf_tp_event+0x21d/0x890
	 ? kvm_sched_clock_read+0x15/0x30
	 ? trace_call_bpf+0x144/0x1a0
	 ? perf_trace_run_bpf_submit+0x70/0xa0
	 ? perf_trace_sched_switch+0x17e/0x1b0
	 ? save_fpregs_to_fpstate+0x40/0xa0
	 ? finish_task_switch+0xad/0x330
	 ? __schedule+0x995/0xde0
	 ? schedule+0x6c/0xf0
	 ? avc_has_extended_perms+0x3ec/0x5c0
	 _RNvMs5_NtCsepCoEf1YMFZ_11rust_binder7processNtB5_7Process5ioctl+0x6d/0xa90
	 ? ioctl_has_perm+0x122/0x170
	 ? selinux_file_ioctl+0x330/0x570
	 ? do_futex+0x1b1/0x2b0
	 _RNvCsepCoEf1YMFZ_11rust_binder24rust_binder_compat_ioctl+0x1e/0x40
	 __se_sys_ioctl+0x78/0xd0
	 __x64_sys_ioctl+0x1c/0x40
	 x64_sys_call+0x1878/0x2ee0
	 do_syscall_64+0x58/0xf0
	 ? clear_bhb_loop+0x35/0x90
	 entry_SYSCALL_64_after_hwframe+0x76/0x7e
	RIP: 0033:0x71bb7b8e6497
	Code: 00 00 00 b8 1b 00 00 00 0f 05 48 3d 01 f0 ff ff 72 09 f7 d8 89 c7 e8 e8 f7 ff ff c3 0f 1f 80 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 72 09 f7 d8 89 c7 e8 c8 f7 ff ff c3 0f 1f 80 00
	RSP: 002b:00007ffe696e3058 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
	RAX: ffffffffffffffda RBX: 00000000fffffff7 RCX: 000071bb7b8e6497
	RDX: 00007ffe696e3188 RSI: 00000000c0306201 RDI: 0000000000000003
	RBP: 00007ffe696e3130 R08: 0000000000000001 R09: 0000000000000000
	R10: 0000000000010000 R11: 0000000000000206 R12: 0000000000000010
	R13: 00007ffe696e3188 R14: 000071ba9b40f380 R15: 0000000000000000
	 </TASK>
	Kernel Offset: disabled
	pstore: backend (ramoops) writing error (-28)

Sample output without this patch:

	rust_kernel: panicked at drivers/android/binder/node.rs:877:13:
	attempt to subtract with overflow
	------------[ cut here ]------------
	kernel BUG at rust/helpers/bug.c:7!
	Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
	CPU: 0 UID: 0 PID: 298 Comm: syz-executor821 Not tainted 6.12.23-syzkaller-g30b14cdad458 #0 c708c6bafa1314b3e84c64b9f03b67766970ebbd
	Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
	RIP: 0010:rust_helper_BUG+0x8/0x10
	Code: cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 8d 71 4c 30 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 <0f> 0b 66 0f 1f 44 00 00 b8 c7 b5 05 bc 90 90 90 90 90 90 90 90 90
	RSP: 0018:ffffc9000124dab0 EFLAGS: 00010246
	RAX: 0000000000000061 RBX: 1ffff92000249b58 RCX: 59dc727b65a9b400
	RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
	RBP: ffffc9000124dab0 R08: 0000000000000003 R09: 0000000000000004
	R10: dffffc0000000000 R11: fffff52000249abc R12: 0000000000000000
	R13: dffffc0000000000 R14: ffffc9000124dae0 R15: ffffc9000124db10
	FS:  00005555659f6380(0000) GS:ffff8881f6e00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007f76714410d0 CR3: 000000012e67a000 CR4: 00000000003526b0
	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	Call Trace:
	 <TASK>
	 _RNvCscSpY9Juk0HT_7___rustc17rust_begin_unwind+0x15b/0x160
	 ? __cfi__RNvCscSpY9Juk0HT_7___rustc17rust_begin_unwind+0x10/0x10
	 ? _RNvMs0_NtCshgDM7dBCdno_11rust_binder4nodeNtB5_4Node22update_refcount_locked+0x401/0x810
	 ? __cfi__RNvXs1b_NtCs9jEwPDbx20M_4core3fmtRNtNtNtB8_5panic10panic_info9PanicInfoNtB6_7Display3fmtCs43vyB533jt3_6kernel+0x10/0x10
	 ? __cfi__RNvMs0_NtCshgDM7dBCdno_11rust_binder4nodeNtB5_4Node22update_refcount_locked+0x10/0x10
	 ? __kasan_check_write+0x18/0x20
	 ? _raw_spin_lock+0x8c/0x120
	 ? __cfi__raw_spin_lock+0x10/0x10
	 _RNvNtCs9jEwPDbx20M_4core9panicking9panic_fmt+0x84/0x90
	 ? __cfi__RNvNtCs9jEwPDbx20M_4core9panicking9panic_fmt+0x10/0x10
	 _RNvNtNtCs9jEwPDbx20M_4core9panicking11panic_const24panic_const_sub_overflow+0xb2/0xc0
	 ? __cfi__RNvNtNtCs9jEwPDbx20M_4core9panicking11panic_const24panic_const_sub_overflow+0x10/0x10
	 _RNvMs3_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process10update_ref+0x17e5/0x1860
	 ? __cfi__RNvMs3_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process10update_ref+0x10/0x10
	 ? __kasan_check_write+0x18/0x20
	 ? _raw_spin_lock+0x8c/0x120
	 ? __cfi__raw_spin_lock+0x10/0x10
	 ? __kasan_check_write+0x18/0x20
	 _RNvMs2_NtCshgDM7dBCdno_11rust_binder6threadNtB5_6Thread10write_read+0x27cf/0x96a0
	 ? __cfi__RNvMs2_NtCshgDM7dBCdno_11rust_binder6threadNtB5_6Thread10write_read+0x10/0x10
	 ? is_bpf_text_address+0x17b/0x1a0
	 ? is_bpf_text_address+0x17b/0x1a0
	 ? kernel_text_address+0xa9/0xe0
	 ? __kernel_text_address+0x11/0x40
	 ? __kasan_check_write+0x18/0x20
	 ? _raw_spin_lock_irqsave+0xaf/0x150
	 ? is_bpf_text_address+0x17b/0x1a0
	 ? kernel_text_address+0xa9/0xe0
	 ? __kasan_check_write+0x18/0x20
	 ? _raw_spin_lock_irqsave+0xaf/0x150
	 ? __cfi__raw_spin_lock_irqsave+0x10/0x10
	 ? _raw_spin_unlock_irqrestore+0x4a/0x70
	 ? stack_depot_save_flags+0x399/0x800
	 ? kasan_save_alloc_info+0x40/0x50
	 ? kasan_save_track+0x4f/0x80
	 ? kasan_save_track+0x3e/0x80
	 ? kasan_save_alloc_info+0x40/0x50
	 ? __kasan_kmalloc+0x96/0xb0
	 ? __kmalloc_node_track_caller_noprof+0x1ad/0x440
	 ? krealloc_noprof+0x8d/0x130
	 ? rust_helper_krealloc+0x33/0xd0
	 ? _RNvMNtNtCs43vyB533jt3_6kernel5alloc9allocatorNtB2_11ReallocFunc4call+0xaf/0x100
	 ? _RNvMs3_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process18get_current_thread+0x715/0x1440
	 ? _RNvMs5_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process5ioctl+0x1a9/0x2c20
	 ? _RNvCshgDM7dBCdno_11rust_binder26rust_binder_unlocked_ioctl+0xa0/0x100
	 ? __se_sys_ioctl+0x132/0x1b0
	 ? __x64_sys_ioctl+0x7f/0xa0
	 ? do_syscall_64+0x58/0xf0
	 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
	 ? __kasan_kmalloc+0x96/0xb0
	 ? kasan_save_alloc_info+0x40/0x50
	 ? __kasan_kmalloc+0x96/0xb0
	 ? __kmalloc_node_track_caller_noprof+0x1ad/0x440
	 ? __kasan_check_write+0x18/0x20
	 ? _raw_spin_lock+0x8c/0x120
	 ? __cfi__raw_spin_lock+0x10/0x10
	 ? arch_scale_cpu_capacity+0x1c/0xb0
	 ? _raw_spin_unlock+0x45/0x60
	 ? rust_helper_spin_unlock+0x19/0x30
	 ? _RNvMs3_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process18get_current_thread+0x934/0x1440
	 ? __cfi___update_load_avg_cfs_rq+0x10/0x10
	 ? update_curr+0x60d/0xc60
	 ? arch_scale_cpu_capacity+0x1c/0xb0
	 ? __cfi__RNvMs3_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process18get_current_thread+0x10/0x10
	 ? update_curr_dl_se+0x10c/0xb20
	 ? sched_clock_noinstr+0xd/0x30
	 ? __cfi___update_load_avg_cfs_rq+0x10/0x10
	 ? update_curr+0x60d/0xc60
	 ? dequeue_entity+0xa9c/0x1750
	 _RNvMs5_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process5ioctl+0x411/0x2c20
	 ? avc_has_extended_perms+0x7c7/0xdd0
	 ? __asan_memcpy+0x5a/0x80
	 ? avc_has_extended_perms+0x921/0xdd0
	 ? __cfi__RNvMs5_NtCshgDM7dBCdno_11rust_binder7processNtB5_7Process5ioctl+0x10/0x10
	 ? do_vfs_ioctl+0xeda/0x1e30
	 ? sched_clock+0x44/0x60
	 ? __ia32_compat_sys_ioctl+0x850/0x850
	 ? psi_group_change+0xb44/0x1130
	 ? ioctl_has_perm+0x384/0x4d0
	 ? has_cap_mac_admin+0xd0/0xd0
	 ? __schedule+0x1463/0x1f10
	 ? selinux_file_ioctl+0x6e0/0x1360
	 ? __cfi_selinux_file_ioctl+0x10/0x10
	 ? __kasan_check_write+0x18/0x20
	 ? _raw_spin_lock_irq+0x8d/0x120
	 ? __cfi__raw_spin_lock_irq+0x10/0x10
	 ? __asan_memset+0x39/0x50
	 ? ptrace_stop+0x6c9/0x8c0
	 ? _raw_spin_unlock_irq+0x45/0x70
	 ? ptrace_notify+0x1e8/0x270
	 _RNvCshgDM7dBCdno_11rust_binder26rust_binder_unlocked_ioctl+0xa0/0x100
	 ? __se_sys_ioctl+0x114/0x1b0
	 ? __cfi__RNvCshgDM7dBCdno_11rust_binder26rust_binder_unlocked_ioctl+0x10/0x10
	 __se_sys_ioctl+0x132/0x1b0
	 __x64_sys_ioctl+0x7f/0xa0
	 x64_sys_call+0x1878/0x2ee0
	 do_syscall_64+0x58/0xf0
	 ? clear_bhb_loop+0x35/0x90
	 entry_SYSCALL_64_after_hwframe+0x76/0x7e
	RIP: 0033:0x7f76713ca249
	Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
	RSP: 002b:00007ffe59fd2328 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f76713ca249
	RDX: 0000200000000480 RSI: 00000000c0306201 RDI: 0000000000000004
	RBP: 00000000000f4240 R08: 0000000000000000 R09: 00005555659f7610
	R10: 0000000000000000 R11: 0000000000000246 R12: 00007f76714181bc
	R13: 00007f767141309b R14: 00007ffe59fd2350 R15: 00007ffe59fd2340
	 </TASK>

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/asm-generic/bug.h |  2 ++
 kernel/panic.c            | 18 ++++++++++++++++++
 rust/kernel/lib.rs        | 22 +++++++++++++++++++---
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 387720933973b6313547dc9a4431473fb6e7c85d..cfec5c3333851d57a71c431354d9da5f49d0579e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -92,6 +92,8 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
+void rust_panic(const char *file, int file_len, int line, void *message);
+
 #ifndef __WARN_FLAGS
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
diff --git a/kernel/panic.c b/kernel/panic.c
index b0b9a8bf4560d5d0139dd74ee9a037bdfeb12c54..3ca4120af3acf57ddd957352ece0e6d660ccfc1e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -830,6 +830,24 @@ void __warn_printk(const char *fmt, ...)
 EXPORT_SYMBOL(__warn_printk);
 #endif
 
+#ifdef CONFIG_RUST
+void rust_panic(const char *file, int file_len, int line, void *message)
+{
+	pr_emerg(CUT_HERE);
+	nbcon_cpu_emergency_enter();
+	disable_trace_on_warning();
+	if (file)
+		pr_emerg("RUST PANIC: CPU: %d PID: %d at %.*s:%d\n",
+			raw_smp_processor_id(), current->pid,
+			file_len, file, line);
+	else
+		pr_emerg("RUST PANIC: CPU: %d PID: %d\n",
+			raw_smp_processor_id(), current->pid);
+	panic("%pA\n", message);
+}
+EXPORT_SYMBOL(rust_panic);
+#endif
+
 /* Support resetting WARN*_ONCE state */
 
 static int clear_warn_once_set(void *data, u64 val)
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c37f4da1866e993be6230bc6715841..3c01ca3449a84a7e396ab92c3a20abada83ad034 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -197,9 +197,25 @@ pub const fn as_ptr(&self) -> *mut bindings::module {
 #[cfg(not(any(testlib, test)))]
 #[panic_handler]
 fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
-    pr_emerg!("{}\n", info);
-    // SAFETY: FFI call.
-    unsafe { bindings::BUG() };
+    use ffi::*;
+
+    let (file, file_len, line) = match info.location() {
+        Some(location) => {
+            let file = location.file();
+            (file.as_ptr(), file.len() as c_int, location.line() as c_int)
+        }
+        None => (core::ptr::null(), 0, 0),
+    };
+
+    match core::format_args!("{}", info.message()) {
+        args => {
+            let args = (&args) as *const core::fmt::Arguments<'_> as *mut c_void;
+            // SAFETY: FFI call.
+            unsafe { bindings::rust_panic(file, file_len, line, args) };
+        }
+    }
+
+    loop {}
 }
 
 /// Produces a pointer to an object from a pointer to one of its fields.

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250619-rust-panic-8bd14e564aa4

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


