Return-Path: <linux-arch+bounces-5398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A8931C5E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 23:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DB41C21B14
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ACB13AA2A;
	Mon, 15 Jul 2024 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="wS2E9kgf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjWxd3R+"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6EC15B;
	Mon, 15 Jul 2024 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077630; cv=none; b=IQYmCBi0N+pin/NBP4vFbMqDUDe5xSuLMHxzrNGTJNh6xaKwGcHZDCmsWK1twL+M5fiJgLXcNM4P9/dazrMSFFI+ibLYQFf9fuuCvmRsNodW9d8svUtXaQTWgA/Mf6dY+iJFX9JWZGCon1s30A89GiL/U8lYBniTqhgfd2ijSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077630; c=relaxed/simple;
	bh=lizupEQGnTa1Co130gaT2iURcByI6Rqjj4RZmXjS+Uo=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=A+sqs7juebLNiTpV0j0ZU7a0FHzmwyHGkrr7yv+fdYUvAKcN/cJIy6HyZm8MHmwgdwjblPwGp7+M8Lj7pTbrM0VTxseG1WZYPiVdyc27IP0UTQPk24pTZyP6pIdewW9IZXP2cV3CAAMLmI9b6YfBkzXxxphydKQCVQcA04QGM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=wS2E9kgf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SjWxd3R+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 268BE1147F7B;
	Mon, 15 Jul 2024 17:07:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 17:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1721077628; x=1721164028; bh=7q+6IYnqmuD50MShCet25BciLTxKWgfP
	x9cMuhrwtGI=; b=wS2E9kgfykEbvr4fI31z3CQP1CSeei4rzb0lMAGgZ6RIUSgo
	BRFmtlOH+rtPNMxh+MzOYT7JWGdTneI1f9X1kg7Di+Y4R89a6etxzS9i0p8ViaDR
	pYuLv634QUV0f1LUl9pIWNuFj4dqwrCe91RVCprEvN2tAxFEgJuSE4mCpd9iSfcm
	hPS/1dcVjob5TD9XXIRSy/LKODsFITjxLWG3NVposgu441tHn+vIz31PUSu6FYQJ
	mPKmRfkom7KkODjRVCtDW7bxEZRBxmDqyK5JyIiaDOXXC1rIbKFwEekFfDcj+unI
	GCKwdwh1eg1RmUpiaLBg8LPcZUnmilwT54e0OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1721077628; x=1721164028; bh=7q+6IYnqmuD50MShCet25BciLTxKWgfPx9c
	MuhrwtGI=; b=SjWxd3R+lq3EleIFErSZn/DYiwI00hnYTeFPdMPnD3A6Ia9ha/M
	V+vruY9CxVBLEI3+lH6SsObvqysnd6z2bU0n6rv0dTlxxJ1VjL5LCcAwciN0KKOm
	l0h0qesT3hFeQRSfZ4akx/QpoxsOqioKs+ldhkEsUYfMSF5i8yUm38y9xLYXSrlj
	JJ6mU4Hwd7E8ouGF4zMa406ijk5mOsKVIQH0lSoDs85yFGv0wNZOJkR91xiaAzRx
	VM/cRdJQYS6FUTVAfmZ07imAjVVBO3r7BCrEx3nkU6DX2MlwNu3FSc5ZdUDjPGjM
	bYDaWXLt3fOvoDjoE8veNEQZ4FHXrPRuXxQ==
X-ME-Sender: <xms:e4-VZmwQmKewoJrhtTl_WW5z1vjxWBGMWPgc_ZI9Ujfh3xtvgFv14A>
    <xme:e4-VZiQiBg4B-TqGGxmpnFGo4CXilO_UJW7NLVTe0PVioUdhW9l6D6yE-0qm5E-ns
    RYJcEZa08aQ-85jovE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fI-VZoU52SOcvNZtiAXeZWY6biEWtooXgSHE2f0fn2oZJhgcPrwZvA>
    <xmx:fI-VZshnqg6B1qoW_S7KdOtvdUdOlBuC4nT7rMtA2tiP45Ttf_Duug>
    <xmx:fI-VZoCkb7BEuRUCZ7p0XRlUaOvFGokWtF2TH98ZZ558Psgd4BVrZA>
    <xmx:fI-VZtKmOpTNoEUAFXAlM4Idrlu_2Exwp_qe900ds72pKa9gl-BUhA>
    <xmx:fI-VZk2NjfSL59A8L2VEa5T41Zzl-MBo4qJUHe3lLxKEloa9Wp2EPcjy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D49A8B6008D; Mon, 15 Jul 2024 17:07:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
Date: Mon, 15 Jul 2024 23:14:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org
Subject: [GIT PULL] asm-generic updates for 6.11
Content-Type: text/plain

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.11

for you to fetch changes up to 1a7b7326d587c9a5e8ff067e70d6aaf0333f4bb3:

  vmlinux.lds.h: catch .bss..L* sections into BSS") (2024-07-12 08:52:45 +0200)

----------------------------------------------------------------
asm-generic updates for 6.11

Most of this is part of my ongoing work to clean up the system call
tables. In this bit, all of the newer architectures are converted to
use the machine readable syscall.tbl format instead in place of complex
macros in include/uapi/asm-generic/unistd.h.

This follows an earlier series that fixed various API mismatches
and in turn is used as the base for planned simplifications.

The other two patches are dead code removal and a warning fix.

----------------------------------------------------------------
Arnd Bergmann (17):
      syscalls: add generic scripts/syscall.tbl
      csky: drop asm/gpio.h wrapper
      um: don't generate asm/bpf_perf_event.h
      loongarch: avoid generating extra header files
      kbuild: verify asm-generic header list
      kbuild: add syscall table generation to scripts/Makefile.asm-headers
      clone3: drop __ARCH_WANT_SYS_CLONE3 macro
      arc: convert to generic syscall table
      arm64: convert unistd_32.h to syscall.tbl format
      arm64: generate 64-bit syscall.tbl
      arm64: rework compat syscall macros
      csky: convert to generic syscall table
      hexagon: use new system call table
      loongarch: convert to generic syscall table
      nios2: convert to generic syscall table
      openrisc: convert to generic syscall table
      riscv: convert to generic syscall table

Christophe Leroy (1):
      vmlinux.lds.h: catch .bss..L* sections into BSS")

Steven Price (1):
      fixmap: Remove unused set_fixmap_offset_io()

 Makefile                                          |   2 +-
 arch/arc/include/asm/Kbuild                       |   2 +
 arch/arc/include/asm/unistd.h                     |  14 +
 arch/arc/include/uapi/asm/Kbuild                  |   2 +
 arch/arc/include/uapi/asm/unistd.h                |  44 +-
 arch/arc/kernel/Makefile.syscalls                 |   3 +
 arch/arc/kernel/sys.c                             |   5 +-
 arch/arm/include/asm/unistd.h                     |   1 -
 arch/arm64/include/asm/Kbuild                     |   8 +
 arch/arm64/include/asm/seccomp.h                  |  13 +-
 arch/arm64/include/asm/unistd.h                   |  22 +-
 arch/arm64/include/asm/unistd32.h                 | 939 +---------------------
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  12 +-
 arch/arm64/include/uapi/asm/Kbuild                |   1 +
 arch/arm64/include/uapi/asm/unistd.h              |  25 +-
 arch/arm64/kernel/Makefile.syscalls               |   6 +
 arch/arm64/kernel/signal32.c                      |   4 +-
 arch/arm64/kernel/sigreturn32.S                   |  18 +-
 arch/arm64/kernel/sys.c                           |   6 +-
 arch/arm64/kernel/sys32.c                         |  17 +-
 arch/arm64/kernel/syscall.c                       |   3 +-
 arch/arm64/tools/Makefile                         |   6 +-
 arch/arm64/tools/syscall_32.tbl                   | 476 +++++++++++
 arch/arm64/tools/syscall_64.tbl                   |   1 +
 arch/csky/include/asm/Kbuild                      |   3 +-
 arch/csky/include/asm/unistd.h                    |   3 +
 arch/csky/include/uapi/asm/Kbuild                 |   2 +
 arch/csky/include/uapi/asm/unistd.h               |  15 +-
 arch/csky/kernel/Makefile.syscalls                |   4 +
 arch/csky/kernel/syscall_table.c                  |   4 +-
 arch/hexagon/include/asm/Kbuild                   |   2 +
 arch/hexagon/include/asm/unistd.h                 |  10 +
 arch/hexagon/include/uapi/asm/Kbuild              |   2 +
 arch/hexagon/include/uapi/asm/unistd.h            |  14 +-
 arch/hexagon/kernel/Makefile.syscalls             |   3 +
 arch/hexagon/kernel/syscalltab.c                  |   8 +-
 arch/loongarch/include/asm/Kbuild                 |  17 +-
 arch/loongarch/include/asm/unistd.h               |   2 +
 arch/loongarch/include/uapi/asm/Kbuild            |   2 +
 arch/loongarch/include/uapi/asm/unistd.h          |   4 +-
 arch/loongarch/kernel/Makefile.syscalls           |   4 +
 arch/loongarch/kernel/syscall.c                   |   3 +-
 arch/m68k/include/asm/unistd.h                    |   1 -
 arch/mips/include/asm/unistd.h                    |   1 -
 arch/nios2/include/asm/Kbuild                     |   2 +
 arch/nios2/include/asm/unistd.h                   |  12 +
 arch/nios2/include/uapi/asm/Kbuild                |   2 +
 arch/nios2/include/uapi/asm/unistd.h              |  14 +-
 arch/nios2/kernel/Makefile.syscalls               |   3 +
 arch/nios2/kernel/syscall_table.c                 |   6 +-
 arch/openrisc/include/asm/Kbuild                  |   2 +
 arch/openrisc/include/asm/syscalls.h              |   4 -
 arch/openrisc/include/asm/unistd.h                |   8 +
 arch/openrisc/include/uapi/asm/Kbuild             |   2 +
 arch/openrisc/include/uapi/asm/unistd.h           |  15 +-
 arch/openrisc/kernel/Makefile.syscalls            |   3 +
 arch/openrisc/kernel/sys_call_table.c             |   9 +-
 arch/parisc/include/asm/unistd.h                  |   1 -
 arch/powerpc/include/asm/unistd.h                 |   1 -
 arch/riscv/include/asm/Kbuild                     |   3 +
 arch/riscv/include/asm/syscall_table.h            |   7 +
 arch/riscv/include/asm/unistd.h                   |  13 +-
 arch/riscv/include/uapi/asm/Kbuild                |   2 +
 arch/riscv/include/uapi/asm/unistd.h              |  41 +-
 arch/riscv/kernel/Makefile.syscalls               |   4 +
 arch/riscv/kernel/compat_syscall_table.c          |   6 +-
 arch/riscv/kernel/syscall_table.c                 |   6 +-
 arch/s390/include/asm/unistd.h                    |   1 -
 arch/sh/include/asm/unistd.h                      |   2 +
 arch/sparc/include/asm/unistd.h                   |   2 +
 arch/um/include/asm/Kbuild                        |   1 -
 arch/um/include/asm/bpf_perf_event.h              |   9 +
 arch/x86/include/asm/unistd.h                     |   1 -
 arch/xtensa/include/asm/unistd.h                  |   1 -
 include/asm-generic/Kbuild                        |   1 -
 include/asm-generic/fixmap.h                      |   3 -
 include/asm-generic/vmlinux.lds.h                 |   2 +-
 include/uapi/asm-generic/unistd.h                 |   4 -
 kernel/fork.c                                     |   8 +-
 kernel/sys_ni.c                                   |   2 -
 scripts/Makefile.asm-generic                      |  58 --
 scripts/Makefile.asm-headers                      |  98 +++
 scripts/syscall.tbl                               | 404 ++++++++++
 tools/arch/arm64/include/uapi/asm/unistd.h        |   1 -
 tools/arch/loongarch/include/uapi/asm/unistd.h    |   1 -
 tools/include/uapi/asm-generic/unistd.h           |   4 -
 86 files changed, 1228 insertions(+), 1275 deletions(-)
 create mode 100644 arch/arc/include/asm/unistd.h
 create mode 100644 arch/arc/kernel/Makefile.syscalls
 create mode 100644 arch/arm64/kernel/Makefile.syscalls
 create mode 100644 arch/arm64/tools/syscall_32.tbl
 create mode 120000 arch/arm64/tools/syscall_64.tbl
 create mode 100644 arch/csky/kernel/Makefile.syscalls
 create mode 100644 arch/hexagon/include/asm/unistd.h
 create mode 100644 arch/hexagon/kernel/Makefile.syscalls
 create mode 100644 arch/loongarch/kernel/Makefile.syscalls
 create mode 100644 arch/nios2/include/asm/unistd.h
 create mode 100644 arch/nios2/kernel/Makefile.syscalls
 create mode 100644 arch/openrisc/include/asm/unistd.h
 create mode 100644 arch/openrisc/kernel/Makefile.syscalls
 create mode 100644 arch/riscv/include/asm/syscall_table.h
 create mode 100644 arch/riscv/kernel/Makefile.syscalls
 create mode 100644 arch/um/include/asm/bpf_perf_event.h
 delete mode 100644 scripts/Makefile.asm-generic
 create mode 100644 scripts/Makefile.asm-headers
 create mode 100644 scripts/syscall.tbl

