Return-Path: <linux-arch+bounces-13279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFEB35423
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B94684D24
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E62F7443;
	Tue, 26 Aug 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vM/cvVQM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vA9RQwkS"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94A2F60DD;
	Tue, 26 Aug 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189105; cv=none; b=Dx7lNSX0FlS2BPlXvOdLnXUUH6D7tY2gAuf0Wp7ouzzSObHTsa6DF1yaEGR3r0Gsn5yXjEzm3Ur2Iz/6+DhzmiQZ6GzVpBO06OTxk6g//9Hod87dSINlMedEUZeJjTFsrYv5eySn3o4J66FdCLGOssVj13dACArefECQq87n0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189105; c=relaxed/simple;
	bh=0FWlozWesIsQ0qQyaOP1bY0lFjVrbfKxBVeB1PCnS50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PqO0tdI8dJ5TybFJrcZpUZ1YU3BUMV2f0k/xpKiqwwf1NtJ2n3rMeZhtxpWfhy2k1DlyH0hZ1ooh46mVZXcY032jEweRw37UqwNNDtZm0kkowh9UNM9uHVkJBRTipRdm53IP+wbyTKGKoxmkXpBEMM8zv3nl0MR+t/HqS0RP3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vM/cvVQM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vA9RQwkS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/oLlHMS/fCP6P1KLSn+cvJJv6PKUv3DICeaKqETsd4=;
	b=vM/cvVQMAyhS92V8y5yVESyKxIqQ5R3zffJXNT39DFeEehqGvQ4cgcMYsWOtpmbyjLR+Jk
	we8S1VPZLk08HyevreXbtrS0WfURWLCD0C1udndZaGXsxcvNVQ2IAa/sI7wZ5EjfeBV3QB
	Xl1IBk2dQX2DHCg8P+mvsjehyFDzZ/AjK26U/WIM/Dx6E1r9CZ+xl3vYpcz/43dfXeL8zq
	t+0oYU9wuduujEn9b3gXCqd8/s4+brqyYCVM79YY7DmkOuCIKG5XnjOxrX8XloYENkIp6J
	frOXYpfPBh2KaqVqKhcgIbWwZ8GW0EG4XRusd22yhv2ylnUvt+X8LNumqRAcrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/oLlHMS/fCP6P1KLSn+cvJJv6PKUv3DICeaKqETsd4=;
	b=vA9RQwkSkeW435dz89cXdm1JlqEJ1IVbHIFd6A9tNEpJZ0qLZJMeeSzlzAhq24mxpdVhVM
	OJzV+jwkYkep1fAA==
Date: Tue, 26 Aug 2025 08:17:08 +0200
Subject: [PATCH 05/11] time: Build generic update_vsyscall() only with
 generic time vDSO
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-5-d9b65750e49f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=943;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0FWlozWesIsQ0qQyaOP1bY0lFjVrbfKxBVeB1PCnS50=;
 b=9pNh5a5NaguFfKkfKR0EeNJ5Hqk/rS5JHEaeEmX/n8dUdZlkDqHcQrQvn3JOYAA8u+Wl7yvQz
 BQudoqsm8axAvusAQkTMXCgGoVnMLts+duG7XkK6Eop3MTQ6RNupbR9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO can be used without the time-related functionality.
In that case the generic update_vsyscall() from kernel/time/vsyscall.c
should not be built.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index e6e9b85d4db5f8dd5d9b574ef7bb0a281b9daa6d..f7d52d9543cc7a2d1a18db179229a8d7936317d3 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_LEGACY_TIMER_TICK)			+= tick-legacy.o
 ifeq ($(CONFIG_SMP),y)
  obj-$(CONFIG_NO_HZ_COMMON)			+= timer_migration.o
 endif
-obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
+obj-$(CONFIG_GENERIC_GETTIMEOFDAY)		+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
 obj-$(CONFIG_TIME_NS)				+= namespace.o

-- 
2.50.1


