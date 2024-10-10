Return-Path: <linux-arch+bounces-7984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A765998C37
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE21C23BB4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA441D04B9;
	Thu, 10 Oct 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVQLUC+r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ADrtVXTW"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278141CEACF;
	Thu, 10 Oct 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575101; cv=none; b=nwcN1ZZ4mbJGZri3m17ID5xxu/URO7wGTHp3LAzqR5ZF37+1HdP3l5OG6tDHJZ5SMMc+QQ9srqP61W8wjOFqio8fXn0QuQP9S7d4ZG+m7pwlHKF59HnjmEzKKOiQxldv5nyf9adqMJPS9x0pGZxRlyRfiT0mNoOEMZdRYqFwfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575101; c=relaxed/simple;
	bh=pLcSqgwzYZzBo43HvSx25Hsn5bLBJRfRGzhKUgfQZe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQBRuqsmpZpKLEDddoToFgCrFfUMtn0RBimUlWSdfQOcPwT9cl3bgbEKOM2Sjk8LD3uoM2eE54H2OaBr7GYo5Ub+HWO7mvVOEAbD9hMnXShuFSCr2/oV0Uyln0dJ62rZFT6Y4bycoFF+Vxuruxabf8DI2MOEmOiXNw82Mfeo3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVQLUC+r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ADrtVXTW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsHx7qJCDp7IdV2H4CgXW4RKtdZIxmt6s+IvFtPbyqE=;
	b=bVQLUC+r0/Au47mrhMwXmYQ+ioZC+OFZQoOvliDU2YgPow76zr+3eWl1iXeXQZhzkvNZwd
	UPK06iM4TS7Qe1ogctAebisMoKyIvigMYwSGOVq3hBhS+c3bXWK+uBCOuqQ3kLjeewA8ZS
	rG14+VvgJM++oRIVOFyJ1jrq0nT0z3kaIg0GDV4oUwtHOb/VqEoBbznA5eepHjJtLa1yf6
	9oKUQg/C8OKSYEgCQUiyTZtCgq7vPnxrSjfCAyGhhyBbLa1JgDepmxG5SESflfsr4pcJ6d
	pGuJ1uewacreeZPZeLE8L8lTrYk04CiMrZhWKPhuKfdG2bkocEltbQ1y3tONtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsHx7qJCDp7IdV2H4CgXW4RKtdZIxmt6s+IvFtPbyqE=;
	b=ADrtVXTWURzZeYoLbH3CWO9mOnOqpADEsBH88QoqujF+oRUQAYvxREHZ8T5z5ujVWPMrLX
	COBQkfx97HO/rACA==
Date: Thu, 10 Oct 2024 17:44:51 +0200
Subject: [PATCH 8/9] LoongArch: vdso: Remove timekeeper includes
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-8-7fe5a3ea4382@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=1624;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pLcSqgwzYZzBo43HvSx25Hsn5bLBJRfRGzhKUgfQZe0=;
 b=/+Ru4UIGFSWAYpglbGdQQ15IMR8PhPL5bPtGdy6DloWXB62UlxGU7KiFw9ja3fuJKbpuMnDZH
 Naozzxi/MEKCfguA2aYMFMxjwK8iC8KaCHVKnYuHz2d+3fK6HZI8guE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/include/asm/vdso/vsyscall.h | 4 ----
 arch/loongarch/kernel/vdso.c               | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/include/asm/vdso/vsyscall.h
index b1273ce6f140691ae8104b2be3d1203ebc57fac2..8987e951d0a93c34ca75de676fb9c191ff4ef3c2 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -4,15 +4,11 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 
 extern struct vdso_data *vdso_data;
 extern struct vdso_rng_data *vdso_rng_data;
 
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__loongarch_get_k_vdso_data(void)
 {
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index f6fcc52aefae0043e307327b8e7a5872fad0822a..4d7cb9425dc34584dd7abdb80a784a4f2932e1b7 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/time_namespace.h>
-#include <linux/timekeeper_internal.h>
 
 #include <asm/page.h>
 #include <asm/vdso.h>

-- 
2.47.0


