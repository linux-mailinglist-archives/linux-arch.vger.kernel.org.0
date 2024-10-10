Return-Path: <linux-arch+bounces-7981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A004998C2B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E09286E40
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970811CF285;
	Thu, 10 Oct 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r7gfiTCA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/DL35uF2"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD141CDFA6;
	Thu, 10 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575099; cv=none; b=nwuZuD5liAaVmvkXMeW6QsjkI485Z1mDXvtnghk/dUC5TDsvIyEjFcmu9fhZSxe+yJ+iNF55PTNwZteq34O9n0i/Lj+ER/woF5fc+fVEP6UBd/A5va00KS8bsghxNH3IXqxkA6P52rG+uhagAJrh9CpK3DEDnYSGGDnkkrSo0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575099; c=relaxed/simple;
	bh=hpe2ufKxO4wcPCONeGKr9TgGjUW1E936UNjQ+nG3JrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2OP/Q7e44LE44OClRoL87VboKAwM683+OujmhXS1huCmsrMJOVKT8HelIzBU0pWPr72qRsu2JFTdaTfpVRh9nUVB1kmMVNlzlwt9zw06TL2+4f2xkpOFj0m/Rcd4IiZDY3+RAkoQodFYrOSPkLFd7LoRu8usJrH0xwmOtX6qV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r7gfiTCA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/DL35uF2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xat0rCkZfuBVy+ds3zzBGDHknhhfaZxhQ/1dfBCZr0w=;
	b=r7gfiTCAQsC/p9L8arvUB1AcmoVbCb06KBfvAwUFBPwE66xPrDZQdOplzHIkTk8Ac+gZDw
	U0EI8/RO2Lf8EqoHHhdV4kOrPr72E2evRfwp3/650RyeQ8xtIomCo6LTOQ1/ibOpBYkYEZ
	r7s96u2+hJUxvZiXOQUgdiY7W6DG3HNC8YgqGQzz6Xat0ZwQJsfXNo1Z5JwLHl9z76Rg0T
	DGjebvVvqJXVuxA25TVBeCwHEPgSItZzu56rtV7mC5kN3RCXB4sCckDrEbdeLy0B5tUmFf
	kMZ/7UlwgoXOdjavq4NU/tC3ZP6yn9+GecVyQ/QP5XU8uP+K27J2wvgwBKvp8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xat0rCkZfuBVy+ds3zzBGDHknhhfaZxhQ/1dfBCZr0w=;
	b=/DL35uF2ubZb8FaGaS2Xtk8IO1KgnsvpfdbZ00U4SPY460WhPFgu+WtEUEO78djLJSq7mr
	9SWI6gYYUV4MWGDg==
Date: Thu, 10 Oct 2024 17:44:48 +0200
Subject: [PATCH 5/9] riscv: vdso: Remove timekeeper include
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-5-7fe5a3ea4382@linutronix.de>
References: <20241010-vdso-generic-arch_update_vsyscall-v1-0-7fe5a3ea4382@linutronix.de>
In-Reply-To: <20241010-vdso-generic-arch_update_vsyscall-v1-0-7fe5a3ea4382@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-s390@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=1078;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hpe2ufKxO4wcPCONeGKr9TgGjUW1E936UNjQ+nG3JrU=;
 b=Z6RtjK/nc0O8tEfVBTBZ0WJ1sj/stEr5ZpmR3YKRCxCah4hYNPuy68GyBh4E+r7C/qWgfxerT
 IHK16qphOLZBJGY2dzcOgcs6USZ+7MX7DH4slmMU1FQj0Mj/nZG1UXo
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/include/asm/vdso/vsyscall.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/vdso/vsyscall.h
index 82fd5d83bd602c72c1688a7dffa292b37b5fa790..e8a9c4b53c0c9f4744196eed800b21f3918d1040 100644
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ b/arch/riscv/include/asm/vdso/vsyscall.h
@@ -4,14 +4,10 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 
 extern struct vdso_data *vdso_data;
 
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline struct vdso_data *__riscv_get_k_vdso_data(void)
 {
 	return vdso_data;

-- 
2.47.0


