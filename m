Return-Path: <linux-arch+bounces-7983-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8B998C32
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CE01F232BE
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F81CF5FE;
	Thu, 10 Oct 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JeOI7EjG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3gi+112"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07D1CEAAC;
	Thu, 10 Oct 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575100; cv=none; b=Y2iXlcqLZRtvK4F1TH6bEfDTfK/gnhSTySB5hAcS4cymI2nI/w+0YvNh1NnRFyRoR9k4GDW45cVS7EP0i4GX1GZjUyh9+8tR/hwbcKyXI3mYZZ+gQ6se7RsIoSXSMTvfMlZCKvASjagqz1U6rBc2h9veK8p9SSOq4Eikf9etEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575100; c=relaxed/simple;
	bh=l54nGxhAvHD6pY7wtN4Hu9pn70wCVvNZSe9VHdZoefM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwJuPeUhJ7OM8QeGIkH78UW2OPfywxYJPa8Mclmex/mYS0VVmC7xtYyTwROBo/wqL95LfONlcJVG4x1yprPHNwSLp90kxDI7hCaNm7DCvFyOeVJcFUOjzd3X2u8hbQ9JzwZiN3MUUgtjDHhcHkzRB+znAUYwqPPz5KHJm0H7Npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JeOI7EjG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3gi+112; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY01drBheEGVUpRb1fYSGc/wPWUSgNrxFS5OIkyqJ0M=;
	b=JeOI7EjGLWzijEdDcl6Tyi4eiJ+IoscNn1jn4Vnt1OJdKL/uMl4CZVmNoWEKL26snSeCc3
	yUpTPNiE6dS+kXCtW/1yOHgifjIaoXu5PN08+QPe2MLJH6B3MorQvyU9c+IOwT3vHUg9ck
	nUlnT87H5MCm3An3Rjd6Om0ySYAyjGgy5ZEi17K9cQzhfP+zJXWKQf3QUzd4pZHVmQ/abD
	3RW6JhvsHdGE/RvnfUfZf56jVx3/uwb8LTV5bMMyjMtZ45FLSkTby93OyLEKukozI71WSX
	NwAl5c4PybYcB33UnzB7wmW8bdj9OQ78VFr+ICgepDAff+wKZqw85Zyvj49WPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY01drBheEGVUpRb1fYSGc/wPWUSgNrxFS5OIkyqJ0M=;
	b=q3gi+1121GrBcixQaKmeu1KvtClMIz0AoNScv5wbMLdknPGj1mZTBeK2w8VhWVCj9v64TY
	VYgJRYX28CCZ+0DQ==
Date: Thu, 10 Oct 2024 17:44:50 +0200
Subject: [PATCH 7/9] x86/vdso: Remove timekeeper include
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-7-7fe5a3ea4382@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=816;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=l54nGxhAvHD6pY7wtN4Hu9pn70wCVvNZSe9VHdZoefM=;
 b=w5TeMa7L2fBX8rWHCW0VUcxRJmtxwVTWhqmFg4Ar7aOri6rXy8RfO9ACmyKKuOK1EBa7U50Tw
 YyJTJNACEbjDPGQDXMNIPF0R+gdo+aXllV8ZfbtgU2RaAvcg1suki3H
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/include/asm/vdso/vsyscall.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 67fedf1698b5e2b710e0504686318949c738bf29..a1f916b18400f65eb91d5ec0e3eb49b070332904 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -4,7 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>

-- 
2.47.0


