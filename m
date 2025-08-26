Return-Path: <linux-arch+bounces-13274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3AB3540A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952B76849B9
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4222F548E;
	Tue, 26 Aug 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EoHq8It+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eX2IPWAG"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BF22D9F7;
	Tue, 26 Aug 2025 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189102; cv=none; b=hXwHYIWfohLq7XOqCcqV4QJIr7s7oHxiqwH/9b7DV1NPp8FcvNR0h7cRHJVjP3Wgrh96IGOkjjmK2Q2bLwNy/O14SV6nJptsQi57JZ5tUnGmvhcKC2NKeNaaWylQtvJdducILx+N1d3Rut42quUSD+LLobyQ5e0z0AHXg7qrIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189102; c=relaxed/simple;
	bh=OKdbTtNFiNAfKDCNOTVL/ZRLmxAuqZzdXzmwBIqDanM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pKOmLcAY0FI2gWPf6/qS5dWdp++VOkZsSkGxImaZnZUlo7rxhUPg6JjlIHeHq9mlpIc/fUD8D1/Ti0Er+4WxtIBWvsPIXRzTjOYooMlxnYNlVFos53oU75OwLt1005sHtkIIYBt7pf7/ZVBrBISIwF4jcJwvrMh1quda/zGF0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EoHq8It+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eX2IPWAG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Qx8zdXwUDEN+QDzIjybGTquRbhLyER4hmo5HtXCS3M=;
	b=EoHq8It+802uE8/W/ZgT+WU1MhU30ljvVJg6J8CsR2XdSCY1W8iKO/0yhuhlIWg93gjtVN
	yjsiguKOCe8MXqL7t5b5NeIYigkWxr9EZY2Mkn3x2W0dIf65A5h/s69Jx20ZLL24VmAnXl
	wWm91dlrX8UnePleqQexNGzu9SWDwlcPXJ8DztYUIGGk65aJetDl/MNeXhull8xcLDd2T/
	Xdhztn1zm0BL6qd7sdPVV8txFwrP1lt98FW2I+LmBrQOqG2Iv+EpggKyKaF35t2W+WDCO2
	x4LqgXrpkfrN62Egk6oQBRYWy9iOgErie977mytBr36Yc1c7jJeu3fV2/Qh79g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Qx8zdXwUDEN+QDzIjybGTquRbhLyER4hmo5HtXCS3M=;
	b=eX2IPWAG+DvooY6YzvBNYPIk4d7JwL6SQGjcVcR/3nVRkZUD/9wZEdubuxvUX29zgYJ6tr
	+6ncwJ9ZGLDV8KDQ==
Subject: [PATCH 00/11] vdso: Various cleanups
Date: Tue, 26 Aug 2025 08:17:03 +0200
Message-Id: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF9RrWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNT3bKU4nzd5JzUxLzSgmLdtBSztKQkY6O0ZENLJaCegqLUtMwKsHn
 RsbW1AHxpxT5fAAAA
X-Change-ID: 20250825-vdso-cleanups-fd6fbb32fc19
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nam Cao <namcao@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=3008;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=OKdbTtNFiNAfKDCNOTVL/ZRLmxAuqZzdXzmwBIqDanM=;
 b=xXLb28HhyOp2V5PAl7NV8Ih+DLTz+T0EwU3m8mTK7t+YdB+1/WbVwG3q2LXi/d5YbmXMM3lwS
 UE/A4xDXG50Ay40TUaB+Dz47MZKMYqchu5q89DYuvoo2r9Z3sDlnSRd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various cleanups to the generic vDSO infrastructure and a patch for ARM
which was never applied.

This series has one trivial syntactic conflict with "dso/datastore: Allow
prefaulting by mlockall()" [0] and a semantic one with "sparc64: vdso:
Switch to generic vDSO library" [1], which still uses the removed
GENERIC_VDSO_DATA_STORE.

[0] https://lore.kernel.org/lkml/20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de/
[1] https://lore.kernel.org/lkml/20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Rasmus Villemoes (1):
      ARM: VDSO: remove cntvct_ok global variable

Thomas Weißschuh (10):
      vdso/datastore: Gate time data behind CONFIG_GENERIC_GETTIMEOFDAY
      vdso: Move ENABLE_COMPAT_VDSO from core to arm64
      vdso/gettimeofday: Remove !CONFIG_TIME_NS stubs
      time: Build generic update_vsyscall() only with generic time vDSO
      riscv: vdso: Untangle kconfig logic
      vdso: Drop kconfig GENERIC_VDSO_32
      vdso: Drop kconfig GENERIC_COMPAT_VDSO
      vdso: Drop kconfig GENERIC_VDSO_DATA_STORE
      vdso: Drop kconfig GENERIC_VDSO_TIME_NS
      vdso: Gate VDSO_GETRANDOM behind HAVE_GENERIC_VDSO

 arch/Kconfig                                      |  2 +-
 arch/arm/include/asm/vdso/vsyscall.h              |  2 --
 arch/arm/kernel/vdso.c                            | 10 +++------
 arch/arm/mm/Kconfig                               |  2 --
 arch/arm64/Kconfig                                |  3 ---
 arch/arm64/include/asm/vdso/compat_barrier.h      |  7 +++---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  6 ++---
 arch/arm64/include/asm/vdso/gettimeofday.h        |  8 +++++++
 arch/arm64/kernel/vdso32/Makefile                 |  1 -
 arch/loongarch/Kconfig                            |  2 --
 arch/mips/Kconfig                                 |  1 -
 arch/powerpc/Kconfig                              |  2 --
 arch/riscv/Kconfig                                | 12 +++++-----
 arch/s390/Kconfig                                 |  2 --
 arch/x86/Kconfig                                  |  3 ---
 include/asm-generic/vdso/vsyscall.h               |  4 ----
 include/vdso/datapage.h                           |  9 +-------
 init/Kconfig                                      |  2 +-
 kernel/time/Makefile                              |  2 +-
 lib/vdso/Kconfig                                  | 25 +--------------------
 lib/vdso/Makefile                                 |  2 +-
 lib/vdso/datastore.c                              |  6 ++---
 lib/vdso/gettimeofday.c                           | 27 -----------------------
 tools/testing/selftests/pidfd/config              |  1 -
 24 files changed, 31 insertions(+), 110 deletions(-)
---
base-commit: 3cd1f6bc6aa056cfd32946f9ce0aa3eb3db180e8
change-id: 20250825-vdso-cleanups-fd6fbb32fc19

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


