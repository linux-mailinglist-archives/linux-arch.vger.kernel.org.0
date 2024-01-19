Return-Path: <linux-arch+bounces-1403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748E832857
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3087A1C210AA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jan 2024 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587264C615;
	Fri, 19 Jan 2024 11:07:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB91D690;
	Fri, 19 Jan 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662444; cv=none; b=OpC6NQdPQ79ClxzjN4Fy/nQWT6EYThleJ4acdTu5bM3hmvISAubgv365aX6F/m2NEWus6y9Qx8YNxhzksJpqPzpBRW03E62uHNT/tNYuQhd1L6ye7jjD9bJlBYhNWrUQFsToEYNuNtwWGDXmJgwYZcbriPI+ZhbBAiohBRUBfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662444; c=relaxed/simple;
	bh=QG7E3xZDv1be+XkDSOyaOlT8BoYaqVCBOneMyW01fZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j68ye8g8w1bSYi9zObeLwc4/F2q5zCPcyuN8ovul5tX331dZwV764kit0bULKJLifuYqiM9CKtbyRaADJSJeApQ/9WIXfOcG6FiRw++UcQYdL/LKAXuC5/7oZRjjNEck2RZrcicxCNlMF+P3ur4kTsWYRinkwBXqTrTJ5xc/sWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A6C433F1;
	Fri, 19 Jan 2024 11:07:21 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch changes for v6.8
Date: Fri, 19 Jan 2024 19:07:00 +0800
Message-Id: <20240119110700.335741-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.8

for you to fetch changes up to 6e441fa3ac475be73c03c9a85bd305d66ea476a6:

  MAINTAINERS: Add BPF JIT for LOONGARCH entry (2024-01-17 12:43:13 +0800)

----------------------------------------------------------------
LoongArch changes for v6.8

1, Raise minimum clang version to 18.0.0;
2, Enable initial Rust support for LoongArch;
3, Add built-in dtb support for LoongArch;
4, Use generic interface to support crashkernel=X,[high,low];
5, Some bug fixes and other small changes;
6, Update the default config file.

----------------------------------------------------------------
Binbin Zhou (9):
      dt-bindings: loongarch: Add CPU bindings for LoongArch
      dt-bindings: loongarch: Add Loongson SoC boards compatibles
      dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check warning for reg-names
      dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check warning for interrupt-names
      LoongArch: Allow device trees be built into the kernel
      LoongArch: dts: DeviceTree for Loongson-2K0500
      LoongArch: dts: DeviceTree for Loongson-2K1000
      LoongArch: dts: DeviceTree for Loongson-2K2000
      LoongArch: Parsing CPU-related information from DTS

Hengqi Chen (2):
      LoongArch: BPF: Support 64-bit pointers to kfuncs
      LoongArch: BPF: Prevent out-of-bounds memory access

Huacai Chen (4):
      LoongArch: Add a missing call to efi_esrt_init()
      LoongArch: Change SHMLBA from SZ_64K to PAGE_SIZE
      LoongArch: Let cores_io_master cover the largest NR_CPUS
      LoongArch: Update Loongson-3 default config file

Tiezhu Yang (2):
      LoongArch: Fix definition of ftrace_regs_set_instruction_pointer()
      MAINTAINERS: Add BPF JIT for LOONGARCH entry

WANG Rui (2):
      scripts/min-tool-version.sh: Raise minimum clang version to 18.0.0 for loongarch
      LoongArch: Enable initial Rust support

WANG Xuerui (1):
      modpost: Ignore relaxation and alignment marker relocs on LoongArch

Xi Ruoyao (1):
      LoongArch: Fix and simplify fcsr initialization on execve()

Youling Tang (1):
      LoongArch: Use generic interface to support crashkernel=X,[high,low]

 Documentation/admin-guide/kernel-parameters.txt    |  24 +-
 .../interrupt-controller/loongson,liointc.yaml     |  18 +-
 .../devicetree/bindings/loongarch/cpus.yaml        |  61 +++
 .../devicetree/bindings/loongarch/loongson.yaml    |  34 ++
 Documentation/rust/arch-support.rst                |  13 +-
 MAINTAINERS                                        |   7 +
 arch/loongarch/Kbuild                              |   1 +
 arch/loongarch/Kconfig                             |  22 +
 arch/loongarch/Makefile                            |   6 +-
 arch/loongarch/boot/dts/Makefile                   |   5 +-
 arch/loongarch/boot/dts/loongson-2k0500-ref.dts    |  88 ++++
 arch/loongarch/boot/dts/loongson-2k0500.dtsi       | 266 +++++++++++
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts    | 183 ++++++++
 arch/loongarch/boot/dts/loongson-2k1000.dtsi       | 492 +++++++++++++++++++++
 arch/loongarch/boot/dts/loongson-2k2000-ref.dts    |  72 +++
 arch/loongarch/boot/dts/loongson-2k2000.dtsi       | 300 +++++++++++++
 arch/loongarch/configs/loongson3_defconfig         |  55 ++-
 arch/loongarch/include/asm/bootinfo.h              |   6 +-
 arch/loongarch/include/asm/crash_core.h            |  12 +
 arch/loongarch/include/asm/elf.h                   |   5 -
 arch/loongarch/include/asm/ftrace.h                |   2 +-
 arch/loongarch/include/asm/shmparam.h              |  12 -
 arch/loongarch/kernel/acpi.c                       |   2 +-
 arch/loongarch/kernel/efi.c                        |   2 +
 arch/loongarch/kernel/elf.c                        |   5 -
 arch/loongarch/kernel/env.c                        |  34 +-
 arch/loongarch/kernel/head.S                       |  10 +
 arch/loongarch/kernel/process.c                    |   1 +
 arch/loongarch/kernel/setup.c                      |  56 +--
 arch/loongarch/kernel/smp.c                        |   5 +-
 arch/loongarch/net/bpf_jit.c                       |  10 +-
 scripts/generate_rust_target.rs                    |   7 +
 scripts/min-tool-version.sh                        |   2 +
 scripts/mod/modpost.c                              |  19 +-
 34 files changed, 1735 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/loongarch/cpus.yaml
 create mode 100644 Documentation/devicetree/bindings/loongarch/loongson.yaml
 create mode 100644 arch/loongarch/boot/dts/loongson-2k0500-ref.dts
 create mode 100644 arch/loongarch/boot/dts/loongson-2k0500.dtsi
 create mode 100644 arch/loongarch/boot/dts/loongson-2k1000-ref.dts
 create mode 100644 arch/loongarch/boot/dts/loongson-2k1000.dtsi
 create mode 100644 arch/loongarch/boot/dts/loongson-2k2000-ref.dts
 create mode 100644 arch/loongarch/boot/dts/loongson-2k2000.dtsi
 create mode 100644 arch/loongarch/include/asm/crash_core.h
 delete mode 100644 arch/loongarch/include/asm/shmparam.h

