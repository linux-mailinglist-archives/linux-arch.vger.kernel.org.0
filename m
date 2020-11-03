Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF842A4DD9
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgKCSHU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:07:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4805 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgKCSHQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Nov 2020 13:07:16 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CQd681Hv0z9v1YY;
        Tue,  3 Nov 2020 19:07:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id onygEN-zwiKy; Tue,  3 Nov 2020 19:07:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CQd675Hwbz9v1YS;
        Tue,  3 Nov 2020 19:07:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DF0F8B7DC;
        Tue,  3 Nov 2020 19:07:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nyfe8n40bfUi; Tue,  3 Nov 2020 19:07:13 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A2238B7D4;
        Tue,  3 Nov 2020 19:07:13 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 30A5C66860; Tue,  3 Nov 2020 18:07:13 +0000 (UTC)
Message-Id: <08ffecd31403b3c692f25f97b07a378ba784873e.1604426550.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1604426550.git.christophe.leroy@csgroup.eu>
References: <cover.1604426550.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v13 2/8] powerpc/feature: Use CONFIG_PPC64 instead of
 __powerpc64__ to define possible features
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue,  3 Nov 2020 18:07:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to build VDSO32 for PPC64, we need to have CPU_FTRS_POSSIBLE
and CPU_FTRS_ALWAYS independant of whether we are building the
32 bits VDSO or the 64 bits VDSO.

Use #ifdef CONFIG_PPC64 instead of #ifdef __powerpc64__

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v13: new
---
 arch/powerpc/include/asm/cputable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 5e31960a56a9..e069a2d9f7c1 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -488,7 +488,7 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_DABRX)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_PPCAS_ARCH_V2)
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 #ifdef CONFIG_PPC_BOOK3E
 #define CPU_FTRS_POSSIBLE	(CPU_FTRS_E6500 | CPU_FTRS_E5500)
 #else
@@ -545,7 +545,7 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 #ifdef CONFIG_PPC_BOOK3E
 #define CPU_FTRS_ALWAYS		(CPU_FTRS_E6500 & CPU_FTRS_E5500)
 #else
-- 
2.25.0

