Return-Path: <linux-arch+bounces-7980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A3998C27
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A072F281B6F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991751CEAB4;
	Thu, 10 Oct 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2VrXyCvl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="84jkthMW"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD871CDA0B;
	Thu, 10 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575098; cv=none; b=r/+JD0rjyUg2PS8IG7Fnwyv+LkCssrTg7BOZfjDXI4Sgswf64HbSTd8bfGNX77m3exZROt9tNceJMsDHq9JVCRgGe1+lQ9B1oXU12jjuIqkeZX4TpZDeghZzsI3aA2uKYbFPwTGjB8O9hUp8vQImDbt/NaBPoHNqKudgFqYADB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575098; c=relaxed/simple;
	bh=2LvKRYHam7JPvf9YTnYT/Pt96cAREdv5IB7CnEDdMso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izFdMv7xpPyTon1l7VcTw8Gr2JQz3mc8io5Xr2tAHQWa9zOwkweaxRw8K4QX2FEt2lbYHjdONu3Jr15XC9QHiJfbrzW/1pB4L7pPLsjhmPZMotKnJESRAiQYmIDmzSPtVY/6lOT0xSYuyb0VgUmNy5lvAHbNP+ZNjZ2RfXH3VbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2VrXyCvl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=84jkthMW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//WOaSb+qiFuhDcrD1QvrKSX9jq6HrXx3vMVSTOjlpM=;
	b=2VrXyCvlEPG/qSkhA7AEYBYXeD45ZWKkLTe2Mlb6dw7lZRpUe5oEjGYhhUTX9WxqWueCmX
	bWyV8FnZpDzj5zu6qChhR6ojn1Jco3nNNl6s6iqrrUSoJjd1fIrYn3aeRZ/SExewoutWqf
	D5xXvosPkw4N7cOT+3CDeFTl0H83mGQjnQU0pXyQWSEffFSNQWpuR0lJXUguCuMfB9XWp3
	vpIgRP5XjW5p56Eo3UApKPrbAzpyLxDzfUjNyI1flxZBOJLMcQhg7ZgijRNfW34LG2iHhk
	LUe6H17KpbiZZMKc2tFVOsdVPc27Hyahhm3Yb4c82oQB0prBIni+Hbhledyjmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//WOaSb+qiFuhDcrD1QvrKSX9jq6HrXx3vMVSTOjlpM=;
	b=84jkthMWjxjsydzn/4oqUu2+UXGDE3w3mSl6Nx3zbBL3u4gTWtw+ZFEf10TNhsDTjLWQy+
	cBy+YXEZCzhNQPAA==
Date: Thu, 10 Oct 2024 17:44:47 +0200
Subject: [PATCH 4/9] powerpc/vdso: Remove timekeeper includes
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-4-7fe5a3ea4382@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=1560;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2LvKRYHam7JPvf9YTnYT/Pt96cAREdv5IB7CnEDdMso=;
 b=wCeMto8LigT0NWmLWaYqjH4etZsM507fuDoQptvkr3x3QkMHLdq+92lLyQYSHdu4J9UgjahuM
 gvKGsW+JLn0B/ParFwQLICcr2DHaXVyP0GNd1k0EsAzL/zETzTfLLPv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/powerpc/include/asm/vdso/vsyscall.h | 4 ----
 arch/powerpc/kernel/time.c               | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
index 92f480d8cc6dcb905d5960185ca8b615cfc541ee..48560a11955956b8fbb59360334a81972723bd57 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -4,12 +4,8 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/timekeeper_internal.h>
 #include <asm/vdso_datapage.h>
 
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__arch_get_k_vdso_data(void)
 {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0ff9f038e800db6dbc910ce581550b457ee5f2db..4a95654c1d36f25d6021284889fdd1510782b408 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -75,7 +75,6 @@
 /* powerpc clocksource/clockevent code */
 
 #include <linux/clockchips.h>
-#include <linux/timekeeper_internal.h>
 
 static u64 timebase_read(struct clocksource *);
 static struct clocksource clocksource_timebase = {

-- 
2.47.0


