Return-Path: <linux-arch+bounces-9662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B86A09516
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012041652E4
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C92116F8;
	Fri, 10 Jan 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nU7XbmRI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2HokUJVx"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB22063E5;
	Fri, 10 Jan 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522636; cv=none; b=Nb9nVPAcHAVpXCLHnruIgcHbDCEvNiXDPd3Nt6RLSwxEQx3Bhgn4anmReNaxWZY4zr3MTUbdUL7uZeJRQ182ZcTuOJhkCFUap14+DfzWwNY5sqOiUQ5FgynDg7vEk/z5o9UE869il7dpQ/ZoZhm/JEbnC3LA5P4ur6xqJX0FUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522636; c=relaxed/simple;
	bh=mrCwYwONHFoKf8BOecbFCAndYakgmDivYb/K3zc9HyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3vmpIFhm51S32lx+A4YD3+TDcfoMBhZjfX/kvMS/qz6aJYJM/vpJHPJhY4aeGqyJuPc+ARqOhH5fKGID9N0rLp9yr1tgM0YJ1W8WaupSLhqVgoWy1sQ7zGSxb2vusgKsD0pLnF7MNwK/XhOxeXlVi7sNGARigEXOyZh5aM9x/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nU7XbmRI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2HokUJVx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiMr/7r350FDztI+yfZ4NjY6nn3Y/Nl0egJSTBaRpLs=;
	b=nU7XbmRIRbhhK3BkvK5wfJIUOzyhNhYr4+SxVEuPhBTWH94wR20ECLrVBsQjZPzYkf27Hq
	p2rG+NUsuOEuqR7htHgrqBwxFzrcQEcKmXRDAqJtMFlnHplhWows76OHkWiLGjUd08m92b
	mBpT0EMoBlt3Kcl9d2OqDlpFbIhDxvId+27k2ovO7ZNYxchvunKinis62iQU34Q24aickE
	Zp1+OCGdsAbDvg6R+vfXDrFRhw0YZiwZCJy8jWZ+U3+mKI4jRBU8/yYHtS33aEoGTPZrA3
	zA8A6xvDiBGOWZRlQbnPxPfKh7N3BF7e0X/cHC/0YyvsM+THVaYj5xz5Tuu37w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiMr/7r350FDztI+yfZ4NjY6nn3Y/Nl0egJSTBaRpLs=;
	b=2HokUJVxbHn8F785G0CHjr9RFD9ifVK8x4g4TuI0POw2FWzUOAxJJbiw3xjwoD7htuVi2G
	QcErSkg3qE8OauDA==
Date: Fri, 10 Jan 2025 16:23:40 +0100
Subject: [PATCH v2 01/18] x86/vdso: Fix latent bug in vclock_pages
 calculation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-vdso-store-rng-v2-1-350c9179bbf1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=2531;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=mrCwYwONHFoKf8BOecbFCAndYakgmDivYb/K3zc9HyU=;
 b=5bbXPNT2cixA+c9v6k3mfkn19z8uqdUaa+GjcugpIz/DlZVc7ni5HOahVN4GdNyeokUKqBUiu
 28329iUY//8CtJtkaCSEgQyd+P1Xi7/4bXcZMBPdBToJqyU81Gwpxz1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vclock pages are *after* the non-vclock pages.
Currently there are both two vclock and two non-vclock pages so the
existing logic works by accident.
As soon as the number of pages changes it will break however.
This will be the case with the introduction of the generic vDSO data
storage.

Use a macro to keep the calculation understandable and in sync between
the linker script and mapping code.

Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 2 +-
 arch/x86/entry/vdso/vma.c             | 2 +-
 arch/x86/include/asm/vdso/vsyscall.h  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 872947c1004c35c006f7508eac7dff251c286aeb..918606ff92a988b14f5e64f984750ae04b3b6ede 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -24,7 +24,7 @@ SECTIONS
 
 	timens_page  = vvar_start + PAGE_SIZE;
 
-	vclock_pages = vvar_start + VDSO_NR_VCLOCK_PAGES * PAGE_SIZE;
+	vclock_pages = VDSO_VCLOCK_PAGES_START(vvar_start);
 	pvclock_page = vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
 	hvclock_page = vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc1a9cab760b8a65e4b02c624e8c75244b5..aa62949335ecec3765d3b46eac7f7b83be5efdda 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -290,7 +290,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	}
 
 	vma = _install_special_mapping(mm,
-				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
+				       VDSO_VCLOCK_PAGES_START(addr),
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
 				       VM_PFNMAP,
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 37b4a70559a8228601203fe7b99b9ddfc3d94f1b..88b31d4cdfaf331d2d597981d3f8ee0c5a339085 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -6,6 +6,7 @@
 #define __VVAR_PAGES	4
 
 #define VDSO_NR_VCLOCK_PAGES	2
+#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE)
 #define VDSO_PAGE_PVCLOCK_OFFSET	0
 #define VDSO_PAGE_HVCLOCK_OFFSET	1
 

-- 
2.47.1


