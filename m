Return-Path: <linux-arch+bounces-13284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA4B35445
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1909C20538D
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602FC2FB60D;
	Tue, 26 Aug 2025 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qff84Umw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faCkWxdj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201092853E9;
	Tue, 26 Aug 2025 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189111; cv=none; b=Da+sbUlZK0IyyAL0FRlIZAkUvnyf53dr5deAm7e13UaJNKpBdcvvNvvsLfMAMUECPIjWmgBojR7YpEkFp2KcaFk8tzGlzforUw3iZc+ZwfRIZ9MHOwDwxbl+dM3ljwAqUaNmB1DK7l/3d17ldg1adwMmrRIA4Z04MsO2epGaiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189111; c=relaxed/simple;
	bh=e70kJzk3rr3WiO6RHhXGvE8arznJOv7er7zNzG1lBZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAan8sWtADeR5fQENN8SfRffYqpsa57iAapwSrF7h7fHFBhiQnywYRZszEU6Bje33EB1nH2xsPcfnQ8hf0RqHMmS6ujoNMldwChLn/eWVkez2fHcs6wXmbZ0iDgfZpE8Q5WBorKStJrS4EdjmVgFVb9GsaDMQOIZuWWhL4oz0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qff84Umw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faCkWxdj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUyzbl96JnTO9V3eNt5MssqL9K7R8ZPYrzwmUDypjtQ=;
	b=qff84UmwLm8iFQvqm09Om+iEel23vC9BJ1wHMhpnGuRjjiVtocG2gJc/efnzy7UGv0bqDh
	X4YctMH0aSIUxDd3i6X4JoDQFU5IM3b5mriVj4iiUX/4ke9TsrEXJU+QjgXN9L2Hvg/r1e
	gVrERdEyqsHFDbRTatoD2jUbrkzofjIHreOcsZGCDEtvBgy1C9OjuykTbsIoRwvmsiEo67
	TT3uKBDVEPfUk1K7JbyuNP89aqNk5szSg7Q98Esgpnao8uytgt5ztulcsAYjKovknEd1Gv
	DdfAb+Xqa/DsFSf6/Qptu/gAQ+92+1NXjLnQVTycTHPHpfQqUdNFtsZzBM1PEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUyzbl96JnTO9V3eNt5MssqL9K7R8ZPYrzwmUDypjtQ=;
	b=faCkWxdjd3FeEyW+rea8Q+WUcDNk36hjcPMaS1Mmo0pdEShLBn6gpn0pA+neXsTYaNOZIy
	GVnfWQSajoT7S0Ag==
Date: Tue, 26 Aug 2025 08:17:14 +0200
Subject: [PATCH 11/11] vdso: Gate VDSO_GETRANDOM behind HAVE_GENERIC_VDSO
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-11-d9b65750e49f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=740;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=e70kJzk3rr3WiO6RHhXGvE8arznJOv7er7zNzG1lBZY=;
 b=Q6ersM0eWZuFWFRqw7St9QnfIHgjvUfXPslz3bmlle7dR6R1Tm8FlCD46/a/HTAHi+acl41TM
 HHiIuT3vNAnDyILoXrbvH+hSpTHjerUzqwG/UiWNkrt8K08Oly20NA4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All architectures which want to implement getrandom() in the vDSO need to
use the generic vDSO library.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 3d2c2b90d193f984e3a202e701fa7f0bfa8f1938..db87ba34ef1928fac0d5c58abca86312687cc159 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -19,9 +19,9 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
 	  time getter functions for the price of an extra conditional
 	  in the hotpath.
 
-endif
-
 config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
+
+endif

-- 
2.50.1


