Return-Path: <linux-arch+bounces-6263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98549954C77
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5516128544E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF31BC9F6;
	Fri, 16 Aug 2024 14:37:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5064C1BC9E8;
	Fri, 16 Aug 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819030; cv=none; b=TzanzOK+VX31gtu+qSxyxiCd4vlF6gXVxcW2V5rFt3jz736kxReBJLQL9oibfqfeVRFKmV5mZK/nMTTYED61tn4FkKgHIXZY50LJFh3XqM1HRT+8ZdN1PS0PNw/06mgXk5QJYYCLg5KJXU9SCvX0jPsEaqhVPiCYpTrRm0/TE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819030; c=relaxed/simple;
	bh=K++segjJQr8QF64fs4Z+bGhGMQj57/fKQI86HMCyRto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibWkm3JdcUfO+/n8aB3f1iHqqnAeEYMRldSLn7PKsKI1nZuvbAYp5HvAqTBHjq9iji4iz5ZdTjauTPrWAny0A/po40KHSaoAs9zdBceXRvCUFpd8pgeBPDlZmCHNE4k462erKJQ74uNRsZaHPkMkHxvhWySpEvqxN0Jkt5QYqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1h3NLbz9sS7;
	Fri, 16 Aug 2024 16:36:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOqG54dVypJt; Fri, 16 Aug 2024 16:36:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1h2X2Qz9rvV;
	Fri, 16 Aug 2024 16:36:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 43F2A8B776;
	Fri, 16 Aug 2024 16:36:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Z6kyv2FpVyLW; Fri, 16 Aug 2024 16:36:56 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A3C08B775;
	Fri, 16 Aug 2024 16:36:55 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/9] powerpc/vdso: Don't discard rela sections
Date: Fri, 16 Aug 2024 16:36:48 +0200
Message-ID: <93652438073547f350feea0daca91464336024b2.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819011; l=1900; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=K++segjJQr8QF64fs4Z+bGhGMQj57/fKQI86HMCyRto=; b=is2TYmfppFjvvakpgBHCsGYWlGaf4/CT2PO7c1dZ5PW6hB2pSeIlflfQNa1SyamqARpJZsuGV 0xczDv0ttdtAuPZwXoeq1vhCP0xsOMTY62EFySZcbZYirXZpMouyAcA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

After building the VDSO, there is a verification that it contains
no dynamic relocation, see commit aff69273af61 ("vdso: Improve
cmd_vdso_check to check all dynamic relocations").

This verification uses readelf -r and doesn't work if rela sections
are discarded.

Fixes: 8ad57add77d3 ("powerpc/build: vdso linker warning for orphan sections")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso/vdso32.lds.S | 4 +++-
 arch/powerpc/kernel/vdso/vdso64.lds.S | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 426e1ccc6971..8f57107000a2 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -74,6 +74,8 @@ SECTIONS
 	.got		: { *(.got) }			:text
 	.plt		: { *(.plt) }
 
+	.rela.dyn	: { *(.rela .rela*) }
+
 	_end = .;
 	__end = .;
 	PROVIDE(end = .);
@@ -87,7 +89,7 @@ SECTIONS
 		*(.branch_lt)
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
-		*(.got1 .glink .iplt .rela*)
+		*(.got1 .glink .iplt)
 	}
 }
 
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
index bda6c8cdd459..400819258c06 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -69,7 +69,7 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 	.gcc_except_table : { *(.gcc_except_table) }
-	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
+	.rela.dyn ALIGN(8) : { *(.rela .rela*) }
 
 	.got ALIGN(8)	: { *(.got .toc) }
 
@@ -86,7 +86,7 @@ SECTIONS
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
 		*(.opd)
-		*(.glink .iplt .plt .rela*)
+		*(.glink .iplt .plt)
 	}
 }
 
-- 
2.44.0


