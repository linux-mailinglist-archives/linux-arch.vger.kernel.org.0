Return-Path: <linux-arch+bounces-4488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274858CC2C2
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A1F1C21B84
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5B7FBA3;
	Wed, 22 May 2024 14:05:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8BA6AB9;
	Wed, 22 May 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386718; cv=none; b=OdJG4E9tizSeHNjeAZ+NBZy6VXH6b/2xfUZZjIRUk6PxJe7RCrAp2pbxUL+Dyotmngi8FZnKfS4b+vUBSBSqZNgcJRYCL8/jEpNs2WL9TH84zFGU1ilpF1PB1w1p+IiC1p9hZx5ISi/djrCPi2RoMlSuOnDDXNEMffuf56g1r7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386718; c=relaxed/simple;
	bh=8e71njZJWwY8ETmCINBrNexR+jgS6wvIDFiP1CyeUi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5PfghoIIjUqDKCmHIpAKK7qPWYDcvmkgetvu1oHxDg/tRvS+ltX6+vvydqDo1qGyBr/FtWs4Oj5oSCO5Ng6l0PrSzrOwSj23BWtqgB+cW2wG9LeVoBLLa7qcn3jEh8mpQ8Oho8Byv7Z8mMKpk8wud7iezupC+9RRGb1g6RFxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3C9C2BBFC;
	Wed, 22 May 2024 14:05:14 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch changes for v6.10
Date: Wed, 22 May 2024 22:05:04 +0800
Message-ID: <20240522140504.4071402-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.10

for you to fetch changes up to 9cc1df421f00453afdcaf78b105d8e7fd03cce78:

  LoongArch: Update Loongson-3 default config file (2024-05-19 22:18:56 +0800)

----------------------------------------------------------------
LoongArch changes for v6.10

1, Select some options in Kconfig;
2, Give a chance to build with !CONFIG_SMP;
3, Switch to use built-in rustc target;
4, Add new supported device nodes to dts;
5, Some bug fixes and other small changes;
6, Update the default config file.

Note: There is a conflict in arch/loongarch/kernel/irq.c, but can be
simply fixed by dropping the modification in this file (because that
section is removed by the kvm tree).

----------------------------------------------------------------
Binbin Zhou (3):
      LoongArch: dts: Remove "disabled" state of clock controller node
      LoongArch: dts: Add new supported device nodes to Loongson-2K0500
      LoongArch: dts: Add new supported device nodes to Loongson-2K2000

Huacai Chen (4):
      LoongArch: Select ARCH_WANT_DEFAULT_BPF_JIT
      LoongArch: Select THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
      LoongArch: Fix callchain parse error with kernel tracepoint events again
      LoongArch: Update Loongson-3 default config file

Tiezhu Yang (1):
      LoongArch: Give a chance to build with !CONFIG_SMP

WANG Rui (1):
      LoongArch: rust: Switch to use built-in rustc target

Xi Ruoyao (2):
      LoongArch: Select ARCH_HAS_FAST_MULTIPLIER
      LoongArch: Select ARCH_SUPPORTS_INT128 if CC_HAS_INT128

 arch/loongarch/Kconfig                          |  6 +-
 arch/loongarch/Makefile                         |  2 +-
 arch/loongarch/boot/dts/loongson-2k0500.dtsi    | 86 ++++++++++++++++++++++++-
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts |  4 --
 arch/loongarch/boot/dts/loongson-2k1000.dtsi    |  1 -
 arch/loongarch/boot/dts/loongson-2k2000.dtsi    | 49 ++++++++++++--
 arch/loongarch/configs/loongson3_defconfig      | 24 +++++++
 arch/loongarch/include/asm/acpi.h               |  1 +
 arch/loongarch/include/asm/asm-prototypes.h     |  6 ++
 arch/loongarch/include/asm/perf_event.h         |  3 +-
 arch/loongarch/include/asm/smp.h                |  6 ++
 arch/loongarch/kernel/irq.c                     |  2 +
 arch/loongarch/kernel/machine_kexec.c           |  2 +-
 arch/loongarch/lib/Makefile                     |  2 +
 arch/loongarch/lib/tishift.S                    | 56 ++++++++++++++++
 arch/loongarch/mm/tlbex.S                       |  9 ++-
 arch/loongarch/power/suspend.c                  |  4 +-
 rust/Makefile                                   |  2 +-
 scripts/Makefile                                |  2 +-
 scripts/generate_rust_target.rs                 |  7 +-
 20 files changed, 245 insertions(+), 29 deletions(-)
 create mode 100644 arch/loongarch/lib/tishift.S

