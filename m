Return-Path: <linux-arch+bounces-13281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE7B3542D
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD981B65121
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C902F83A5;
	Tue, 26 Aug 2025 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4Tv7+zx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMy3eGdf"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479A2F618F;
	Tue, 26 Aug 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189106; cv=none; b=O2Y5gN0XShPRI3X4FYqThBbd9VukPmnqBZEhlbu9uTdbYnBn5pcHGx4tXHjPSeujHlGNHie284385A1BMV7nFTSl2V/QBtxVcu2vb/pErQwtaHHR3XZL5oNwqX1fXLPpqQmmaIu7PJW+kkvCR/6gvtXDuy+tDY0HMz8V4hIOa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189106; c=relaxed/simple;
	bh=MIu9l2pTXbhJrvGPCmWjImoXUcbBkNjVmM+9aAFDkec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPuWj6pDafWtR8vuz2wvF/ShEVYGdXUQ7/MXldtrui7aSI2rZCTt8SrVSkoNxAWaIE8gthj3F+g+7wc0jApgxGl+8LXmH0hR1YYVY791iHvczCwwnNitXRVz3lr181EBXfA/kj57RxgecTHEb7ZxdbRe8bbOw1sGYUz8IEQw5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4Tv7+zx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aMy3eGdf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrBALLudUMMQIpB9Jb++BwmBRlfN0yHG1/njX6fnTE0=;
	b=s4Tv7+zxFO1UuAQBOJqY36fYzoMoq9HBwuIpEoBOQcWaZh9/ewd4GAmLh1SU0pUebpqr7O
	IrbBTzCLj7CJDuzlV6Dcdr1OqFm6SyO764o/62pnvhkTGUXW7ugMG+bh1U2I/2k0NNBSr5
	OP1XpFRZEaXTaVFqIq3YdSg5+qsRfdKUKvpdsuwozMooSfzSGI0VUbRnkjOqSx5qOrar6I
	ypdEH+UclFWViex+hKIMMrHA9akYZJ7i5W7/rVbBGGVIoe66Tmy8jOSesu8OQcaEiRtLvM
	BHYdoRiODg0CG8wUQD0HRSdvaeLU921bXP6hDATICdIR91DBtxAh0Kw0aN0s1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrBALLudUMMQIpB9Jb++BwmBRlfN0yHG1/njX6fnTE0=;
	b=aMy3eGdfoQdV0esGEjqNzj2T+GNVN9Gu5aP0E8xfdTY9CE2D/Ql6h41CsmHASq33jrTvgS
	d2ksM8s+JfbrYcAg==
Date: Tue, 26 Aug 2025 08:17:10 +0200
Subject: [PATCH 07/11] vdso: Drop kconfig GENERIC_VDSO_32
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-7-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
In-Reply-To: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=1702;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MIu9l2pTXbhJrvGPCmWjImoXUcbBkNjVmM+9aAFDkec=;
 b=VT2YYQvzHfODm57uAqR09c1duKjkkmGSVqmCVlLdgGb/ARCoX9KqMLFcxG4POgZTTs3Rm7rqY
 RTH8Lz9nPvLBWpZeMT5QB55ugWOPWVYU1mHssRVmDUpj+5tIKw9H+EU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This configuration is never used.

Remove it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/mm/Kconfig | 1 -
 arch/x86/Kconfig    | 1 -
 lib/vdso/Kconfig    | 7 -------
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5c1023a6d78c1b4db67b2d62b71af5a79b7e701f..2347988cf6417b91d8d3580387b53e610ed49a00 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -926,7 +926,6 @@ config VDSO
 	default y if ARM_ARCH_TIMER
 	select HAVE_GENERIC_VDSO
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_DATA_STORE
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100eb6990880bcf5ba600cdefb0a7d1..4f120070a51bd4e225256440649a2dae17025c41 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,7 +14,6 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
-	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
 	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 45df764b49ad62479e6456e00c053e46131936a3..76157c26931d28327750ad53bfcae5109a29d998 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -12,13 +12,6 @@ config GENERIC_GETTIMEOFDAY
 	  Each architecture that enables this feature has to
 	  provide the fallback implementation.
 
-config GENERIC_VDSO_32
-	bool
-	depends on GENERIC_GETTIMEOFDAY && !64BIT
-	help
-	  This config option helps to avoid possible performance issues
-	  in 32 bit only architectures.
-
 config GENERIC_COMPAT_VDSO
 	bool
 	help

-- 
2.50.1


