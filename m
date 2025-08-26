Return-Path: <linux-arch+bounces-13282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C834B35433
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FB668525E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257F2F83B7;
	Tue, 26 Aug 2025 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RgDlVbjO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8pcUg9Do"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932072F6567;
	Tue, 26 Aug 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189106; cv=none; b=nIqeohaX1vDenTw4H3RtjL3SZRXV5q7YUV5AF7PskEE8a2zuWRtJI1j6XRT1JaNuDB9e5NyxLKelp/x6kjyEdK1T0dfL97EDwp9iVSp2iSisRjcya2yGSuvQseChA1tNR2K7d8rIIikqevkaFc0emdLxksZgC5FF1ZqM407DQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189106; c=relaxed/simple;
	bh=t5/9HDmyIs2t4g7FWEeD3BGuAZjUNxjgX5TY/5a0ZYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OH4NAA25wdO1T5Pf1NT+uBX4KXl5OljTqF29VMrDCaKDJGQNT6YYw4MFnLEPGXXGrBtD5lk7gR9lZQYa2xYEB3AQqImZTk7rgUem8M6iE+hXISu4Aj2TUe4qxXY1hl+2IxMoWq6++u5nenL8QNgCidBy84NRZPFuNDZdCJe7vfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RgDlVbjO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8pcUg9Do; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0t+60eV41IKUZ9ezcmekgKTWqNgupDcJulsKXmUteXI=;
	b=RgDlVbjO8jhuoPY4mfKuN7Slnu45ISnAWFOw/cSKuUrM166A5Xf4Erm/D2UDrSZRjb+TRd
	kgmua8gHOCLunG9wwz2DpSTBXdpmSEa71Lb0hP+HK5ysGZ4To/F9r9b4YwQ9GRjarwPVe9
	uS9AhT4Sz0+dbivk9lEzt4gd1nc4bK5HMZCjdAVtZW/0Fq3ATh+T7SGWw+DWsEEnez8l0S
	l+JOMfNCM36pb3xgaN/Xdoh5jXwrQ/yCb90R7Ig/RRuSEtYwhJZ6k4ETPQI7pdrgOQZwVs
	cqIUgd5QTF7ISENOyaqbvQpo+sHhZmxunt2tS6GEfzGIrgBnNf5Lv/0G9tlpGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0t+60eV41IKUZ9ezcmekgKTWqNgupDcJulsKXmUteXI=;
	b=8pcUg9DoAWVBxDLyXzgtGwnNadG0alezHP8Es7YoGFl4eRzHD98RNasRncD8HY+yHWoxjq
	+eUsVcLyCZNMQYCA==
Date: Tue, 26 Aug 2025 08:17:11 +0200
Subject: [PATCH 08/11] vdso: Drop kconfig GENERIC_COMPAT_VDSO
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-8-d9b65750e49f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=1240;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=t5/9HDmyIs2t4g7FWEeD3BGuAZjUNxjgX5TY/5a0ZYE=;
 b=CNBKp7BJyz4ivh16tO14JDMhakvNZC/uzVXIEyWpElrKLVyg8TDExe/3LZIlXzjfpdnGKz/bi
 sJVuBe1Vf4yBKs8TudfOmPB/74FMQCcA5A/RjRFrYkYOWqYvHO0ISoL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This configuration is never used.

Remove it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/Kconfig | 1 -
 lib/vdso/Kconfig   | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64d7ef1793a5d7f7ff8db138f2814..5c61b19ea9c80559ca3c4d1aa0732c6126494cb0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1782,7 +1782,6 @@ config COMPAT_VDSO
 	bool "Enable vDSO for 32-bit applications"
 	depends on !CPU_BIG_ENDIAN
 	depends on (CC_IS_CLANG && LD_IS_LLD) || "$(CROSS_COMPILE_COMPAT)" != ""
-	select GENERIC_COMPAT_VDSO
 	default y
 	help
 	  Place in the process address space of 32-bit applications an
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 76157c26931d28327750ad53bfcae5109a29d998..2594dd7185be762a4a94aa38ecec5db016776f85 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -12,11 +12,6 @@ config GENERIC_GETTIMEOFDAY
 	  Each architecture that enables this feature has to
 	  provide the fallback implementation.
 
-config GENERIC_COMPAT_VDSO
-	bool
-	help
-	  This config option enables the compat VDSO layer.
-
 config GENERIC_VDSO_TIME_NS
 	bool
 	help

-- 
2.50.1


