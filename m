Return-Path: <linux-arch+bounces-7977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B4998C19
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DD8288BE2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C41CDA14;
	Thu, 10 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sIOYAh5N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g1Dc/Dss"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729391CC8B2;
	Thu, 10 Oct 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575097; cv=none; b=RMidtkUXpT7d5Ejrnf1nQqwziRQB3js4C16AuA+AjBDLBJMWTu9a3YXkWBZkK3uRZvnqb0GkG2NY7TO1nuqNP5Z9P/3S8VNlteW1sHs4JU+7o0x/KgIJ0Ff8kwt25JM9KBm7X9JB4EeeoSfveW2mi7cpggfuqu/n9JT8rvDHe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575097; c=relaxed/simple;
	bh=UwiQqNt43HWSbVEJA12ycEovjhf8yvNhZRUab1vZ6TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxBR2J2x2kCl4X8N9atNbE4Rzsrog+ptZw3p7JBfsRvX4CbkKmiR70nklaTrX0ew/YzZMXKqHNKV0A9vfltTff/fBX4vSdqSILjJDiCm44cpeybTlmSybTpWnutX2J25BIRQ2NM7EKFCFUf5lsOs4azHHyH7nlM8LHHmDkSNTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sIOYAh5N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g1Dc/Dss; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4vUnVSJS3DTEb//Gs9BVFoP2u0LwPRGtOqbRqRypbM=;
	b=sIOYAh5NzXO0FOxy5po1A3r9yhCcksujDF8lsizoipoumMt6VTgm2JcDvV6NwBbBMlbGJx
	Kn3LsdIJhEXc0rrXzy1MHxdrkMCWzbNbsg/turOZ6YbjPY3cq/Z+/Rf5iw3YzOZMJeAms+
	inOaqTMkyaJMfzMgx/DJqFoi0ZOImxKYKuwFgYChI4FLMHyE92T9iHRhmVeOcca81HpsXY
	SICMUvoJ2A9p9IUe0zweJ/8yzVc1dttU98/chnLvx+HSrwdY6nP6BSkjfsst/rkXt3kHEE
	9PFuJfMyufxQ26tfvzuwUAoQ6Ij6qCeHRXQT6o52lhnqEbynfzhVl/yRhZ0Szg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4vUnVSJS3DTEb//Gs9BVFoP2u0LwPRGtOqbRqRypbM=;
	b=g1Dc/DssNf7HgFLP/aKNzFqQAI+fIyoQsY+40NP2OIH2OwKugLREQbaHbQ8liXUdTYoZ2A
	mIWRh2bOk4Agl8Dw==
Date: Thu, 10 Oct 2024 17:44:45 +0200
Subject: [PATCH 2/9] arm: vdso: Remove timekeeper includes
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-2-7fe5a3ea4382@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=1591;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UwiQqNt43HWSbVEJA12ycEovjhf8yvNhZRUab1vZ6TI=;
 b=3nrK8ribXR6CLoOX+9blmTN0WotnLlJVbn0mBaFSX/u7EyGlJSmB7anjWYMlRkqPO1MDPqqek
 2+m9ZLARYeaC+jFTNzFUSsmzlNKktBc4+BBRN++ne/SFR7a3xWCy7w4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/include/asm/vdso/vsyscall.h | 4 ----
 arch/arm/kernel/vdso.c               | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index 47e41ae8ccd0b997b54dda59abea8ae98bbe3c56..705414710dcdbfa9a97c344806bd079c08368801 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -4,16 +4,12 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
 
 extern struct vdso_data *vdso_data;
 extern bool cntvct_ok;
 
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__arm_get_k_vdso_data(void)
 {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index d499ad461b004b05e1f0f13cbedad71b587f8478..29dd2f3c62fec64c7f290468421bfad1e739c667 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -14,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
 #include <asm/arch_timer.h>
 #include <asm/barrier.h>

-- 
2.47.0


