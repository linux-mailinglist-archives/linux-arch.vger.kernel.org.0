Return-Path: <linux-arch+bounces-9393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9449F3282
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFB8163DF5
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EB205E16;
	Mon, 16 Dec 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KdufFQ9y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/u+tT8fS"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1329205E17;
	Mon, 16 Dec 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358254; cv=none; b=e3ZkWFP76Xn/ft7iz9wskfpbH6MyMb8jpiIFKsZFyAqhsj82on7I2xrS6c1J7dvKUYB4FerPywl+dmUxC7WUxZ2N9csiAkjBGZbVL92AIWgHqppErQUyCetTr2c3fPhSAFtI4+d5cI/LC1uiJCFRVl9fyOG5P9S3+GChxqFNxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358254; c=relaxed/simple;
	bh=djYBYaWoItcXUsVYqkOg6DhKy9XnOUI8nNrRC+z9rAU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hjoSesfoksHnFiC0qcOznQy8FQRHZmfLP6VM+7eEF9gHvaTGgNRoWLcxg7gcS0NRtYnPxfz8LXyDQP7ZqmfwSlDdVRnLt79NIJaBSpeJSHMu+/aB3adyaTi9SDsqMqWzkfO98P24vptFbOdowHcQCWLdW5ad9pbA/aTrbOrM63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KdufFQ9y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/u+tT8fS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734358250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HKVp/Caa3kBEDzmNrfvKYA3RNNrY0C92zVprRqMI1SE=;
	b=KdufFQ9yzC5Ccn77ghWA8wMSofMP42Zkq2YdPaJ2A10YNms20X7NC8Hxi+abz4ROYmqVYh
	CKh8+qO4oFDm3McLx4thCKwPp4d9pZkbPn7YuRT6GdMzrOCCJ9LAd+SLXp9FxXhrYc1Njf
	EASL4b3P4RxQ/VMcgorUj16d32fvKJI5JcWLHGxqYuOOu7tXzsGjHIKxOeEWngv8j8V1xD
	VqLUtnbtI3PL9fNVv0DclRhDYLLKxW9sneh1Gx5Q8jZ+EULkpYDXOXsb4FJG7BTQMCkBGb
	E5E9fCgAEOXWs0vcarn0iqbq9v3goh4LSx3xpzWX3C+fuKDi/c1tOtRR/bod3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734358250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HKVp/Caa3kBEDzmNrfvKYA3RNNrY0C92zVprRqMI1SE=;
	b=/u+tT8fSj1h0nM3WDlaNJH3x66iqvvap+8AtYcWufIcKOYjQK6XUnl7D/FVY+IzgCPpSQr
	1E+y5++vPqqWOdDQ==
Subject: [PATCH 00/17] vDSO: Introduce generic data storage
Date: Mon, 16 Dec 2024 15:09:56 +0100
Message-Id: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALU0YGcC/x3MywqEMAyF4VeRrCeQekVfZXAhNmo2rSQiM0jf3
 eryg3P+C4xV2GAoLlA+xSSGDPcpYN6msDKKz4aSypp65/D0FtGOqIwaVmypmyo/90wNQT7tyov
 83uB3zN7k2f6ffkrpBvZg+p5vAAAA
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
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734358247; l=7632;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=djYBYaWoItcXUsVYqkOg6DhKy9XnOUI8nNrRC+z9rAU=;
 b=nB6k75T44i3XiBispikp3W7OCCiI+BnnKEjikbsYEp+QxVBLBTagyb2PXd9wSlsp2iNvC4Dr8
 7Dg6HPvjJg+AI7LSiIsW01eZlsVkYR2FxwK80tr8AI4F5QdZPyk/VoF
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
Thomas Weißschuh (17):
      parisc: Remove unused symbol vdso_data
      vdso: Introduce vdso/align.h
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
      vdso: Remove kconfig symbol GENERIC_VDSO_DATA_STORE

 MAINTAINERS                                        |   1 +
 arch/Kconfig                                       |   4 +
 arch/arm/include/asm/vdso.h                        |   2 +
 arch/arm/include/asm/vdso/gettimeofday.h           |   7 +-
 arch/arm/include/asm/vdso/vsyscall.h               |  12 +-
 arch/arm/kernel/asm-offsets.c                      |   4 -
 arch/arm/kernel/vdso.c                             |  34 ++----
 arch/arm/vdso/vdso.lds.S                           |   4 +-
 arch/arm64/include/asm/vdso.h                      |   2 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  |  32 +++---
 arch/arm64/include/asm/vdso/getrandom.h            |  12 --
 arch/arm64/include/asm/vdso/gettimeofday.h         |  16 +--
 arch/arm64/include/asm/vdso/vsyscall.h             |  25 +----
 arch/arm64/kernel/vdso.c                           |  90 +--------------
 arch/arm64/kernel/vdso/vdso.lds.S                  |   7 +-
 arch/arm64/kernel/vdso32/vdso.lds.S                |   7 +-
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/include/asm/vdso.h                  |   1 -
 arch/loongarch/include/asm/vdso/arch_data.h        |  25 +++++
 arch/loongarch/include/asm/vdso/getrandom.h        |   5 -
 arch/loongarch/include/asm/vdso/gettimeofday.h     |  14 +--
 arch/loongarch/include/asm/vdso/vdso.h             |  38 +------
 arch/loongarch/include/asm/vdso/vsyscall.h         |  17 ---
 arch/loongarch/kernel/asm-offsets.c                |   2 +-
 arch/loongarch/kernel/vdso.c                       |  92 +--------------
 arch/loongarch/vdso/vdso.lds.S                     |   8 +-
 arch/loongarch/vdso/vgetcpu.c                      |   7 +-
 arch/mips/include/asm/vdso/gettimeofday.h          |   9 +-
 arch/mips/include/asm/vdso/vdso.h                  |  19 ++--
 arch/mips/include/asm/vdso/vsyscall.h              |  14 +--
 arch/mips/kernel/vdso.c                            |  47 +++-----
 arch/mips/vdso/vdso.lds.S                          |   5 +-
 arch/parisc/include/asm/vdso.h                     |   2 -
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/vdso.h                    |   1 +
 arch/powerpc/include/asm/vdso/arch_data.h          |  37 ++++++
 arch/powerpc/include/asm/vdso/getrandom.h          |  11 +-
 arch/powerpc/include/asm/vdso/gettimeofday.h       |  36 +++---
 arch/powerpc/include/asm/vdso/vsyscall.h           |  13 ---
 arch/powerpc/include/asm/vdso_datapage.h           |  44 +-------
 arch/powerpc/kernel/asm-offsets.c                  |   1 -
 arch/powerpc/kernel/time.c                         |   2 +-
 arch/powerpc/kernel/vdso.c                         | 115 ++-----------------
 arch/powerpc/kernel/vdso/cacheflush.S              |   2 +-
 arch/powerpc/kernel/vdso/datapage.S                |   4 +-
 arch/powerpc/kernel/vdso/gettimeofday.S            |   4 +-
 arch/powerpc/kernel/vdso/vdso32.lds.S              |   4 +-
 arch/powerpc/kernel/vdso/vdso64.lds.S              |   4 +-
 arch/powerpc/kernel/vdso/vgettimeofday.c           |  14 +--
 arch/riscv/Kconfig                                 |   2 +-
 arch/riscv/include/asm/vdso.h                      |   2 +-
 .../include/asm/vdso/{time_data.h => arch_data.h}  |   8 +-
 arch/riscv/include/asm/vdso/gettimeofday.h         |  14 +--
 arch/riscv/include/asm/vdso/vsyscall.h             |   9 --
 arch/riscv/kernel/sys_hwprobe.c                    |   3 +-
 arch/riscv/kernel/vdso.c                           |  90 +--------------
 arch/riscv/kernel/vdso/hwprobe.c                   |   6 +-
 arch/riscv/kernel/vdso/vdso.lds.S                  |   7 +-
 arch/s390/include/asm/vdso.h                       |   4 +-
 arch/s390/include/asm/vdso/getrandom.h             |  12 --
 arch/s390/include/asm/vdso/gettimeofday.h          |  15 +--
 arch/s390/include/asm/vdso/vsyscall.h              |  20 ----
 arch/s390/kernel/time.c                            |   6 +-
 arch/s390/kernel/vdso.c                            |  97 +---------------
 arch/s390/kernel/vdso32/vdso32.lds.S               |   7 +-
 arch/s390/kernel/vdso64/vdso64.lds.S               |   8 +-
 arch/x86/entry/vdso/vdso-layout.lds.S              |  10 +-
 arch/x86/entry/vdso/vdso2c.c                       |  21 ----
 arch/x86/entry/vdso/vdso2c.h                       |  20 ----
 arch/x86/entry/vdso/vma.c                          | 125 ++-------------------
 arch/x86/include/asm/vdso.h                        |   6 -
 arch/x86/include/asm/vdso/getrandom.h              |  10 --
 arch/x86/include/asm/vdso/gettimeofday.h           |  25 +----
 arch/x86/include/asm/vdso/vsyscall.h               |  22 +---
 drivers/char/random.c                              |   6 +-
 include/asm-generic/vdso/vsyscall.h                |  15 +--
 include/linux/align.h                              |  10 +-
 include/linux/time_namespace.h                     |   2 -
 include/linux/vdso_datastore.h                     |  10 ++
 include/vdso/align.h                               |  15 +++
 include/vdso/datapage.h                            | 105 ++++++++++++++---
 include/vdso/helpers.h                             |   8 +-
 kernel/time/namespace.c                            |  12 +-
 kernel/time/vsyscall.c                             |  19 ++--
 lib/Makefile                                       |   2 +
 lib/vdso/getrandom.c                               |   4 +-
 lib/vdso/gettimeofday.c                            |  62 +++++-----
 lib/vdso_kernel/Makefile                           |   3 +
 lib/vdso_kernel/datastore.c                        | 125 +++++++++++++++++++++
 89 files changed, 574 insertions(+), 1231 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20240911-vdso-store-rng-607a3dc9e050

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


