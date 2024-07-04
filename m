Return-Path: <linux-arch+bounces-5247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6892788C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDA01F24536
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3931AEFCF;
	Thu,  4 Jul 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHzAGzTp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFE1A070D;
	Thu,  4 Jul 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103800; cv=none; b=PdZqArbGRzdHkS0qPPKRcO27EOiCbN1tFwGreqWOXqUrUcua+tG0EBFYxo4fhkiYPyKag2KaCv5AImH79wysqIoPRUggF+QIMpcQWEnN8pIlfe+ANkTNFoTkCXyMP/6FHrHMDn2DAglOM+JP3TpBCr9o1cZu2js9D5uRrxc1chY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103800; c=relaxed/simple;
	bh=d8RBLuH5Pasj8CitSVF748rHET+zfK2JgBl1Bace8pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eNCI2vHEfIjUii3f4YO46Gioa2eU8GLvLfgr53k2kYu7geoCBXxnVMfzGNYHVS4CaVbdQTy+oAzLu6ToXyRDvY7LF2T57wxUrq4GbKdSgFivzTZ155vXXI/32qBC5XfzyKYdiHvsc0IjsWFMqKL1Nm363rLjuZ43zeRILzecEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHzAGzTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF67AC3277B;
	Thu,  4 Jul 2024 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103800;
	bh=d8RBLuH5Pasj8CitSVF748rHET+zfK2JgBl1Bace8pc=;
	h=From:To:Cc:Subject:Date:From;
	b=uHzAGzTpE6j/WOHutILRZlCBD4yqe5shQQueAfrC5t1s6TFO1ajW9YIWCw1o1lmYv
	 SUG2wZ76xEdTpMTZa7IAh0GltSJmZhhBIVOIfb3HNYppr3Vk3ShI3HM6aeEAPLmGPp
	 wI6fZGozAJ1Ev68n0SKPmJaXe5Ia2+Urut3mFTwJf1VvyQM5E/1NOu2ekNGOtxBqlQ
	 u32o6+mrKKgaE/0aUSYvObtokELefUljjL3BA1YWVRS4Ask1PJUMb/XTzm3+OFdA5u
	 oF/cIqfR7xQ7XqHLH77Q2oBQrbv2ng0HGvWY2mTK5MypuAlDqGVau/J2cekYXrgyaH
	 uwiay5ttQDWMw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 00/17] arch: convert everything to syscall.tbl
Date: Thu,  4 Jul 2024 16:35:54 +0200
Message-Id: <20240704143611.2979589-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are eight architectures using include/uapi/asm-generic/unistd.h,
which is still in an old format and not easily parsed by scripts.
In addition, arm64 uses the old format for the 32-bit arm compat syscalls,
despite them using the modern syscall.tbl format for the native calls.

As part of a larger cleanup, this converts all of them to use the new
format with a shared file. I was planning to post this earlier, but ended
up fixing up any system calls that have mismatched calling conventions
between kernel and userspace first, as that seemed more important.

I originally tried adding the same arch/*/kernel/syscalls/Makefile as used
on the other architectures, but ended up simplifying this in the process
to use a single set of Makefile rules in scripts/Makefile.asm-headers,
which in turn requires a few cleanups to arch/*/include/asm/Kbuild files.

Another prerequisite included in here is to make sys_clone3 get provided
on all architectures, though it remains broken and returns -ENOSYS on
hexagon, nios2, sh and sparc. To preserve the compile-time warning,
I added an explicit #warning for those that are marked broken.

Once we have the new table format in place everywhere, additional
improvements I have planned will be much easier, including:

 - generating machine-readable syscall API descriptions for each
   syscall on each architecture

 - type checking to ensure that the in-kernel prototype matches
   what userspace tools see

 - unifying the last common bits of all tables so that new syscalls
   only need to get added in one place

 - generate human-readable wrappers for native and compat syscalls
   on all architectures to replace the SYSCALL_DEFINEx() macros.

       Arnd

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

 Makefile                                      |   2 +-
 arch/alpha/include/asm/unistd.h               |   1 +
 arch/arc/include/asm/Kbuild                   |   2 +
 arch/arc/include/asm/unistd.h                 |  14 +
 arch/arc/include/uapi/asm/Kbuild              |   2 +
 arch/arc/include/uapi/asm/unistd.h            |  44 +-
 arch/arc/kernel/Makefile.syscalls             |   3 +
 arch/arc/kernel/sys.c                         |   5 +-
 arch/arm/include/asm/unistd.h                 |   1 -
 arch/arm64/include/asm/Kbuild                 |   8 +
 arch/arm64/include/asm/seccomp.h              |  13 +-
 arch/arm64/include/asm/unistd.h               |  22 +-
 arch/arm64/include/asm/unistd32.h             | 939 +-----------------
 .../include/asm/vdso/compat_gettimeofday.h    |  12 +-
 arch/arm64/include/uapi/asm/Kbuild            |   1 +
 arch/arm64/include/uapi/asm/unistd.h          |  25 +-
 arch/arm64/kernel/Makefile.syscalls           |   6 +
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/arm64/kernel/sigreturn32.S               |  18 +-
 arch/arm64/kernel/sys.c                       |   6 +-
 arch/arm64/kernel/sys32.c                     |  17 +-
 arch/arm64/kernel/syscall.c                   |   3 +-
 arch/arm64/tools/Makefile                     |   6 +-
 arch/arm64/tools/syscall_32.tbl               | 476 +++++++++
 arch/arm64/tools/syscall_64.tbl               |   1 +
 arch/csky/include/asm/Kbuild                  |   3 +-
 arch/csky/include/asm/unistd.h                |   3 +
 arch/csky/include/uapi/asm/Kbuild             |   2 +
 arch/csky/include/uapi/asm/unistd.h           |  15 +-
 arch/csky/kernel/Makefile.syscalls            |   4 +
 arch/csky/kernel/syscall_table.c              |   4 +-
 arch/hexagon/include/asm/Kbuild               |   2 +
 arch/hexagon/include/asm/unistd.h             |  10 +
 arch/hexagon/include/uapi/asm/Kbuild          |   2 +
 arch/hexagon/include/uapi/asm/unistd.h        |  13 +-
 arch/hexagon/kernel/Makefile.syscalls         |   3 +
 arch/hexagon/kernel/syscalltab.c              |   8 +-
 arch/loongarch/include/asm/Kbuild             |  17 +-
 arch/loongarch/include/asm/unistd.h           |   2 +
 arch/loongarch/include/uapi/asm/Kbuild        |   2 +
 arch/loongarch/include/uapi/asm/unistd.h      |   4 +-
 arch/loongarch/kernel/Makefile.syscalls       |   4 +
 arch/loongarch/kernel/syscall.c               |   3 +-
 arch/m68k/include/asm/unistd.h                |   1 -
 arch/microblaze/include/asm/unistd.h          |   2 +
 arch/mips/include/asm/unistd.h                |   1 -
 arch/nios2/include/asm/Kbuild                 |   2 +
 arch/nios2/include/asm/unistd.h               |  10 +
 arch/nios2/include/uapi/asm/Kbuild            |   2 +
 arch/nios2/include/uapi/asm/unistd.h          |  14 +-
 arch/nios2/kernel/Makefile.syscalls           |   3 +
 arch/nios2/kernel/syscall_table.c             |   6 +-
 arch/openrisc/include/asm/Kbuild              |   2 +
 arch/openrisc/include/asm/syscalls.h          |   4 -
 arch/openrisc/include/asm/unistd.h            |   8 +
 arch/openrisc/include/uapi/asm/Kbuild         |   2 +
 arch/openrisc/include/uapi/asm/unistd.h       |  15 +-
 arch/openrisc/kernel/Makefile.syscalls        |   3 +
 arch/openrisc/kernel/sys_call_table.c         |   9 +-
 arch/parisc/include/asm/unistd.h              |   1 -
 arch/powerpc/include/asm/unistd.h             |   1 -
 arch/riscv/include/asm/Kbuild                 |   3 +
 arch/riscv/include/asm/syscall_table.h        |   7 +
 arch/riscv/include/asm/unistd.h               |  13 +-
 arch/riscv/include/uapi/asm/Kbuild            |   2 +
 arch/riscv/include/uapi/asm/unistd.h          |  41 +-
 arch/riscv/kernel/Makefile.syscalls           |   4 +
 arch/riscv/kernel/compat_syscall_table.c      |   6 +-
 arch/riscv/kernel/syscall_table.c             |   6 +-
 arch/s390/include/asm/unistd.h                |   1 -
 arch/sh/include/asm/unistd.h                  |   2 +
 arch/sparc/include/asm/unistd.h               |   2 +
 arch/um/include/asm/Kbuild                    |   1 -
 arch/um/include/asm/bpf_perf_event.h          |   3 +
 arch/x86/include/asm/unistd.h                 |   1 -
 arch/xtensa/include/asm/unistd.h              |   1 -
 include/asm-generic/Kbuild                    |   1 -
 include/uapi/asm-generic/unistd.h             |   4 -
 kernel/fork.c                                 |   8 +-
 kernel/sys_ni.c                               |   2 -
 scripts/Makefile.asm-generic                  |  58 --
 scripts/Makefile.asm-headers                  |  98 ++
 scripts/syscall.tbl                           | 404 ++++++++
 tools/arch/arm64/include/uapi/asm/unistd.h    |   1 -
 .../arch/loongarch/include/uapi/asm/unistd.h  |   1 -
 tools/include/uapi/asm-generic/unistd.h       |   4 -
 86 files changed, 1219 insertions(+), 1271 deletions(-)
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

-- 
2.39.2

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Brian Cain <bcain@quicinc.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-openrisc@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org

