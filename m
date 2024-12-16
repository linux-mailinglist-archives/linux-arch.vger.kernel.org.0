Return-Path: <linux-arch+bounces-9394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A89F327D
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EB87A224B
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A70206269;
	Mon, 16 Dec 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GuH2uzo5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHswSq9R"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC9205E23;
	Mon, 16 Dec 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358255; cv=none; b=Y3Daj0Oxcw+Dx8u4o8QEDLiG2wEvKrQNq+AkRfuuqwQ//bk48fAAcbziUTnHAX26vdREREpNw5lnxYeCWY0GiQUlF3/euv6vXVNhOYoo2diwX3RDNMR6Zy2R0cyzw1qe/rieX07mEz3rXhjtfN4feut8Qo/whDuWCRlKzNi5uIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358255; c=relaxed/simple;
	bh=NPXgHz1pg7k88XY5Q1tIpqIToZjmPGQbKRJBGkTsdlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kS5Ln7Eeq969OB5sjPlgWMPY9TL9CoR4EFsxsesNKrtg4mYWCZx0RCAFd63CaIyVV7wnHvzab1Y7Ofc/PEdHJk6DZa5SEoPaJ0IGxDJLKgQFYhChLixaXYocaox/6sLlMAB9YZ2YRNLahFTCYPYkxcUCjXcUTwGyNVNyKotcFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GuH2uzo5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHswSq9R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734358251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbUS2hSpGUfA91ZBUqWCU2EUGjDUwjlK6bc3CIpIefE=;
	b=GuH2uzo5FyR0o68VJgLh22/tvAh4VO3tEUIc29jvZ8lPLWfEUfhNVtSSK4HXCnohLAwbXo
	gEvHjDWSFgEqrnTfKdaUVzxP8s5vskJ2urPXPUkPw83/2mrnYmmUmtERhGRPRyqbznf4z/
	TVaywADhuO62/QPyaae+wx5X5FFV9M6xrmUCZwtSxnJjI7TGlFQtv14U1ie1HeMP7FyoI3
	c1H/xkAQk/cMW7DvQZU32HKaDQtXwDyR962kNnn2WJH5P5qddPMfspglgzNhxbDwOoN8y+
	dtTDWffUBFUBMw1UmRJd6JaZJDQjLnMLryFw+HzWyUuw08nbuaNBceWbkpr+/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734358251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbUS2hSpGUfA91ZBUqWCU2EUGjDUwjlK6bc3CIpIefE=;
	b=hHswSq9RfYopT6aqpSY7CX9cu9WJ1N9ZlLIWnRYrgQChCxsQi0dPawuK/Q9SjHGdFt/Ezg
	DmHWkKKYf0nrzRBw==
Date: Mon, 16 Dec 2024 15:09:57 +0100
Subject: [PATCH 01/17] parisc: Remove unused symbol vdso_data
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-vdso-store-rng-v1-1-f7aed1bdb3b2@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
In-Reply-To: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734358247; l=796;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NPXgHz1pg7k88XY5Q1tIpqIToZjmPGQbKRJBGkTsdlQ=;
 b=qIq583Nq2J6WTZk5uFF7tgmMVMT+mFXj9RQI8M6crN6E2uuxfEuALnkyGREgmp/vYO82I170d
 yKTyVvOCDqzB5fc8Z9c7wx+qHEKzuwOd6U9tdpzQYbFVujg6jSoRO3t
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The symbol vdso_data is and has been unused.
Remove it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/parisc/include/asm/vdso.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/parisc/include/asm/vdso.h b/arch/parisc/include/asm/vdso.h
index 2a2dc11b5545fc642a7ae4596dc174111433e948..5f581c1d64606b3ec8f9967efe31dd3d551adf76 100644
--- a/arch/parisc/include/asm/vdso.h
+++ b/arch/parisc/include/asm/vdso.h
@@ -12,8 +12,6 @@
 #define VDSO64_SYMBOL(tsk, name) ((tsk)->mm->context.vdso_base + (vdso64_offset_##name))
 #define VDSO32_SYMBOL(tsk, name) ((tsk)->mm->context.vdso_base + (vdso32_offset_##name))
 
-extern struct vdso_data *vdso_data;
-
 #endif /* __ASSEMBLY __ */
 
 /* Default link addresses for the vDSOs */

-- 
2.47.1


