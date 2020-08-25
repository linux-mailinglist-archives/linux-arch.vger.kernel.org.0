Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095C825193C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 15:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHYNKD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 09:10:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21184 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgHYNKA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 09:10:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BbTqS2Jtpz9tyVf;
        Tue, 25 Aug 2020 15:09:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8HmPZoTz24vt; Tue, 25 Aug 2020 15:09:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BbTqS0gC3z9tyVY;
        Tue, 25 Aug 2020 15:09:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 80BAA8B81B;
        Tue, 25 Aug 2020 15:09:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id e3gGQXRhb8eK; Tue, 25 Aug 2020 15:09:57 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 444F18B812;
        Tue, 25 Aug 2020 15:09:57 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 23B4F65D37; Tue, 25 Aug 2020 13:09:57 +0000 (UTC)
Message-Id: <d76d58b7c198a6c3df15e82603a1a17ccaf577a8.1598360789.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1598360789.git.christophe.leroy@csgroup.eu>
References: <cover.1598360789.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v11 3/5] powerpc/vdso: Save and restore TOC pointer on PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue, 25 Aug 2020 13:09:57 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On PPC64, the TOC pointer needs to be saved and restored.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v9: New.

I'm not sure this is really needed, I can't see the VDSO C code doing
anything with r2, at least on ppc64_defconfig.

So I let you decide whether you take it or not.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index dce9d5051259..59a609a48b63 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -19,10 +19,16 @@
   .cfi_register lr, r0
 	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
 	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_STL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
 	get_datapage	r5, r0
 	addi		r5, r5, VDSO_DATA_OFFSET
 	bl		\funct
 	PPC_LL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_LL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
 	cmpwi		r3, 0
 	mtlr		r0
   .cfi_restore lr
@@ -42,10 +48,16 @@
   .cfi_register lr, r0
 	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
 	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_STL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
 	get_datapage	r4, r0
 	addi		r4, r4, VDSO_DATA_OFFSET
 	bl		\funct
 	PPC_LL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_LL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
 	crclr		so
 	mtlr		r0
   .cfi_restore lr
-- 
2.25.0

