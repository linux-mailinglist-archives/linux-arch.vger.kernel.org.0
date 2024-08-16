Return-Path: <linux-arch+bounces-6269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C81954C8A
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9448D1F2605B
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5C01BDA8F;
	Fri, 16 Aug 2024 14:37:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A71BD015;
	Fri, 16 Aug 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819058; cv=none; b=bK1MJPNZLU0jaoH2GbXKCPt0PbrTg4VGgtfaktBTkDSmSfz5yLxi+Zgx42+Z2MIzYnBkdkwFqQVUuh3000Ry9jgjhGZiOXS63RJ7IDy9cE4jYhI1J9pX/1STG+LwKntY+nz+qpq6sQOKGDFpihyhmaXavgBThcImOsZo4P3eB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819058; c=relaxed/simple;
	bh=ZRZ74nUfhlj//3k0SFeHq4s60ExiEQUmJYVI6+7VWwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCDR9fhLsbZWcrXY1Mvrg3QookbvAgOpJviN5K4dFH/rdYbfQQ+cD90z8nzkqBCDDIeBWEQ0UKoWR3yPE//4ykd9GbLT769EXczaPzrH7B57mfvZF+WxPo7XatTnrojb04cDukbbRaFCX21XU5+yrpZ5T7iliwMUuWyaUCAP3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1p2rL0z9sSZ;
	Fri, 16 Aug 2024 16:37:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0FGio_3SM76h; Fri, 16 Aug 2024 16:37:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1m655vz9rvV;
	Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BD9988B764;
	Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aeg8OhdT1BTv; Fri, 16 Aug 2024 16:37:00 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 080968B776;
	Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
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
Subject: [PATCH 7/9] powerpc: Add little endian variants of LHZX_BE and friends
Date: Fri, 16 Aug 2024 16:36:54 +0200
Message-ID: <a3d5db51c2e0f115e271b507c89e5af96bfeb015.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819011; l=2150; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ZRZ74nUfhlj//3k0SFeHq4s60ExiEQUmJYVI6+7VWwQ=; b=kOKzSdAaDCocEGjcwOOPnE+zyg2ugOITM5x4/kDd+DSi3Cnis0XztcJ0bnyXg3azflp+Ah2lp f1aaVakKCwqCagp9h8RMNaoyAhus0oxNEiHBcWf0t94NrqIHTc9X41i
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

To support getrandom in VDSO which is based on little endian storage,
add macros equivalent to LHZX_BE for little endian accesses.

And move it outside of __powerpc64__ #ifdef so that it can also be
used for PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/asm-compat.h | 40 +++++++++++++++++----------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 2bc53c646ccd..ef8e79ae669a 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -25,20 +25,6 @@
 #define PPC_LR_STKOFF	16
 #define PPC_MIN_STKFRM	112
 
-#ifdef __BIG_ENDIAN__
-#define LHZX_BE	stringify_in_c(lhzx)
-#define LWZX_BE	stringify_in_c(lwzx)
-#define LDX_BE	stringify_in_c(ldx)
-#define STWX_BE	stringify_in_c(stwx)
-#define STDX_BE	stringify_in_c(stdx)
-#else
-#define LHZX_BE	stringify_in_c(lhbrx)
-#define LWZX_BE	stringify_in_c(lwbrx)
-#define LDX_BE	stringify_in_c(ldbrx)
-#define STWX_BE	stringify_in_c(stwbrx)
-#define STDX_BE	stringify_in_c(stdbrx)
-#endif
-
 #else /* 32-bit */
 
 /* operations for longs and pointers */
@@ -61,4 +47,30 @@
 
 #endif
 
+#ifdef __BIG_ENDIAN__
+#define LHZX_BE	stringify_in_c(lhzx)
+#define LWZX_BE	stringify_in_c(lwzx)
+#define LDX_BE	stringify_in_c(ldx)
+#define STWX_BE	stringify_in_c(stwx)
+#define STDX_BE	stringify_in_c(stdx)
+
+#define LHZX_LE	stringify_in_c(lhbrx)
+#define LWZX_LE	stringify_in_c(lwbrx)
+#define LDX_LE	stringify_in_c(ldbrx)
+#define STWX_LE	stringify_in_c(stwbrx)
+#define STDX_LE	stringify_in_c(stdbrx)
+#else
+#define LHZX_BE	stringify_in_c(lhbrx)
+#define LWZX_BE	stringify_in_c(lwbrx)
+#define LDX_BE	stringify_in_c(ldbrx)
+#define STWX_BE	stringify_in_c(stwbrx)
+#define STDX_BE	stringify_in_c(stdbrx)
+
+#define LHZX_LE	stringify_in_c(lhzx)
+#define LWZX_LE	stringify_in_c(lwzx)
+#define LDX_LE	stringify_in_c(ldx)
+#define STWX_LE	stringify_in_c(stwx)
+#define STDX_LE	stringify_in_c(stdx)
+#endif
+
 #endif /* _ASM_POWERPC_ASM_COMPAT_H */
-- 
2.44.0


