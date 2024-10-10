Return-Path: <linux-arch+bounces-7982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B576998C2E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1241C24D88
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6C1CF29D;
	Thu, 10 Oct 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMtaSsQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aF5YLex6"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA31CDFA9;
	Thu, 10 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575099; cv=none; b=l+dyuWz5tC36RP8PnhICKltFY7tKOohTKMqIWS49zbfc7Jlewza8lWdS6MIyPurLkfbn0yYA6+e2V5moE7ycPvy0yT3CARhoHpJy/0UZp7Dn/pTlyYQpbNn5LNuMMQm72wftSJ+MyyCDG+bEDskDRuQa6v9+aKj1BpkYUKHHMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575099; c=relaxed/simple;
	bh=Yn7KlHbEU0MJ+dl8y9vpCiJdVRBNRAPzXohBNMI7g0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABZ3BBsL52h6fOOuJUddMXo4hkohqEH5RTW1EY8eZe3nNnEGpUiVj3GcLt+TwVswFQrRHaTEQ5vK9og1WkJA9rLa7sYttnK+WmMR3OyK7F8+33I8PutRRZMEBsq3KUzSM7N0/fwpj8slhnk4fAS/TQtrvc7UzAdGXMcOEDKDbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMtaSsQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aF5YLex6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CaseVhBtdpQtjTcTpmIfibKjxpzap/T9WUWXl9xwak=;
	b=pMtaSsQ8UrCsbp0jWIphuw/8nDX6xrSAMhkuRxGYx7ednp2ZohFYZNLSwmRC6nGSe96v2R
	myIxY30VOOL+YKTv4KEKjTFAQTFXZxKDzvwO0vdUUx1QOQbBpCECJmfsfCyqDvsc5ltoSf
	sxlDi8TJSOv1F5Xd+LjfoHO7JYjK2etzhLqqeqj4MV6ncu885QuT2gk989A8np/TdqjLeJ
	sAi5Fuo7FllnsTpDwTgpwZDaBvRpi59Lio6+uH2rkZaGgKPjDroa4CVten3bk1oOk52Hzw
	23NiNwtZgS+25/KXZ/e4rP7stFRyMr/IejAb2q1gfs4+vnoDCdiO/hPnPzLaFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CaseVhBtdpQtjTcTpmIfibKjxpzap/T9WUWXl9xwak=;
	b=aF5YLex66+lKNdsdoeGgHL1V07NVdOH+rxgXzLe0/EuBdxw2xWHmfdy3blPVHY68rEImru
	Q6CrxNOILwfKytBg==
Date: Thu, 10 Oct 2024 17:44:49 +0200
Subject: [PATCH 6/9] s390/vdso: Remove timekeeper includes
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-6-7fe5a3ea4382@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=1648;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Yn7KlHbEU0MJ+dl8y9vpCiJdVRBNRAPzXohBNMI7g0A=;
 b=U2qMs1WEZtI+3Gz7n0ZlWNu0+kuRgmXI0J5su635wqTf1yCSL0UPUdTMPKc+UQDEA1H6FwQAV
 QZnsg/j8477BGlLQZ+LPIOF96Iz9MwCJvbWAUGHv/zuGibQhhFvb0Mo
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/include/asm/vdso/vsyscall.h | 5 -----
 arch/s390/kernel/time.c               | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
index 3c5d5e47814e16dcfc20f9901481127246e8f348..3eb576ecd3bd998daf9372a52befa8b76d52f2bf 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -7,7 +7,6 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/hrtimer.h>
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
 
@@ -17,10 +16,6 @@ enum vvar_pages {
 	VVAR_NR_PAGES
 };
 
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-
 static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
 {
 	return vdso_data;
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b713effe057967623f64da8297314fcc42ff1af2..4fae6c701784746519bab0b295429082529e4501 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -36,7 +36,6 @@
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/clockchips.h>
 #include <linux/gfp.h>
 #include <linux/kprobes.h>

-- 
2.47.0


