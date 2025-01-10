Return-Path: <linux-arch+bounces-9660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C063A0950C
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D403A96C7
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149262116E7;
	Fri, 10 Jan 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uY/ax7AL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/9rzHba"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701B20E035;
	Fri, 10 Jan 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522636; cv=none; b=puPVqOwIPfT3XYzQwh9fi5M/EncaGmIQ3A0mLLPrCSBtpNGsiQoXs2qLV9vNSV5GxZQPijyy4AP+sNIJ15oRQvyeqZpWh/DKi3VcLiO9jUM/Vk2J0B1ICCesvkGy5MwU1osEsqDBflGVctI2Q5LdeRMmOrj4PNGWZqMdRP88YqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522636; c=relaxed/simple;
	bh=gHW/zEEmiS5AuvJBD42Grk7gAg6JiH501MsDcMhU8a8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vFEEdaUa+6nbMB8jNzE9mwaloiDLI2/hlEXA/nuOI6VrLgLL8dXSKqBH2p/rkY8JH/7b3/4Bv5H6sd8DqUihcC//LuUDjJfj2lNN3Xj6lZ0RjkEL9ndUvcb8A1mRjQd6Smj23wAhZ2e/O1J7BFvP2TbDg88eKWV/lzy7o2EPuIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uY/ax7AL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/9rzHba; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UI7XVJHwyBBPQMiPL+ZamFg3pb9rD7DgDNZEm6y13nA=;
	b=uY/ax7AL7Plx4ur9D/Yp2YdgMZ61KuqsU8wMKpwGRge3O2jVFI0Z3t9dX7gU6IQXJsUJA1
	ugdrWlHNISgjE4+Hhq6goOTvD9ASfrQGoJUMBS5P+h+WbJsPpZ0psPlr9r16pR3800n3k0
	b/dkZNI8LbC1PryxZqGBIXMGRYIKjFZHh+B2VvLOEfVTWVY4FG3kkQ6D+cv7wqr12ii2o4
	CI7LGNlt7G5l4qJc0R5F41H0f/Sdg1V1TSqK1ePP8loNWbtBX/z1JB96qRAmv9/jU+yPC+
	7D/X1OHtbEzIQ/QXcERVbejzF7kMjtLVdnl+2f7yRYSupLUNPSAsplGsPFwnpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UI7XVJHwyBBPQMiPL+ZamFg3pb9rD7DgDNZEm6y13nA=;
	b=E/9rzHbalg8TqlnMyHo4JH/y16nchoJm56KUN1rXmB0MXD6E0TNwmPoDZrCfP7giNrWyGB
	of7HGIQWEzooasCA==
Subject: [PATCH v2 00/18] vDSO: Introduce generic data storage
Date: Fri, 10 Jan 2025 16:23:39 +0100
Message-Id: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHw7gWcC/13MwQ6CMAzG8VchPVuzDoXgifcwHIAVaGI2s+GCI
 Xt3B0eP/6bfb4fAXjjAo9jBc5QgzubQlwLGpbczo5jcoJW+qYYIowkOw+o8o7czVqruSzM2rO4
 K8ujteZLtBJ9d7kWO3+/pRzquJ0Waqn8qEiqc6p4NDWYoB92+xH5W76xsV8PQpZR+f1NTK7AAA
 AA=
X-Change-ID: 20240911-vdso-store-rng-607a3dc9e050
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
 Guo Ren <guoren@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-csky@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=9279;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gHW/zEEmiS5AuvJBD42Grk7gAg6JiH501MsDcMhU8a8=;
 b=ZiIr16RiQfjdFdicYH3uLXIHVrt2Mk4E5DqIKDdiPYFwiRGM5J08v4FNlMJIgrpRpL1kM0aSg
 tJm8A7ZCaa0BZVnMfK0zy2WggTs4ngbNYpeobNqgVuWNovXsc8ixb2s
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently each architecture defines the setup of the vDSO data page on
its own, mostly through copy-and-paste from some other architecture.
Extend the existing generic vDSO implementation to also provide generic
data storage.
This removes duplicated code and paves the way for further changes to
the generic vDSO implementation without having to go through a lot of
per-architecture changes.

Based on v6.13-rc1 and intended to be merged through the tip tree.

This also provides the basis for some generic vDSO reworks.
The commits from this series and the upcoming reworks can be seen at:
https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/log/?h=vdso/store

---
Changes in v2:
- Drop __arch_get_vdso_u_timens_data() (Christophe)
- Move to lib/vdso/ (Christophe)
- Rename __ppc_get_vdso_u_timens_data() to
  __arch_get_vdso_u_timens_data(), same for other hooks
  (Christophe)
- Fix build for architectures with time-less vDSO, like riscv32. (Conor)
- Explicitly fix bug around x86 vclock pages
- Link to v1: https://lore.kernel.org/r/20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de

---
Thomas Weißschuh (18):
      x86/vdso: Fix latent bug in vclock_pages calculation
      parisc: Remove unused symbol vdso_data
      vdso: Introduce vdso/align.h
      vdso: Rename included Makefile
      vdso: Add generic time data storage
      vdso: Add generic random data storage
      vdso: Add generic architecture-specific data storage
      arm64: vdso: Switch to generic storage implementation
      riscv: vdso: Switch to generic storage implementation
      LoongArch: vDSO: Switch to generic storage implementation
      arm: vdso: Switch to generic storage implementation
      s390/vdso: Switch to generic storage implementation
      MIPS: vdso: Switch to generic storage implementation
      powerpc/vdso: Switch to generic storage implementation
      x86/vdso: Switch to generic storage implementation
      x86/vdso/vdso2c: Remove page handling
      vdso: Remove remnants of architecture-specific random state storage
      vdso: Remove remnants of architecture-specific time storage

 arch/Kconfig                                       |   4 +
 arch/arm/include/asm/vdso.h                        |   2 +
 arch/arm/include/asm/vdso/gettimeofday.h           |   7 +-
 arch/arm/include/asm/vdso/vsyscall.h               |  12 +-
 arch/arm/kernel/asm-offsets.c                      |   4 -
 arch/arm/kernel/vdso.c                             |  34 ++----
 arch/arm/mm/Kconfig                                |   1 +
 arch/arm/vdso/Makefile                             |   2 +-
 arch/arm/vdso/vdso.lds.S                           |   4 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/vdso.h                      |   2 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  |  36 ++----
 arch/arm64/include/asm/vdso/getrandom.h            |  12 --
 arch/arm64/include/asm/vdso/gettimeofday.h         |  16 +--
 arch/arm64/include/asm/vdso/vsyscall.h             |  25 +---
 arch/arm64/kernel/vdso.c                           |  90 +-------------
 arch/arm64/kernel/vdso/Makefile                    |   2 +-
 arch/arm64/kernel/vdso/vdso.lds.S                  |   7 +-
 arch/arm64/kernel/vdso32/Makefile                  |   2 +-
 arch/arm64/kernel/vdso32/vdso.lds.S                |   7 +-
 arch/csky/kernel/vdso/Makefile                     |   2 +-
 arch/loongarch/Kconfig                             |   2 +
 arch/loongarch/include/asm/vdso.h                  |   1 -
 arch/loongarch/include/asm/vdso/arch_data.h        |  25 ++++
 arch/loongarch/include/asm/vdso/getrandom.h        |   5 -
 arch/loongarch/include/asm/vdso/gettimeofday.h     |  14 +--
 arch/loongarch/include/asm/vdso/vdso.h             |  38 +-----
 arch/loongarch/include/asm/vdso/vsyscall.h         |  17 ---
 arch/loongarch/kernel/asm-offsets.c                |   2 +-
 arch/loongarch/kernel/vdso.c                       |  92 +--------------
 arch/loongarch/vdso/Makefile                       |   2 +-
 arch/loongarch/vdso/vdso.lds.S                     |   8 +-
 arch/loongarch/vdso/vgetcpu.c                      |  12 +-
 arch/mips/Kconfig                                  |   1 +
 arch/mips/include/asm/vdso/gettimeofday.h          |   9 +-
 arch/mips/include/asm/vdso/vdso.h                  |  19 ++-
 arch/mips/include/asm/vdso/vsyscall.h              |  14 +--
 arch/mips/kernel/vdso.c                            |  47 +++-----
 arch/mips/vdso/Makefile                            |   2 +-
 arch/mips/vdso/vdso.lds.S                          |   5 +-
 arch/parisc/include/asm/vdso.h                     |   2 -
 arch/parisc/kernel/vdso32/Makefile                 |   2 +-
 arch/parisc/kernel/vdso64/Makefile                 |   2 +-
 arch/powerpc/Kconfig                               |   2 +
 arch/powerpc/include/asm/vdso.h                    |   1 +
 arch/powerpc/include/asm/vdso/arch_data.h          |  37 ++++++
 arch/powerpc/include/asm/vdso/getrandom.h          |  11 +-
 arch/powerpc/include/asm/vdso/gettimeofday.h       |  29 ++---
 arch/powerpc/include/asm/vdso/vsyscall.h           |  13 ---
 arch/powerpc/include/asm/vdso_datapage.h           |  44 +------
 arch/powerpc/kernel/asm-offsets.c                  |   1 -
 arch/powerpc/kernel/time.c                         |   2 +-
 arch/powerpc/kernel/vdso.c                         | 115 ++----------------
 arch/powerpc/kernel/vdso/Makefile                  |   2 +-
 arch/powerpc/kernel/vdso/cacheflush.S              |   2 +-
 arch/powerpc/kernel/vdso/datapage.S                |   4 +-
 arch/powerpc/kernel/vdso/gettimeofday.S            |   4 +-
 arch/powerpc/kernel/vdso/vdso32.lds.S              |   4 +-
 arch/powerpc/kernel/vdso/vdso64.lds.S              |   4 +-
 arch/powerpc/kernel/vdso/vgettimeofday.c           |  14 +--
 arch/riscv/Kconfig                                 |   3 +-
 arch/riscv/include/asm/vdso.h                      |   2 +-
 .../include/asm/vdso/{time_data.h => arch_data.h}  |   8 +-
 arch/riscv/include/asm/vdso/gettimeofday.h         |  14 +--
 arch/riscv/include/asm/vdso/vsyscall.h             |   9 --
 arch/riscv/kernel/sys_hwprobe.c                    |   3 +-
 arch/riscv/kernel/vdso.c                           |  90 +-------------
 arch/riscv/kernel/vdso/Makefile                    |   2 +-
 arch/riscv/kernel/vdso/hwprobe.c                   |   6 +-
 arch/riscv/kernel/vdso/vdso.lds.S                  |   7 +-
 arch/s390/Kconfig                                  |   1 +
 arch/s390/include/asm/vdso.h                       |   4 +-
 arch/s390/include/asm/vdso/getrandom.h             |  12 --
 arch/s390/include/asm/vdso/gettimeofday.h          |  15 +--
 arch/s390/include/asm/vdso/vsyscall.h              |  20 ----
 arch/s390/kernel/time.c                            |   6 +-
 arch/s390/kernel/vdso.c                            |  97 +---------------
 arch/s390/kernel/vdso32/Makefile                   |   2 +-
 arch/s390/kernel/vdso32/vdso32.lds.S               |   7 +-
 arch/s390/kernel/vdso64/Makefile                   |   2 +-
 arch/s390/kernel/vdso64/vdso64.lds.S               |   8 +-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/entry/vdso/Makefile                       |   2 +-
 arch/x86/entry/vdso/vdso-layout.lds.S              |  10 +-
 arch/x86/entry/vdso/vdso2c.c                       |  21 ----
 arch/x86/entry/vdso/vdso2c.h                       |  20 ----
 arch/x86/entry/vdso/vma.c                          | 125 ++------------------
 arch/x86/include/asm/vdso.h                        |   6 -
 arch/x86/include/asm/vdso/getrandom.h              |  10 --
 arch/x86/include/asm/vdso/gettimeofday.h           |  25 +---
 arch/x86/include/asm/vdso/vsyscall.h               |  23 +---
 drivers/char/random.c                              |   6 +-
 include/asm-generic/vdso/vsyscall.h                |  23 ++--
 include/linux/align.h                              |  10 +-
 include/linux/time_namespace.h                     |   2 -
 include/linux/vdso_datastore.h                     |  10 ++
 include/vdso/align.h                               |  15 +++
 include/vdso/datapage.h                            |  75 +++++++++---
 include/vdso/helpers.h                             |   8 +-
 kernel/time/namespace.c                            |  12 +-
 kernel/time/vsyscall.c                             |  19 ++-
 lib/Makefile                                       |   2 +-
 lib/vdso/Kconfig                                   |   5 +
 lib/vdso/Makefile                                  |  19 +--
 lib/vdso/Makefile.include                          |  18 +++
 lib/vdso/datastore.c                               | 129 +++++++++++++++++++++
 lib/vdso/getrandom.c                               |   8 +-
 lib/vdso/gettimeofday.c                            |  74 +++++++-----
 108 files changed, 602 insertions(+), 1276 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20240911-vdso-store-rng-607a3dc9e050

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


