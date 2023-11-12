Return-Path: <linux-arch+bounces-135-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1397E8E6B
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5081C20627
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2602100;
	Sun, 12 Nov 2023 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28E1FD1;
	Sun, 12 Nov 2023 05:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3362EC433C7;
	Sun, 12 Nov 2023 05:13:50 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch changes for v6.7
Date: Sun, 12 Nov 2023 13:12:48 +0800
Message-Id: <20231112051248.272444-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.7

for you to fetch changes up to 1d375d65466e5c8d7a9406826d80d475a22e8c6d:

  selftests/bpf: Enable cpu v4 tests for LoongArch (2023-11-08 14:12:21 +0800)

----------------------------------------------------------------
LoongArch changes for v6.7

1, Support PREEMPT_DYNAMIC with static keys;
2, Relax memory ordering for atomic operations;
3, Support BPF CPU v4 instructions for LoongArch;
4, Some build and runtime warning fixes.

Note: There is a conflicts in arch/loongarch/include/asm/inst.h but can
be simply fixed by adjusting context.

----------------------------------------------------------------
Hengqi Chen (8):
      LoongArch: Add more instruction opcodes and emit_* helpers
      LoongArch: BPF: Support sign-extension load instructions
      LoongArch: BPF: Support sign-extension mov instructions
      LoongArch: BPF: Support unconditional bswap instructions
      LoongArch: BPF: Support 32-bit offset jmp instructions
      LoongArch: BPF: Support signed div instructions
      LoongArch: BPF: Support signed mod instructions
      selftests/bpf: Enable cpu v4 tests for LoongArch

Huacai Chen (3):
      Merge 'bpf-next 2023-10-16' into loongarch-next
      LoongArch: Support PREEMPT_DYNAMIC with static keys
      LoongArch/smp: Call rcutree_report_cpu_starting() earlier

Nathan Chancellor (1):
      LoongArch: Mark __percpu functions as always inline

WANG Rui (2):
      LoongArch: Disable module from accessing external data directly
      LoongArch: Relax memory ordering for atomic operations

 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/Makefile                            |   2 +
 arch/loongarch/include/asm/atomic.h                |  88 ++++++++++---
 arch/loongarch/include/asm/inst.h                  |  13 ++
 arch/loongarch/include/asm/percpu.h                |  10 +-
 arch/loongarch/kernel/smp.c                        |   3 +-
 arch/loongarch/net/bpf_jit.c                       | 143 ++++++++++++++++-----
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_bswap.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |   3 +-
 tools/testing/selftests/bpf/progs/verifier_movsx.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |   3 +-
 13 files changed, 215 insertions(+), 63 deletions(-)

