Return-Path: <linux-arch+bounces-9985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF9A2712D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 13:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20922167DB5
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158B214219;
	Tue,  4 Feb 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zjT7Aglf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="maYODhnL"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EA214206;
	Tue,  4 Feb 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670770; cv=none; b=Qn0lwnyP3lep8PErltBhHU561LFIv6kQ+gGiSDQNnAtFtVKjSPBYxw8LT3zW3CCXBRbwfH4jkHwuKAn3Np1L0HjnOqlQWMKyg+USEIakUarCFjYt+R3KZR5/AdRSO3qIRdkp+M6FSOaHRxI8zzKNAKhIrb5To52d9qIZLqJUwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670770; c=relaxed/simple;
	bh=diey4KuX/1JIeahP2US5MbAQ+aq1EaqLaZh78/9RRnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwK9458EiKjShLwMvkEihCwKdolTIpxm9Q9gj5SOahxot0FLA8wEH/uktum2ITkBvuL3y8tQWEOgjFpRjNMVgx0ZnxoWx/9jtDXwSop2FbTo9EK1o7cSoLOZqHEgfAt1o+eePjJySYUtQLt2DWZxM40lyQrSwOz6PLAR808jrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zjT7Aglf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=maYODhnL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738670765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wComa0rnv3YEZ+WWCSgArmJaGL7iGg51pamsHsk6CyU=;
	b=zjT7AglfqW8bAJaYgQwyBQ7tphSgCxzlX591JYJNSllxJAInakXKdyvc0UBohtHNcPJHfq
	cyQjcGE3yDfC8DzxG82hOM4BJ71L86tBCYr+4kKFaspzZlRRAgPZB3AKB0nlwFTQbmTRmz
	e/footbcGZcY9JPUghuQrP0fnD/P7938z1x3X4ABUfimO0xiJmouGzcA/hCPFZ6YsWW+z/
	2RdHKIm8XVnCH07Ge+/HVndG6GeM94m1RE/ccWUVQmcMiI+jgrjO7xuUI9ybFARefZYxww
	yljSU7d4WOi5I+fJrVP1jFRh4XR18grNSJafs65dWD6qWJaCahSMLn4vAS2nCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738670765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wComa0rnv3YEZ+WWCSgArmJaGL7iGg51pamsHsk6CyU=;
	b=maYODhnLRzvQTV4wA3qxa6VFPIVn0/4FnFJ5A1dz43kK0y03eAzMeHStiNwlZrl6MQaLJj
	o94SkJjzgkx7PIDw==
Subject: [PATCH v3 00/18] vDSO: Introduce generic data storage
Date: Tue, 04 Feb 2025 13:05:32 +0100
Message-Id: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI0ComcC/2XMQQ6CMBCF4auQrq2ZKQKpK+9hXFA6wCSmNS02G
 MLdLSRucPlP5n2LiBSYorgWiwiUOLJ3OcpTIbqxdQNJtrmFAnUBjSiTjV7GyQeSwQ2yhqYtbac
 JKhB59ArU87yD90fukbffz+4n3K47hQrrI5VQguybliwaa0qjbk927yl4x/PZkti4pH5EBYjwR
 6hMlBV0GhttTI9HYl3XL2ZkT9vzAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738670761; l=9448;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=diey4KuX/1JIeahP2US5MbAQ+aq1EaqLaZh78/9RRnk=;
 b=eykOiCWTO8c7BXuS/MdiVepPTNuDiqU3uNePw1rtYinpyXlJBZbYzbJBzrgNinoOGxbxkPWLy
 CLrsNL8rqq4DQUs+K700KWIg/bSFyxb0dmG+yAQWsQlNnpbWusivgtj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently each architecture defines the setup of the vDSO data page on
its own, mostly through copy-and-paste from some other architecture.
Extend the existing generic vDSO implementation to also provide generic
data storage.
This removes duplicated code and paves the way for further changes to
the generic vDSO implementation without having to go through a lot of
per-architecture changes.

Based on v6.14-rc1 and intended to be merged through the tip tree.

This also provides the basis for some generic vDSO reworks.
The commits from this series and the upcoming reworks can be seen at:
https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/log/?h=vdso/store

---
Changes in v3:
- Rebase on v6.14-rc1
- Fix build on riscv64-nommu
- Link to v2: https://lore.kernel.org/r/20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de

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
 include/asm-generic/vdso/vsyscall.h                |  27 +++--
 include/linux/align.h                              |  10 +-
 include/linux/time_namespace.h                     |   2 -
 include/linux/vdso_datastore.h                     |  10 ++
 include/vdso/align.h                               |  15 +++
 include/vdso/datapage.h                            |  74 +++++++++---
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
 108 files changed, 604 insertions(+), 1277 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20240911-vdso-store-rng-607a3dc9e050

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


