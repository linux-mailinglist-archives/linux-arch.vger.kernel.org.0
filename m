Return-Path: <linux-arch+bounces-9406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123D99F32C1
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E8E16211B
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A520B1F5;
	Mon, 16 Dec 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ya1tDQHP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cLthQ9KI"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2320A5C2;
	Mon, 16 Dec 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358265; cv=none; b=Wn6MtVSm9S5PXbsHyF7EUECRj5Ug94yDGOYzOAgtAkNINiEEz+OLYPJqNgcxL5H5g4BSzekVxkppwVJ8dQB2DTyOyuNvSAmCy8SjkT2AfppkxobP8T/vYPJ6IBJhqzAxGt5560sVkjH9kkHQ2SqTDTnv/p20/xwApUkirVYJnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358265; c=relaxed/simple;
	bh=hm6YB5615FQw+H7C/KqIosijpF6HWDKCQo7bql3/qXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M06Rt//NyAXx7UmD6nKt18yFz7gisWSrb6THCk+f9DmWdv6Bc+FL7cxs1i00pc1w6mLwjam6/vBA8KpSmsaq2B7iTqJ0E7mwZYv8N84/O2kCu+QwmvUnVDhK1S4tzDY2DjoIVES8H5cwBtq0mT5s2DnuTTDT6ttf9jfpsEby+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ya1tDQHP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cLthQ9KI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734358260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5l232bDDTPHDtrpy3uPDsqoOrdHFpF2R9izCvQsfbME=;
	b=ya1tDQHPtGIm3l1JQG++n6r9+R5dHMnjNjX8KPLn/jS6YHnoEm3gd72gqFfTw6+cBGwhPN
	Ey6/qe6didg8EUZDQGn7GvnupowR9l8WIOJ+vI1Uy2QYJldd3FW6q47V3Q8sclUjbeCr1Y
	CIJ1wYYmSJs7qpSPESzxfG0WMFqfVKSfENrJVFAfY2xDdwf2wk/dXJ8TfvUtAXvPGQ3x32
	Nhw8nCndzUfqnCBHaMhIHkaWH8gZqrQFsMjHZVvKS6+gzuIoswux1S0fsn4CI7QCOm36hJ
	afcJHgvl0/LEtCs3rEXdQMOIuQLoINYMshRnRZKLBpYlUJuNjAoZG+AwQ/ub4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734358260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5l232bDDTPHDtrpy3uPDsqoOrdHFpF2R9izCvQsfbME=;
	b=cLthQ9KIcCzSJeoIF8+Vdtt685Ogzf1tTB3d4qtk7EGbr4qP7jqXaqZVoaxyrobmJ2mAXf
	gFkO7kavFaEQtpAQ==
Date: Mon, 16 Dec 2024 15:10:10 +0100
Subject: [PATCH 14/17] x86/vdso/vdso2c: Remove page handling
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-vdso-store-rng-v1-14-f7aed1bdb3b2@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734358247; l=3853;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hm6YB5615FQw+H7C/KqIosijpF6HWDKCQo7bql3/qXQ=;
 b=zb7E9hkEEWcgED43aWR2fQhrImC3Ijdh2iPo/T3cIu7zynS14K34Y3JGp0yvTAubJ7yk0tk75
 VKWqDZoSZ7CA8u6EHm0TkVPvUe15kheclbB17hFuAnFSp2ZnTm0/KG5
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The values are not used anymore.
Also the sanity checks performed by vdso2c can never trigger as they
only validate invariants already enforced by the linker script.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/vdso-layout.lds.S |  4 ----
 arch/x86/entry/vdso/vdso2c.c          | 21 ---------------------
 arch/x86/entry/vdso/vdso2c.h          | 20 --------------------
 arch/x86/include/asm/vdso.h           |  6 ------
 4 files changed, 51 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 6a628ead49beb3480dc750786c31dc125dfd017a..f93944ec29e5318aea29e4ad83c3e7f76889e489 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -24,10 +24,6 @@ SECTIONS
 	pvclock_page = vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
 	hvclock_page = vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
 
-	/* For compatibility with vdso2c */
-	vvar_page = vdso_u_data;
-	vvar_start = vdso_u_data;
-
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 90d15f2a72055e37f2ef4292096dd780a051bc84..f84e8f8fa5fe6d1bc680895dfef28fe9251a7fe3 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -69,33 +69,12 @@
 
 const char *outfilename;
 
-/* Symbols that we need in vdso2c. */
-enum {
-	sym_vvar_start,
-	sym_vvar_page,
-	sym_pvclock_page,
-	sym_hvclock_page,
-	sym_timens_page,
-};
-
-const int special_pages[] = {
-	sym_vvar_page,
-	sym_pvclock_page,
-	sym_hvclock_page,
-	sym_timens_page,
-};
-
 struct vdso_sym {
 	const char *name;
 	bool export;
 };
 
 struct vdso_sym required_syms[] = {
-	[sym_vvar_start] = {"vvar_start", true},
-	[sym_vvar_page] = {"vvar_page", true},
-	[sym_pvclock_page] = {"pvclock_page", true},
-	[sym_hvclock_page] = {"hvclock_page", true},
-	[sym_timens_page] = {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 67b3e37576a64a29ecbdc6fd75e410fc52a82e58..78ed1c1f28b92b97973f57d3f65b9c4d4694f462 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -150,26 +150,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		}
 	}
 
-	/* Validate mapping addresses. */
-	for (i = 0; i < sizeof(special_pages) / sizeof(special_pages[0]); i++) {
-		INT_BITS symval = syms[special_pages[i]];
-
-		if (!symval)
-			continue;  /* The mapping isn't used; ignore it. */
-
-		if (symval % 4096)
-			fail("%s must be a multiple of 4096\n",
-			     required_syms[i].name);
-		if (symval + 4096 < syms[sym_vvar_start])
-			fail("%s underruns vvar_start\n",
-			     required_syms[i].name);
-		if (symval + 4096 > 0)
-			fail("%s is on the wrong side of the vdso text\n",
-			     required_syms[i].name);
-	}
-	if (syms[sym_vvar_start] % 4096)
-		fail("vvar_begin must be a multiple of 4096\n");
-
 	if (!image_name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index d7f6592b74a94f6fecba59ce8f23eb3990843db4..80be0da733df43de7520bef69ad120ce05d37994 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -18,12 +18,6 @@ struct vdso_image {
 	unsigned long extable_base, extable_len;
 	const void *extable;
 
-	long sym_vvar_start;  /* Negative offset to the vvar area */
-
-	long sym_vvar_page;
-	long sym_pvclock_page;
-	long sym_hvclock_page;
-	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;

-- 
2.47.1


