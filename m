Return-Path: <linux-arch+bounces-9936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93FA20C0B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 15:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8C37A2A99
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE361A841E;
	Tue, 28 Jan 2025 14:27:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD44819F11B;
	Tue, 28 Jan 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074445; cv=none; b=RPlEDOTdi9Vhdpqt+dAn+s9kvXKWyV0NOjjBMHbOBhM7xbavIu5ftFOWn/zh/6ciUP5hKYUFoeXm6HAVtfQxwRVd++rulq4oC5AYpvRTPAe3WcEQzySnKMSb1fkhL+wN7gewEG1Krsm3DJgpiR+094IVxnsraC2CwhsKkwVT67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074445; c=relaxed/simple;
	bh=kOjuqxYeqG0BDEllG8TB03Q3Phj32ouj8K+NtIxP+Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Au/KYsHgcv4TVnuTWkb5Hz2i8Je+81p/RjMh0C9JlKq5F2D01AX6TskSIJrezuUfCki/kj5SIsqdLbNe0MHOReeKegusoDZ+sv5kxrHxq9CEIHneg/7PPwNBegEZOxwNk+1Y5L1KiFcFP2o0DGrPQ+Vzy0CrV5lT/P/I+qxxGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8BxPOJB6ZhnwelpAA--.14508S3;
	Tue, 28 Jan 2025 22:27:13 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMBxUMY96ZhnXQowAA--.23741S2;
	Tue, 28 Jan 2025 22:27:12 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.14
Date: Tue, 28 Jan 2025 22:26:54 +0800
Message-ID: <20250128142654.301146-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxUMY96ZhnXQowAA--.23741S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr45XFyDWw4Utw17tFW5urX_yoW5Ar4fpF
	9IvrnxJF48Gr1fJFnxt343ur98Jr97Gr12qanIyry8Cr15Zr1UXr1kGrykXFyUt3y5JrW0
	qr1rGw1YgFyUJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=

The following changes since commit ffd294d346d185b70e28b1a28abe367bbfe53c04:

  Linux 6.13 (2025-01-19 15:51:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.14

for you to fetch changes up to 531936dee53e471a3ec668de3c94ca357f54b7e8:

  LoongArch: Extend the maximum number of watchpoints (2025-01-26 21:49:59 +0800)

----------------------------------------------------------------
LoongArch changes for v6.14

1, Migrate to the generic rule for built-in DTB;
2, Disable FIX_EARLYCON_MEM when ARCH_IOREMAP is enabled;
3, Derive timer max_delta from PRCFG1's timer_bits;
4, Correct the cacheinfo sharing information;
5, Add pgprot_nx() implementation;
6, Add debugfs entries to switch SFB/TSO state;
7, Change the maximum number of watchpoints;
8, Some bug fixes and other small changes.

----------------------------------------------------------------
Huacai Chen (8):
      Merge tag 'irq-core-2025-01-21' into loongarch-next
      LoongArch: Correct the cacheinfo sharing information
      LoongArch: Correct the __switch_to() prototype in comments
      LoongArch: Add pgprot_nx() implementation
      LoongArch: Refactor bug_handler() implementation
      LoongArch: Adjust SETUP_SLEEP and SETUP_WAKEUP
      LoongArch: Fix warnings during S3 suspend
      LoongArch: Add debugfs entries to switch SFB/TSO state

Jiaxun Yang (2):
      LoongArch: Disable FIX_EARLYCON_MEM when ARCH_IOREMAP is enabled
      LoongArch: Derive timer max_delta from PRCFG1's timer_bits

Masahiro Yamada (1):
      LoongArch: Migrate to the generic rule for built-in DTB

Tiezhu Yang (2):
      LoongArch: Change 8 to 14 for LOONGARCH_MAX_{BRP,WRP}
      LoongArch: Extend the maximum number of watchpoints

 arch/loongarch/Kbuild                      |   1 -
 arch/loongarch/Kconfig                     |   3 +-
 arch/loongarch/boot/dts/Makefile           |   2 -
 arch/loongarch/include/asm/acpi.h          |   2 +
 arch/loongarch/include/asm/cpu-info.h      |   1 +
 arch/loongarch/include/asm/hw_breakpoint.h |   4 +-
 arch/loongarch/include/asm/loongarch.h     |  76 ++++++++++++-
 arch/loongarch/include/asm/pgtable-bits.h  |   7 ++
 arch/loongarch/include/uapi/asm/ptrace.h   |  10 ++
 arch/loongarch/kernel/Makefile             |   2 +-
 arch/loongarch/kernel/cacheinfo.c          |   6 ++
 arch/loongarch/kernel/cpu-probe.c          |   1 +
 arch/loongarch/kernel/hw_breakpoint.c      |  16 ++-
 arch/loongarch/kernel/kdebugfs.c           | 168 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/ptrace.c             |   6 +-
 arch/loongarch/kernel/switch.S             |   2 +-
 arch/loongarch/kernel/time.c               |   2 +-
 arch/loongarch/kernel/traps.c              |  13 ++-
 arch/loongarch/kernel/unaligned.c          |   8 +-
 arch/loongarch/power/platform.c            |   2 +-
 arch/loongarch/power/suspend_asm.S         |  10 +-
 21 files changed, 313 insertions(+), 29 deletions(-)
 create mode 100644 arch/loongarch/kernel/kdebugfs.c


