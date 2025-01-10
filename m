Return-Path: <linux-arch+bounces-9661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB6A09519
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86427188CB86
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9D2116F0;
	Fri, 10 Jan 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uOv2bxTh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCXOoqps"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10A211481;
	Fri, 10 Jan 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522636; cv=none; b=SrUAez+y5btwn9W1v/DcRHpBQCNVlIdyeK1Vt4KOFtTDiDQBQYW1Ghv9eb9NEbc6TWK7kuivv5OqQXQ4FfoRLRtB/HTvB7dCDlaSXzYtRMQ7QGuowQIZantDWb1WNsgXLVCtBqp12BFs0hFQVVZgz5ittQsGqpntniWFcszk+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522636; c=relaxed/simple;
	bh=NPXgHz1pg7k88XY5Q1tIpqIToZjmPGQbKRJBGkTsdlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PErHKMcJ3G2NhqwlBOZKrIiRJsar/K3VcklwfpmMk2NYzXcd8vTaxncc5QoZ7tTVl17snh4fnXJeMIyJY7qRHVZ0k5b7mxYPmQxNztg5JdK50KY49bQiSkdtK+SSs2QRobVdBu4uedTbZ5sBJqZtlU4Amwe5kcg6HRcD+AiNSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uOv2bxTh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCXOoqps; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbUS2hSpGUfA91ZBUqWCU2EUGjDUwjlK6bc3CIpIefE=;
	b=uOv2bxTh5LBAc6lQBNxHI225ZQIyI3sjNmKl0oWDqhbMm3+2Aq1CgAiY/WGKjYdJujeASg
	X5yRhUXpIWcQyFWiHfZtG6b3KXCjOtxlLnuS77Gc29T2b0JYczwJsSObkhk0BIyJASuK3r
	j78fThlBjFc9jsBeKSlPdsW6SYuzPAIVqko1senufIDxGaUR2jm7/JzErdDsY+maWiSAc/
	mopt7buykITKw+x/h1Hd8DBYahvWn3cXYNCcE2rNgQ3kezsHOFLRDnm1wiXwQd26o4wqOT
	ak8g0JlrxBQhbszlIVZlHKPQKAPTEJd+aSkC3Ljp36LJjFP/rGVCCl7gUWHxmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbUS2hSpGUfA91ZBUqWCU2EUGjDUwjlK6bc3CIpIefE=;
	b=bCXOoqpsmZBfuCWTLWyKzXWgI+48Fg+ZiQP8gjNQ8tgcAu+konADycZa3Bs2MBPDsKLYfI
	V9BFQPPLHv6mNWAA==
Date: Fri, 10 Jan 2025 16:23:41 +0100
Subject: [PATCH v2 02/18] parisc: Remove unused symbol vdso_data
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-vdso-store-rng-v2-2-350c9179bbf1@linutronix.de>
References: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
In-Reply-To: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
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
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
 Guo Ren <guoren@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-csky@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=796;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NPXgHz1pg7k88XY5Q1tIpqIToZjmPGQbKRJBGkTsdlQ=;
 b=pQu1+khW515G686AWZAaU8xzr79tj7q5lDK175IcOzOT9nOwePjQUofvqBqqfKXCFWPJMnR3M
 9bUkIqqwyozCTnEzLbN/eUBLTMra60lhj1W2SasaPH7bLefw8MVTs27
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


